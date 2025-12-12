<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="modelo.CursoDocente, modelo.Seccion, java.util.*" %>
<%@ page session="true" %>

<%
    // Recuperar datos preparados por el servlet
    Integer totalCursos = (Integer) request.getAttribute("totalCursos");
    if (totalCursos == null) totalCursos = 0;

    Integer totalAlumnos = (Integer) request.getAttribute("totalAlumnos");
    if (totalAlumnos == null) totalAlumnos = 0;

    List<CursoDocente> clasesHoy = (List<CursoDocente>) request.getAttribute("clasesHoy");
    if (clasesHoy == null) clasesHoy = Collections.emptyList();

    Map<Integer, List<CursoDocente>> cursosPorId =
        (Map<Integer, List<CursoDocente>>) request.getAttribute("cursosPorId");
    if (cursosPorId == null) cursosPorId = new HashMap<>();

    Map<Integer, Seccion> seccionesPorId =
        (Map<Integer, Seccion>) request.getAttribute("seccionesPorId");
    if (seccionesPorId == null) seccionesPorId = new HashMap<>();

    Map<Integer, Integer> alumnosPorGrupo =
        (Map<Integer, Integer>) request.getAttribute("alumnosPorGrupo");
    if (alumnosPorGrupo == null) alumnosPorGrupo = new HashMap<>();

    // sidebarActive ya lo puso el servlet, pero si no estuviera:
    if (request.getAttribute("sidebarActive") == null) {
        request.setAttribute("sidebarActive", "dashboard");
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Docente - Nivel A1</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        .content-container {
            padding: 2rem;
            background: #f5f6fa;
        }
        
        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .stat-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
        }
        
        .stat-card.cyan {
            background: linear-gradient(135deg, #e0f7fa 0%, #b2ebf2 100%);
        }
        
        .stat-card.purple {
            background: linear-gradient(135deg, #f3e5f5 0%, #e1bee7 100%);
        }
        
        .stat-card.yellow {
            background: linear-gradient(135deg, #fff9c4 0%, #fff59d 100%);
        }
        
        .stat-content h6 {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        
        .stat-content h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2D1B69;
            margin: 0;
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
        }
        
        .stat-icon.cyan { background: #00bcd4; color: white; }
        .stat-icon.purple { background: #9c27b0; color: white; }
        .stat-icon.yellow { background: #ffc107; color: white; }
        
        /* Section Headers */
        .section-header {
            margin-bottom: 1.5rem;
        }
        
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 1.5rem;
        }
        
        /* Clase Card */
        .clase-card {
            background: white;
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1rem;
            border-left: 4px solid #00D9C0;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
            transition: all 0.3s ease;
        }
        
        .clase-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.12);
            transform: translateX(4px);
        }
        
        .clase-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 0.75rem;
        }
        
        .clase-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 0.25rem;
        }
        
        .clase-code {
            font-size: 0.85rem;
            color: #6c757d;
        }
        
        .clase-badge {
            background: #e3f2fd;
            color: #1976d2;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .clase-info {
            display: flex;
            gap: 1.5rem;
            flex-wrap: wrap;
        }
        
        .clase-info-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .clase-info-item i {
            color: #00D9C0;
        }
        
        /* Curso Card */
        .curso-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .curso-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
        }
        
        .curso-badge {
            display: inline-block;
            padding: 0.35rem 0.85rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .curso-badge.matematicas { background: #00d9c0; color: white; }
        .curso-badge.fisica { background: #667eea; color: white; }
        .curso-badge.quimica { background: #f093fb; color: white; }
        .curso-badge.ingenieria { background: #4facfe; color: white; }
        .curso-badge.medicina { background: #43e97b; color: white; }
        .curso-badge.derecho { background: #fa709a; color: white; }
        
        .curso-title {
            font-size: 1.15rem;
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 0.5rem;
            line-height: 1.3;
        }
        
        .curso-code {
            font-size: 0.85rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }
        
        .curso-info-grid {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .curso-info-row {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: #495057;
        }
        
        .curso-info-row i {
            color: #00D9C0;
            width: 20px;
        }
        
        .empty-state {
            background: white;
            border-radius: 16px;
            padding: 3rem 2rem;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #dee2e6;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar-docente.jsp" />
    
    <div class="main-content-wrapper">
        <jsp:include page="topbar-docente.jsp" />
        
        <div class="content-container">
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card cyan">
                    <div class="stat-content">
                        <h6>Cursos Asignados</h6>
                        <h2><%= totalCursos %></h2>
                    </div>
                    <div class="stat-icon cyan">
                        <i class="bi bi-journal-bookmark"></i>
                    </div>
                </div>
                
                <div class="stat-card purple">
                    <div class="stat-content">
                        <h6>Total Alumnos</h6>
                        <h2><%= totalAlumnos %></h2>
                    </div>
                    <div class="stat-icon purple">
                        <i class="bi bi-people"></i>
                    </div>
                </div>
                
                <div class="stat-card yellow">
                    <div class="stat-content">
                        <h6>Clases Hoy</h6>
                        <h2><%= clasesHoy.size() %></h2>
                    </div>
                    <div class="stat-icon yellow">
                        <i class="bi bi-calendar-check"></i>
                    </div>
                </div>
            </div>
            
            <!-- Clases de Hoy -->
            <div class="section-header">
                <h3 class="section-title">Clases de Hoy</h3>
            </div>
            
            <% if (clasesHoy.isEmpty()) { %>
                <div class="empty-state">
                    <i class="bi bi-calendar-x"></i>
                    <h5>No tienes clases programadas para hoy</h5>
                    <p class="text-muted">Disfruta tu día libre</p>
                </div>
            <% } else { 
                for (CursoDocente clase : clasesHoy) {
                    Seccion sec = seccionesPorId.get(clase.getIdSeccion());
                    int numAlumnos = 0;
                    if (sec != null) {
                        Integer totalGrupo = alumnosPorGrupo.get(sec.getIdGrupo());
                        if (totalGrupo != null) numAlumnos = totalGrupo;
                    }
            %>
                <div class="clase-card">
                    <div class="clase-header">
                        <div>
                            <div class="clase-title"><%= clase.getNombreCurso() %></div>
                            <div class="clase-code"><%= clase.getCarrera() != null ? clase.getCarrera() : "" %></div>
                        </div>
                        <div class="clase-badge">
                            <%= clase.getSeccion() != null ? clase.getSeccion() : "" %>-<%= clase.getGrupo() != null ? clase.getGrupo().substring(clase.getGrupo().length()-1) : "" %>
                        </div>
                    </div>
                    <div class="clase-info">
                        <div class="clase-info-item">
                            <i class="bi bi-clock"></i>
                            <span><%= clase.getHoraInicio() %> - <%= clase.getHoraFin() %></span>
                        </div>
                        <div class="clase-info-item">
                            <i class="bi bi-people"></i>
                            <span><%= numAlumnos %> estudiantes</span>
                        </div>
                    </div>
                </div>
            <% 
                } 
            } %>
            
            <!-- Mis Cursos -->
            <div class="section-header mt-5">
                <h3 class="section-title">Mis Cursos</h3>
            </div>
            
            <div class="row g-4">
            <% 
                if (cursosPorId.isEmpty()) {
            %>
                <div class="col-12">
                    <div class="empty-state">
                        <i class="bi bi-book"></i>
                        <h5>No tienes cursos asignados</h5>
                        <p class="text-muted">Contacta con el administrador</p>
                    </div>
                </div>
            <% 
                } else {
                    for (Map.Entry<Integer, List<CursoDocente>> entry : cursosPorId.entrySet()) {
                        CursoDocente curso = entry.getValue().get(0);
                        
                        // Contar total de alumnos en todas las secciones de este curso usando los mapas ya cacheados
                        Set<Integer> gruposDelCurso = new HashSet<>();
                        int totalAlumnosCurso = 0;
                        for (CursoDocente cd : entry.getValue()) {
                            Seccion sec = seccionesPorId.get(cd.getIdSeccion());
                            if (sec != null && gruposDelCurso.add(sec.getIdGrupo())) {
                                Integer totalGrupo = alumnosPorGrupo.get(sec.getIdGrupo());
                                if (totalGrupo != null) totalAlumnosCurso += totalGrupo;
                            }
                        }
                        
                        String badgeClass = "ingenieria";
                        if (curso.getCarrera() != null) {
                            if (curso.getCarrera().contains("Matematica")) badgeClass = "matematicas";
                            else if (curso.getCarrera().contains("Fisica")) badgeClass = "fisica";
                            else if (curso.getCarrera().contains("Quimica")) badgeClass = "quimica";
                            else if (curso.getCarrera().contains("Medicina")) badgeClass = "medicina";
                            else if (curso.getCarrera().contains("Derecho")) badgeClass = "derecho";
                        }
            %>
                <div class="col-md-6 col-lg-4">
                    <div class="curso-card">
                        <span class="curso-badge <%= badgeClass %>">
                            <%= curso.getCarrera() != null ? curso.getCarrera() : "General" %>
                        </span>
                        <div class="curso-title"><%= curso.getNombreCurso() %></div>
                        <div class="curso-code">Código: <%= curso.getIdCurso() %></div>
                        
                        <div class="curso-info-grid">
                            <div class="curso-info-row">
                                <i class="bi bi-people-fill"></i>
                                <span><%= totalAlumnosCurso %> estudiantes</span>
                            </div>
                            <% 
                                // Mostrar secciones
                                for (CursoDocente cd : entry.getValue()) {
                            %>
                            <div class="curso-info-row">
                                <i class="bi bi-diagram-3"></i>
                                <span>Sección <%= cd.getSeccion() %> - Grupo <%= cd.getGrupo() %></span>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% 
                    }
                }
            %>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
