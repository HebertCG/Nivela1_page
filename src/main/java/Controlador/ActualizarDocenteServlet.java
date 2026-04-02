package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo.Usuario;
import java.io.IOException;

@WebServlet("/ActualizarDocenteServlet")
public class ActualizarDocenteServlet extends HttpServlet {
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

            Usuario docente = new Usuario();
            docente.setId(id);
            docente.setNombre(nombre);
            docente.setApellido(apellido);
            docente.setCorreo(correo);
            docente.setIdRol(2);
            docente.setPassword((password != null && !password.trim().isEmpty()) ? password : actual.getPassword());

            dao.actualizar(docente);
            response.sendRedirect(request.getContextPath() + "/ListarDocentesServlet?mensaje=exito");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarDocentesServlet?mensaje=error");
        }
    }
}
