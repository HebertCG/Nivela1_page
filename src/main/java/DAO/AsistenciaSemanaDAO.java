package DAO;

import SQL.conecct;
import modelo.AsistenciaSemana;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsistenciaSemanaDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    // Listar todas las semanas
    public List<AsistenciaSemana> listarTodas() {
        List<AsistenciaSemana> lista = new ArrayList<>();
        String sql = "SELECT * FROM asistencia_semanas ORDER BY numero_semana";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                AsistenciaSemana semana = new AsistenciaSemana();
                semana.setId(rs.getInt("id"));
                semana.setNumeroSemana(rs.getInt("numero_semana"));
                semana.setNombre(rs.getString("nombre"));
                semana.setFechaInicio(rs.getDate("fecha_inicio"));
                semana.setFechaFin(rs.getDate("fecha_fin"));
                semana.setActiva(rs.getInt("activa") == 1);
                semana.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                lista.add(semana);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return lista;
    }

    // Obtener semana activa
    public AsistenciaSemana obtenerActiva() {
        AsistenciaSemana semana = null;
        String sql = "SELECT * FROM asistencia_semanas WHERE activa = 1 LIMIT 1";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                semana = new AsistenciaSemana();
                semana.setId(rs.getInt("id"));
                semana.setNumeroSemana(rs.getInt("numero_semana"));
                semana.setNombre(rs.getString("nombre"));
                semana.setFechaInicio(rs.getDate("fecha_inicio"));
                semana.setFechaFin(rs.getDate("fecha_fin"));
                semana.setActiva(rs.getInt("activa") == 1);
                semana.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return semana;
    }

    // Obtener semana por ID
    public AsistenciaSemana obtenerPorId(int id) {
        AsistenciaSemana semana = null;
        String sql = "SELECT * FROM asistencia_semanas WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                semana = new AsistenciaSemana();
                semana.setId(rs.getInt("id"));
                semana.setNumeroSemana(rs.getInt("numero_semana"));
                semana.setNombre(rs.getString("nombre"));
                semana.setFechaInicio(rs.getDate("fecha_inicio"));
                semana.setFechaFin(rs.getDate("fecha_fin"));
                semana.setActiva(rs.getInt("activa") == 1);
                semana.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            cerrarRecursos();
        }

        return semana;
    }

    // Insertar nueva semana
    public boolean insertar(AsistenciaSemana semana) {
        String sql = "INSERT INTO asistencia_semanas (numero_semana, nombre, fecha_inicio, fecha_fin, activa) VALUES (?, ?, ?, ?, ?)";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, semana.getNumeroSemana());
            ps.setString(2, semana.getNombre());
            ps.setDate(3, semana.getFechaInicio());
            ps.setDate(4, semana.getFechaFin());
            ps.setInt(5, semana.isActiva() ? 1 : 0);

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Actualizar semana
    public boolean actualizar(AsistenciaSemana semana) {
        String sql = "UPDATE asistencia_semanas SET numero_semana = ?, nombre = ?, fecha_inicio = ?, fecha_fin = ?, activa = ? WHERE id = ?";

        try {
            conn = conecct.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, semana.getNumeroSemana());
            ps.setString(2, semana.getNombre());
            ps.setDate(3, semana.getFechaInicio());
            ps.setDate(4, semana.getFechaFin());
            ps.setInt(5, semana.isActiva() ? 1 : 0);
            ps.setInt(6, semana.getId());

            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cerrarRecursos();
        }
    }

    // Activar una semana (desactiva las demás)
    public boolean activarSemana(int id) {
        Connection conn = null;
        PreparedStatement ps1 = null;
        PreparedStatement ps2 = null;

        try {
            conn = conecct.getConnection();
            conn.setAutoCommit(false);

            // Desactivar todas las semanas
            String sql1 = "UPDATE asistencia_semanas SET activa = 0";
            ps1 = conn.prepareStatement(sql1);
            ps1.executeUpdate();

            // Activar la semana seleccionada
            String sql2 = "UPDATE asistencia_semanas SET activa = 1 WHERE id = ?";
            ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, id);
            ps2.executeUpdate();

            conn.commit();
            return true;
        } catch (Exception e) {
            try {
                if (conn != null)
                    conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps1 != null)
                    ps1.close();
                if (ps2 != null)
                    ps2.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
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
