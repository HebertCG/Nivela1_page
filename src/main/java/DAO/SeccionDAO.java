package DAO;

import SQL.conecct;
import modelo.Seccion;
import modelo.Grupo;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SeccionDAO {
    private conecct conecct = new conecct();

    /**
     * Listar todas las secciones de un grupo específico
     */
    public List<Seccion> listarSeccionesPorGrupo(int idGrupo) {
        List<Seccion> lista = new ArrayList<>();
        String sql = "SELECT s.*, g.nombre as nombre_grupo, COUNT(ge.id) as alumnos_actuales " +
                "FROM seccion s " +
                "INNER JOIN grupo g ON s.id_grupo = g.id " +
                "LEFT JOIN grupo_estudiante ge ON s.id = ge.id_seccion " +
                "WHERE s.id_grupo = ? " +
                "GROUP BY s.id " +
                "ORDER BY s.nombre";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idGrupo);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Seccion s = new Seccion();
                s.setId(rs.getInt("id"));
                s.setNombre(rs.getString("nombre"));
                s.setIdGrupo(rs.getInt("id_grupo"));
                s.setIdHorario(rs.getInt("id_horario"));
                s.setNombreGrupo(rs.getString("nombre_grupo"));
                s.setAlumnosActuales(rs.getInt("alumnos_actuales"));
                lista.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Obtener capacidad disponible de una sección
     * Cuenta cuántos estudiantes están asignados a esta sección vía
     * grupo_estudiante
     */
    public int obtenerCapacidadDisponible(int seccionId) {
        String sql = "SELECT COUNT(*) as total FROM grupo_estudiante " +
                "WHERE id_seccion = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, seccionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int ocupados = rs.getInt("total");
                return 45 - ocupados; // Capacidad máxima 45
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * Asignar un estudiante a una sección
     * Actualiza la tabla grupo_estudiante.id_seccion
     */
    public boolean asignarEstudianteASeccion(int usuarioId, int seccionId) {
        // Verificar capacidad disponible
        if (obtenerCapacidadDisponible(seccionId) <= 0) {
            return false;
        }

        String sql = "UPDATE grupo_estudiante SET id_seccion = ? WHERE id_usuario = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, seccionId);
            ps.setInt(2, usuarioId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Crear una nueva sección
     */
    public boolean crearNuevaSeccion(Seccion seccion) {
        String sql = "INSERT INTO seccion (nombre, id_grupo, id_horario) VALUES (?, ?, ?)";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, seccion.getNombre());
            ps.setInt(2, seccion.getIdGrupo());

            // Si no tiene horario asignado, insertar NULL
            if (seccion.getIdHorario() > 0) {
                ps.setInt(3, seccion.getIdHorario());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }

            int rowsAffected = ps.executeUpdate();
            System.out.println("✅ Sección creada: " + seccion.getNombre() + " (Grupo: " + seccion.getIdGrupo()
                    + ") - Rows affected: " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("❌ Error al crear sección: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Listar estudiantes sin asignar de un grupo específico
     * Usa grupo_estudiante para encontrar estudiantes sin sección
     */
    public List<modelo.Usuario> listarEstudiantesSinAsignar(int idGrupo) {
        List<modelo.Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.* FROM usuarios u " +
                "INNER JOIN grupo_estudiante ge ON u.id = ge.id_usuario " +
                "WHERE ge.id_grupo = ? " +
                "AND ge.id_seccion IS NULL " +
                "ORDER BY u.nombre, u.apellido";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idGrupo);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                modelo.Usuario u = new modelo.Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setCorreo(rs.getString("correo"));
                u.setCarrera(rs.getString("carrera"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Eliminar asignación de sección (mover a sin asignar)
     */
    public boolean removerDeSeccion(int preinscripcionId) {
        String sql = "UPDATE preinscripcion SET seccion_id = NULL WHERE id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, preinscripcionId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Listar todos los grupos
     */
    public List<Grupo> listarGrupos() {
        List<Grupo> lista = new ArrayList<>();
        String sql = "SELECT * FROM grupo ORDER BY nombre";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Grupo g = new Grupo();
                g.setId(rs.getInt("id"));
                g.setNombre(rs.getString("nombre"));
                g.setCarrera(rs.getString("carrera"));
                g.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                lista.add(g);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Obtener grupo por ID
     */
    public Grupo obtenerGrupoPorId(int id) {
        String sql = "SELECT * FROM grupo WHERE id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Grupo g = new Grupo();
                g.setId(rs.getInt("id"));
                g.setNombre(rs.getString("nombre"));
                g.setCarrera(rs.getString("carrera"));
                g.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                return g;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Obtener sección por ID (para DocentePanelServlet)
     */
    public modelo.Seccion obtenerPorId(int id) {
        String sql = "SELECT s.*, g.nombre as nombre_grupo FROM seccion s " +
                "LEFT JOIN grupo g ON s.id_grupo = g.id WHERE s.id = ?";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                modelo.Seccion s = new modelo.Seccion();
                s.setId(rs.getInt("id"));
                s.setNombre(rs.getString("nombre"));
                s.setIdGrupo(rs.getInt("id_grupo"));
                s.setIdHorario(rs.getInt("id_horario"));
                s.setNombreGrupo(rs.getString("nombre_grupo"));
                return s;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Listar todas las secciones (para ListarEstudiantesSeccionServlet)
     */
    public List<modelo.Seccion> listar() {
        List<modelo.Seccion> lista = new ArrayList<>();
        String sql = "SELECT s.*, g.nombre as nombre_grupo FROM seccion s " +
                "LEFT JOIN grupo g ON s.id_grupo = g.id ORDER BY s.nombre";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                modelo.Seccion s = new modelo.Seccion();
                s.setId(rs.getInt("id"));
                s.setNombre(rs.getString("nombre"));
                s.setIdGrupo(rs.getInt("id_grupo"));
                s.setIdHorario(rs.getInt("id_horario"));
                s.setNombreGrupo(rs.getString("nombre_grupo"));
                lista.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    /**
     * Listar estudiantes por sección (para ListarEstudiantesSeccionServlet)
     */
    public List<modelo.Usuario> listarEstudiantesPorSeccion(int idSeccion) {
        List<modelo.Usuario> lista = new ArrayList<>();
        String sql = "SELECT u.* FROM usuarios u " +
                "INNER JOIN grupo_estudiante ge ON u.id = ge.id_usuario " +
                "INNER JOIN seccion s ON ge.id_grupo = s.id_grupo " +
                "WHERE s.id = ? ORDER BY u.apellido, u.nombre";

        try (Connection conn = conecct.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idSeccion);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                modelo.Usuario u = new modelo.Usuario();
                u.setId(rs.getInt("id"));
                u.setCorreo(rs.getString("correo"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setIdRol(rs.getInt("id_rol"));
                u.setGrupo(rs.getString("grupo"));
                u.setEstado(rs.getInt("estado"));
                lista.add(u);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
