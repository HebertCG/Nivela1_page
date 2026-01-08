package Controlador;

import DAO.AsistenciaEstudianteDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "EliminarEstudianteServlet", urlPatterns = { "/EliminarEstudianteServlet" })
public class EliminarEstudianteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();
        Gson gson = new Gson();

        try {
            String idStr = request.getParameter("id");

            if (idStr == null || idStr.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "ID no proporcionado");
            } else {
                AsistenciaEstudianteDAO dao = new AsistenciaEstudianteDAO();
                int id = Integer.parseInt(idStr);

                boolean eliminado = dao.eliminar(id);

                if (eliminado) {
                    jsonResponse.put("success", true);
                    jsonResponse.put("message", "Eliminado correctamente");
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "No se pudo eliminar (o ya estaba eliminado)");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Error: " + e.getMessage());
        }

        out.print(gson.toJson(jsonResponse));
        out.flush();
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
