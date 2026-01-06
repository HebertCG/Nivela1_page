package Controlador;

import DAO.AsistenciaEstudianteDAO;
import modelo.AsistenciaEstudiante;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegistrarEstudianteServlet", urlPatterns = { "/RegistrarEstudianteServlet" })
public class RegistrarEstudianteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        try {
            // DEBUG: Log all parameters
            System.out.println("=== RegistrarEstudianteServlet DEBUG ===");
            System.out.println("Method: " + request.getMethod());
            System.out.println("Content-Type: " + request.getContentType());
            System.out.println("All Parameters:");
            request.getParameterMap().forEach((key, values) -> {
                System.out.println("  " + key + " = " + String.join(", ", values));
            });

            String seccionIdStr = request.getParameter("seccionId");
            String nombreCompleto = request.getParameter("nombreCompleto");
            String codigo = request.getParameter("codigo");

            System.out.println("seccionIdStr: [" + seccionIdStr + "]");
            System.out.println("nombreCompleto: [" + nombreCompleto + "]");
            System.out.println("codigo: [" + codigo + "]");
            System.out.println("========================================");

            // Validar que seccionId no sea null o vacío
            if (seccionIdStr == null || seccionIdStr.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"Debe seleccionar una sección\"}");
                return;
            }

            // Validar nombre
            if (nombreCompleto == null || nombreCompleto.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"El nombre es requerido\"}");
                return;
            }

            // Convertir seccionId a entero
            int seccionId;
            try {
                seccionId = Integer.parseInt(seccionIdStr);
            } catch (NumberFormatException e) {
                response.getWriter()
                        .write("{\"success\": false, \"message\": \"ID de sección inválido: " + seccionIdStr + "\"}");
                return;
            }

            AsistenciaEstudiante estudiante = new AsistenciaEstudiante();
            estudiante.setSeccionId(seccionId);
            estudiante.setNombreCompleto(nombreCompleto.trim());
            estudiante.setCodigo(codigo != null && !codigo.trim().isEmpty() ? codigo.trim() : null);
            estudiante.setActivo(true);

            AsistenciaEstudianteDAO dao = new AsistenciaEstudianteDAO();
            boolean guardado = dao.guardar(estudiante);

            if (guardado) {
                response.getWriter().write("{\"success\": true, \"message\": \"Estudiante registrado correctamente\"}");
            } else {
                response.getWriter()
                        .write("{\"success\": false, \"message\": \"Error al guardar en la base de datos\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter()
                    .write("{\"success\": false, \"message\": \"Error del servidor: " + e.getMessage() + "\"}");
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
