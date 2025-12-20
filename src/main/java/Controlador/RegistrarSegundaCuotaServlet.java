package Controlador;

import DAO.PreinscripcionDAO;
import DAO.PagoDAO;
import modelo.Pago;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/RegistrarSegundaCuota")
public class RegistrarSegundaCuotaServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;
    private PagoDAO pagoDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
        pagoDAO = new PagoDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int idPreinscripcion = Integer.parseInt(request.getParameter("idPreinscripcion"));
            String metodoPago = request.getParameter("metodoPago");
            String referencia = request.getParameter("referencia");
            String notas = request.getParameter("notas");

            // Verificar que no exista ya un pago de 2da cuota
            if (pagoDAO.existePagoCuota(idPreinscripcion, 2)) {
                response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=duplicate");
                return;
            }

            // Crear registro de pago (2da cuota siempre es S/. 200)
            Pago pago = new Pago();
            pago.setIdPreinscripcion(idPreinscripcion);
            pago.setNumeroCuota(2);
            pago.setMonto(200.00);
            pago.setMetodoPago(metodoPago);
            pago.setReferenciaPago(referencia);
            pago.setRegistradoPor("admin");
            pago.setNotas(notas != null ? notas : "Pago de segunda cuota");

            boolean pagoRegistrado = pagoDAO.registrarPago(pago);

            if (pagoRegistrado) {
                // Actualizar preinscripcion (suma S/. 200 al monto_pagado y resta del saldo)
                preinscripcionDAO.actualizarPago(idPreinscripcion, 200.00);
                response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?success=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=payment");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=invalid");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/ListarDeudores?error=database");
        }
    }
}
