package Controlador;

import DAO.*;
import modelo.*;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GetEstudiantesAsistenciaServlet", urlPatterns = { "/GetEstudiantesAsistenciaServlet" })
public class GetEstudiantesAsistenciaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            int seccionId = Integer.parseInt(request.getParameter("seccionId"));
            String fechaClaseStr = request.getParameter("fechaClase");
            Date fechaClase = Date.valueOf(fechaClaseStr);

            AsistenciaEstudianteDAO estudianteDAO = new AsistenciaEstudianteDAO();
            AsistenciaRegistroDAO registroDAO = new AsistenciaRegistroDAO();

            List<AsistenciaEstudiante> estudiantes = estudianteDAO.listarPorSeccion(seccionId);

            StringBuilder json = new StringBuilder();
            json.append("{\"success\": true, \"estudiantes\": [");

            for (int i = 0; i < estudiantes.size(); i++) {
                AsistenciaEstudiante est = estudiantes.get(i);
                json.append("{");
                json.append("\"id\": ").append(est.getId()).append(",");
                json.append("\"nombreCompleto\": \"").append(est.getNombreCompleto()).append("\"");
                json.append("}");

                if (i < estudiantes.size() - 1) {
                    json.append(",");
                }
            }

            json.append("], \"asistencias\": [");

            List<AsistenciaRegistro> registros = registroDAO.obtenerPorSeccionYFecha(seccionId, fechaClase);

            for (int i = 0; i < registros.size(); i++) {
                AsistenciaRegistro reg = registros.get(i);
                json.append("{");
                json.append("\"estudianteId\": ").append(reg.getEstudianteId()).append(",");
                json.append("\"estado\": \"").append(reg.getEstado()).append("\"");
                json.append("}");

                if (i < registros.size() - 1) {
                    json.append(",");
                }
            }

            json.append("]}");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
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
