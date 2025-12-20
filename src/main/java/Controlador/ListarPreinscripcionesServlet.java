package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Preinscripcion;
import java.io.IOException;
import java.util.List;

@WebServlet("/ListarPreinscripciones")
public class ListarPreinscripcionesServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Preinscripcion> preinscripciones = preinscripcionDAO.listarTodas();
            request.setAttribute("preinscripciones", preinscripciones);
            request.getRequestDispatcher("/admin/preinscripciones.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/panel.jsp");
        }
    }
}
