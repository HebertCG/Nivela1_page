package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/ListarDeudores")
public class ListarDeudoresServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros de filtro
        String filtroEstado = request.getParameter("filtro");
        String grado = request.getParameter("grado");

        if (filtroEstado == null || filtroEstado.isEmpty()) {
            filtroEstado = "todos";
        }

        // Obtener datos financieros completos
        Map<String, Object> datos = preinscripcionDAO.obtenerDatosFinancieros(filtroEstado, grado);

        // Pasar datos a JSP
        request.setAttribute("preinscripciones", datos.get("preinscripciones"));
        request.setAttribute("totalEsperado", datos.get("totalEsperado"));
        request.setAttribute("totalRecaudado", datos.get("totalRecaudado"));
        request.setAttribute("totalPendiente", datos.get("totalPendiente"));
        request.setAttribute("filtroActual", filtroEstado);
        request.setAttribute("gradoActual", grado != null ? grado : "");

        request.getRequestDispatcher("deudores.jsp").forward(request, response);
    }
}
