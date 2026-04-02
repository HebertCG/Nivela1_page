package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CambiarEstadoDocenteServlet")
public class CambiarEstadoDocenteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int estadoActual = Integer.parseInt(request.getParameter("estado")); // estado actual: 0 o 1

        // Toggle: si estaba activo (1) → desactivar (0), si estaba inactivo (0) →
        // activar (1)
        int nuevoEstado = (estadoActual == 1) ? 0 : 1;

        UsuarioDAO dao = new UsuarioDAO();
        boolean exito = dao.cambiarEstado(id, nuevoEstado);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/ListarDocentesServlet?mensaje=estado_cambiado");
        } else {
            response.sendRedirect(request.getContextPath() + "/ListarDocentesServlet?mensaje=error");
        }
    }
}
