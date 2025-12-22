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
    private static final int REGISTROS_POR_PAGINA = 15;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Obtener número de página (por defecto 1)
            int pagina = 1;
            String paginaParam = request.getParameter("pagina");
            if (paginaParam != null && !paginaParam.isEmpty()) {
                try {
                    pagina = Integer.parseInt(paginaParam);
                    if (pagina < 1)
                        pagina = 1;
                } catch (NumberFormatException e) {
                    pagina = 1;
                }
            }

            // Obtener total de registros y calcular páginas
            int totalRegistros = preinscripcionDAO.contarTotal();
            int totalPaginas = (int) Math.ceil((double) totalRegistros / REGISTROS_POR_PAGINA);

            // Ajustar página si excede el total
            if (pagina > totalPaginas && totalPaginas > 0) {
                pagina = totalPaginas;
            }

            // Obtener lista paginada
            List<Preinscripcion> preinscripciones = preinscripcionDAO.listarPaginado(pagina, REGISTROS_POR_PAGINA);

            // Enviar atributos a la vista
            request.setAttribute("preinscripciones", preinscripciones);
            request.setAttribute("paginaActual", pagina);
            request.setAttribute("totalPaginas", totalPaginas);
            request.setAttribute("totalRegistros", totalRegistros);
            request.setAttribute("registrosPorPagina", REGISTROS_POR_PAGINA);

            request.getRequestDispatcher("/admin/preinscripciones.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/panel.jsp");
        }
    }
}
