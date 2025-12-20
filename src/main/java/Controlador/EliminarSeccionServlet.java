
package Controlador;

import DAO.AdminSeccionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/EliminarSeccion")
public class EliminarSeccionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        new AdminSeccionDAO().eliminar(id);
        response.sendRedirect(request.getContextPath() + "/ListarSeccion");
    }
}
