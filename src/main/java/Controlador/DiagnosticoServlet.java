package Controlador;

import DAO.*;
import modelo.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiagnosticoServlet", urlPatterns = { "/DiagnosticoServlet", "/admin/DiagnosticoServlet" })
public class DiagnosticoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            AsistenciaSeccionDAO seccionDAO = new AsistenciaSeccionDAO();
            AsistenciaEstudianteDAO estudianteDAO = new AsistenciaEstudianteDAO();
            AsistenciaRegistroDAO registroDAO = new AsistenciaRegistroDAO();

            String seccionIdStr = request.getParameter("seccionId");

            out.println("<!DOCTYPE html>");
            out.println("<html><head><title>Diagnóstico de Datos</title>");
            out.println("<link rel='stylesheet' href='assets/bootstrap/css/bootstrap.min.css'>");
            out.println("</head><body class='p-4'>");
            out.println("<h1>🛠️ Diagnóstico de Base de Datos</h1>");
            out.println("<a href='DiagnosticoServlet' class='btn btn-secondary mb-3'>Volver a Secciones</a>");

            // LOGICA REPARACION
            String action = request.getParameter("action");
            if ("repair".equals(action)) {
                try {
                    java.sql.Connection conn = SQL.conecct.getConnection();
                    String sqlDelete = "DELETE t1 FROM asistencia_registros t1 " +
                            "INNER JOIN asistencia_registros t2 " +
                            "WHERE t1.id < t2.id " +
                            "AND t1.estudiante_id = t2.estudiante_id " +
                            "AND t1.fecha_clase = t2.fecha_clase";
                    java.sql.PreparedStatement ps = conn.prepareStatement(sqlDelete);
                    int deleted = ps.executeUpdate();
                    out.println("<div class='alert alert-success'>✅ Se eliminaron " + deleted
                            + " registros duplicados.</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>❌ Error reparando: " + e.getMessage() + "</div>");
                }
            } else if ("fixDates".equals(action)) {
                try {
                    java.sql.Connection conn = SQL.conecct.getConnection();
                    // Actualizar las semanas con sus fechas correctas (Iniciando Lunes 5 Enero
                    // 2026)
                    String[] fechas = {
                            "2026-01-05", // Semana 1
                            "2026-01-12", // Semana 2
                            "2026-01-19", // Semana 3
                            "2026-01-26", // Semana 4
                            "2026-02-02", // Semana 5
                            "2026-02-09", // Semana 6
                            "2026-02-16", // Semana 7
                            "2026-02-23", // Semana 8
                            "2026-03-02", // Semana 9
                            "2026-03-09" // Semana 10
                    };

                    int updated = 0;
                    String sqlUpdate = "UPDATE asistencia_semanas SET fecha_inicio = ? WHERE id = ?";
                    java.sql.PreparedStatement ps = conn.prepareStatement(sqlUpdate);

                    for (int i = 0; i < fechas.length; i++) {
                        ps.setDate(1, java.sql.Date.valueOf(fechas[i]));
                        ps.setInt(2, i + 1); // ID 1 a 10
                        updated += ps.executeUpdate();
                    }

                    out.println("<div class='alert alert-success'>✅ Se actualizaron fechas de inicio para " + updated
                            + " semanas.</div>");
                } catch (Exception e) {
                    out.println("<div class='alert alert-danger'>❌ Error actualizando fechas: " + e.getMessage()
                            + "</div>");
                }
            } else if ("fixWeekIds".equals(action)) {
                try {
                    java.sql.Connection conn = SQL.conecct.getConnection();
                    int updated = 0;
                    String[] updates = {
                            "UPDATE asistencia_registros SET semana_id = 1 WHERE fecha_clase BETWEEN '2026-01-05' AND '2026-01-11'",
                            "UPDATE asistencia_registros SET semana_id = 2 WHERE fecha_clase BETWEEN '2026-01-12' AND '2026-01-18'",
                            "UPDATE asistencia_registros SET semana_id = 3 WHERE fecha_clase BETWEEN '2026-01-19' AND '2026-01-25'",
                            "UPDATE asistencia_registros SET semana_id = 4 WHERE fecha_clase BETWEEN '2026-01-26' AND '2026-02-01'",
                            "UPDATE asistencia_registros SET semana_id = 5 WHERE fecha_clase BETWEEN '2026-02-02' AND '2026-02-08'",
                            "UPDATE asistencia_registros SET semana_id = 6 WHERE fecha_clase BETWEEN '2026-02-09' AND '2026-02-15'",
                            "UPDATE asistencia_registros SET semana_id = 7 WHERE fecha_clase BETWEEN '2026-02-16' AND '2026-02-22'",
                            "UPDATE asistencia_registros SET semana_id = 8 WHERE fecha_clase BETWEEN '2026-02-23' AND '2026-03-01'",
                            "UPDATE asistencia_registros SET semana_id = 9 WHERE fecha_clase BETWEEN '2026-03-02' AND '2026-03-08'",
                            "UPDATE asistencia_registros SET semana_id = 10 WHERE fecha_clase BETWEEN '2026-03-09' AND '2026-03-15'"
                    };

                    java.sql.Statement stmt = conn.createStatement();
                    for (String sql : updates) {
                        updated += stmt.executeUpdate(sql);
                    }

                    out.println("<div class='alert alert-success'>✅ Se corrigieron IDs de semana para " + updated
                            + " registros.</div>");
                } catch (Exception e) {
                    out.println(
                            "<div class='alert alert-danger'>❌ Error corrigiendo IDs: " + e.getMessage() + "</div>");
                }
            }

            if (seccionIdStr == null) {
                // Listar Secciones
                List<AsistenciaSeccion> secciones = seccionDAO.listarTodas();
                out.println("<h3>Seleccione una Sección para analizar:</h3>");
                out.println("<div class='mb-3'>");
                out.println(
                        "<a href='DiagnosticoServlet?action=repair' class='btn btn-danger me-2'>⚠️ Reparar TODOS los Duplicados</a>");
                out.println(
                        "<a href='DiagnosticoServlet?action=fixDates' class='btn btn-success me-2'>📅 Corregir Fechas de Semanas BD</a>");
                out.println(
                        "<a href='DiagnosticoServlet?action=fixWeekIds' class='btn btn-info text-white'>🛠️ Corregir IDs de Registros</a>");
                out.println("</div>");
                out.println("<div class='list-group'>");
                for (AsistenciaSeccion s : secciones) {
                    int count = estudianteDAO.contarPorSeccion(s.getId());
                    out.println("<a href='DiagnosticoServlet?seccionId=" + s.getId()
                            + "' class='list-group-item list-group-item-action'>");
                    out.println(s.getNombre() + " (ID: " + s.getId() + ") - Estudiantes Activos: " + count);
                    out.println("</a>");
                }
                out.println("</div>");

            } else {
                // Analizar Estudiantes de la Sección
                int seccionId = Integer.parseInt(seccionIdStr);
                AsistenciaSeccion seccion = seccionDAO.obtenerPorId(seccionId);
                List<AsistenciaEstudiante> estudiantes = estudianteDAO.listarPorSeccion(seccionId);

                // Mostrar Info de Semanas
                List<AsistenciaSemana> semanas = new DAO.AsistenciaSemanaDAO().listarTodas();
                out.println("<div class='alert alert-info'><strong>Info Semanas (BD):</strong><ul>");
                for (AsistenciaSemana s : semanas) {
                    out.println("<li>ID: " + s.getId() + " | " + s.getNombre() + " | Inicio: <strong>"
                            + s.getFechaInicio() + "</strong></li>");
                }
                out.println("</ul></div>");

                out.println("<h3>Analizando: " + (seccion != null ? seccion.getNombre() : "Desconocida") + "</h3>");
                out.println("<div class='mb-3'>");
                out.println("<a href='DiagnosticoServlet?seccionId=" + seccionId
                        + "&action=repair' class='btn btn-warning'>🛠️ Reparar Duplicados (Solo SQL)</a>");
                out.println("</div>");

                out.println("<table class='table table-bordered table-striped'>");
                out.println("<thead class='table-dark'><tr>");
                out.println(
                        "<th>ID</th><th>Nombre</th><th>Activo</th><th>Detalle Registros [ID Semana: Fecha]</th></tr></thead>");
                out.println("<tbody>");

                // Detectar Duplicados por Nombre
                Map<String, Integer> nameCount = new HashMap<>();
                for (AsistenciaEstudiante e : estudiantes) {
                    nameCount.put(e.getNombreCompleto(), nameCount.getOrDefault(e.getNombreCompleto(), 0) + 1);
                }

                for (AsistenciaEstudiante e : estudiantes) {
                    List<AsistenciaRegistro> registros = registroDAO.obtenerPorEstudiante(e.getId());

                    String rowClass = "";
                    if (nameCount.get(e.getNombreCompleto()) > 1) {
                        rowClass = "table-warning"; // Resaltar duplicados
                    }

                    out.println("<tr class='" + rowClass + "'>");
                    out.println("<td>" + e.getId() + "</td>");

                    String nombreDisplay = e.getNombreCompleto();
                    if (nameCount.get(e.getNombreCompleto()) > 1) {
                        nombreDisplay += " <span class='badge bg-danger'>DUPLICADO</span>";
                    }
                    out.println("<td>" + nombreDisplay + "</td>");

                    out.println("<td>" + (e.isActivo() ? "SI" : "NO") + "</td>");

                    // Detalle de fecha exacta
                    StringBuilder detalle = new StringBuilder();
                    for (AsistenciaRegistro r : registros) {
                        detalle.append("<span class='badge bg-secondary me-1'>[").append(r.getSemanaId()).append(":")
                                .append(r.getFechaClase()).append("]</span> ");
                    }
                    out.println("<td>" + (detalle.length() > 0 ? detalle.toString() : "-") + "</td>");

                    out.println("</tr>");
                }
                out.println("</tbody></table>");
            }

            out.println("</body></html>");

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
