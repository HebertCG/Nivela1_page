<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="modelo.Usuario, DAO.*, modelo.*, java.util.*, java.util.stream.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Validar sesión
    Usuario docente = (Usuario) session.getAttribute("usuario");
    if (docente == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    UsuarioDAO dao = new UsuarioDAO();
    String rol = dao.obtenerNombreRol(docente.getIdRol());
    if (!"docente".equalsIgnoreCase(rol)) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    // Obtener cursos del docente
    CursoDocenteDAO cdDao = new CursoDocenteDAO();
    List<CursoDocente> todosCursos = cdDao.listarPorDocente(docente.getId());
    
    // Filtrar solo cursos con secciones (idSeccion > 0)
    List<CursoDocente> cursosConSecciones = todosCursos.stream()
        .filter(cd -> cd.getIdSeccion() > 0)
        .collect(Collectors.toList());
    
    // Agrupar por curso para evitar duplicados
    Map<Integer, List<CursoDocente>> cursosPorId = new HashMap<>();
    for (CursoDocente cd : cursosConSecciones) {
        cursosPorId.computeIfAbsent(cd.getIdCurso(), k -> new ArrayList<>()).add(cd);
    }
    
    request.setAttribute("sidebarActive", "cursos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Cursos - Nivel A1</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        .content-container {
            padding: 2rem;
            background: #f5f6fa;
        }
        
        .page-header {
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #2D1B69;
            margin-bottom: 0.5rem;
        }
        
        .page-subtitle {
            color: #6c757d;
            font-size: 1rem;
        }
        
        /* Curso Card */
        .curso-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .curso-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
        }
        
        .curso-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .curso-image::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 600"><text x="50%" y="50%" font-size="120" fill="rgba(255,255,255,0.1)" text-anchor="middle" dominant-baseline="middle" font-family="Arial, sans-serif" font-weight="bold">✏️</text></svg>');
            background-size: cover;
            opacity: 0.3;
        }
        
        .curso-image.matematicas {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .curso-image.fisica {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        
        .curso-image.quimica {
            background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        }
        
        .curso-image.ingenieria {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
        }
        
        .curso-image.medicina {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }
        
        .curso-image.derecho {
            background: linear-gradient(135deg, #30cfd0 0%, #330867 100%);
        }
        
        .curso-badge {
            position: absolute;
            top: 1rem;
            left: 1rem;
            background: white;
            color: #2D1B69;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
            z-index: 2;
        }
        
        .curso-body {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .curso-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #2D1B69;
            margin-bottom: 0.5rem;
            line-height: 1.3;
        }
        
        .curso-code {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 1.25rem;
        }
        
        .curso-info-list {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            margin-bottom: 1.5rem;
            flex: 1;
        }
        
        .curso-info-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.9rem;
            color: #495057;
        }
        
        .curso-info-item i {
            color: #00D9C0;
            font-size: 1.1rem;
            width: 20px;
            text-align: center;
        }
        
        .btn-ver-detalles {
            width: 100%;
            background: #00D9C0;
            border: none;
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-ver-detalles:hover {
            background: #00c4b0;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 217, 192, 0.3);
            color: white;
        }
        
        .empty-state {
            background: white;
            border-radius: 16px;
            padding: 4rem 2rem;
            text-align: center;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 1.5rem;
        }
        
        .empty-state h3 {
            color: #2D1B69;
            margin-bottom: 0.5rem;
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
            <div class="page-header">
                <h1 class="page-title">Mis Cursos</h1>
                <p class="page-subtitle">Gestiona tus cursos asignados, calificaciones y asistencia</p>
            </div>
            
            <% if (cursosPorId.isEmpty()) { %>
                <div class="empty-state">
                    <i class="bi bi-book"></i>
                    <h3>No tienes cursos asignados</h3>
                    <p>Contacta con el administrador para que te asigne cursos</p>
                </div>
            <% } else { %>
                <div class="row g-4">
                <%
                    GrupoEstudianteDAO geDao = new GrupoEstudianteDAO();
                    SeccionDAO secDao = new SeccionDAO();
                    
                    for (Map.Entry<Integer, List<CursoDocente>> entry : cursosPorId.entrySet()) {
                        CursoDocente curso = entry.getValue().get(0);
                        int idCurso = entry.getKey();
                        
                        // Determinar clase CSS según carrera
                        String imageClass = "ingenieria";
                        String emoji = "📚";
                        if (curso.getCarrera() != null) {
                            String carrera = curso.getCarrera().toLowerCase();
                            if (carrera.contains("matematica") || carrera.contains("algebra") || carrera.contains("calculo")) {
                                imageClass = "matematicas";
                                emoji = "➗";
                            } else if (carrera.contains("fisica") || carrera.contains("mecanica")) {
                                imageClass = "fisica";
                                emoji = "⚛️";
                            } else if (carrera.contains("quimica")) {
                                imageClass = "quimica";
                                emoji = "🧪";
                            } else if (carrera.contains("medicina") || carrera.contains("biologia")) {
                                imageClass = "medicina";
                                emoji = "🏥";
                            } else if (carrera.contains("derecho")) {
                                imageClass = "derecho";
                                emoji = "⚖️";
                            }
                        }
                        
                        // Calcular total de estudiantes únicos
                        Set<Integer> gruposDelCurso = new HashSet<>();
                        int totalEstudiantes = 0;
                        List<String> diasClase = new ArrayList<>();
                        String horarioCompleto = "";
                        
                        for (CursoDocente cd : entry.getValue()) {
                            Seccion sec = secDao.obtenerPorId(cd.getIdSeccion());
                            if (sec != null && !gruposDelCurso.contains(sec.getIdGrupo())) {
                                gruposDelCurso.add(sec.getIdGrupo());
                                List<Usuario> alumnos = geDao.listarPorGrupo(sec.getIdGrupo());
                                totalEstudiantes += alumnos.size();
                            }
                            
                            if (cd.getDia() != null && !diasClase.contains(cd.getDia())) {
                                diasClase.add(cd.getDia());
                            }
                            
                            if (horarioCompleto.isEmpty() && cd.getHoraInicio() != null) {
                                horarioCompleto = cd.getHoraInicio() + " - " + cd.getHoraFin();
                            }
                        }
                        
                        String diasTexto = String.join(", ", diasClase);
                        int idCursoVal = curso.getIdCurso();
                        String codigoCursoTexto = (idCursoVal > 0) ? "Código: " + idCursoVal : "";
                %>
                    <div class="col-md-6 col-lg-4">
                        <div class="curso-card">
                            <div class="curso-image <%= imageClass %>">
                                <span class="curso-badge"><%= curso.getCarrera() != null ? curso.getCarrera() : "General" %></span>
                            </div>
                            
                            <div class="curso-body">
                                <h3 class="curso-title"><%= curso.getNombreCurso() %></h3>
                                <p class="curso-code"><%= codigoCursoTexto %></p>
                                
                                <div class="curso-info-list">
                                    <div class="curso-info-item">
                                        <i class="bi bi-people-fill"></i>
                                        <span><%= totalEstudiantes %> estudiantes</span>
                                    </div>
                                    
                                    <% if (diasTexto != null && diasTexto.length() > 0) { %>
                                    <div class="curso-info-item">
                                        <i class="bi bi-calendar3"></i>
                                        <span><%= diasTexto %></span>
                                    </div>
                                    <% } %>
                                    
                                    <% if (horarioCompleto != null && horarioCompleto.length() > 0) { %>
                                    <div class="curso-info-item">
                                        <i class="bi bi-clock"></i>
                                        <span><%= horarioCompleto %></span>
                                    </div>
                                    <% } %>
                                </div>
                                
                                <a href="${pageContext.request.contextPath}/docente/curso-detalle.jsp?idCurso=<%= idCurso %>" 
                                   class="btn-ver-detalles">
                                    Ver Detalles
                                </a>
                            </div>
                        </div>
                    </div>
                <% 
                    }
                %>
                </div>
            <% } %>
        </div>
    </div>
    
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
