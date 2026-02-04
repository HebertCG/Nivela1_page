package Controlador;

import DAO.UsuarioDAO;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String correo = request.getParameter("correo").trim();
        String password = request.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.login(correo, password);

        if (usuario != null) {

            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);

            String nombreRol = dao.obtenerNombreRol(usuario.getIdRol());
            session.setAttribute("nombreRol", nombreRol);

            // Para evitar problemas de mayúsculas/minúsculas
            String rol = nombreRol != null ? nombreRol.toLowerCase() : "";

            String ctx = request.getContextPath();

            switch (rol) {
                case "administrador":
                    // Si luego quieres, también puedes pasar esto por un servlet AdminPanel
                    response.sendRedirect(ctx + "/admin/panel.jsp");
                    break;

                case "docente":
                    // IMPORTANTE: ir al servlet, NO al JSP
                    response.sendRedirect(ctx + "/Docente/Panel");
                    break;

                case "estudiante":
                    // Igual que admin, podrías luego moverlo a un servlet EstudiantePanel
                    response.sendRedirect(ctx + "/estudiante/panel.jsp");
                    break;

                default:
                    session.invalidate();
                    response.sendRedirect(ctx + "/login.jsp?error=rol");
                    break;
            }
        } else {
            // Aquí podrías manejar error de credenciales si lo necesitas
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=login");
        }
    }
}
