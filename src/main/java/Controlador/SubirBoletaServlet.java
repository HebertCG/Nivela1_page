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

@WebServlet("/SubirBoletaServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class SubirBoletaServlet extends HttpServlet {

    private PreinscripcionDAO preinscripcionDAO;

    @Override
    public void init() throws ServletException {
        preinscripcionDAO = new PreinscripcionDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String idStr = request.getParameter("idPreinscripcion");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ListarDeudores?error=missing_id");
            return;
        }

        int id = Integer.parseInt(idStr);
        String boletaPath = null;

        try {
            Part filePart = request.getPart("boletaFile");

            if (filePart != null && filePart.getSize() > 0) {
                String fileName = "boleta_" + id + "_" + System.currentTimeMillis() + "_" + getFileName(filePart);

                // Ruta para guardar boletas
                String projectPath = "C:\\Users\\corne\\PAGINA_WEB\\src\\main\\webapp\\uploads\\boletas\\";

                File uploadDir = new File(projectPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                File destinationFile = new File(projectPath + fileName);

                // Escribir el archivo
                try (java.io.InputStream input = filePart.getInputStream();
                        java.io.FileOutputStream output = new java.io.FileOutputStream(destinationFile)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = input.read(buffer)) != -1) {
                        output.write(buffer, 0, bytesRead);
                    }
                }

                boletaPath = "uploads/boletas/" + fileName;

                // Actualizar en la base de datos
                boolean actualizado = preinscripcionDAO.actualizarBoletaSunat(id, boletaPath);

                if (actualizado) {
                    response.sendRedirect(request.getContextPath() + "/ListarDeudores?success=boleta");
                } else {
                    response.sendRedirect(request.getContextPath() + "/ListarDeudores?error=update");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/ListarDeudores?error=no_file");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ListarDeudores?error=exception");
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
