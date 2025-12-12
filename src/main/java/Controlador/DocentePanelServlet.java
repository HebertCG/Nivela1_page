package Controlador;

import DAO.CursoDocenteDAO;
import DAO.GrupoEstudianteDAO;
import DAO.SeccionDAO;
import DAO.UsuarioDAO;
import modelo.CursoDocente;
import modelo.Seccion;
import modelo.Usuario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/Docente/Panel")
public class DocentePanelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ======= Validación de sesión =======
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        UsuarioDAO usuarioDao = new UsuarioDAO();
        String nombreRol = usuarioDao.obtenerNombreRol(usuario.getIdRol());
        if (!"docente".equalsIgnoreCase(nombreRol)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // ======= DAOs =======
        CursoDocenteDAO cdDao = new CursoDocenteDAO();
        SeccionDAO secDao = new SeccionDAO();
        GrupoEstudianteDAO geDao = new GrupoEstudianteDAO();

        // ======= Lógica de panel (antes en panel.jsp) =======

        // Cursos del docente
        List<CursoDocente> todosCursos = cdDao.listarPorDocente(usuario.getId());

        // Solo cursos con secciones válidas
        List<CursoDocente> cursosConSecciones = todosCursos.stream()
                .filter(cd -> cd.getIdSeccion() != null && cd.getIdSeccion() > 0)
                .collect(Collectors.toList());

        // Total cursos asignados (únicos)
        int totalCursos = (int) cursosConSecciones.stream()
                .map(CursoDocente::getIdCurso)
                .distinct()
                .count();

        // Cache local para no hacer N consultas iguales
        Map<Integer, Seccion> cacheSecciones = new HashMap<>();
        Map<Integer, Integer> cacheAlumnosPorGrupo = new HashMap<>();

        int totalAlumnos = 0;
        Set<Integer> gruposUnicos = new HashSet<>();

        for (CursoDocente cd : cursosConSecciones) {
            // Sección cacheada
            Seccion sec = cacheSecciones.get(cd.getIdSeccion());
            if (sec == null) {
                sec = secDao.obtenerPorId(cd.getIdSeccion());
                cacheSecciones.put(cd.getIdSeccion(), sec);
            }

            if (sec != null && gruposUnicos.add(sec.getIdGrupo())) {
                // Primera vez que vemos este grupo: contamos alumnos
                Integer totalGrupo = cacheAlumnosPorGrupo.get(sec.getIdGrupo());
                if (totalGrupo == null) {
                    int size = geDao.listarPorGrupo(sec.getIdGrupo()).size();
                    totalGrupo = size;
                    cacheAlumnosPorGrupo.put(sec.getIdGrupo(), totalGrupo);
                }
                totalAlumnos += totalGrupo;
            }
        }

        // ======= Día de hoy en español capitalizado =======
        String diaHoyTemp = LocalDate.now()
                .getDayOfWeek()
                .getDisplayName(TextStyle.FULL, new Locale("es", "ES"));
        // Capitalizar primera letra y hacer final para usar en lambda
        final String diaHoy = diaHoyTemp.substring(0, 1).toUpperCase() + diaHoyTemp.substring(1);

        // ======= Clases de hoy =======
        List<CursoDocente> clasesHoy = cursosConSecciones.stream()
                .filter(cd -> cd.getDia() != null && cd.getDia().equalsIgnoreCase(diaHoy))
                .collect(Collectors.toList());

        // ======= Agrupar cursos por id =======
        Map<Integer, List<CursoDocente>> cursosPorId = new HashMap<>();
        for (CursoDocente cd : cursosConSecciones) {
            cursosPorId
                    .computeIfAbsent(cd.getIdCurso(), k -> new ArrayList<>())
                    .add(cd);
        }

        // ======= Pasar datos al JSP =======
        request.setAttribute("totalCursos", totalCursos);
        request.setAttribute("totalAlumnos", totalAlumnos);
        request.setAttribute("clasesHoy", clasesHoy);
        request.setAttribute("cursosPorId", cursosPorId);
        request.setAttribute("cursosConSecciones", cursosConSecciones);

        // Mapas cacheados para que el JSP no toque la base de datos
        request.setAttribute("seccionesPorId", cacheSecciones);
        request.setAttribute("alumnosPorGrupo", cacheAlumnosPorGrupo);

        // Sidebar activo
        request.setAttribute("sidebarActive", "dashboard");

        // Forward al JSP
        request.getRequestDispatcher("/docente/panel.jsp").forward(request, response);
    }
}
