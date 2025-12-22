package Controlador;

import DAO.PreinscripcionDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/RegistrarPreinscripcionPublica")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class RegistrarPreinscripcionPublicaServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Datos del alumno (ya no incluye DNI)
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String email = request.getParameter("email");
        String direccion = request.getParameter("direccion");
        String colegio = request.getParameter("colegio");
        String grado = request.getParameter("grado");

        // Datos del apoderado (ahora incluye DNI)
        String nombreApoderado = request.getParameter("nombreApoderado");
        String apellidoApoderado = request.getParameter("apellidoApoderado");
        String dniApoderado = request.getParameter("dniApoderado");
        String emailApoderado = request.getParameter("emailApoderado");
        String telefono1Apoderado = request.getParameter("telefono1Apoderado");
        String telefono2Apoderado = request.getParameter("telefono2Apoderado");

        // Datos de pago
        String modalidadPago = request.getParameter("modalidadPago");
        String metodoPago = request.getParameter("metodoPago");
        String referenciaPago = request.getParameter("referenciaPago");

        // Debug: Ver qué valor se está recibiendo
        System.out.println("🔍 DEBUG - Referencia de Pago recibida: '" + referenciaPago + "'");

        String comprobantePath = null;

        try {
            Part filePart = request.getPart("comprobante");

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + getFileName(filePart);

                // Usar una ruta fija en el proyecto
                String projectPath = "C:\\Users\\corne\\PAGINA_WEB\\src\\main\\webapp\\uploads\\comprobantes\\";

                System.out.println("📁 DEBUG - Ruta de uploads: " + projectPath);

                File uploadDir = new File(projectPath);
                if (!uploadDir.exists()) {
                    boolean created = uploadDir.mkdirs();
                    System.out.println("✅ Directorio creado: " + created);
                }

                // Crear el archivo completo
                File destinationFile = new File(projectPath + fileName);
                System.out.println("💾 DEBUG - Archivo destino: " + destinationFile.getAbsolutePath());

                // Escribir el archivo usando InputStream
                try (java.io.InputStream input = filePart.getInputStream();
                        java.io.FileOutputStream output = new java.io.FileOutputStream(destinationFile)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

                comprobantePath = "uploads/comprobantes/" + fileName;

                System.out.println("✅ Archivo guardado correctamente: " + comprobantePath);
            }
        } catch (Exception e) {
            // Si hay error con el archivo, continuar sin él
            System.err.println("❌ Error procesando archivo: " + e.getMessage());
            e.printStackTrace();
            comprobantePath = null;
        }

        try {
            // Debug: Ver el valor final de comprobantePath
            System.out.println("🔍 DEBUG - Valor de comprobantePath antes de insertar: '" + comprobantePath + "'");

            // Insertar preinscripción y obtener ID
            int idPreinscripcion = preinscripcionDAO.insertarPublica(
                    nombre, apellido, email, direccion, colegio, grado,
                    nombreApoderado, apellidoApoderado, dniApoderado, emailApoderado,
                    telefono1Apoderado, telefono2Apoderado,
                    modalidadPago, metodoPago, referenciaPago, comprobantePath);

            if (idPreinscripcion > 0) {
                // Registrar primer pago en tabla pagos
                DAO.PagoDAO pagoDAO = new DAO.PagoDAO();
                modelo.Pago pago = new modelo.Pago();
                pago.setIdPreinscripcion(idPreinscripcion);
                pago.setNumeroCuota(1);

                // Calcular monto de primera cuota
                util.PreciosPreinscripcion precios = new util.PreciosPreinscripcion();
                double[] montos = util.PreciosPreinscripcion.calcularMontos(grado, modalidadPago);
                pago.setMonto(montos[1]); // Primera cuota

                pago.setMetodoPago(metodoPago);
                pago.setReferenciaPago(referenciaPago);
                pago.setComprobantePago(comprobantePath);
                pago.setRegistradoPor("sistema");
                pago.setNotas("Pago de primera cuota - Registro online");

                pagoDAO.registrarPago(pago);

                response.sendRedirect(request.getContextPath() + "/preinscripcion-publica.jsp?success=true");
            } else if (idPreinscripcion == -1) {
                response.sendRedirect(request.getContextPath() + "/preinscripcion-publica.jsp?error=duplicate");
            } else {
                response.sendRedirect(request.getContextPath() + "/preinscripcion-publica.jsp?error=unknown");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/preinscripcion-publica.jsp?error=database");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
