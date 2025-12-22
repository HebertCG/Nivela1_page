<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <% String sidebarActive=(String) request.getAttribute("sidebarActive"); if (sidebarActive==null) sidebarActive="" ;
        %>
        <style>
            :root {
                --admin-primary: #1A1A2E;
                --admin-secondary: #16213E;
                --admin-accent: #8B5CF6;
                --sidebar-width: 280px;
                --sidebar-collapsed: 80px;
            }

            .admin-sidebar {
                position: fixed;
                top: 0;
                left: 0;
                width: var(--sidebar-width);
                height: 100vh;
                background: linear-gradient(180deg, var(--admin-primary) 0%, var(--admin-secondary) 100%);
                color: white;
                display: flex;
                flex-direction: column;
                transition: width 0.3s ease;
                z-index: 1000;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }

            .admin-sidebar[data-collapsed="true"] {
                width: var(--sidebar-collapsed);
            }

            .sidebar-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 1.5rem 1rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-toggle {
                background: var(--admin-accent);
                border: none;
                border-radius: 12px;
                width: 48px;
                height: 48px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
                color: white;
                font-size: 1.5rem;
            }

            .sidebar-toggle:hover {
                background: #7C3AED;
                transform: scale(1.05);
            }

            .sidebar-logo-container {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                transition: opacity 0.3s ease;
            }

            .admin-sidebar[data-collapsed="true"] .sidebar-logo-container {
                opacity: 0;
                pointer-events: none;
            }

            .sidebar-logo-icon {
                width: 40px;
                height: 40px;
                background: var(--admin-accent);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 1.2rem;
            }

            .sidebar-logo-text {
                display: flex;
                flex-direction: column;
            }

            .sidebar-logo-nivel {
                font-size: 0.75rem;
                opacity: 0.8;
                letter-spacing: 1px;
            }

            .sidebar-logo-nivel-big {
                font-size: 1.5rem;
                font-weight: bold;
                line-height: 1;
            }

            .sidebar-logo-academia {
                font-size: 0.85rem;
                opacity: 0.9;
            }

            .sidebar-nav {
                flex: 1;
                padding: 1rem 0;
                overflow-y: auto;
            }

            .nav-link {
                position: relative;
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem 1.5rem;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                margin: 0.25rem 1rem;
                border-radius: 12px;
            }

            .nav-link:hover {
                background: rgba(139, 92, 246, 0.1);
                color: white;
            }

            .nav-link.active {
                background: rgba(139, 92, 246, 0.1);
                color: white;
            }

            .nav-link.active .nav-indicator {
                opacity: 1;
            }

            .nav-indicator {
                position: absolute;
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                width: 4px;
                height: 32px;
                background: var(--admin-accent);
                border-radius: 0 4px 4px 0;
                opacity: 0;
                transition: opacity 0.3s ease;
            }

            .nav-link i {
                font-size: 1.4rem;
                min-width: 24px;
                text-align: center;
            }

            .nav-text {
                font-size: 1rem;
                font-weight: 500;
                white-space: nowrap;
            }

            .admin-sidebar[data-collapsed="true"] .nav-text {
                opacity: 0;
                pointer-events: none;
            }

            .sidebar-footer {
                padding: 1rem;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
            }

            .logout-link {
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem 1.5rem;
                color: rgba(255, 255, 255, 0.8);
                text-decoration: none;
                transition: all 0.3s ease;
                border-radius: 12px;
            }

            .logout-link:hover {
                background: rgba(255, 59, 48, 0.2);
                color: #ff3b30;
            }

            .logout-link i {
                font-size: 1.4rem;
                min-width: 24px;
            }

            @media (max-width: 991.98px) {
                .admin-sidebar {
                    width: 0;
                    overflow: hidden;
                }

                .admin-sidebar.is-open {
                    width: var(--sidebar-width);
                }
            }
        </style>
        <aside class="admin-sidebar" id="adminSidebar" data-collapsed="false">
            <div class="sidebar-header">
                <button class="sidebar-toggle" id="adminSidebarToggle" type="button">
                    <i class="bi bi-list"></i>
                </button>
                <div class="sidebar-logo-container">
                    <div class="sidebar-logo-icon">A</div>
                    <div class="sidebar-logo-text">
                        <span class="sidebar-logo-nivel">NIVEL</span>
                        <span class="sidebar-logo-nivel-big">A1</span>
                        <span class="sidebar-logo-academia">ACADEMIA</span>
                    </div>
                </div>
            </div>
            <nav class="sidebar-nav">
                <a class="nav-link <%= " dashboard".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/panel.jsp">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-grid-1x2-fill"></i>
                    <span class="nav-text">Dashboard</span>
                </a>
                <a class="nav-link <%= " administradores".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/administradores.jsp">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-shield-check"></i>
                    <span class="nav-text">Administradores</span>
                </a>
                <a class="nav-link <%= " docentes".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/docentes.jsp">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-person-workspace"></i>
                    <span class="nav-text">Docentes</span>
                </a>
                <a class="nav-link <%= " estudiantes".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/estudiantes.jsp">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-mortarboard"></i>
                    <span class="nav-text">Estudiantes</span>
                </a>
                <a class="nav-link <%= " preinscripciones".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/ListarPreinscripciones">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-clipboard-check"></i>
                    <span class="nav-text">Inscripciones</span>
                </a>
                <a class="nav-link <%= " secciones".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/ListarSecciones">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-journal-text"></i>
                    <span class="nav-text">Secciones</span>
                </a>
                <a class="nav-link <%= " horarios".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                    href="${pageContext.request.contextPath}/admin/horarios.jsp">
                    <span class="nav-indicator"></span>
                    <i class="bi bi-calendar-week"></i>
                    <span class="nav-text">Horarios</span>
                </a>
            </nav>
            <div class="sidebar-footer">
                <a class="logout-link" href="${pageContext.request.contextPath}/salir">
                    <i class="bi bi-box-arrow-right"></i>
                    <span class="nav-text">Cerrar Sesion</span>
                </a>
            </div>
        </aside>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var sidebar = document.getElementById('adminSidebar');
                if (!sidebar) return;
                var toggle = document.getElementById('adminSidebarToggle');
                var externalToggle = document.getElementById('sidebarToggle');
                if (toggle) {
                    toggle.addEventListener('click', function () {
                        var isCollapsed = sidebar.getAttribute('data-collapsed') === 'true';
                        sidebar.setAttribute('data-collapsed', String(!isCollapsed));
                    });
                }
                if (externalToggle) {
                    externalToggle.addEventListener('click', function () {
                        sidebar.classList.toggle('is-open');
                    });
                }
            });
        </script>