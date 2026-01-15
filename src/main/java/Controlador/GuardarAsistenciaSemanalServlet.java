package Controlador;

import DAO.AsistenciaRegistroDAO;
import modelo.AsistenciaRegistro;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GuardarAsistenciaSemanalServlet", urlPatterns = { "/GuardarAsistenciaSemanalServlet" })
public class GuardarAsistenciaSemanalServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            String semanaIdStr = request.getParameter("semanaId");
            String dataJson = request.getParameter("data");

            if (semanaIdStr == null || dataJson == null) {
                System.out.println("❌ ERROR: Faltan parámetros en GuardarAsistenciaSemanalServlet");
                response.getWriter().write("{\"success\": false, \"message\": \"Faltan parámetros semanaId o data\"}");
                return;
            }

            System.out.println("📥 Servlet Guardar (Masivo): Semana=" + semanaIdStr + " DataSize=" + dataJson.length());

            int semanaId = Integer.parseInt(semanaIdStr);
            AsistenciaRegistroDAO dao = new AsistenciaRegistroDAO();

            // Limpieza básica del JSON Array
            String cleanData = dataJson.trim();
            if (cleanData.startsWith("["))
                cleanData = cleanData.substring(1);
            if (cleanData.endsWith("]"))
                cleanData = cleanData.substring(0, cleanData.length() - 1);

            // Separar objetos usando regex robusto
            String[] objetos = cleanData.split("(?<=\\}),\\s*(?=\\{)");

            List<AsistenciaRegistro> registrosParaGuardar = new ArrayList<>();
            String usuario = "ADMIN";

            for (String obj : objetos) {
                try {
                    // Limpiar caracteres JSON residuales
                    obj = obj.replace("{", "").replace("}", "").replace("\"", "");

                    String[] pares = obj.split(",");
                    int estudianteId = 0;
                    String fechaStr = "";
                    boolean presente = false;
                    String estado = "";

                    for (String par : pares) {
                        String[] kv = par.split(":");
                        String key = kv[0].trim();
                        // Reconstruir valor si tenia :
                        String val = "";
                        if (kv.length > 1) {
                            for (int k = 1; k < kv.length; k++)
                                val += kv[k] + (k < kv.length - 1 ? ":" : "");
                        }
                        val = val.trim();

                        if (key.equals("estudianteId"))
                            estudianteId = Integer.parseInt(val);
                        else if (key.equals("fecha"))
                            fechaStr = val;
                        else if (key.equals("presente"))
                            presente = Boolean.parseBoolean(val);
                        else if (key.equals("estado"))
                            estado = val;
                    }

                    if (estudianteId > 0 && !fechaStr.isEmpty()) {
                        Date fecha = Date.valueOf(fechaStr);

                        // Fallback de compatibilidad
                        if (estado.isEmpty() || estado.equals("null") || estado.equals("undefined")) {
                            estado = presente ? "asistio" : "falto";
                        }

                        AsistenciaRegistro nuevoReg = new AsistenciaRegistro();
                        nuevoReg.setEstudianteId(estudianteId);
                        nuevoReg.setSemanaId(semanaId);
                        nuevoReg.setFechaClase(fecha);
                        nuevoReg.setEstado(estado);
                        nuevoReg.setPresente(presente);
                        nuevoReg.setUsuarioRegistro(usuario);

                        registrosParaGuardar.add(nuevoReg);
                    }
                } catch (Exception ex) {
                    System.out.println("❌ Error procesando registro individual (Parseo): " + ex.getMessage());
                }
            }

            // Llamar al DAO Masivo
            boolean exito = dao.guardarMasivo(registrosParaGuardar);

            if (exito) {
                System.out.println("✅ Guardado Masivo completado. Total registros: " + registrosParaGuardar.size());
                response.getWriter().write("{\"success\": true, \"message\": \"Se guardaron "
                        + registrosParaGuardar.size() + " registros\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Error al guardar en base de datos\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error Servlet: " + e.getMessage() + "\"}");
        }
    }
}
