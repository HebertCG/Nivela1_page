package Controlador;

import DAO.AsistenciaHorarioDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ObtenerDiasClaseServlet", urlPatterns = { "/ObtenerDiasClaseServlet" })
public class ObtenerDiasClaseServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            int seccionId = Integer.parseInt(request.getParameter("seccionId"));

            AsistenciaHorarioDAO dao = new AsistenciaHorarioDAO();
            List<String> dias = dao.obtenerDiasPorSeccion(seccionId);

            StringBuilder json = new StringBuilder();
            json.append("{\"success\": true, \"dias\": [");

            for (int i = 0; i < dias.size(); i++) {
                json.append("\"").append(dias.get(i)).append("\"");
                if (i < dias.size() - 1) {
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
