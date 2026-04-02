package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet("/EliminarAdministradorServlet")
public class EliminarAdministradorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            UsuarioDAO dao = new UsuarioDAO();
            dao.eliminar(id);
            response.sendRedirect(request.getContextPath() + "/ListarAdministradoresServlet?mensaje=eliminado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarAdministradoresServlet?mensaje=error");
        }
    }
}
