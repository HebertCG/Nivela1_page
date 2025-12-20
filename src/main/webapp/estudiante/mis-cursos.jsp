<%@ page import="modelo.Usuario" %>
    <%@ page session="true" %>
        <%@ page import="DAO.UsuarioDAO" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                    <%@ include file="verificarEstudiante.jsp" %>
                        <% if ("true".equals(request.getParameter("logout"))) { session.invalidate();
                            response.sendRedirect("../login.jsp"); return; }
                            request.setAttribute("sidebarActive", "cursos" ); %>
                            <!DOCTYPE html>
                            <html lang="es">

                            <head>
                                <meta charset="UTF-8">
                                <title>Mis Cursos</title>
                                <link rel="stylesheet"
                                    href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                                <link rel="stylesheet"
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                                <style>
                                    :root {
                                        --color-bg: #F3F4F6;
                                        --color-surface: #FFFFFF;
                                        --color-border: #E5E7EB;
                                        --color-muted: #6B7280;
                                        --color-accent: #00C2CB;
                                        --color-accent-2: #00A63E;
                                        --color-sidebar-top: #1E1B4B;
                                        --color-sidebar-bottom: #2F0059;
                                        --color-sidebar-text: #FFFFFFB2;
                                    }

                                    body {
                                        font-family: "Segoe UI", "Inter", system-ui, -apple-system, sans-serif;
                                        background: var(--color-bg);
                                        color: #1A1A1A;
                                        margin: 0;
                                    }

                                    .dashboard-layout {
                                        min-height: 100vh;
                                        background: var(--color-bg);
                                    }

                                    .content-wrapper {
                                        flex: 1;
                                        display: flex;
                                        flex-direction: column;
                                        background: var(--color-bg);
                                        margin-left: 280px;
                                        transition: margin-left 0.3s ease;
                                    }

                                    .dashboard-main {
                                        flex: 1;
                                        padding: 2rem;
                                    }

                                    .section-card {
                                        background: var(--color-surface);
                                        border-radius: 20px;
                                        border: 1px solid var(--color-border);
                                        padding: 1.5rem;
                                    }

                                    .courses-hero {
                                        margin-bottom: 2rem;
                                    }

                                    .courses-hero h1 {
                                        font-size: 2rem;
                                        font-weight: 700;
                                        color: #1A1A1A;
                                        margin: 0;
                                    }

                                    .courses-hero p {
                                        color: var(--color-muted);
                                        margin: 0;
                                    }

                                    .courses-grid {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                                        gap: 2rem;
                                        margin-bottom: 2rem;
                                    }

                                    .course-card {
                                        background: var(--color-surface);
                                        border-radius: 16px;
                                        overflow: hidden;
                                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                        transition: all 0.3s ease;
                                        border: 1px solid var(--color-border);
                                        height: 100%;
                                        display: flex;
                                        flex-direction: column;
                                    }

                                    .course-card:hover {
                                        transform: translateY(-4px);
                                        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
                                    }

                                    .course-cover {
                                        width: 100%;
                                        height: 200px;
                                        background-size: cover;
                                        background-position: center;
                                        position: relative;
                                    }

                                    .course-cover::after {
                                        content: '';
                                        position: absolute;
                                        inset: 0;
                                        background: linear-gradient(to bottom, transparent 0%, rgba(0, 0, 0, 0.3) 100%);
                                    }

                                    .course-body {
                                        padding: 1.5rem;
                                    }

                                    .course-tag {
                                        display: inline-block;
                                        background: #EEF2FF;
                                        color: #4F46E5;
                                        padding: 0.25rem 0.75rem;
                                        border-radius: 999px;
                                        font-size: 0.75rem;
                                        font-weight: 600;
                                        text-transform: uppercase;
                                        letter-spacing: 0.5px;
                                        margin-bottom: 0.75rem;
                                    }

                                    .course-title {
                                        font-size: 1.1rem;
                                        font-weight: 700;
                                        color: #1A1A1A;
                                        margin: 0.5rem 0;
                                        line-height: 1.4;
                                        min-height: 2.8rem;
                                        display: -webkit-box;
                                        -webkit-line-clamp: 2;
                                        -webkit-box-orient: vertical;
                                        overflow: hidden;
                                    }

                                    .course-meta {
                                        display: flex;
                                        align-items: center;
                                        gap: 0.75rem;
                                        margin-top: 1rem;
                                        padding-top: 1rem;
                                        border-top: 1px solid var(--color-border);
                                    }

                                    .course-avatar {
                                        width: 40px;
                                        height: 40px;
                                        border-radius: 50%;
                                        background: linear-gradient(135deg, var(--color-accent), var(--color-accent-2));
                                        color: white;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        font-weight: 700;
                                        font-size: 1.1rem;
                                    }

                                    .course-footer {
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                        margin-top: 1rem;
                                        padding-top: 1rem;
                                        border-top: 1px solid var(--color-border);
                                    }

                                    .course-level {
                                        display: flex;
                                        align-items: center;
                                        gap: 0.35rem;
                                        color: var(--color-muted);
                                        font-size: 0.875rem;
                                        font-weight: 500;
                                    }

                                    .btn-outline-primary {
                                        color: var(--color-accent);
                                        border: 2px solid var(--color-accent);
                                        background: transparent;
                                        padding: 0.65rem 1.25rem;
                                        border-radius: 8px;
                                        font-weight: 600;
                                        transition: all 0.3s ease;
                                        text-decoration: none;
                                        display: inline-block;
                                        text-align: center;
                                    }

                                    .btn-outline-primary:hover {
                                        background: var(--color-accent);
                                        color: white;
                                        transform: translateY(-2px);
                                        box-shadow: 0 4px 12px rgba(0, 194, 203, 0.3);
                                    }

                                    .btn-secondary {
                                        background: #6B7280;
                                        color: white;
                                        border: none;
                                        padding: 0.75rem 1.5rem;
                                        border-radius: 8px;
                                        font-weight: 600;
                                        transition: all 0.3s ease;
                                        text-decoration: none;
                                        display: inline-block;
                                    }

                                    .btn-secondary:hover {
                                        background: #4B5563;
                                        transform: translateY(-2px);
                                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                                    }

                                    @media (max-width: 991.98px) {
                                        .dashboard-main {
                                            padding: 1.5rem 1rem 2rem;
                                        }

                                        .content-wrapper {
                                            margin-left: 0 !important;
                                        }
                                    }

                                    .estudiante-sidebar[data-collapsed="true"]~.content-wrapper {
                                        margin-left: 80px;
                                    }
                                </style>
                            </head>

                            <body>
                                <c:set var="courseCovers"
                                    value="${fn:split('https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=900&q=60,https://images.unsplash.com/photo-1509221963641-49e27c514d3c?auto=format&fit=crop&w=900&q=60', ',')}" />
                                <c:set var="progressPattern" value="${fn:split('65,40,85', ',')}" />
                                <div class="dashboard-layout d-flex">
                                    <%@ include file="sidebar-estudiante.jsp" %>
                                        <div class="content-wrapper">
                                            <%@ include file="topbar-estudiante.jsp" %>
                                                <main class="dashboard-main courses-main">
                                                    <div class="courses-hero mb-4">
                                                        <div>
                                                            <p class="text-muted mb-1">Descubre y gestiona tus cursos
                                                            </p>
                                                            <h1 class="mb-0">Mis Cursos</h1>
                                                        </div>
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${not empty secciones}">
                                                            <div class="courses-grid">
                                                                <c:forEach var="curso" items="${secciones}"
                                                                    varStatus="status">
                                                                    <c:set var="coverIndex"
                                                                        value="${status.index % fn:length(courseCovers)}" />
                                                                    <c:set var="progressIndex"
                                                                        value="${status.index % fn:length(progressPattern)}" />
                                                                    <c:set var="progressValue"
                                                                        value="${progressPattern[progressIndex]}" />
                                                                    <div class="course-card">
                                                                        <div class="course-cover"
                                                                            style="background-image: url('${courseCovers[coverIndex]}');">
                                                                        </div>
                                                                        <div class="course-body">
                                                                            <span class="course-tag">${empty
                                                                                curso.carrera ? "Curso" :
                                                                                curso.carrera}</span>
                                                                            <h5 class="course-title">${curso.curso}
                                                                            </h5>
                                                                            <p class="text-muted mb-2">
                                                                                ${curso.seccion} &middot;
                                                                                ${curso.grupo}</p>
                                                                            <div class="course-meta">
                                                                                <div class="course-avatar">
                                                                                    ${fn:substring(curso.curso, 0,
                                                                                    1)}</div>
                                                                                <div>
                                                                                    <p class="mb-0 fw-semibold">
                                                                                        ${empty curso.profesor ?
                                                                                        'Por asignar' :
                                                                                        curso.profesor}</p>
                                                                                    <small
                                                                                        class="text-muted">Instructor</small>
                                                                                </div>
                                                                            </div>
                                                                            <div class="course-footer">
                                                                                <div>
                                                                                    <small
                                                                                        class="text-muted">Horario</small>
                                                                                    <p class="mb-0 fw-semibold">
                                                                                        ${curso.dia} &middot;
                                                                                        ${curso.horaInicio} -
                                                                                        ${curso.horaFin}</p>
                                                                                </div>
                                                                                <div class="course-level">
                                                                                    <i class="bi bi-bookmark"></i>
                                                                                    ${empty curso.seccion ?
                                                                                    "Seccion" : curso.seccion}
                                                                                </div>
                                                                            </div>
                                                                            <a class="btn btn-outline-primary w-100 mt-3"
                                                                                href="${pageContext.request.contextPath}/Estudiante/Cursos/Detalle?idSeccion=${curso.id}">
                                                                                Ver material
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="section-card text-center">
                                                                <h5>A&uacute;n no tienes cursos asignados</h5>
                                                                <p class="text-muted mb-0">Cuando te inscribas en una
                                                                    secci&oacute;n ver&aacute;s sus detalles
                                                                    aqu&iacute;.</p>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <div class="text-center mt-4">
                                                        <a href="${pageContext.request.contextPath}/estudiante/panel.jsp"
                                                            class="btn btn-secondary px-4">Volver al panel</a>
                                                    </div>
                                                </main>
                                        </div>
                                </div>
                                <script
                                    src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                            </body>

                            </html>