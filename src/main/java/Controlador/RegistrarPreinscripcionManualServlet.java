package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegistrarPreinscripcionManual")
public class RegistrarPreinscripcionManualServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Datos del Alumno
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String colegio = request.getParameter("colegio");
        String grado = request.getParameter("grado");

        // Carrera - manejar "Otros"
        String carrera = request.getParameter("carrera");
        if ("Otros".equals(carrera)) {
            String otraCarrera = request.getParameter("otraCarrera");
            if (otraCarrera != null && !otraCarrera.trim().isEmpty()) {
                carrera = otraCarrera.trim();
            }
        }

        // Datos del Apoderado
        String nombreApoderado = request.getParameter("nombreApoderado");
        String apellidoApoderado = request.getParameter("apellidoApoderado");
        String emailApoderado = request.getParameter("emailApoderado");
        String telefono1Apoderado = request.getParameter("telefono1Apoderado");
        String telefono2Apoderado = request.getParameter("telefono2Apoderado");

        // Datos de Pago
        String modalidadPago = request.getParameter("modalidadPago");
        String metodoPago = request.getParameter("metodoPago");
        String referenciaPago = request.getParameter("referenciaPago");

        // LÓGICA DE ESTADO AUTOMÁTICO
        // Efectivo → aceptado (va directo al Panel de Deudas)
        // Yape/Transferencia → pendiente (va al Panel de Confirmación para admin)
        String estadoInicial;
        if ("efectivo".equalsIgnoreCase(metodoPago)) {
            estadoInicial = "aceptado";
        } else {
            estadoInicial = "pendiente";
        }

        try {
            boolean registrado = preinscripcionDAO.insertarManual(
                    nombre, apellido, dni, email, direccion, colegio, carrera, grado,
                    nombreApoderado, apellidoApoderado, emailApoderado,
                    telefono1Apoderado, telefono2Apoderado,
                    modalidadPago, metodoPago, referenciaPago, estadoInicial);

            if (registrado) {
                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones");
            } else {
                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?error=duplicate");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?error=database");
        }
    }
}
