package Controlador;

import DAO.AsistenciaRegistroDAO;
import java.io.IOException;
import java.sql.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.Enumeration;
// Imports removed

@WebServlet(name = "GuardarAsistenciaSemanalServlet", urlPatterns = { "/GuardarAsistenciaSemanalServlet" })
public class GuardarAsistenciaSemanalServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            // Leer el cuerpo de la petición (JSON)
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }

            // Parsear JSON manual (simple) o usar org.json si estuviera disponible.
            // Dado que no estoy seguro de las librerías, voy a intentar parsear el JSON
            // de forma muy básica o mejor aun, confiar en que el usuario tiene org.json
            // Vimos en archivos anteriores que NO hay imports de org.json o Gson visible.
            // Construyen JSON a mano.

            // CAMBIO DE ESTRATEGIA:
            // Parsear JSON a mano es propenso a errores.
            // Voy a asumir que el cliente envía datos como FORM VARIABLES tradicionales
            // usando application/x-www-form-urlencoded
            // El cliente enviará: datos=[{estudianteId:1, fecha:2026.., presente:true},
            // ...]
            // O mejor, una cadena JSON en un parametro 'data'.

            throw new Exception("Use el método POST con parámetros x-www-form-urlencoded");

        } catch (Exception e) {
            // Fallback para manejar la lógica real en doPost si enviamos form-data
        }
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

            System.out.println("📥 Servlet Guardar: Semana=" + semanaIdStr + " DataSize=" + dataJson.length());
            // System.out.println("📦 Data: " + dataJson); // Descomentar para debug full

            int semanaId = Integer.parseInt(semanaIdStr);
            AsistenciaRegistroDAO dao = new AsistenciaRegistroDAO();

            // Limpieza básica del JSON Array
            String cleanData = dataJson.trim();
            if (cleanData.startsWith("["))
                cleanData = cleanData.substring(1);
            if (cleanData.endsWith("]"))
                cleanData = cleanData.substring(0, cleanData.length() - 1);

            // Separar objetos
            String[] objetos = cleanData.split("\\},\\{");

            int guardados = 0;
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

                        boolean ok = dao.guardarAsistencia(estudianteId, semanaId, fecha, estado, usuario);
                        if (ok)
                            guardados++;
                        else
                            System.out.println("⚠️ DAO retornó FALSE para Estudiante: " + estudianteId);
                    }
                } catch (Exception ex) {
                    System.out.println("❌ Error procesando registro individual: " + ex.getMessage());
                }
            }

            System.out.println("✅ Guardado completado. Total procesados correctamente: " + guardados);
            response.getWriter()
                    .write("{\"success\": true, \"message\": \"Se guardaron " + guardados + " registros\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}
