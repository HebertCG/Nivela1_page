package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/RechazarPreinscripcion")
public class RechazarPreinscripcionServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isBlank()) {
            int id = Integer.parseInt(idStr);
            dao.actualizarEstadoPorId(id, "rechazado");
        }

        response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=rechazado");
    }
}
