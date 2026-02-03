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
                    <link rel="icon" type="image/png" href="../img/LOGOS.png" />
                    <title>Panel Administrador - NivelA1</title>
                    <link rel="stylesheet"
                        href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                    <link
                        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">

                    <style>
                        :root {
                            --admin-primary: #000d83;
                            --admin-secondary: #3ec4ff;
                            --color-bg: #F1F4FD;
                            --color-surface: #FFFFFF;
                        }

                        body {
                            font-family: 'Poppins', sans-serif;
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
                            margin-bottom: 2.5rem;
                        }

                        .page-title {
                            font-size: 2.25rem;
                            font-weight: 800;
                            background: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                            margin: 0 0 0.5rem 0;
                            letter-spacing: -0.5px;
                        }

                        .page-subtitle {
                            color: #6B7280;
                            margin: 0;
                            font-size: 1.05rem;
                            font-weight: 400;
                        }

                        .cards-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                            gap: 1.75rem;
                        }

                        .admin-card {
                            background: white;
                            border-radius: 20px;
                            padding: 2rem;
                            border: 1px solid rgba(0, 13, 131, 0.08);
                            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
                            position: relative;
                            overflow: hidden;
                        }

                        .admin-card::before {
                            content: '';
                            position: absolute;
                            top: 0;
                            left: 0;
                            right: 0;
                            height: 5px;
                            background: var(--card-gradient);
                        }

                        .admin-card::after {
                            content: '';
                            position: absolute;
                            bottom: 0;
                            right: 0;
                            width: 120px;
                            height: 120px;
                            background: var(--card-gradient);
                            opacity: 0.05;
                            border-radius: 50%;
                            transform: translate(40%, 40%);
                            transition: all 0.4s ease;
                        }

                        .admin-card:hover {
                            transform: translateY(-6px);
                            box-shadow: 0 20px 40px rgba(0, 13, 131, 0.12);
                            border-color: rgba(0, 13, 131, 0.15);
                        }

                        .admin-card:hover::after {
                            transform: translate(30%, 30%) scale(1.2);
                            opacity: 0.08;
                        }

                        .card-icon {
                            width: 64px;
                            height: 64px;
                            border-radius: 16px;
                            background: var(--card-gradient);
                            color: white;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 1.85rem;
                            margin-bottom: 1.25rem;
                            box-shadow: 0 8px 16px var(--card-shadow);
                            position: relative;
                            z-index: 1;
                        }

                        .card-title {
                            font-size: 1.3rem;
                            font-weight: 700;
                            color: #1A1A1A;
                            margin: 0 0 0.75rem 0;
                            position: relative;
                            z-index: 1;
                        }

                        .card-description {
                            color: #6B7280;
                            font-size: 0.95rem;
                            margin: 0 0 1.75rem 0;
                            line-height: 1.6;
                            position: relative;
                            z-index: 1;
                        }

                        .card-button {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.875rem 1.75rem;
                            background: var(--card-gradient);
                            color: white;
                            border: none;
                            border-radius: 12px;
                            font-weight: 600;
                            text-decoration: none;
                            transition: all 0.3s ease;
                            position: relative;
                            z-index: 1;
                            box-shadow: 0 4px 12px var(--card-shadow);
                            font-size: 0.95rem;
                        }

                        .card-button:hover {
                            color: white;
                            transform: translateY(-2px);
                            box-shadow: 0 8px 20px var(--card-shadow);
                        }

                        .card-button i {
                            font-size: 1.1rem;
                            transition: transform 0.3s ease;
                        }

                        .card-button:hover i {
                            transform: translateX(4px);
                        }

                        /* Card Color Variants */
                        .card-purple {
                            --card-gradient: linear-gradient(135deg, #8B5CF6, #7C3AED);
                            --card-shadow: rgba(139, 92, 246, 0.3);
                        }

                        .card-teal {
                            --card-gradient: linear-gradient(135deg, #14B8A6, #0D9488);
                            --card-shadow: rgba(20, 184, 166, 0.3);
                        }

                        .card-blue {
                            --card-gradient: linear-gradient(135deg, #000d83, #3ec4ff);
                            --card-shadow: rgba(0, 13, 131, 0.3);
                        }

                        .card-orange {
                            --card-gradient: linear-gradient(135deg, #F59E0B, #D97706);
                            --card-shadow: rgba(245, 158, 11, 0.3);
                        }

                        .card-green {
                            --card-gradient: linear-gradient(135deg, #10B981, #059669);
                            --card-shadow: rgba(16, 185, 129, 0.3);
                        }

                        .card-indigo {
                            --card-gradient: linear-gradient(135deg, #6366F1, #4F46E5);
                            --card-shadow: rgba(99, 102, 241, 0.3);
                        }

                        .card-pink {
                            --card-gradient: linear-gradient(135deg, #EC4899, #DB2777);
                            --card-shadow: rgba(236, 72, 153, 0.3);
                        }

                        .card-red {
                            --card-gradient: linear-gradient(135deg, #ff5d5d, #EF4444);
                            --card-shadow: rgba(255, 93, 93, 0.3);
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

                            .page-title {
                                font-size: 1.75rem;
                            }

                            .cards-grid {
                                grid-template-columns: 1fr;
                                gap: 1.25rem;
                            }
                        }

                        @media (max-width: 576px) {
                            .page-title {
                                font-size: 1.5rem;
                            }

                            .admin-card {
                                padding: 1.5rem;
                            }

                            .card-icon {
                                width: 56px;
                                height: 56px;
                                font-size: 1.6rem;
                            }

                            .card-title {
                                font-size: 1.15rem;
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
                                            <p class="page-subtitle">¿Qué deseas realizar?</p>
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
                                                <div class="card-icon"><i class="bi bi-person-plus-fill"></i></div>
                                                <h3 class="card-title">Registrar Estudiantes</h3>
                                                <p class="card-description">Agrega estudiantes a las secciones del
                                                    sistema.</p>
                                                <a href="${pageContext.request.contextPath}/admin/registrar-estudiante.jsp"
                                                    class="card-button">
                                                    <span>Registrar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-blue">
                                                <div class="card-icon"><i class="bi bi-mortarboard"></i></div>
                                                <h3 class="card-title">Estudiantes Aceptados</h3>
                                                <p class="card-description">Visualiza y asigna grupos.</p>
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
                                                <p class="card-description">Define días y horas para cada curso-docente.
                                                </p>
                                                <a href="${pageContext.request.contextPath}/admin/horarios.jsp"
                                                    class="card-button">
                                                    <span>Configurar</span><i class="bi bi-arrow-right"></i>
                                                </a>
                                            </div>

                                            <div class="admin-card card-indigo">
                                                <div class="card-icon"><i class="bi bi-calendar-check"></i></div>
                                                <h3 class="card-title">Asistencia</h3>
                                                <p class="card-description">Toma asistencia diaria de los estudiantes.
                                                </p>
                                                <a href="${pageContext.request.contextPath}/admin/asistencia.jsp"
                                                    class="card-button">
                                                    <span>Tomar Asistencia</span><i class="bi bi-arrow-right"></i>
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