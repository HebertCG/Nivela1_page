package DAO;

import SQL.conecct;
import modelo.AsistenciaSeccion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaSeccionDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Listar todas las secciones
    public List<AsistenciaSeccion> listarTodas() {
        List<AsistenciaSeccion> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencia_secciones WHERE activo = TRUE ORDER BY orden";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaSeccion seccion = new AsistenciaSeccion();
                seccion.setId(rs.getInt("id"));
                seccion.setNombre(rs.getString("nombre"));
                seccion.setDescripcion(rs.getString("descripcion"));
                seccion.setOrden(rs.getInt("orden"));
                seccion.setActivo(rs.getBoolean("activo"));
                lista.add(seccion);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Obtener sección por ID
    public AsistenciaSeccion obtenerPorId(int id) {
        AsistenciaSeccion seccion = null;
        String sql = "SELECT * FROM asistencia_secciones WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                seccion = new AsistenciaSeccion();
                seccion.setId(rs.getInt("id"));
                seccion.setNombre(rs.getString("nombre"));
                seccion.setDescripcion(rs.getString("descripcion"));
                seccion.setOrden(rs.getInt("orden"));
                seccion.setActivo(rs.getBoolean("activo"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return seccion;
    }

    // Insertar nueva sección
    public boolean insertar(AsistenciaSeccion seccion) {
        String sql = "INSERT INTO asistencia_secciones (nombre, descripcion, orden, activo) VALUES (?, ?, ?, ?)";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, seccion.getNombre());
            ps.setString(2, seccion.getDescripcion());
            ps.setInt(3, seccion.getOrden());
            ps.setBoolean(4, seccion.isActivo());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Actualizar sección
    public boolean actualizar(AsistenciaSeccion seccion) {
        String sql = "UPDATE asistencia_secciones SET nombre = ?, descripcion = ?, orden = ?, activo = ? WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, seccion.getNombre());
            ps.setString(2, seccion.getDescripcion());
            ps.setInt(3, seccion.getOrden());
            ps.setBoolean(4, seccion.isActivo());
            ps.setInt(5, seccion.getId());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Eliminar sección (soft delete)
    public boolean eliminar(int id) {
        String sql = "UPDATE asistencia_secciones SET activo = FALSE WHERE id = ?";

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
