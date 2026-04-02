package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/RegistrarAdministrador")
public class RegistrarAdministradorServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        UsuarioDAO dao = new UsuarioDAO();

        if (dao.existeCorreo(correo)) {
            setMensaje(request, "El correo ya está registrado en el sistema.", "error");
        } else {
            try {
                Usuario admin = new Usuario();
                admin.setNombre(nombre);
                admin.setApellido(apellido);
                admin.setCorreo(correo);
                admin.setPassword(contrasena);
                admin.setIdRol(1); // Rol 1 = Administrador
                dao.insertar(admin);
                setMensaje(request, "Administrador registrado exitosamente.", "success");
            } catch (Exception e) {
                e.printStackTrace();
                setMensaje(request, "Error al registrar el administrador: " + e.getMessage(), "error");
            }
        }

        List<Usuario> administradores = dao.obtenerPorRol(1);
        request.setAttribute("administradores", administradores);
        request.getRequestDispatcher("admin/administradores.jsp").forward(request, response);
    }

    private void setMensaje(HttpServletRequest request, String texto, String tipo) {
        request.setAttribute("mensaje", texto);
        request.setAttribute("tipoMensaje", tipo);
    }
}
