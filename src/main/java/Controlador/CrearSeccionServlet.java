package Controlador;

import DAO.SeccionDAO;
import modelo.Seccion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/CrearSeccion")
public class CrearSeccionServlet extends HttpServlet {
    private SeccionDAO seccionDAO = new SeccionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        int idGrupo = Integer.parseInt(request.getParameter("idGrupo"));
        String grado = request.getParameter("grado");

        Seccion seccion = new Seccion(nombre, idGrupo);

        boolean exito = seccionDAO.crearNuevaSeccion(seccion);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/admin/ListarSecciones?idGrupo=" + idGrupo + "&grado="
                    + grado + "&created=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/ListarSecciones?idGrupo=" + idGrupo + "&grado="
                    + grado + "&error=crear");
        }
    }
}
