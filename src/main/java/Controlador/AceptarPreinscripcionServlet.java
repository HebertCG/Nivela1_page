package Controlador;

import DAO.PreinscripcionDAO;
import modelo.Preinscripcion;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.List;

@WebServlet("/AceptarPreinscripcion")
public class AceptarPreinscripcionServlet extends HttpServlet {
    private PreinscripcionDAO dao = new PreinscripcionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String dni = request.getParameter("dni");
        if (dni == null || dni.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=error");
            return;
        }
        try {

            dao.actualizarEstado(dni, "aceptado");

            List<Preinscripcion> aceptados = dao.listarPorEstado("aceptado");
            Preinscripcion pre = aceptados.stream()
                    .filter(p -> p.getDni().equals(dni))
                    .findFirst()
                    .orElse(null);

            if (pre != null) {

                String pwd = generarPassword(8);

                dao.insertarUsuarioDesdePreinscripcion(pre, pwd);

                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=aceptado&pwd=" + pwd);
            } else {
                response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarPreinscripciones?mensaje=error");
        }
    }

    private String generarPassword(int length) {
        final String CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                + "abcdefghijklmnopqrstuvwxyz"
                + "0123456789";
        SecureRandom rnd = new SecureRandom();
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(CHARS.charAt(rnd.nextInt(CHARS.length())));
        }
        return sb.toString();
    }
}
