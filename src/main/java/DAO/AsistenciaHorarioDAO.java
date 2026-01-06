package DAO;

import SQL.conecct;
import modelo.AsistenciaHorario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaHorarioDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Listar horarios por sección
    public List<AsistenciaHorario> obtenerPorSeccion(int seccionId) {
        List<AsistenciaHorario> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencia_horarios WHERE seccion_id = ? ORDER BY " +
                "FIELD(dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo')";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaHorario horario = new AsistenciaHorario();
                horario.setId(rs.getInt("id"));
                horario.setSeccionId(rs.getInt("seccion_id"));
                horario.setDiaSemana(rs.getString("dia_semana"));
                lista.add(horario);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Obtener solo los nombres de los días
    public List<String> obtenerDiasPorSeccion(int seccionId) {
        List<String> dias = new ArrayList<>();
        String sql = "SELECT dia_semana FROM asistencia_horarios WHERE seccion_id = ? ORDER BY " +
                "FIELD(dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo')";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            rs = ps.executeQuery();

            while (rs.next()) {
                dias.add(rs.getString("dia_semana"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return dias;
    }

    // Insertar nuevo horario
    public boolean insertar(AsistenciaHorario horario) {
        String sql = "INSERT INTO asistencia_horarios (seccion_id, dia_semana) VALUES (?, ?)";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, horario.getSeccionId());
            ps.setString(2, horario.getDiaSemana());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Eliminar horario
    public boolean eliminar(int id) {
        String sql = "DELETE FROM asistencia_horarios WHERE id = ?";

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

    // Verificar si un día es válido para una sección
    public boolean esDiaValido(int seccionId, String diaSemana) {
        String sql = "SELECT COUNT(*) as total FROM asistencia_horarios WHERE seccion_id = ? AND dia_semana = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, seccionId);
            ps.setString(2, diaSemana);
            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return false;
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
