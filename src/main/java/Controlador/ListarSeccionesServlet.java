package Controlador;

import DAO.SeccionDAO;
import modelo.Grupo;
import modelo.Seccion;
import modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/ListarSecciones")
public class ListarSeccionesServlet extends HttpServlet {
    private SeccionDAO seccionDAO = new SeccionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros
        String idGrupoParam = request.getParameter("idGrupo");
        String grado = request.getParameter("grado");

        // Si no hay grupo seleccionado, usar el primero
        List<Grupo> grupos = seccionDAO.listarGrupos();
        Grupo grupoSeleccionado = null;
        int idGrupoActual = 0;

        if (idGrupoParam != null && !idGrupoParam.isEmpty()) {
            idGrupoActual = Integer.parseInt(idGrupoParam);
            grupoSeleccionado = seccionDAO.obtenerGrupoPorId(idGrupoActual);
        } else if (grupos != null && !grupos.isEmpty()) {
            grupoSeleccionado = grupos.get(0);
            idGrupoActual = grupoSeleccionado.getId();
        }

        // Cargar secciones del grupo seleccionado
        List<Seccion> secciones = seccionDAO.listarSeccionesPorGrupo(idGrupoActual);

        // Cargar estudiantes sin asignar del grupo
        List<Usuario> estudiantesSinAsignar = seccionDAO.listarEstudiantesSinAsignar(idGrupoActual);

        // Calcular estadísticas
        int totalSecciones = (secciones != null) ? secciones.size() : 0;
        int totalAsignados = 0;
        int capacidadTotal = totalSecciones * 45;

        if (secciones != null) {
            for (Seccion s : secciones) {
                totalAsignados += s.getAlumnosActuales();
            }
        }

        int totalSinAsignar = (estudiantesSinAsignar != null) ? estudiantesSinAsignar.size() : 0;

        // Establecer atributos
        request.setAttribute("grupos", grupos);
        request.setAttribute("secciones", secciones);
        request.setAttribute("estudiantesSinAsignar", estudiantesSinAsignar);
        request.setAttribute("idGrupoActual", idGrupoActual);
        request.setAttribute("gradoActual", (grupoSeleccionado != null) ? grupoSeleccionado.getNombre() : "");
        request.setAttribute("totalSecciones", totalSecciones);
        request.setAttribute("totalAsignados", totalAsignados);
        request.setAttribute("totalSinAsignar", totalSinAsignar);
        request.setAttribute("capacidadTotal", capacidadTotal);

        request.getRequestDispatcher("/admin/secciones.jsp").forward(request, response);
    }
}
