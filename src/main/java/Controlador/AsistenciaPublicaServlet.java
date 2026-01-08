package Controlador;

import DAO.*;
import modelo.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AsistenciaPublicaServlet", urlPatterns = { "/AsistenciaPublicaServlet" })
public class AsistenciaPublicaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("getData".equals(action)) {
            getData(request, response);
        } else {
            loadPage(request, response);
        }
    }

    private void loadPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            AsistenciaSeccionDAO seccionDAO = new AsistenciaSeccionDAO();
            AsistenciaSemanaDAO semanaDAO = new AsistenciaSemanaDAO();

            List<AsistenciaSeccion> secciones = seccionDAO.listarTodas();
            List<AsistenciaSemana> semanas = semanaDAO.listarTodas();

            request.setAttribute("secciones", secciones);
            request.setAttribute("semanas", semanas);

            request.getRequestDispatcher("asistencia-publica.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error cargando página: " + e.getMessage());
        }
    }

    private void getData(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            System.out.println("Processing Public Request...");

            // Check params
            if (request.getParameter("seccionId") == null || request.getParameter("semanaId") == null) {
                response.getWriter()
                        .write("{\"success\": false, \"message\": \"Faltan parámetros seccionId o semanaId\"}");
                return;
            }

            int seccionId = Integer.parseInt(request.getParameter("seccionId"));
            int semanaId = Integer.parseInt(request.getParameter("semanaId"));
            System.out.println("🔍 PublicServlet: Req Sec=" + seccionId + " Sem=" + semanaId);

            AsistenciaEstudianteDAO estudianteDAO = new AsistenciaEstudianteDAO();
            AsistenciaRegistroDAO registroDAO = new AsistenciaRegistroDAO();
            AsistenciaHorarioDAO horarioDAO = new AsistenciaHorarioDAO();

            // Obtener estudiantes de la sección
            List<AsistenciaEstudiante> estudiantes = estudianteDAO.listarPorSeccion(seccionId);
            System.out.println("   Found Students: " + estudiantes.size());

            // Obtener días de clase de la sección
            // ⚠️ FIX: Usar la misma lógica que el Admin (GetAsistenciaSemanalServlet) para
            // consistencia
            // en lugar de confiar en asistencia_horarios que puede tener datos erróneos
            // ("Martes" vs "Miércoles")
            AsistenciaSeccionDAO seccionDAO = new AsistenciaSeccionDAO();
            AsistenciaSeccion seccionObj = seccionDAO.obtenerPorId(seccionId);
            String nombreSeccion = (seccionObj != null) ? seccionObj.getNombre() : "";
            nombreSeccion = nombreSeccion.toLowerCase();

            List<String> diasClase = new ArrayList<>();
            if (nombreSeccion.contains("4to") || nombreSeccion.contains("5to")) {
                diasClase = Arrays.asList("Lunes", "Martes", "Miércoles", "Jueves", "Viernes");
            } else if (nombreSeccion.contains("2do") || nombreSeccion.contains("3ro")) {
                diasClase = Arrays.asList("Lunes", "Miércoles", "Viernes");
            } else if (nombreSeccion.contains("6to") || nombreSeccion.contains("1ro")) {
                diasClase = Arrays.asList("Martes", "Jueves", "Sábado");
            } else {
                diasClase = Arrays.asList("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado");
            }

            // Obtener todas las asistencias de la semana
            List<AsistenciaRegistro> registros = registroDAO.obtenerPorSeccionYSemana(seccionId, semanaId);
            System.out.println("   Found Registros: " + registros.size());

            // Construir JSON
            StringBuilder json = new StringBuilder();
            json.append("{\"success\": true, ");
            json.append("\"diasClase\": [");

            for (int i = 0; i < diasClase.size(); i++) {
                json.append("\"").append(escapeJson(diasClase.get(i))).append("\"");
                if (i < diasClase.size() - 1)
                    json.append(",");
            }

            json.append("], \"estudiantes\": [");

            for (int i = 0; i < estudiantes.size(); i++) {
                AsistenciaEstudiante est = estudiantes.get(i);
                json.append("{");
                json.append("\"nombre\": \"").append(escapeJson(est.getNombreCompleto())).append("\",");
                json.append("\"asistencias\": {");

                // Buscar asistencias de este estudiante
                boolean first = true;
                for (AsistenciaRegistro reg : registros) {
                    if (reg.getEstudianteId() == est.getId()) {
                        if (!first)
                            json.append(",");
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        String fecha = sdf.format(reg.getFechaClase());

                        // Ensure estado is not null
                        String estadoSafe = reg.getEstado() != null ? reg.getEstado() : "falto";

                        json.append("\"").append(fecha).append("\": \"").append(escapeJson(estadoSafe)).append("\"");
                        first = false;
                    }
                }

                json.append("}");
                json.append("}");

                if (i < estudiantes.size() - 1)
                    json.append(",");
            }

            json.append("]}");
            System.out.println("📤 JSON generated successfully");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500); // 500 para que el fetch lo detecte si no parsea JSON
            response.getWriter().write("{\"success\": false, \"message\": \"" + escapeJson(e.getMessage()) + "\"}");
        }
    }

    // Helper para escapar caracteres JSON
    private String escapeJson(String str) {
        if (str == null)
            return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\b", "\\b")
                .replace("\f", "\\f")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
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
