package DAO;

import SQL.conecct;
import modelo.AsistenciaEstudiante;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaEstudianteDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Listar estudiantes por sección
    public List<AsistenciaEstudiante> listarPorSeccion(int seccionId) {
        List<AsistenciaEstudiante> lista = new ArrayList<>();
        String sql = "SELECT e.*, s.nombre as nombre_seccion " +
                "FROM asistencia_estudiantes e " +
                "INNER JOIN asistencia_secciones s ON e.seccion_id = s.id " +
                "WHERE e.seccion_id = ? AND e.activo = 1 " +
                "ORDER BY e.orden, e.nombre_completo";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaEstudiante estudiante = new AsistenciaEstudiante();
                estudiante.setId(rs.getInt("id"));
                estudiante.setSeccionId(rs.getInt("seccion_id"));
                estudiante.setNombreCompleto(rs.getString("nombre_completo"));
                estudiante.setOrden(rs.getInt("orden"));
                estudiante.setActivo(rs.getBoolean("activo"));
                estudiante.setCodigo(rs.getString("codigo"));
                estudiante.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                estudiante.setNombreSeccion(rs.getString("nombre_seccion"));
                lista.add(estudiante);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Obtener estudiante por ID
    public AsistenciaEstudiante obtenerPorId(int id) {
        AsistenciaEstudiante estudiante = null;
        String sql = "SELECT * FROM asistencia_estudiantes WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                estudiante = new AsistenciaEstudiante();
                estudiante.setId(rs.getInt("id"));
                estudiante.setSeccionId(rs.getInt("seccion_id"));
                estudiante.setNombreCompleto(rs.getString("nombre_completo"));
                estudiante.setOrden(rs.getInt("orden"));
                estudiante.setActivo(rs.getBoolean("activo"));
                estudiante.setFechaRegistro(rs.getTimestamp("fecha_registro"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return estudiante;
    }

    // Insertar nuevo estudiante
    public boolean insertar(AsistenciaEstudiante estudiante) {
        String sql = "INSERT INTO asistencia_estudiantes (seccion_id, nombre_completo, orden, activo) VALUES (?, ?, ?, ?)";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, estudiante.getSeccionId());
            ps.setString(2, estudiante.getNombreCompleto());
            ps.setInt(3, estudiante.getOrden());
            ps.setBoolean(4, estudiante.isActivo());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Guardar estudiante
    public boolean guardar(AsistenciaEstudiante estudiante) {
        String sql = "INSERT INTO asistencia_estudiantes (seccion_id, nombre_completo, codigo, orden, activo) VALUES (?, ?, ?, ?, ?)";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, estudiante.getSeccionId());
            ps.setString(2, estudiante.getNombreCompleto());
            ps.setString(3, estudiante.getCodigo());
            ps.setInt(4, 0); // orden por defecto
            ps.setBoolean(5, estudiante.isActivo());

            int filasAfectadas = ps.executeUpdate();
            System.out.println("✅ Estudiante guardado. Filas afectadas: " + filasAfectadas);
            return filasAfectadas > 0;
        } catch (Exception e) {
            System.err.println("❌ ERROR al guardar estudiante:");
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Actualizar estudiante
    public boolean actualizar(AsistenciaEstudiante estudiante) {
        String sql = "UPDATE asistencia_estudiantes SET seccion_id = ?, nombre_completo = ?, codigo = ?, orden = ?, activo = ? WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, estudiante.getSeccionId());
            ps.setString(2, estudiante.getNombreCompleto());
            ps.setString(3, estudiante.getCodigo());
            ps.setInt(4, estudiante.getOrden());
            ps.setBoolean(5, estudiante.isActivo());
            ps.setInt(6, estudiante.getId());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Eliminar estudiante (soft delete)
    public boolean eliminar(int id) {
        String sql = "UPDATE asistencia_estudiantes SET activo = 0 WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Contar estudiantes por sección
    public int contarPorSeccion(int seccionId) {
        int count = 0;
        String sql = "SELECT COUNT(*) as total FROM asistencia_estudiantes WHERE seccion_id = ? AND activo = 1";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return count;
    }

    // Cerrar recursos
    private void cerrarRecursos() {
        try {
            if (rs != null)
                rs.close();
            if (ps != null)
                ps.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
