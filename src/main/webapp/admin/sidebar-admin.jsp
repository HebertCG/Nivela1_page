<%String sidebarActive=(String) request.getAttribute("sidebarActive"); if (sidebarActive==null) sidebarActive="" ; %>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        :root {
            --admin-primary: #000d83;
            --admin-secondary: #3ec4ff;
            --admin-dark: #0d0541;
            --sidebar-width: 280px;
            --sidebar-collapsed: 80px;
        }

        .admin-sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(135deg, var(--admin-primary) 0%, var(--admin-secondary) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            z-index: 1000;
            box-shadow: 4px 0 30px rgba(0, 13, 131, 0.3);
            font-family: 'Poppins', sans-serif;
        }

        .admin-sidebar[data-collapsed="true"] {
            width: var(--sidebar-collapsed);
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.5rem 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
        }

        .sidebar-logo-container {
            display: flex;
            align-items: center;
            gap: 0.875rem;
            transition: opacity 0.3s ease;
            flex: 1;
        }

        .admin-sidebar[data-collapsed="true"] .sidebar-logo-container {
            opacity: 0;
            pointer-events: none;
        }

        .sidebar-logo-img {
            width: 50px;
            height: 50px;
            object-fit: contain;
            filter: drop-shadow(0 2px 8px rgba(255, 255, 255, 0.3));
        }

        .sidebar-logo-text {
            display: flex;
            flex-direction: column;
            line-height: 1.2;
        }

        .sidebar-logo-nivel {
            font-size: 0.75rem;
            opacity: 0.9;
            letter-spacing: 2px;
            font-weight: 500;
        }

        .sidebar-logo-nivel-big {
            font-size: 1.5rem;
            font-weight: 800;
            line-height: 1;
            letter-spacing: -1px;
        }

        .sidebar-logo-academia {
            font-size: 0.8rem;
            opacity: 0.85;
            font-weight: 400;
        }

        .sidebar-toggle {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
            font-size: 1.4rem;
        }

        .sidebar-toggle:hover {
            background: rgba(255, 255, 255, 0.25);
            transform: scale(1.05);
        }

        .sidebar-nav {
            flex: 1;
            padding: 1.5rem 0;
            overflow-y: auto;
            overflow-x: hidden;
        }

        .sidebar-nav::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar-nav::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.2);
            border-radius: 10px;
        }

        .sidebar-nav::-webkit-scrollbar-track {
            background: rgba(0, 0, 0, 0.1);
        }

        .nav-link {
            position: relative;
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            color: rgba(255, 255, 255, 0.75);
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin: 0.25rem 1rem;
            border-radius: 14px;
            font-weight: 500;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 4px;
            background: white;
            border-radius: 0 4px 4px 0;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            color: white;
            transform: translateX(4px);
        }

        .nav-link.active {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            color: white;
            font-weight: 600;
        }

        .nav-link.active::before {
            opacity: 1;
        }

        .nav-link i {
            font-size: 1.35rem;
            min-width: 24px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .nav-text {
            font-size: 0.95rem;
            white-space: nowrap;
            transition: opacity 0.3s ease;
        }

        .admin-sidebar[data-collapsed="true"] .nav-text {
            opacity: 0;
            pointer-events: none;
        }

        .sidebar-footer {
            padding: 1rem;
            border-top: 1px solid rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
        }

        .logout-link {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem 1.5rem;
            color: rgba(255, 255, 255, 0.75);
            text-decoration: none;
            transition: all 0.3s ease;
            border-radius: 14px;
            font-weight: 500;
        }

        .logout-link:hover {
            background: rgba(255, 93, 93, 0.25);
            color: #ff5d5d;
            backdrop-filter: blur(10px);
        }

        .logout-link i {
            font-size: 1.35rem;
            min-width: 24px;
        }

        /* Mobile Responsive */
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
            <div class="sidebar-logo-container">
                <img src="${pageContext.request.contextPath}/img/LOGOSECU.png" alt="NivelA1" class="sidebar-logo-img">
                <div class="sidebar-logo-text">
                    <span class="sidebar-logo-nivel">NIVEL</span>
                    <span class="sidebar-logo-nivel-big">A1</span>
                    <span class="sidebar-logo-academia">ACADEMIA</span>
                </div>
            </div>
            <button class="sidebar-toggle" id="adminSidebarToggle" type="button">
                <i class="bi bi-list"></i>
            </button>
        </div>

        <nav class="sidebar-nav">
            <a class="nav-link <%= " dashboard".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/panel.jsp">
                <i class="bi bi-grid-1x2-fill"></i>
                <span class="nav-text">Dashboard</span>
            </a>

            <a class="nav-link <%= " administradores".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/administradores.jsp">
                <i class="bi bi-shield-check"></i>
                <span class="nav-text">Administradores</span>
            </a>

            <a class="nav-link <%= " docentes".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/docentes.jsp">
                <i class="bi bi-person-workspace"></i>
                <span class="nav-text">Docentes</span>
            </a>

            <a class="nav-link <%= " estudiantes".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/estudiantes.jsp">
                <i class="bi bi-mortarboard"></i>
                <span class="nav-text">Estudiantes</span>
            </a>

            <a class="nav-link <%= " registrar-estudiante".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/registrar-estudiante.jsp">
                <i class="bi bi-person-plus-fill"></i>
                <span class="nav-text">Registrar Estudiante</span>
            </a>

            <a class="nav-link <%= " preinscripciones".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/ListarPreinscripciones">
                <i class="bi bi-clipboard-check"></i>
                <span class="nav-text">Preinscripciones</span>
            </a>

            <a class="nav-link <%= " secciones".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/ListarSecciones">
                <i class="bi bi-journal-text"></i>
                <span class="nav-text">Secciones</span>
            </a>

            <a class="nav-link <%= " asistencia".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/asistencia.jsp">
                <i class="bi bi-calendar-check"></i>
                <span class="nav-text">Asistencia</span>
            </a>

            <a class="nav-link <%= " horarios".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/horarios.jsp">
                <i class="bi bi-calendar-week"></i>
                <span class="nav-text">Horarios</span>
            </a>

            <a class="nav-link <%= " deudores".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/ListarDeudores">
                <i class="bi bi-cash-stack"></i>
                <span class="nav-text">Deudores</span>
            </a>

            <a class="nav-link <%= " diagnostico".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
                href="${pageContext.request.contextPath}/admin/DiagnosticoServlet">
                <i class="bi bi-tools"></i>
                <span class="nav-text">Diagnóstico</span>
            </a>
        </nav>
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