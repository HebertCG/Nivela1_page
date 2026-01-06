package Controlador;

import DAO.AsistenciaRegistroDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "GuardarAsistenciaServlet", urlPatterns = { "/GuardarAsistenciaServlet" })
public class GuardarAsistenciaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Sesión expirada\"}");
            return;
        }

        String usuario = (String) session.getAttribute("usuario");

        try {
            int semanaId = Integer.parseInt(request.getParameter("semanaId"));
            String fechaClaseStr = request.getParameter("fechaClase");
            Date fechaClase = Date.valueOf(fechaClaseStr);

            String[] estudiantesIds = request.getParameterValues("estudiantes[]");

            if (estudiantesIds == null || estudiantesIds.length == 0) {
                response.getWriter().write("{\"success\": false, \"message\": \"No se recibieron estudiantes\"}");
                return;
            }

            AsistenciaRegistroDAO dao = new AsistenciaRegistroDAO();
            int guardados = 0;

            for (String estudianteIdStr : estudiantesIds) {
                int estudianteId = Integer.parseInt(estudianteIdStr);
                String estado = request.getParameter("estado_" + estudianteId);

                // Si no se recibió estado, asumir 'falto'
                if (estado == null || estado.isEmpty()) {
                    estado = "falto";
                }

                if (dao.guardarAsistencia(estudianteId, semanaId, fechaClase, estado, usuario)) {
                    guardados++;
                }
            }

            if (guardados > 0) {
                response.getWriter().write("{\"success\": true, \"message\": \"Asistencia guardada correctamente. "
                        + guardados + " registros actualizados.\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"No se pudo guardar la asistencia\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
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
