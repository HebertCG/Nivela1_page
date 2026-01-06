package DAO;

import SQL.conecct;
import modelo.AsistenciaRegistro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaRegistroDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Obtener asistencias por sección y semana (TODOS LOS DÍAS)
    public List<AsistenciaRegistro> obtenerPorSeccionYSemana(int seccionId, int semanaId) {
        List<AsistenciaRegistro> lista = new ArrayList<>();
        String sql = "SELECT r.*, e.nombre_completo, e.orden, s.nombre as nombre_semana, s.numero_semana " +
                "FROM asistencia_registros r " +
                "INNER JOIN asistencia_estudiantes e ON r.estudiante_id = e.id " +
                "INNER JOIN asistencia_semanas s ON r.semana_id = s.id " +
                "WHERE e.seccion_id = ? AND r.semana_id = ? AND e.activo = TRUE " +
                "ORDER BY r.fecha_clase, e.orden, e.nombre_completo";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            ps.setInt(2, semanaId);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaRegistro registro = new AsistenciaRegistro();
                registro.setId(rs.getInt("id"));
                registro.setEstudianteId(rs.getInt("estudiante_id"));
                registro.setSemanaId(rs.getInt("semana_id"));
                registro.setFechaClase(rs.getDate("fecha_clase"));
                registro.setEstado(rs.getString("estado"));
                registro.setPresente(rs.getBoolean("presente"));
                registro.setObservaciones(rs.getString("observaciones"));
                registro.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                registro.setUsuarioRegistro(rs.getString("usuario_registro"));
                registro.setNombreEstudiante(rs.getString("nombre_completo"));
                registro.setNombreSemana(rs.getString("nombre_semana"));
                registro.setNumeroSemana(rs.getInt("numero_semana"));
                lista.add(registro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Obtener asistencias por sección y fecha específica
    public List<AsistenciaRegistro> obtenerPorSeccionYFecha(int seccionId, Date fecha) {
        List<AsistenciaRegistro> lista = new ArrayList<>();
        String sql = "SELECT r.*, e.nombre_completo, e.orden " +
                "FROM asistencia_registros r " +
                "INNER JOIN asistencia_estudiantes e ON r.estudiante_id = e.id " +
                "WHERE e.seccion_id = ? AND r.fecha_clase = ? AND e.activo = TRUE " +
                "ORDER BY e.orden, e.nombre_completo";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            ps.setDate(2, fecha);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaRegistro registro = new AsistenciaRegistro();
                registro.setId(rs.getInt("id"));
                registro.setEstudianteId(rs.getInt("estudiante_id"));
                registro.setSemanaId(rs.getInt("semana_id"));
                registro.setFechaClase(rs.getDate("fecha_clase"));
                registro.setEstado(rs.getString("estado"));
                registro.setPresente(rs.getBoolean("presente"));
                registro.setObservaciones(rs.getString("observaciones"));
                registro.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                registro.setUsuarioRegistro(rs.getString("usuario_registro"));
                registro.setNombreEstudiante(rs.getString("nombre_completo"));
                lista.add(registro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Guardar o actualizar asistencia DIARIA con ESTADO
    public boolean guardarAsistencia(int estudianteId, int semanaId, Date fechaClase, String estado, String usuario) {
        String sqlCheck = "SELECT id FROM asistencia_registros WHERE estudiante_id = ? AND fecha_clase = ?";
        String sqlInsert = "INSERT INTO asistencia_registros (estudiante_id, semana_id, fecha_clase, estado, presente, usuario_registro) VALUES (?, ?, ?, ?, ?, ?)";
        String sqlUpdate = "UPDATE asistencia_registros SET estado = ?, presente = ?, usuario_registro = ?, fecha_registro = CURRENT_TIMESTAMP WHERE estudiante_id = ? AND fecha_clase = ?";

        try {
            conn = conecct.getConnection();

            System.out.println("DAO: Guardando Est:" + estudianteId + " Sem:" + semanaId + " Fech:" + fechaClase
                    + " Edo:" + estado);

            // Verificar si ya existe
            ps = conn.prepareStatement(sqlCheck);
            ps.setInt(1, estudianteId);
            ps.setDate(2, fechaClase);
            rs = ps.executeQuery();

            boolean presente = "asistio".equals(estado) || "tardanza".equals(estado); // Tardanza cuenta como presente
                                                                                      // para logica simple

            int filasAfectadas = 0;
            if (rs.next()) {
                // Actualizar
                System.out.println("... Actualizando registro existente");
                ps = conn.prepareStatement(sqlUpdate);
                ps.setString(1, estado);
                ps.setBoolean(2, presente);
                ps.setString(3, usuario);
                ps.setInt(4, estudianteId);
                ps.setDate(5, fechaClase);
                filasAfectadas = ps.executeUpdate();
            } else {
                // Insertar
                System.out.println("... Insertando nuevo registro");
                ps = conn.prepareStatement(sqlInsert);
                ps.setInt(1, estudianteId);
                ps.setInt(2, semanaId);
                ps.setDate(3, fechaClase);
                ps.setString(4, estado);
                ps.setBoolean(5, presente);
                ps.setString(6, usuario);
                filasAfectadas = ps.executeUpdate();
            }

            System.out.println("... Filas afectadas: " + filasAfectadas);
            return filasAfectadas > 0;
        } catch (Exception e) {
            System.out.println("❌ Error DAO Guardar: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Obtener asistencia de un estudiante en una fecha
    public AsistenciaRegistro obtenerAsistencia(int estudianteId, Date fechaClase) {
        AsistenciaRegistro registro = null;
        String sql = "SELECT * FROM asistencia_registros WHERE estudiante_id = ? AND fecha_clase = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, estudianteId);
            ps.setDate(2, fechaClase);
            rs = ps.executeQuery();

            if (rs.next()) {
                registro = new AsistenciaRegistro();
                registro.setId(rs.getInt("id"));
                registro.setEstudianteId(rs.getInt("estudiante_id"));
                registro.setSemanaId(rs.getInt("semana_id"));
                registro.setFechaClase(rs.getDate("fecha_clase"));
                registro.setEstado(rs.getString("estado"));
                registro.setPresente(rs.getBoolean("presente"));
                registro.setObservaciones(rs.getString("observaciones"));
                registro.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                registro.setUsuarioRegistro(rs.getString("usuario_registro"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return registro;
    }

    // Obtener todas las asistencias de un estudiante
    public List<AsistenciaRegistro> obtenerPorEstudiante(int estudianteId) {
        List<AsistenciaRegistro> lista = new ArrayList<>();
        String sql = "SELECT r.*, s.nombre as nombre_semana, s.numero_semana " +
                "FROM asistencia_registros r " +
                "INNER JOIN asistencia_semanas s ON r.semana_id = s.id " +
                "WHERE r.estudiante_id = ? " +
                "ORDER BY r.fecha_clase";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, estudianteId);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaRegistro registro = new AsistenciaRegistro();
                registro.setId(rs.getInt("id"));
                registro.setEstudianteId(rs.getInt("estudiante_id"));
                registro.setSemanaId(rs.getInt("semana_id"));
                registro.setFechaClase(rs.getDate("fecha_clase"));
                registro.setEstado(rs.getString("estado"));
                registro.setPresente(rs.getBoolean("presente"));
                registro.setObservaciones(rs.getString("observaciones"));
                registro.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                registro.setUsuarioRegistro(rs.getString("usuario_registro"));
                registro.setNombreSemana(rs.getString("nombre_semana"));
                registro.setNumeroSemana(rs.getInt("numero_semana"));
                lista.add(registro);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
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
