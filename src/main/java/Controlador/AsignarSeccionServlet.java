package Controlador;

import DAO.SeccionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/AsignarSeccion")
public class AsignarSeccionServlet extends HttpServlet {
    private SeccionDAO seccionDAO = new SeccionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int usuarioId = Integer.parseInt(request.getParameter("usuarioId"));
        int seccionId = Integer.parseInt(request.getParameter("seccionId"));
        int idGrupo = Integer.parseInt(request.getParameter("idGrupo"));
        String grado = request.getParameter("grado");

        boolean exito = seccionDAO.asignarEstudianteASeccion(usuarioId, seccionId);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/admin/ListarSecciones?idGrupo=" + idGrupo + "&grado="
                    + grado + "&success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/ListarSecciones?idGrupo=" + idGrupo + "&grado="
                    + grado + "&error=capacidad");
        }
    }
}
