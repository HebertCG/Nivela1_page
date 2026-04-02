package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;

@WebServlet("/ActualizarAdministradorServlet")
public class ActualizarAdministradorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String apellido = request.getParameter("apellido");
            String correo = request.getParameter("correo");
            String password = request.getParameter("password");

            UsuarioDAO dao = new UsuarioDAO();
            Usuario actual = dao.obtenerPorId(id);

            Usuario admin = new Usuario();
            admin.setId(id);
            admin.setNombre(nombre);
            admin.setApellido(apellido);
            admin.setCorreo(correo);
            admin.setIdRol(1);
            admin.setPassword((password != null && !password.trim().isEmpty()) ? password : actual.getPassword());

            dao.actualizar(admin);
            response.sendRedirect(request.getContextPath() + "/ListarAdministradoresServlet?mensaje=exito");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarAdministradoresServlet?mensaje=error");
        }
    }
}
