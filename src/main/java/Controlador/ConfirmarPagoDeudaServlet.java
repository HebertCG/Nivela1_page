package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ConfirmarPagoDeuda")
public class ConfirmarPagoDeudaServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String montoStr = request.getParameter("monto");

        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=faltaId");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            double monto = montoStr != null ? Double.parseDouble(montoStr) : 0;

            // Si no se especifica monto, pagar todo el saldo pendiente
            if (monto <= 0) {
                // Obtener saldo pendiente actual
                modelo.Preinscripcion p = preinscripcionDAO.obtenerPorId(id);
                if (p != null) {
                    monto = p.getSaldoPendiente();
                }
            }

            // Actualizar el pago
            preinscripcionDAO.actualizarPago(id, monto);

            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?success=pagado");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=formatoInvalido");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=database");
        }
    }
}
