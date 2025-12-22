<%@ page import="modelo.Usuario" %>
    <%@ page session="true" %>
        <%@ include file="verificarAdmin.jsp" %>
            <% if ("true".equals(request.getParameter("logout"))) { session.invalidate();
                response.sendRedirect("../login.jsp"); return; } request.setAttribute("sidebarActive", "dashboard" ); %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link rel="icon" type="image/png" href="img/LOGOS.png" />
                    <title>Panel Administrador</title>
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                    <style>
                        :root {
                            --admin-accent: #8B5CF6;
                            --color-bg: #F3F4F6;
                            --color-surface: #FFFFFF;
                            --color-border: #E5E7EB;
                        }

                        body {
                            font-family: "Segoe UI", "Inter", system-ui, -apple-system, sans-serif;
                            background: var(--color-bg);
                            margin: 0;
                            color: #1A1A1A;
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
                            min-height: 100vh;
                        }

                        .dashboard-main {
                            flex: 1;
                            padding: 2rem;
                        }

                        .page-header {
                            margin-bottom: 2rem;
                        }

                        .page-title {
                            font-size: 2rem;
                            font-weight: 700;
                            color: #1A1A1A;
                            margin: 0 0 0.5rem 0;
                        }

                        .page-subtitle {
                            color: #6B7280;
                            margin: 0;
                        }

                        .cards-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                            gap: 1.5rem;
                        }

                        .admin-card {
                            background: white;
                            border-radius: 16px;
                            padding: 2rem;
                            border: 1px solid var(--color-border);
                            transition: all 0.3s ease;
                            position: relative;
                            overflow: hidden;
                        }

                        .admin-card::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            height: 4px;
                            background: var(--card-color);
                        }

                        .admin-card:hover {
                            transform: translateY(-4px);
                            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
                        }

                        .card-icon {
                            width: 56px;
                            height: 56px;
                            border-radius: 12px;
                            background: var(--card-color);
                            color: white;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.75rem;
                            margin-bottom: 1rem;
                        }

                        .card-title {
                            font-size: 1.25rem;
                            font-weight: 700;
                            color: #1A1A1A;
                            margin: 0 0 0.5rem 0;
                        }

                        .card-description {
                            color: #6B7280;
                            font-size: 0.95rem;
                            margin: 0 0 1.5rem 0;
                            line-height: 1.5;
                        }

                        .card-button {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.75rem 1.5rem;
                            background: var(--card-color);
                            color: white;
                            border: none;
                            border-radius: 10px;
                            font-weight: 600;
                            text-decoration: none;
                            transition: all 0.3s ease;
                        }

                        .card-button:hover {
                            background: var(--card-color-dark);
                            color: white;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                        }

                        .card-purple {
                            --card-color: #8B5CF6;
                            --card-color-dark: #7C3AED;
                        }

                        .card-teal {
                            --card-color: #14B8A6;
                            --card-color-dark: #0D9488;
                        }

                        .card-blue {
                            --card-color: #3B82F6;
                            --card-color-dark: #2563EB;
                        }

                        .card-orange {
                            --card-color: #F59E0B;
                            --card-color-dark: #D97706;
                        }

                        .card-green {
                            --card-color: #10B981;
                            --card-color-dark: #059669;
                        }

                        .card-indigo {
                            --card-color: #6366F1;
                            --card-color-dark: #4F46E5;
                        }

                        .card-pink {
                            --card-color: #EC4899;
                            --card-color-dark: #DB2777;
                        }

                        .card-red {
                            --card-color: #EF4444;
                            --card-color-dark: #DC2626;
                        }


                        .admin-sidebar[data-collapsed="true"]~.content-wrapper {
                            margin-left: 80px;
                        }

                        @media (max-width: 991.98px) {
                            .content-wrapper {
                                margin-left: 0 !important;
                            }
                        }

                        @media (max-width: 991.98px) {
                            .dashboard-main {
                                padding: 1.5rem 1rem;
                            }

                            .cards-grid {
                                grid-template-columns: 1fr;
                            }
                        }
                    </style>
                </head>

                <body>
                    <div class="dashboard-layout d-flex">
                        <%@ include file="sidebar-admin.jsp" %>
                            <div class="content-wrapper">
                                <%@ include file="topbar-admin.jsp" %>
                                    <main class="dashboard-main">
                                        <div class="page-header">
                                            <h1 class="page-title">Panel de Administrador</h1>
                                            <p class="page-subtitle">Que deseas realizar?</p>
                                        </div>

                                        <div class="cards-grid">
                                            <div class="admin-card card-purple">
                                                <div class="card-icon"><i class="bi bi-shield-check"></i></div>
                                                <h3 class="card-title">Administradores</h3>
                                                <p class="card-description">Crea nuevos administradores con permisos
                                                    elevados.</p>
                                                <a href="${pageContext.request.contextPath}/admin/administradores.jsp"
                                                    class="card-button">
                                                    <span>Gestionar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-teal">
                                                <div class="card-icon"><i class="bi bi-person-workspace"></i></div>
                                                <h3 class="card-title">Docentes</h3>
                                                <p class="card-description">Agrega nuevos docentes al sistema.</p>
                                                <a href="${pageContext.request.contextPath}/admin/docentes.jsp"
                                                    class="card-button">
                                                    <span>Gestionar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-blue">
                                                <div class="card-icon"><i class="bi bi-mortarboard"></i></div>
                                                <h3 class="card-title">Estudiantes Aceptados</h3>
                                                <p class="card-description">Visualice y asigne grupos.</p>
                                                <a href="${pageContext.request.contextPath}/admin/estudiantes.jsp"
                                                    class="card-button">
                                                    <span>Ver estudiantes</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-orange">
                                                <div class="card-icon"><i class="bi bi-clipboard-check"></i></div>
                                                <h3 class="card-title">Preinscripciones</h3>
                                                <p class="card-description">Consulta la lista de estudiantes
                                                    preinscritos.</p>
                                                <a href="${pageContext.request.contextPath}/ListarPreinscripciones"
                                                    class="card-button">
                                                    <span>Ver solicitudes</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-green">
                                                <div class="card-icon"><i class="bi bi-journal-text"></i></div>
                                                <h3 class="card-title">Secciones</h3>
                                                <p class="card-description">Crea y gestiona secciones A/B.</p>
                                                <a href="${pageContext.request.contextPath}/admin/ListarSecciones"
                                                    class="card-button">
                                                    <span>Gestionar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-indigo">
                                                <div class="card-icon"><i class="bi bi-person-plus"></i></div>
                                                <h3 class="card-title">Asignar Docentes a Cursos</h3>
                                                <p class="card-description">Relaciona docentes con los cursos
                                                    precargados.</p>
                                                <a href="${pageContext.request.contextPath}/admin/asignar-docentes.jsp"
                                                    class="card-button">
                                                    <span>Asignar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-pink">
                                                <div class="card-icon"><i class="bi bi-calendar-week"></i></div>
                                                <h3 class="card-title">Asignar Horarios</h3>
                                                <p class="card-description">Define dias y horas para cada curso-docente.
                                                </p>
                                                <a href="${pageContext.request.contextPath}/admin/horarios.jsp"
                                                    class="card-button">
                                                    <span>Configurar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-red">
                                                <div class="card-icon"><i class="bi bi-cash-stack"></i></div>
                                                <h3 class="card-title">Control de Deudores</h3>
                                                <p class="card-description">Gestiona pagos pendientes de cuotas - Verano
                                                    2026.</p>
                                                <a href="${pageContext.request.contextPath}/admin/ListarDeudores"
                                                    class="card-button">
                                                    <span>Ver deudores</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </main>
                            </div>
                    </div>
                    <script
                        src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>