package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import modelo.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/ListarAdministradoresServlet")
public class ListarAdministradoresServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> administradores = dao.obtenerPorRol(1); // 1 = Administrador

        request.setAttribute("administradores", administradores);

        String param = request.getParameter("mensaje");
        if (param != null) {
            switch (param) {
                case "exito":
                    request.setAttribute("mensaje", "Operación completada exitosamente.");
                    request.setAttribute("tipoMensaje", "success");
                    break;
                case "existe":
                    request.setAttribute("mensaje", "El correo ya está registrado en el sistema.");
                    request.setAttribute("tipoMensaje", "error");
                    break;
                case "estado_cambiado":
                    request.setAttribute("mensaje", "Estado del administrador actualizado.");
                    request.setAttribute("tipoMensaje", "success");
                    break;
                case "eliminado":
                    request.setAttribute("mensaje", "Administrador eliminado correctamente.");
                    request.setAttribute("tipoMensaje", "success");
                    break;
                case "error":
                default:
                    request.setAttribute("mensaje", "Ocurrió un error. Intente nuevamente.");
                    request.setAttribute("tipoMensaje", "error");
                    break;
            }
        }

        request.getRequestDispatcher("admin/administradores.jsp").forward(request, response);
    }
}
