package Controlador;

import SQL.conecct;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DiagnosticoServlet", urlPatterns = { "/DiagnosticoServlet" })
public class DiagnosticoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Diagnostico Servlet</title>");
            out.println(
                    "<style>table { border-collapse: collapse; width: 100%; font-family: sans-serif; } th, td { border: 1px solid #ddd; padding: 8px; } th { background-color: #f2f2f2; } tr:nth-child(even){background-color: #f9f9f9;} .success { color: green; font-weight: bold; } .fail { color: red; font-weight: bold; }</style>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Diagnostico Directo de Base de Datos</h1>");

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = conecct.getConnection();
                out.println("<p class='success'>✅ Conexión a BD Exitosa</p>");

                // 1. Verificar Estructura
                out.println("<h3>1. Estructura de Tabla 'asistencia_registros'</h3>");
                out.println("<table><thead><tr><th>Columna</th><th>Tipo</th></tr></thead><tbody>");

                stmt = conn.createStatement();
                rs = stmt.executeQuery("DESCRIBE asistencia_registros");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString(1) + "</td>");
                    out.println("<td>" + rs.getString(2) + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody></table>");
                rs.close(); // Cerrar RS para reusar stmt

                // 2. Verificar Datos
                out.println("<h3>2. Últimos 20 Registros insertados</h3>");
                out.println(
                        "<table><thead><tr><th>ID</th><th>Estudiante ID</th><th>Semana ID</th><th>Fecha Clase</th><th>Estado</th><th>Presente</th><th>Usuario</th></tr></thead><tbody>");

                rs = stmt.executeQuery("SELECT * FROM asistencia_registros ORDER BY id DESC LIMIT 20");
                boolean hayDatos = false;
                while (rs.next()) {
                    hayDatos = true;
                    String estado = rs.getString("estado");
                    String colorClass = (estado != null && !estado.equals("falto")) ? "success" : "";

                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getInt("estudiante_id") + "</td>");
                    out.println("<td>" + rs.getInt("semana_id") + "</td>");
                    out.println("<td>" + rs.getDate("fecha_clase") + "</td>");
                    out.println("<td class='" + colorClass + "'>" + (estado != null ? estado : "NULL") + "</td>");
                    out.println("<td>" + rs.getBoolean("presente") + "</td>");
                    out.println("<td>" + rs.getString("usuario_registro") + "</td>");
                    out.println("</tr>");
                }
                out.println("</tbody></table>");

                if (!hayDatos) {
                    out.println("<p class='fail'>⚠️ No se encontraron registros en la tabla.</p>");
                }

            } catch (Exception e) {
                out.println("<h2 class='fail'>❌ Error Grave:</h2>");
                out.println("<pre>" + e.toString() + "</pre>");
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null)
                        rs.close();
                } catch (Exception ex) {
                }
                try {
                    if (stmt != null)
                        stmt.close();
                } catch (Exception ex) {
                }
                try {
                    if (conn != null)
                        conn.close();
                } catch (Exception ex) {
                }
            }

            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
