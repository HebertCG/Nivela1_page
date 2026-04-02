package Controlador;

import DAO.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.Usuario;

@WebServlet("/ListarDocentesServlet")
public class ListarDocentesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> docentes = dao.obtenerPorRol(2); // 2 = Docente
        request.setAttribute("docentes", docentes);

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
                    request.setAttribute("mensaje", "Estado del docente actualizado.");
                    request.setAttribute("tipoMensaje", "success");
                    break;
                case "eliminado":
                    request.setAttribute("mensaje", "Docente eliminado correctamente.");
                    request.setAttribute("tipoMensaje", "success");
                    break;
                case "error":
                default:
                    request.setAttribute("mensaje", "Ocurrió un error. Intente nuevamente.");
                    request.setAttribute("tipoMensaje", "error");
                    break;
            }
        }

        request.getRequestDispatcher("admin/docentes.jsp").forward(request, response);
    }
}
