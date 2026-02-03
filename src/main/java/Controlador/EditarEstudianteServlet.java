package Controlador;

import DAO.AsistenciaEstudianteDAO;
import modelo.AsistenciaEstudiante;

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

@WebServlet(name = "EditarEstudianteServlet", urlPatterns = { "/EditarEstudianteServlet" })
public class EditarEstudianteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();
        Gson gson = new Gson();

        try {
            String idStr = request.getParameter("id");
            String nombre = request.getParameter("nombre");
            String codigo = request.getParameter("codigo");
            String seccionIdStr = request.getParameter("seccionId");

            if (idStr == null || nombre == null || seccionIdStr == null || nombre.trim().isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Datos incompletos");
            } else {
                AsistenciaEstudianteDAO dao = new AsistenciaEstudianteDAO();
                int id = Integer.parseInt(idStr);
                int seccionId = Integer.parseInt(seccionIdStr);

                // Obtener el estudiante actual para no perder datos como 'orden' o 'activo'
                AsistenciaEstudiante estudiante = dao.obtenerPorId(id);

                if (estudiante != null) {
                    estudiante.setNombreCompleto(nombre);
                    estudiante.setCodigo(codigo);
                    estudiante.setSeccionId(seccionId);

                    boolean actualizado = dao.actualizar(estudiante);

                    if (actualizado) {
                        jsonResponse.put("success", true);
                        jsonResponse.put("message", "Actualizado correctamente");
                    } else {
                        jsonResponse.put("success", false);
                        jsonResponse.put("message", "Error al actualizar en BD");
                    }
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Estudiante no encontrado");
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
