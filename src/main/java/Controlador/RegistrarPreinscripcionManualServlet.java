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

        // Datos del Alumno (ya no incluye DNI)
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String colegio = request.getParameter("colegio");
        String grado = request.getParameter("grado");

        // Datos del Apoderado (ahora incluye DNI)
        String nombreApoderado = request.getParameter("nombreApoderado");
        String apellidoApoderado = request.getParameter("apellidoApoderado");
        String dniApoderado = request.getParameter("dniApoderado");
        String emailApoderado = request.getParameter("emailApoderado");
        String telefono1Apoderado = request.getParameter("telefono1Apoderado");
        String telefono2Apoderado = request.getParameter("telefono2Apoderado");

        // Datos de Pago
        String modalidadPago = request.getParameter("modalidadPago");
        String metodoPago = request.getParameter("metodoPago");
        String referenciaPago = request.getParameter("referenciaPago");

        // Todos los registros manuales empiezan en 'pendiente' para que el admin revise
        String estadoInicial = "pendiente";

        try {
            boolean registrado = preinscripcionDAO.insertarManual(
                    nombre, apellido, email, direccion, colegio, grado,
                    nombreApoderado, apellidoApoderado, dniApoderado, emailApoderado,
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
