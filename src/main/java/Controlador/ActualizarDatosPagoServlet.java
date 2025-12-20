package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ActualizarDatosPago")
public class ActualizarDatosPagoServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            // Obtener parámetros del formulario
            int id = Integer.parseInt(request.getParameter("id"));
            double montoTotal = Double.parseDouble(request.getParameter("montoTotal"));
            double montoPagado = Double.parseDouble(request.getParameter("montoPagado"));
            String metodoPago = request.getParameter("metodoPago");
            String modalidadPago = request.getParameter("modalidadPago");

            // Actualizar en la base de datos
            boolean actualizado = preinscripcionDAO.actualizarDatosPago(
                    id, montoTotal, montoPagado, metodoPago, modalidadPago);

            if (actualizado) {
                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=actualizado");
            } else {
                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?error=no_actualizado");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?error=datos_invalidos");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?error=database");
        }
    }
}
