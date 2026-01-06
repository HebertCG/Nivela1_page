package Controlador;

import DAO.AsistenciaEstudianteDAO;
import DAO.AsistenciaRegistroDAO;
import DAO.AsistenciaSemanaDAO;
import modelo.AsistenciaEstudiante;
import modelo.AsistenciaRegistro;
import modelo.AsistenciaSemana;
import java.io.IOException;
import java.sql.Date;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GetAsistenciaSemanalServlet", urlPatterns = { "/GetAsistenciaSemanalServlet" })
public class GetAsistenciaSemanalServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");

        try {
            int seccionId = Integer.parseInt(request.getParameter("seccionId"));
            int semanaId = Integer.parseInt(request.getParameter("semanaId"));

            AsistenciaEstudianteDAO estudianteDAO = new AsistenciaEstudianteDAO();
            AsistenciaRegistroDAO registroDAO = new AsistenciaRegistroDAO();
            AsistenciaSemanaDAO semanaDAO = new AsistenciaSemanaDAO();

            AsistenciaSemana semana = semanaDAO.obtenerPorId(semanaId);
            if (semana == null) {
                System.out.println("❌ ERROR: Semana no encontrada ID: " + semanaId);
                throw new Exception("Semana no encontrada");
            }

            System.out.println("✅ Semana encontrada: " + semana.getNombre() + " Inicio: " + semana.getFechaInicio());

            // 2. Calcular los fechas de Lunes a Viernes
            LocalDate lunes;
            if (semana.getFechaInicio() == null) {
                System.out.println("⚠️ WARNING: Fecha inicio es NULL. Usando fecha actual como fallback.");
                lunes = LocalDate.now().with(java.time.DayOfWeek.MONDAY); // Fallback al lunes actual
            } else {
                lunes = semana.getFechaInicio().toLocalDate();
            }
            // Verificar si la fechaInicio es lunes, sino ajustar (opcional, asumimos que es
            // lunes)
            // Si la fechaInicio no fuera lunes, habría que ajustar. Asumimos modelo
            // correcto.

            List<String> fechasSemana = new ArrayList<>();
            List<String> nombresDias = new ArrayList<>();

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            Locale esLocale = new Locale("es", "ES");

            // Generar Lunes a Sábado (6 días)
            for (int i = 0; i < 6; i++) {
                LocalDate fecha = lunes.plusDays(i);
                fechasSemana.add(fecha.format(formatter));
                String nombreDia = fecha.getDayOfWeek().getDisplayName(TextStyle.FULL, esLocale);
                // Capitalizar primera letra
                nombreDia = nombreDia.substring(0, 1).toUpperCase() + nombreDia.substring(1);
                nombresDias.add(nombreDia);
            }

            // 3. Obtener estudiantes y nombre de sección VERDADERO
            List<AsistenciaEstudiante> estudiantes = estudianteDAO.listarPorSeccion(seccionId);

            // Obtener el nombre de la sección directamente del DAO de secciones para
            // asegurar que no sea null
            DAO.AsistenciaSeccionDAO seccionDAO = new DAO.AsistenciaSeccionDAO();
            modelo.AsistenciaSeccion seccionObj = seccionDAO.obtenerPorId(seccionId);

            String nombreSeccion = (seccionObj != null) ? seccionObj.getNombre() : "";
            nombreSeccion = nombreSeccion.toLowerCase();

            List<Integer> diasValidos = new ArrayList<>();

            // Lógica de validación
            if (nombreSeccion.contains("4to") || nombreSeccion.contains("5to")) {
                diasValidos = List.of(0, 1, 2, 3, 4); // Lun-Vie
            } else if (nombreSeccion.contains("2do") || nombreSeccion.contains("3ro")) {
                diasValidos = List.of(0, 2, 4); // Lun, Mie, Vie
            } else if (nombreSeccion.contains("6to") || nombreSeccion.contains("1ro")) {
                diasValidos = List.of(1, 3, 5); // Mar, Jue, Sab
            } else {
                diasValidos = List.of(0, 1, 2, 3, 4, 5); // Default todos
            }

            // 4. Obtener registros existentes de esa semana
            List<AsistenciaRegistro> registros = registroDAO.obtenerPorSeccionYSemana(seccionId, semanaId);

            // 5. Construir JSON Manualmente
            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"success\": true,");

            // Array de días (fechas y nombres) + Flag si es válido
            json.append("\"dias\": [");
            for (int i = 0; i < 6; i++) {
                boolean esValido = diasValidos.contains(i);
                json.append("{");
                json.append("\"fecha\": \"").append(fechasSemana.get(i)).append("\",");
                json.append("\"nombre\": \"").append(nombresDias.get(i)).append("\",");
                json.append("\"habilitado\": ").append(esValido);
                json.append("}");
                if (i < 5)
                    json.append(",");
            }
            json.append("],");

            // Array de estudiantes
            json.append("\"estudiantes\": [");
            for (int i = 0; i < estudiantes.size(); i++) {
                AsistenciaEstudiante est = estudiantes.get(i);
                json.append("{");
                json.append("\"id\": ").append(est.getId()).append(",");
                json.append("\"nombreCompleto\": \"").append(est.getNombreCompleto()).append("\",");
                json.append("\"codigo\": \"").append(est.getCodigo() != null ? est.getCodigo() : "").append("\"");
                json.append("}");
                if (i < estudiantes.size() - 1)
                    json.append(",");
            }
            json.append("],");

            // Array de registros existentes (simplificado)
            json.append("\"registros\": [");
            for (int i = 0; i < registros.size(); i++) {
                AsistenciaRegistro reg = registros.get(i);
                json.append("{");
                json.append("\"estudianteId\": ").append(reg.getEstudianteId()).append(",");
                json.append("\"fecha\": \"").append(reg.getFechaClase().toString()).append("\",");
                json.append("\"estado\": \"").append(reg.getEstado() != null ? reg.getEstado() : "falto").append("\",");
                json.append("\"presente\": ").append(reg.isPresente());
                json.append("}");
                if (i < registros.size() - 1)
                    json.append(",");
            }
            json.append("]");

            json.append("}");

            response.getWriter().write(json.toString());

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500); // Forzar error 500 para ver en consola
            response.getWriter()
                    .write("{\"success\": false, \"message\": \"Error del servidor: " + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
