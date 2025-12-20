<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="modelo.Seccion" %>
            <%@ page import="modelo.Grupo" %>
                <%@ page import="modelo.Usuario" %>
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
                                            String[] grados = {"6to Prim - 1ro Sec", "2do Sec - 3ro Sec", "4to Sec - 5to
                                            Sec"};
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
                                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                                                <style>
                                                    body {
                                                        background: #f3f4f6;
                                                        font-family: 'Segoe UI', sans-serif;
                                                    }

                                                    .stats-card {
                                                        background: white;
                                                        border-radius: 12px;
                                                        padding: 1.5rem;
                                                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                                        margin-bottom: 1.5rem;
                                                    }

                                                    .stats-card h6 {
                                                        color: #6b7280;
                                                        font-size: 0.875rem;
                                                        margin-bottom: 0.5rem;
                                                    }

                                                    .stats-card .value {
                                                        font-size: 1.75rem;
                                                        font-weight: 700;
                                                    }

                                                    .seccion-card {
                                                        background: white;
                                                        border-radius: 12px;
                                                        padding: 1.5rem;
                                                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                                        margin-bottom: 1rem;
                                                    }

                                                    .seccion-card.llena {
                                                        border-left: 4px solid #ef4444;
                                                    }

                                                    .seccion-card.disponible {
                                                        border-left: 4px solid #10b981;
                                                    }

                                                    .progress {
                                                        height: 8px;
                                                        border-radius: 4px;
                                                    }

                                                    .estudiante-item {
                                                        background: white;
                                                        border: 1px solid #e5e7eb;
                                                        border-radius: 8px;
                                                        padding: 1rem;
                                                        margin-bottom: 0.5rem;
                                                    }
                                                </style>
                                            </head>

                                            <body>
                                                <div class="container-fluid p-4">
                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                        <h1><i class="bi bi-building me-2"></i>Gestión de Secciones
                                                        </h1>
                                                        <a href="${pageContext.request.contextPath}/admin/panel.jsp"
                                                            class="btn btn-secondary">
                                                            <i class="bi bi-arrow-left me-2"></i>Volver
                                                        </a>
                                                    </div>

                                                    <!-- Selector de Grado -->
                                                    <div class="mb-3">
                                                        <label class="form-label"><strong>Selecciona
                                                                Grado:</strong></label>
                                                        <select class="form-select" onchange="cambiarGrado(this.value)">
                                                            <% for (String g : grados) { %>
                                                                <option value="<%= g %>" <%=g.equals(gradoActual)
                                                                    ? "selected" : "" %>><%= g %>
                                                                </option>
                                                                <% } %>
                                                        </select>
                                                    </div>

                                                    <!-- Tabs de Grupos -->
                                                    <ul class="nav nav-tabs mb-3">
                                                        <% if (grupos !=null) { for (Grupo grupo : grupos) { String
                                                            activeClass=(grupo.getId()==idGrupoActual) ? "active" : "" ;
                                                            %>
                                                            <li class="nav-item">
                                                                <a class="nav-link <%= activeClass %>"
                                                                    href="?idGrupo=<%= grupo.getId() %>&grado=<%= gradoActual %>">
                                                                    <%= grupo.getNombre() %> (<%= grupo.getCarrera() %>)
                                                                </a>
                                                            </li>
                                                            <% } } %>
                                                    </ul>

                                                    <!-- Estadísticas -->
                                                    <div class="row mb-4">
                                                        <div class="col-md-3">
                                                            <div class="stats-card">
                                                                <h6><i class="bi bi-door-open me-2"></i>Total
                                                                    Secciones
                                                                </h6>
                                                                <div class="value" style="color: #8b5cf6;">
                                                                    <%= totalSecciones %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="stats-card">
                                                                <h6><i class="bi bi-people-fill me-2"></i>Estudiantes
                                                                    Asignados</h6>
                                                                <div class="value" style="color: #10b981;">
                                                                    <%= totalAsignados %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="stats-card">
                                                                <h6><i class="bi bi-person-x me-2"></i>Sin Asignar
                                                                </h6>
                                                                <div class="value" style="color: #ef4444;">
                                                                    <%= totalSinAsignar %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="stats-card">
                                                                <h6><i class="bi bi-grid-3x3 me-2"></i>Capacidad
                                                                    Total
                                                                </h6>
                                                                <div class="value">
                                                                    <%= capacidadTotal %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <!-- Columna de Secciones -->
                                                        <div class="col-md-7">
                                                            <div
                                                                class="d-flex justify-content-between align-items-center mb-3">
                                                                <h4>Secciones Creadas</h4>
                                                                <button class="btn btn-primary btn-sm"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#modalCrearSeccion">
                                                                    <i class="bi bi-plus-circle me-1"></i>Nueva
                                                                    Sección
                                                                </button>
                                                            </div>

                                                            <% if (secciones !=null && !secciones.isEmpty()) { for
                                                                (Seccion s : secciones) { String claseCard=s.estaLlena()
                                                                ? "llena" : "disponible" ; double
                                                                porcentaje=s.getPorcentajeOcupacion(); %>
                                                                <div class="seccion-card <%= claseCard %>">
                                                                    <div
                                                                        class="d-flex justify-content-between align-items-start mb-2">
                                                                        <div>
                                                                            <h5 class="mb-1">
                                                                                <%= s.getNombre() %>
                                                                            </h5>
                                                                            <small class="text-muted">Capacidad: <%=
                                                                                    s.getAlumnosActuales() %>
                                                                                    /45</small>
                                                                        </div>
                                                                        <% if (s.estaLlena()) { %>
                                                                            <span class="badge bg-danger">Llena</span>
                                                                            <% } else { %>
                                                                                <span class="badge bg-success">
                                                                                    <%= s.getCapacidadDisponible() %>
                                                                                        disponibles
                                                                                </span>
                                                                                <% } %>
                                                                    </div>
                                                                    <div class="progress">
                                                                        <div class='progress-bar <%= s.estaLlena() ? "bg-danger" : "bg-success" %>'
                                                                            style="width: <%= porcentaje %>%"></div>
                                                                    </div>
                                                                </div>
                                                                <% } } else { %>
                                                                    <div class="alert alert-info">
                                                                        <i class="bi bi-info-circle me-2"></i>No hay
                                                                        secciones creadas para este grupo. Crea la
                                                                        primera sección.
                                                                    </div>
                                                                    <% } %>
                                                        </div>

                                                        <!-- Columna de Estudiantes Sin Asignar -->
                                                        <div class="col-md-5">
                                                            <h4 class="mb-3">Estudiantes Sin Asignar (<%=
                                                                    totalSinAsignar %>)</h4>
                                                            <div style="max-height: 600px; overflow-y: auto;">
                                                                <% if (estudiantesSinAsignar !=null &&
                                                                    !estudiantesSinAsignar.isEmpty()) { for (Usuario e :
                                                                    estudiantesSinAsignar) { %>
                                                                    <div class="estudiante-item">
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-start">
                                                                            <div>
                                                                                <strong>
                                                                                    <%= e.getNombre() %>
                                                                                        <%= e.getApellido() %>
                                                                                </strong><br>
                                                                                <small class="text-muted">Email: <%=
                                                                                        e.getCorreo() %> | Carrera:
                                                                                        <%= e.getCarrera() %>
                                                                                </small>
                                                                            </div>
                                                                            <button class="btn btn-sm btn-primary"
                                                                                onclick="abrirModalAsignar(<%= e.getId() %>, '<%= e.getNombre() %> <%= e.getApellido() %>')">
                                                                                <i class="bi bi-arrow-right"></i>
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                    <% } } else { %>
                                                                        <div class="alert alert-success">
                                                                            <i class="bi bi-check-circle me-2"></i>Todos
                                                                            los estudiantes de este grado han sido
                                                                            asignados.
                                                                        </div>
                                                                        <% } %>
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
                                                                        class="bi bi-plus-circle me-2"></i>Crear
                                                                    Nueva
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
                                                                            placeholder="Ej: Salón A1">
                                                                    </div>
                                                                    <p class="text-muted"><small>Capacidad por
                                                                            defecto:
                                                                            45 alumnos</small></p>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-secondary"
                                                                        data-bs-dismiss="modal">Cancelar</button>
                                                                    <button type="submit" class="btn btn-primary">Crear
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
                                                                    <p>Estudiante: <strong
                                                                            id="nombreEstudiante"></strong></p>
                                                                    <div class="mb-3">
                                                                        <label class="form-label">Selecciona
                                                                            Sección</label>
                                                                        <select class="form-select" name="seccionId"
                                                                            required>
                                                                            <option value="">Selecciona...</option>
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
                                                                    <button type="submit"
                                                                        class="btn btn-primary">Asignar</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>

                                                <script
                                                    src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                                                <script>
                                                    function cambiarGrado(grado) {
                                                        window.location.href = '?idGrupo=<%= idGrupoActual %>&grado=' + encodeURIComponent(grado);
                                                    }

                                                    function abrirModalAsignar(id, nombre) {
                                                        document.getElementById('estudianteId').value = id;
                                                        document.getElementById('nombreEstudiante').textContent = nombre;
                                                        new bootstrap.Modal(document.getElementById('modalAsignar')).show();
                                                    }

                                                    const urlParams = new URLSearchParams(window.location.search);
                                                    if (urlParams.get('success')) {
                                                        alert('✅ Estudiante asignado correctamente');
                                                    } else if (urlParams.get('created')) {
                                                        alert('✅ Sección creada correctamente');
                                                    } else if (urlParams.get('error') === 'capacidad') {
                                                        alert('❌ La sección está llena');
                                                    } else if (urlParams.get('error') === 'crear') {
                                                        alert('❌ Error al crear la sección');
                                                    }
                                                </script>
                                            </body>

                                            </html>