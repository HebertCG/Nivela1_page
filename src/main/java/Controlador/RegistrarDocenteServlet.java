package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/RegistrarDocente")
public class RegistrarDocenteServlet extends HttpServlet {
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
                Usuario docente = new Usuario();
                docente.setNombre(nombre);
                docente.setApellido(apellido);
                docente.setCorreo(correo);
                docente.setPassword(contrasena);
                docente.setIdRol(2); // Rol 2 = Docente
                dao.insertar(docente);
                setMensaje(request, "Docente registrado exitosamente.", "success");
            } catch (Exception e) {
                e.printStackTrace();
                setMensaje(request, "Error al registrar el docente: " + e.getMessage(), "error");
            }
        }

        List<Usuario> docentes = dao.obtenerPorRol(2);
        request.setAttribute("docentes", docentes);
        request.getRequestDispatcher("admin/docentes.jsp").forward(request, response);
    }

    private void setMensaje(HttpServletRequest request, String texto, String tipo) {
        request.setAttribute("mensaje", texto);
        request.setAttribute("tipoMensaje", tipo);
    }
}
