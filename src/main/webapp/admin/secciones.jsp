<%@ page import="java.util.List" %>
    <%@ page import="modelo.Seccion" %>
        <%@ page import="modelo.Grupo" %>
            <%@ page import="modelo.Usuario" %>
                <%@ page session="true" %>
                    <% List<Grupo> grupos = (List<Grupo>) request.getAttribute("grupos");
                            List<Seccion> secciones = (List<Seccion>) request.getAttribute("secciones");
                                    List<Usuario> estudiantesSinAsignar = (List<Usuario>)
                                            request.getAttribute("estudiantesSinAsignar");
                                            Integer idGrupoActual = (Integer) request.getAttribute("idGrupoActual");
                                            String gradoActual = (String) request.getAttribute("gradoActual");
                                            Integer totalSecciones = (Integer) request.getAttribute("totalSecciones");
                                            Integer totalAsignados = (Integer) request.getAttribute("totalAsignados");
                                            Integer totalSinAsignar = (Integer) request.getAttribute("totalSinAsignar");
                                            Integer capacidadTotal = (Integer) request.getAttribute("capacidadTotal");
                                            request.setAttribute("sidebarActive", "secciones");
                                            %>
                                            <!DOCTYPE html>
                                            <html lang="es">

                                            <head>
                                                <meta charset="UTF-8">
                                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                                <title>Gestión de Secciones</title>
                                                <link
                                                    href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css"
                                                    rel="stylesheet">
                                                <link rel="stylesheet"
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                                                <style>
                                                    :root {
                                                        --admin-accent: #8B5CF6;
                                                        --color-bg: #F3F4F6;
                                                        --color-surface: #FFFFFF;
                                                        --color-border: #E5E7EB;
                                                        --color-success: #10B981;
                                                        --color-danger: #EF4444;
                                                        --color-warning: #F59E0B;
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
                                                        display: flex;
                                                        align-items: center;
                                                        gap: 0.75rem;
                                                    }

                                                    .page-title i {
                                                        color: var(--admin-accent);
                                                    }

                                                    .stats-grid {
                                                        display: grid;
                                                        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                                                        gap: 1.5rem;
                                                        margin-bottom: 2rem;
                                                    }

                                                    .stat-card {
                                                        background: white;
                                                        border-radius: 16px;
                                                        padding: 1.5rem;
                                                        border: 1px solid var(--color-border);
                                                        transition: all 0.3s ease;
                                                        position: relative;
                                                        overflow: hidden;
                                                    }

                                                    .stat-card::before {
                                                        content: '';
                                                        position: absolute;
                                                        top: 0;
                                                        left: 0;
                                                        right: 0;
                                                        height: 4px;
                                                        background: var(--card-color);
                                                    }

                                                    .stat-card:hover {
                                                        transform: translateY(-4px);
                                                        box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
                                                    }

                                                    .stat-icon {
                                                        width: 48px;
                                                        height: 48px;
                                                        border-radius: 12px;
                                                        background: var(--icon-bg);
                                                        color: var(--icon-color);
                                                        display: flex;
                                                        align-items: center;
                                                        justify-content: center;
                                                        font-size: 1.5rem;
                                                        margin-bottom: 1rem;
                                                    }

                                                    .stat-label {
                                                        font-size: 0.875rem;
                                                        color: #6B7280;
                                                        margin-bottom: 0.5rem;
                                                        font-weight: 500;
                                                    }

                                                    .stat-value {
                                                        font-size: 2rem;
                                                        font-weight: 700;
                                                        color: #1A1A1A;
                                                    }

                                                    .filter-section {
                                                        background: white;
                                                        border-radius: 16px;
                                                        padding: 1.5rem;
                                                        margin-bottom: 2rem;
                                                        border: 1px solid var(--color-border);
                                                    }

                                                    .filter-section label {
                                                        font-weight: 600;
                                                        color: #1A1A1A;
                                                        margin-bottom: 0.5rem;
                                                    }

                                                    .filter-section select {
                                                        border-radius: 12px;
                                                        border: 1px solid var(--color-border);
                                                        padding: 0.75rem 1rem;
                                                        font-size: 1rem;
                                                    }

                                                    .nav-tabs {
                                                        border: none;
                                                        gap: 0.5rem;
                                                        margin-bottom: 2rem;
                                                    }

                                                    .nav-tabs .nav-link {
                                                        border: 1px solid var(--color-border);
                                                        border-radius: 12px;
                                                        padding: 0.75rem 1.5rem;
                                                        color: #6B7280;
                                                        font-weight: 500;
                                                        transition: all 0.3s ease;
                                                    }

                                                    .nav-tabs .nav-link:hover {
                                                        background: #F9FAFB;
                                                        color: #1A1A1A;
                                                    }

                                                    .nav-tabs .nav-link.active {
                                                        background: var(--admin-accent);
                                                        color: white;
                                                        border-color: var(--admin-accent);
                                                    }

                                                    .section-header {
                                                        display: flex;
                                                        justify-content: space-between;
                                                        align-items: center;
                                                        margin-bottom: 1.5rem;
                                                    }

                                                    .section-title {
                                                        font-size: 1.5rem;
                                                        font-weight: 700;
                                                        color: #1A1A1A;
                                                        margin: 0;
                                                    }

                                                    .seccion-card {
                                                        background: white;
                                                        border-radius: 16px;
                                                        padding: 1.5rem;
                                                        margin-bottom: 1rem;
                                                        border: 1px solid var(--color-border);
                                                        transition: all 0.3s ease;
                                                    }

                                                    .seccion-card:hover {
                                                        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                                                    }

                                                    .seccion-card.disponible {
                                                        border-left: 4px solid var(--color-success);
                                                    }

                                                    .seccion-card.llena {
                                                        border-left: 4px solid var(--color-danger);
                                                    }

                                                    .seccion-header-inner {
                                                        display: flex;
                                                        justify-content: space-between;
                                                        align-items: start;
                                                        margin-bottom: 1rem;
                                                    }

                                                    .seccion-name {
                                                        font-size: 1.25rem;
                                                        font-weight: 700;
                                                        color: #1A1A1A;
                                                        margin: 0 0 0.25rem 0;
                                                    }

                                                    .seccion-capacity {
                                                        font-size: 0.875rem;
                                                        color: #6B7280;
                                                    }

                                                    .progress {
                                                        height: 8px;
                                                        border-radius: 4px;
                                                        background: #F3F4F6;
                                                    }

                                                    .progress-bar {
                                                        border-radius: 4px;
                                                    }

                                                    .estudiante-card {
                                                        background: white;
                                                        border: 1px solid var(--color-border);
                                                        border-radius: 12px;
                                                        padding: 1rem;
                                                        margin-bottom: 0.75rem;
                                                        transition: all 0.3s ease;
                                                    }

                                                    .estudiante-card:hover {
                                                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
                                                        border-color: var(--admin-accent);
                                                    }

                                                    .estudiante-info {
                                                        flex: 1;
                                                    }

                                                    .estudiante-name {
                                                        font-weight: 600;
                                                        color: #1A1A1A;
                                                        margin-bottom: 0.25rem;
                                                    }

                                                    .estudiante-details {
                                                        font-size: 0.875rem;
                                                        color: #6B7280;
                                                    }

                                                    .btn-assign {
                                                        width: 40px;
                                                        height: 40px;
                                                        border-radius: 10px;
                                                        background: var(--admin-accent);
                                                        border: none;
                                                        color: white;
                                                        display: flex;
                                                        align-items: center;
                                                        justify-content: center;
                                                        transition: all 0.3s ease;
                                                    }

                                                    .btn-assign:hover {
                                                        background: #7C3AED;
                                                        transform: scale(1.05);
                                                    }

                                                    .empty-state {
                                                        text-align: center;
                                                        padding: 3rem 2rem;
                                                        background: white;
                                                        border-radius: 16px;
                                                        border: 2px dashed var(--color-border);
                                                    }

                                                    .empty-state i {
                                                        font-size: 3rem;
                                                        color: #D1D5DB;
                                                        margin-bottom: 1rem;
                                                    }

                                                    .empty-state h5 {
                                                        color: #6B7280;
                                                        font-weight: 600;
                                                    }

                                                    .modal-content {
                                                        border-radius: 16px;
                                                        border: none;
                                                        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                                                    }

                                                    .modal-header {
                                                        border-bottom: 1px solid var(--color-border);
                                                        padding: 1.5rem;
                                                    }

                                                    .modal-title {
                                                        font-weight: 700;
                                                        color: #1A1A1A;
                                                    }

                                                    .modal-body {
                                                        padding: 1.5rem;
                                                    }

                                                    .modal-footer {
                                                        border-top: 1px solid var(--color-border);
                                                        padding: 1.5rem;
                                                    }

                                                    .form-label {
                                                        font-weight: 600;
                                                        color: #1A1A1A;
                                                        margin-bottom: 0.5rem;
                                                    }

                                                    .form-control,
                                                    .form-select {
                                                        border-radius: 12px;
                                                        border: 1px solid var(--color-border);
                                                        padding: 0.75rem 1rem;
                                                    }

                                                    .form-control:focus,
                                                    .form-select:focus {
                                                        border-color: var(--admin-accent);
                                                        box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
                                                    }

                                                    .btn {
                                                        border-radius: 12px;
                                                        padding: 0.75rem 1.5rem;
                                                        font-weight: 600;
                                                        transition: all 0.3s ease;
                                                    }

                                                    .btn-primary {
                                                        background: var(--admin-accent);
                                                        border: none;
                                                    }

                                                    .btn-primary:hover {
                                                        background: #7C3AED;
                                                        transform: translateY(-2px);
                                                        box-shadow: 0 8px 16px rgba(139, 92, 246, 0.3);
                                                    }

                                                    .badge {
                                                        padding: 0.5rem 1rem;
                                                        border-radius: 8px;
                                                        font-weight: 600;
                                                        font-size: 0.875rem;
                                                    }
                                                </style>
                                            </head>

                                            <body>
                                                <div class="dashboard-layout">
                                                    <%@ include file="sidebar-admin.jsp" %>
                                                        <div class="content-wrapper">
                                                            <%@ include file="topbar-admin.jsp" %>
                                                                <div class="dashboard-main">
                                                                    <div class="page-header">
                                                                        <h1 class="page-title"><i
                                                                                class="bi bi-building"></i>Gestión de
                                                                            Secciones</h1>
                                                                    </div>

                                                                    <!-- Estadísticas -->
                                                                    <div class="stats-grid">
                                                                        <div class="stat-card"
                                                                            style="--card-color: var(--admin-accent); --icon-bg: rgba(139, 92, 246, 0.1); --icon-color: var(--admin-accent);">
                                                                            <div class="stat-icon"><i
                                                                                    class="bi bi-door-open"></i></div>
                                                                            <div class="stat-label">Total Secciones
                                                                            </div>
                                                                            <div class="stat-value">
                                                                                <%= totalSecciones %>
                                                                            </div>
                                                                        </div>
                                                                        <div class="stat-card"
                                                                            style="--card-color: var(--color-success); --icon-bg: rgba(16, 185, 129, 0.1); --icon-color: var(--color-success);">
                                                                            <div class="stat-icon"><i
                                                                                    class="bi bi-people-fill"></i></div>
                                                                            <div class="stat-label">Estudiantes
                                                                                Asignados</div>
                                                                            <div class="stat-value">
                                                                                <%= totalAsignados %>
                                                                            </div>
                                                                        </div>
                                                                        <div class="stat-card"
                                                                            style="--card-color: var(--color-danger); --icon-bg: rgba(239, 68, 68, 0.1); --icon-color: var(--color-danger);">
                                                                            <div class="stat-icon"><i
                                                                                    class="bi bi-person-x"></i></div>
                                                                            <div class="stat-label">Sin Asignar</div>
                                                                            <div class="stat-value">
                                                                                <%= totalSinAsignar %>
                                                                            </div>
                                                                        </div>
                                                                        <div class="stat-card"
                                                                            style="--card-color: #6366F1; --icon-bg: rgba(99, 102, 241, 0.1); --icon-color: #6366F1;">
                                                                            <div class="stat-icon"><i
                                                                                    class="bi bi-grid-3x3"></i></div>
                                                                            <div class="stat-label">Capacidad Total
                                                                            </div>
                                                                            <div class="stat-value">
                                                                                <%= capacidadTotal %>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <!-- Filtro de Grado -->
                                                                    <div class="filter-section">
                                                                        <label for="gradoSelect"><i
                                                                                class="bi bi-funnel me-2"></i>Filtrar
                                                                            por Grado</label>
                                                                        <select id="gradoSelect" class="form-select"
                                                                            onchange="cambiarGrado(this)">
                                                                            <% if (grupos !=null) { for (Grupo g :
                                                                                grupos) { %>
                                                                                <option value="<%= g.getCarrera() %>"
                                                                                    data-grupo-id="<%= g.getId() %>"
                                                                                    <%=g.getCarrera().equals(gradoActual)
                                                                                    ? "selected" : "" %>>
                                                                                    <%= g.getCarrera() %>
                                                                                </option>
                                                                                <% } } %>
                                                                        </select>
                                                                    </div>

                                                                    <!-- Tabs de Grupos -->
                                                                    <ul class="nav nav-tabs">
                                                                        <% if (grupos !=null) { for (Grupo grupo :
                                                                            grupos) { String
                                                                            activeClass=(grupo.getId()==idGrupoActual)
                                                                            ? "active" : "" ; %>
                                                                            <li class="nav-item">
                                                                                <a class="nav-link <%= activeClass %>"
                                                                                    href="?idGrupo=<%= grupo.getId() %>&grado=<%= gradoActual %>">
                                                                                    <%= grupo.getNombre() %> · <%=
                                                                                            grupo.getCarrera() %>
                                                                                </a>
                                                                            </li>
                                                                            <% } } %>
                                                                    </ul>

                                                                    <div class="row">
                                                                        <!-- Columna de Secciones -->
                                                                        <div class="col-lg-7">
                                                                            <div class="section-header">
                                                                                <h2 class="section-title">Secciones
                                                                                    Creadas</h2>
                                                                                <button class="btn btn-primary"
                                                                                    data-bs-toggle="modal"
                                                                                    data-bs-target="#modalCrearSeccion">
                                                                                    <i
                                                                                        class="bi bi-plus-circle me-2"></i>Nueva
                                                                                    Sección
                                                                                </button>
                                                                            </div>

                                                                            <% if (secciones !=null &&
                                                                                !secciones.isEmpty()) { for (Seccion s :
                                                                                secciones) { String
                                                                                claseCard=s.estaLlena() ? "llena"
                                                                                : "disponible" ; double
                                                                                porcentaje=s.getPorcentajeOcupacion();
                                                                                %>
                                                                                <div
                                                                                    class="seccion-card <%= claseCard %>">
                                                                                    <div class="seccion-header-inner">
                                                                                        <div>
                                                                                            <h3 class="seccion-name">
                                                                                                <%= s.getNombre() %>
                                                                                            </h3>
                                                                                            <p class="seccion-capacity">
                                                                                                <i
                                                                                                    class="bi bi-people me-1"></i>
                                                                                                <%= s.getAlumnosActuales()
                                                                                                    %> / 45 estudiantes
                                                                                            </p>
                                                                                        </div>
                                                                                        <% if (s.estaLlena()) { %>
                                                                                            <span
                                                                                                class="badge bg-danger"><i
                                                                                                    class="bi bi-exclamation-circle me-1"></i>Llena</span>
                                                                                            <% } else { %>
                                                                                                <span
                                                                                                    class="badge bg-success">
                                                                                                    <%= s.getCapacidadDisponible()
                                                                                                        %> disponibles
                                                                                                </span>
                                                                                                <% } %>
                                                                                    </div>
                                                                                    <div class="progress">
                                                                                        <div class="progress-bar <%= s.estaLlena() ? "
                                                                                            bg-danger" : "bg-success" %>
                                                                                            " style="width: <%=
                                                                                                porcentaje %>%"></div>
                                                                                    </div>
                                                                                </div>
                                                                                <% } } else { %>
                                                                                    <div class="empty-state">
                                                                                        <i class="bi bi-inbox"></i>
                                                                                        <h5>No hay secciones creadas
                                                                                        </h5>
                                                                                        <p class="text-muted">Crea la
                                                                                            primera sección para este
                                                                                            grupo</p>
                                                                                    </div>
                                                                                    <% } %>
                                                                        </div>

                                                                        <!-- Columna de Estudiantes Sin Asignar -->
                                                                        <div class="col-lg-5">
                                                                            <div class="section-header">
                                                                                <h2 class="section-title">Sin Asignar
                                                                                    <span class="badge bg-danger ms-2">
                                                                                        <%= totalSinAsignar %>
                                                                                    </span>
                                                                                </h2>
                                                                            </div>

                                                                            <div
                                                                                style="max-height: 600px; overflow-y: auto;">
                                                                                <% if (estudiantesSinAsignar !=null &&
                                                                                    !estudiantesSinAsignar.isEmpty()) {
                                                                                    for (Usuario e :
                                                                                    estudiantesSinAsignar) { %>
                                                                                    <div class="estudiante-card">
                                                                                        <div
                                                                                            class="d-flex justify-content-between align-items-center">
                                                                                            <div
                                                                                                class="estudiante-info">
                                                                                                <div
                                                                                                    class="estudiante-name">
                                                                                                    <i
                                                                                                        class="bi bi-person-circle me-2"></i>
                                                                                                    <%= e.getNombre() %>
                                                                                                        <%= e.getApellido()
                                                                                                            %>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="estudiante-details">
                                                                                                    <i
                                                                                                        class="bi bi-envelope me-1"></i>
                                                                                                    <%= e.getCorreo() %>
                                                                                                </div>
                                                                                            </div>
                                                                                            <button class="btn-assign"
                                                                                                onclick="abrirModalAsignar(<%= e.getId() %>, '<%= e.getNombre() %> <%= e.getApellido() %>')">
                                                                                                <i
                                                                                                    class="bi bi-arrow-right"></i>
                                                                                            </button>
                                                                                        </div>
                                                                                    </div>
                                                                                    <% } } else { %>
                                                                                        <div class="empty-state">
                                                                                            <i
                                                                                                class="bi bi-check-circle"></i>
                                                                                            <h5>¡Todos asignados!</h5>
                                                                                            <p class="text-muted">Todos
                                                                                                los estudiantes de este
                                                                                                grado han sido asignados
                                                                                                a secciones</p>
                                                                                        </div>
                                                                                        <% } %>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                        </div>
                                                </div>

                                                <!-- Modal Crear Sección -->
                                                <div class="modal fade" id="modalCrearSeccion" tabindex="-1">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title"><i
                                                                        class="bi bi-plus-circle me-2"></i>Crear Nueva
                                                                    Sección</h5>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/CrearSeccion"
                                                                method="post">
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="idGrupo"
                                                                        value="<%= idGrupoActual %>">
                                                                    <input type="hidden" name="grado"
                                                                        value="<%= gradoActual %>">
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Nombre de la
                                                                            Sección</label>
                                                                        <input type="text" class="form-control"
                                                                            name="nombre" required
                                                                            placeholder="Ej: Salón A1, Sección B">
                                                                    </div>
                                                                    <div class="alert alert-info"><i
                                                                            class="bi bi-info-circle me-2"></i><small>Capacidad
                                                                            por defecto: 45 estudiantes</small></div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">Cancelar</button>
                                                                    <button type="submit" class="btn btn-primary"><i
                                                                            class="bi bi-check-circle me-2"></i>Crear
                                                                        Sección</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Modal Asignar Estudiante -->
                                                <div class="modal fade" id="modalAsignar" tabindex="-1">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title"><i
                                                                        class="bi bi-person-plus me-2"></i>Asignar a
                                                                    Sección</h5>
                                                                <button type="button" class="btn-close"
                                                                    data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <form
                                                                action="${pageContext.request.contextPath}/admin/AsignarSeccion"
                                                                method="post">
                                                                <div class="modal-body">
                                                                    <input type="hidden" name="usuarioId"
                                                                        id="estudianteId">
                                                                    <input type="hidden" name="idGrupo"
                                                                        value="<%= idGrupoActual %>">
                                                                    <input type="hidden" name="grado"
                                                                        value="<%= gradoActual %>">

                                                                    <div class="alert alert-primary">
                                                                        <strong>Estudiante:</strong> <span
                                                                            id="nombreEstudiante"></span>
                                                                    </div>

                                                                    <div class="mb-3">
                                                                        <label class="form-label">Selecciona
                                                                            Sección</label>
                                                                        <select class="form-select" name="seccionId"
                                                                            required>
                                                                            <option value="">-- Selecciona una sección
                                                                                --</option>
                                                                            <% if (secciones !=null) { for (Seccion s :
                                                                                secciones) { if (!s.estaLlena()) { %>
                                                                                <option value="<%= s.getId() %>">
                                                                                    <%= s.getNombre() %> (<%=
                                                                                            s.getCapacidadDisponible()
                                                                                            %> disponibles)
                                                                                </option>
                                                                                <% } } } %>
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">Cancelar</button>
                                                                    <button type="submit" class="btn btn-primary"><i
                                                                            class="bi bi-check-circle me-2"></i>Asignar</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <script
                                                    src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                                                <script>
                                                    function cambiarGrado(selectElement) {
                                                        const selectedOption = selectElement.options[selectElement.selectedIndex];
                                                        const idGrupo = selectedOption.getAttribute('data-grupo-id');
                                                        if (idGrupo) {
                                                            window.location.href = '?idGrupo=' + idGrupo;
                                                        }
                                                    }
                                                    function abrirModalAsignar(id, nombre) {
                                                        document.getElementById('estudianteId').value = id;
                                                        document.getElementById('nombreEstudiante').textContent = nombre;
                                                        new bootstrap.Modal(document.getElementById('modalAsignar')).show();
                                                    }
                                                    const urlParams = new URLSearchParams(window.location.search);
                                                    function showToast(message, type) {
                                                        const toast = document.createElement('div');
                                                        toast.className = `alert alert-${type} position-fixed top-0 end-0 m-3`;
                                                        toast.style.zIndex = '9999';
                                                        toast.textContent = message;
                                                        document.body.appendChild(toast);
                                                        setTimeout(() => toast.remove(), 3000);
                                                    }
                                                    if (urlParams.get('success')) showToast('✅ Estudiante asignado correctamente', 'success');
                                                    else if (urlParams.get('created')) showToast('✅ Sección creada correctamente', 'success');
                                                    else if (urlParams.get('error') === 'capacidad') showToast('❌ La sección está llena', 'danger');
                                                    else if (urlParams.get('error') === 'crear') showToast('❌ Error al crear la sección', 'danger');
                                                </script>
                                            </body>

                                            </html>