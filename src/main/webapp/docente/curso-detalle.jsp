<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.*, DAO.*, java.util.*, java.util.stream.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Validar sesión
    Usuario docente = (Usuario) session.getAttribute("usuario");
    if (docente == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Obtener ID del curso
    String idCursoParam = request.getParameter("idCurso");
    if (idCursoParam == null || idCursoParam.isEmpty()) {
        response.sendRedirect(request.getContextPath() + "/MisCursos");
        return;
    }
    
    int idCurso = Integer.parseInt(idCursoParam);
    
    // Obtener información del curso
    CursoDocenteDAO cdDao = new CursoDocenteDAO();
    List<CursoDocente> cursosDocente = cdDao.listarPorDocente(docente.getId());
    
    CursoDocente cursoActual = cursosDocente.stream()
        .filter(cd -> cd.getIdCurso() == idCurso && cd.getIdSeccion() != null && cd.getIdSeccion() > 0)
        .findFirst()
        .orElse(null);
    
    if (cursoActual == null) {
        response.sendRedirect(request.getContextPath() + "/MisCursos");
        return;
    }
    
    // Obtener todas las secciones de este curso
    List<CursoDocente> seccionesCurso = cursosDocente.stream()
        .filter(cd -> cd.getIdCurso() == idCurso && cd.getIdSeccion() != null && cd.getIdSeccion() > 0)
        .collect(Collectors.toList());
    
    // Obtener alumnos
    SeccionDAO secDao = new SeccionDAO();
    GrupoEstudianteDAO geDao = new GrupoEstudianteDAO();
    Set<Integer> gruposVistos = new HashSet<>();
    List<Usuario> todosAlumnos = new ArrayList<>();
    
    for (CursoDocente cd : seccionesCurso) {
        Seccion sec = secDao.obtenerPorId(cd.getIdSeccion());
        if (sec != null && !gruposVistos.contains(sec.getIdGrupo())) {
            gruposVistos.add(sec.getIdGrupo());
            List<Usuario> alumnos = geDao.listarPorGrupo(sec.getIdGrupo());
            todosAlumnos.addAll(alumnos);
        }
    }
    
    // Obtener materiales del curso
    MaterialCursoDAO matDao = new MaterialCursoDAO();
    List<MaterialCurso> materiales = matDao.listarPorCurso(idCurso);
    
    // Agrupar materiales por "semanas" (basado en el título)
    Map<String, List<MaterialCurso>> materialesPorSemana = new LinkedHashMap<>();
    for (MaterialCurso mat : materiales) {
        String titulo = mat.getTitulo() != null ? mat.getTitulo() : "Material";
        String semana = "Semana 1";
        
        if (titulo.toLowerCase().contains("semana")) {
            String[] partes = titulo.split(":", 2);
            semana = partes[0].trim();
        }
        
        materialesPorSemana.computeIfAbsent(semana, k -> new ArrayList<>()).add(mat);
    }
    
    // Calcular días de clase
    String diasClase = seccionesCurso.stream()
        .map(CursoDocente::getDia)
        .filter(Objects::nonNull)
        .distinct()
        .collect(Collectors.joining(", "));
    
    request.setAttribute("sidebarActive", "cursos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= cursoActual.getNombreCurso() %> - Nivel A1</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        .content-container {
            padding: 2rem;
            background: #f5f6fa;
        }
        
        /* Back Button */
        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
            text-decoration: none;
            font-size: 0.95rem;
            margin-bottom: 1.5rem;
            transition: color 0.3s ease;
        }
        
        .back-button:hover {
            color: #2D1B69;
        }
        
        /* Course Header */
        .course-header {
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        
        .course-badge {
            display: inline-block;
            background: #00D9C0;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .course-title {
            font-size: 1.75rem;
            font-weight: 700;
            color: #2D1B69;
            margin-bottom: 0.5rem;
        }
        
        .course-code {
            color: #6c757d;
            margin-bottom: 1.5rem;
        }
        
        .course-info-grid {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }
        
        .course-info-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #495057;
        }
        
        .course-info-item i {
            color: #00D9C0;
        }
        
        /* Tabs */
        .custom-tabs {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 2rem;
            display: flex;
            gap: 2rem;
        }
        
        .custom-tab {
            padding: 1rem 0;
            color: #6c757d;
            text-decoration: none;
            font-weight: 600;
            border-bottom: 3px solid transparent;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .custom-tab:hover {
            color: #2D1B69;
        }
        
        .custom-tab.active {
            color: #2D1B69;
            border-bottom-color: #00D9C0;
        }
        
        .tab-content-wrapper {
            display: none;
        }
        
        .tab-content-wrapper.active {
            display: block;
        }
        
        /* Alumnos List */
        .alumnos-list {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        }
        
        .alumno-item {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: background 0.3s ease;
        }
        
        .alumno-item:last-child {
            border-bottom: none;
        }
        
        .alumno-item:hover {
            background: #f8f9fa;
        }
        
        .alumno-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2D1B69, #00D9C0);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .alumno-info {
            flex: 1;
        }
        
        .alumno-name {
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 0.25rem;
        }
        
        .alumno-code {
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .alumno-promedio {
            text-align: right;
        }
        
        .promedio-label {
            font-size: 0.75rem;
            color: #6c757d;
            display: block;
        }
        
        .promedio-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #00D9C0;
        }
        
        /* Materiales */
        .materiales-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }
        
        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #2D1B69;
        }
        
        .section-subtitle {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .btn-subir-material {
            background: #00D9C0;
            color: white;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .btn-subir-material:hover {
            background: #00c4b0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 217, 192, 0.3);
        }
        
        /* Semana Card */
        .semana-card {
            background: white;
            border-radius: 16px;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .semana-header {
            padding: 1.25rem 1.5rem;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: space-between;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .semana-header:hover {
            background: #e9ecef;
        }
        
        .semana-title-container {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .semana-icon {
            width: 40px;
            height: 40px;
            background: #00D9C0;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }
        
        .semana-title {
            font-weight: 600;
            color: #2D1B69;
            margin: 0;
        }
        
        .semana-subtitle {
            font-size: 0.875rem;
            color: #6c757d;
            margin: 0;
        }
        
        .semana-toggle {
            color: #6c757d;
            transition: transform 0.3s ease;
        }
        
        .semana-toggle.collapsed {
            transform: rotate(0deg);
        }
        
        .semana-toggle.expanded {
            transform: rotate(180deg);
        }
        
        .semana-content {
            padding: 0;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        
        .semana-content.show {
            max-height: 2000px;
        }
        
        /* Material Item */
        .material-item {
            padding: 1.25rem 1.5rem;
            border-bottom: 1px solid #f0f0f0;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: background 0.3s ease;
        }
        
        .material-item:last-child {
            border-bottom: none;
        }
        
        .material-item:hover {
            background: #f8f9fa;
        }
        
        .material-icon {
            width: 45px;
            height: 45px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }
        
        .material-icon.pdf { background: #ffebee; color: #d32f2f; }
        .material-icon.doc { background: #e3f2fd; color: #1976d2; }
        .material-icon.video { background: #fff3e0; color: #f57c00; }
        .material-icon.archivo { background: #f3e5f5; color: #7b1fa2; }
        
        .material-info {
            flex: 1;
        }
        
        .material-title {
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 0.25rem;
        }
        
        .material-meta {
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .material-actions {
            display: flex;
            gap: 0.5rem;
        }
        
        .btn-action {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            border: none;
            background: #f8f9fa;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-action:hover {
            background: #00D9C0;
            color: white;
        }
        
        .btn-agregar-material {
            width: 100%;
            padding: 1rem;
            background: #f8f9fa;
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            color: #6c757d;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .btn-agregar-material:hover {
            border-color: #00D9C0;
            color: #00D9C0;
            background: rgba(0, 217, 192, 0.05);
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
    <!-- Sidebar -->
    <jsp:include page="sidebar-docente.jsp" />
    
    <!-- Contenedor Principal -->
    <div class="main-content-wrapper">
        <!-- Topbar -->
        <jsp:include page="topbar-docente.jsp" />
        
        <!-- Contenido -->
        <div class="content-container">
            <!-- Back Button -->
            <a href="${pageContext.request.contextPath}/MisCursos" class="back-button">
                <i class="bi bi-arrow-left"></i>
                Volver a mis cursos
            </a>
            
            <!-- Course Header -->
            <div class="course-header">
                <span class="course-badge"><%= cursoActual.getCarrera() != null ? cursoActual.getCarrera() : "General" %></span>
                <h1 class="course-title"><%= cursoActual.getNombreCurso() %></h1>
                <p class="course-code">Código: <%= cursoActual.getIdCurso() %></p>
                
                <div class="course-info-grid">
                    <div class="course-info-item">
                        <i class="bi bi-people-fill"></i>
                        <span><%= todosAlumnos.size() %> estudiantes</span>
                    </div>
                    <% if (!diasClase.isEmpty()) { %>
                    <div class="course-info-item">
                        <i class="bi bi-calendar3"></i>
                        <span><%= diasClase %></span>
                    </div>
                    <% } %>
                </div>
            </div>
            
            <!-- Tabs -->
            <div class="custom-tabs">
                <a class="custom-tab active" data-tab="alumnos">Alumnos</a>
                <a class="custom-tab" data-tab="materiales">Materiales</a>
            </div>
            
            <!-- Tab Content: Alumnos -->
            <div class="tab-content-wrapper active" id="tab-alumnos">
                <div class="section-title mb-3">Lista de Estudiantes</div>
                
                <% if (todosAlumnos.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="bi bi-people"></i>
                        <h5>No hay estudiantes matriculados</h5>
                        <p>Aún no se han asignado estudiantes a este curso</p>
                    </div>
                <% } else { %>
                    <div class="alumnos-list">
                        <% for (Usuario alumno : todosAlumnos) { 
                            String iniciales = alumno.getNombre().substring(0, 1).toUpperCase() + 
                                             alumno.getApellido().substring(0, 1).toUpperCase();
                        %>
                        <div class="alumno-item">
                            <div class="alumno-avatar"><%= iniciales %></div>
                            <div class="alumno-info">
                                <div class="alumno-name"><%= alumno.getNombre() %> <%= alumno.getApellido() %></div>
                                <div class="alumno-code"><%= alumno.getCorreo() %></div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                <% } %>
            </div>
            
            <!-- Tab Content: Materiales -->
            <div class="tab-content-wrapper" id="tab-materiales">
                <div class="materiales-header">
                    <div>
                        <div class="section-title">Materiales del Curso</div>
                        <div class="section-subtitle">Gestiona y organiza los materiales por módulo</div>
                    </div>
                    <button class="btn-subir-material">
                        <i class="bi bi-cloud-upload"></i>
                        Subir Material
                    </button>
                </div>
                
                <% if (materialesPorSemana.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="bi bi-folder"></i>
                        <h5>No hay materiales disponibles</h5>
                        <p>Sube el primer material para este curso</p>
                    </div>
                <% } else { 
                    int semanaIndex = 0;
                    for (Map.Entry<String, List<MaterialCurso>> entry : materialesPorSemana.entrySet()) {
                        String semana = entry.getKey();
                        List<MaterialCurso> materialesSemana = entry.getValue();
                        String descripcion = materialesSemana.get(0).getDescripcion();
                        if (descripcion == null || descripcion.isEmpty()) {
                            descripcion = "Contenidos y recursos de la semana";
                        }
                        semanaIndex++;
                %>
                <div class="semana-card">
                    <div class="semana-header" onclick="toggleSemana(<%= semanaIndex %>)">
                        <div class="semana-title-container">
                            <div class="semana-icon">
                                <i class="bi bi-book"></i>
                            </div>
                            <div>
                                <div class="semana-title"><%= semana %></div>
                                <div class="semana-subtitle"><%= descripcion %></div>
                            </div>
                        </div>
                        <i class="bi bi-chevron-down semana-toggle" id="toggle-<%= semanaIndex %>"></i>
                    </div>
                    <div class="semana-content" id="content-<%= semanaIndex %>">
                        <% for (MaterialCurso mat : materialesSemana) { 
                            String iconClass = "archivo";
                            String iconName = "bi-file-earmark";
                            
                            if ("PDF".equals(mat.getTipo())) {
                                iconClass = "pdf";
                                iconName = "bi-file-pdf";
                            } else if ("DOC".equals(mat.getTipo())) {
                                iconClass = "doc";
                                iconName = "bi-file-word";
                            } else if ("VIDEO".equals(mat.getTipo())) {
                                iconClass = "video";
                                iconName = "bi-file-play";
                            }
                        %>
                        <div class="material-item">
                            <div class="material-icon <%= iconClass %>">
                                <i class="bi <%= iconName %>"></i>
                            </div>
                            <div class="material-info">
                                <div class="material-title"><%= mat.getTitulo() %></div>
                                <div class="material-meta"><%= mat.getTipo() %></div>
                            </div>
                            <div class="material-actions">
                                <button class="btn-action" title="Ver">
                                    <i class="bi bi-eye"></i>
                                </button>
                                <a href="${pageContext.request.contextPath}/descargar?file=<%= mat.getArchivo() %>" 
                                   class="btn-action" title="Descargar">
                                    <i class="bi bi-download"></i>
                                </a>
                            </div>
                        </div>
                        <% } %>
                        
                        <div class="p-3">
                            <button class="btn-agregar-material">
                                <i class="bi bi-plus-circle"></i>
                                Agregar material a este módulo
                            </button>
                        </div>
                    </div>
                </div>
                <% 
                    }
                } %>
            </div>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>
        // Tabs switching
        document.querySelectorAll('.custom-tab').forEach(tab => {
            tab.addEventListener('click', function(e) {
                e.preventDefault();
                
                // Remove active class from all tabs
                document.querySelectorAll('.custom-tab').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-content-wrapper').forEach(c => c.classList.remove('active'));
                
                // Add active class to clicked tab
                this.classList.add('active');
                const tabName = this.getAttribute('data-tab');
                document.getElementById('tab-' + tabName).classList.add('active');
            });
        });
        
        // Toggle semana accordion
        function toggleSemana(index) {
            const content = document.getElementById('content-' + index);
            const toggle = document.getElementById('toggle-' + index);
            
            if (content.classList.contains('show')) {
                content.classList.remove('show');
                toggle.classList.remove('expanded');
                toggle.classList.add('collapsed');
            } else {
                content.classList.add('show');
                toggle.classList.add('expanded');
                toggle.classList.remove('collapsed');
            }
        }
    </script>
</body>
</html>