package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import modelo.Preinscripcion;

@WebServlet("/admin/ExportarExcelDeudores")
public class ExportarExcelDeudoresServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filtro = request.getParameter("filtro");
        String grado = request.getParameter("grado");

        if (filtro == null)
            filtro = "todos";

        // Obtener datos
        Map<String, Object> datos = preinscripcionDAO.obtenerDatosFinancieros(filtro, grado);
        List<Preinscripcion> lista = (List<Preinscripcion>) datos.get("preinscripciones");

        // Configurar respuesta para descarga de Excel
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("UTF-8");

        String fileName = "Control_Financiero_" + new SimpleDateFormat("yyyyMMdd_HHmmss").format(new java.util.Date())
                + ".xls";
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        PrintWriter out = response.getWriter();

        // Escribir HTML como tabla Excel
        out.println("<html xmlns:x=\"urn:schemas-microsoft-com:office:excel\">");
        out.println("<head>");
        out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
        out.println("<style>");
        out.println("table { border-collapse: collapse; }");
        out.println(
                "th { background-color: #667eea; color: white; font-weight: bold; padding: 8px; border: 1px solid #ccc; }");
        out.println("td { padding: 6px; border: 1px solid #ccc; }");
        out.println(".pagado { background-color: #D1FAE5; }");
        out.println(".pendiente { background-color: #FEF3C7; }");
        out.println(".header-info { font-size: 18px; font-weight: bold; margin-bottom: 10px; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");

        // Título y resumen
        out.println("<p class='header-info'>Control Financiero - Academia Nivel A1</p>");
        out.println("<p>Fecha de exportación: " + new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new java.util.Date())
                + "</p>");
        out.println("<p>Filtro: " + filtro.toUpperCase()
                + (grado != null && !grado.isEmpty() ? " | Grado: " + grado : "") + "</p>");
        out.println("<p>Total registros: " + lista.size() + "</p>");
        out.println("<br/>");

        // Métricas
        out.println("<table>");
        out.println("<tr><th>Total Esperado</th><th>Total Recaudado</th><th>Total Pendiente</th></tr>");
        out.println("<tr>");
        out.println("<td>S/. " + String.format("%.2f", datos.get("totalEsperado")) + "</td>");
        out.println("<td>S/. " + String.format("%.2f", datos.get("totalRecaudado")) + "</td>");
        out.println("<td>S/. " + String.format("%.2f", datos.get("totalPendiente")) + "</td>");
        out.println("</tr>");
        out.println("</table>");
        out.println("<br/>");

        // Tabla de datos
        out.println("<table>");
        out.println("<tr>");
        out.println("<th>Fecha Reg.</th>");
        out.println("<th>DNI</th>");
        out.println("<th>Alumno</th>");
        out.println("<th>Grado</th>");
        out.println("<th>Carrera</th>");
        out.println("<th>Apoderado</th>");
        out.println("<th>Email Apod.</th>");
        out.println("<th>Tel. 1</th>");
        out.println("<th>Tel. 2</th>");
        out.println("<th>Modalidad</th>");
        out.println("<th>Método</th>");
        out.println("<th>Total</th>");
        out.println("<th>Pagado</th>");
        out.println("<th>Saldo</th>");
        out.println("<th>Límite 2da</th>");
        out.println("<th>Estado</th>");
        out.println("</tr>");

        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        SimpleDateFormat sdfTime = new SimpleDateFormat("dd/MM/yyyy HH:mm");

        for (Preinscripcion p : lista) {
            String estadoClass = p.getSaldoPendiente() == 0 ? "pagado" : "pendiente";
            String estadoTexto = p.getSaldoPendiente() == 0 ? "Pagado" : "Pendiente";

            out.println("<tr class='" + estadoClass + "'>");
            out.println("<td>" + (p.getFechaRegistro() != null ? sdfTime.format(p.getFechaRegistro()) : "-") + "</td>");
            out.println("<td>" + safeString(p.getDni()) + "</td>");
            out.println("<td>" + safeString(p.getNombres()) + " " + safeString(p.getApellidos()) + "</td>");
            out.println("<td>" + safeString(p.getGrado()) + "</td>");
            out.println("<td>" + safeString(p.getCarrera()) + "</td>");
            out.println(
                    "<td>" + safeString(p.getNombreApoderado()) + " " + safeString(p.getApellidoApoderado()) + "</td>");
            out.println("<td>" + safeString(p.getEmailApoderado()) + "</td>");
            out.println("<td>" + safeString(p.getTelefonoApoderado()) + "</td>");
            out.println("<td>" + safeString(p.getTelefono2Apoderado()) + "</td>");
            out.println("<td>" + safeString(p.getModalidadPago()) + "</td>");
            out.println("<td>" + safeString(p.getMetodoPago()) + "</td>");
            out.println("<td>S/. " + String.format("%.2f", p.getMontoTotal()) + "</td>");
            out.println("<td>S/. " + String.format("%.2f", p.getMontoPagado()) + "</td>");
            out.println("<td>S/. " + String.format("%.2f", p.getSaldoPendiente()) + "</td>");
            out.println("<td>" + (p.getFechaLimite2daCuota() != null ? sdf.format(p.getFechaLimite2daCuota()) : "-")
                    + "</td>");
            out.println("<td>" + estadoTexto + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");
        out.println("</body>");
        out.println("</html>");

        out.flush();
        out.close();
    }

    private String safeString(String value) {
        return value != null ? value : "-";
    }
}
