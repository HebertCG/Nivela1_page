<%@page import="DAO.AsistenciaSeccionDAO" %>
    <%@page import="DAO.AsistenciaEstudianteDAO" %>
        <%@page import="modelo.AsistenciaSeccion" %>
            <%@page import="modelo.AsistenciaEstudiante" %>
                <%@page import="java.util.List" %>
                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
                        <% if (session.getAttribute("usuario")==null) { response.sendRedirect("../login.jsp"); return; }
                            AsistenciaSeccionDAO seccionDAO=new AsistenciaSeccionDAO(); List<AsistenciaSeccion>
                            secciones = seccionDAO.listarTodas();
                            %>
                            <!DOCTYPE html>
                            <html lang="es">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Registrar Estudiantes - Academia NivelA1</title>
                                <link rel="icon" type="image/png"
                                    href="${pageContext.request.contextPath}/img/LOGOS.png" />
                                <link rel="stylesheet"
                                    href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                                <link rel="stylesheet"
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                                <script src="https://kit.fontawesome.com/f054896dbd.js"
                                    crossorigin="anonymous"></script>
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

                                <style>
                                    body {
                                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                                        background-color: #f5f5f5;
                                    }

                                    .dashboard-layout {
                                        min-height: 100vh;
                                        background: #F3F4F6;
                                    }

                                    .content-wrapper {
                                        flex: 1;
                                        display: flex;
                                        flex-direction: column;
                                        background: #F3F4F6;
                                        margin-left: 280px;
                                        transition: margin-left 0.3s ease;
                                        min-height: 100vh;
                                    }

                                    .dashboard-main {
                                        flex: 1;
                                        padding: 2rem;
                                    }

                                    .page-header {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        color: white;
                                        padding: 2rem;
                                        border-radius: 10px;
                                        margin-bottom: 2rem;
                                    }

                                    .form-card,
                                    .list-card {
                                        background: white;
                                        padding: 2rem;
                                        border-radius: 10px;
                                        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                        margin-bottom: 2rem;
                                    }

                                    .student-item {
                                        padding: 1rem;
                                        border-bottom: 1px solid #eee;
                                        display: flex;
                                        justify-content: space-between;
                                        align-items: center;
                                    }

                                    .student-item:hover {
                                        background: #f8f9fa;
                                    }

                                    .badge-section {
                                        font-size: 0.85rem;
                                    }

                                    .admin-sidebar[data-collapsed="true"]~.content-wrapper {
                                        margin-left: 80px;
                                    }

                                    @media (max-width: 991.98px) {
                                        .content-wrapper {
                                            margin-left: 0 !important;
                                        }
                                    }
                                </style>
                            </head>

                            <body>

                                <div class="dashboard-layout d-flex">
                                    <jsp:include page="sidebar-admin.jsp" />

                                    <div class="content-wrapper">
                                        <jsp:include page="topbar-admin.jsp" />

                                        <main class="dashboard-main">
                                            <div class="page-header">
                                                <h2><i class="fas fa-user-plus"></i> Registrar Estudiantes</h2>
                                                <p class="mb-0">Agrega estudiantes a las secciones del sistema</p>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-5">
                                                    <div class="form-card">
                                                        <h4 class="mb-4">Nuevo Estudiante</h4>

                                                        <!-- Importante: action="javascript:void(0)" previene envío si JS falla -->
                                                        <form id="studentForm" action="javascript:void(0);">
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Sección: <span
                                                                        class="text-danger">*</span></label>
                                                                <select id="seccionId" name="seccionId"
                                                                    class="form-select" required>
                                                                    <option value="">Seleccione una sección...</option>
                                                                    <% if (secciones !=null) { for (AsistenciaSeccion
                                                                        seccion : secciones) { %>
                                                                        <option value="<%= seccion.getId() %>">
                                                                            <%= seccion.getNombre() %>
                                                                        </option>
                                                                        <% } } %>
                                                                </select>
                                                                <small class="text-muted">Selecciona el grupo al que
                                                                    pertenece el estudiante</small>
                                                            </div>

                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Nombre Completo: <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" id="nombreCompleto"
                                                                    name="nombreCompleto" class="form-control"
                                                                    placeholder="Ej: Juan Pérez García" required>
                                                            </div>

                                                            <input type="hidden" id="codigo" name="codigo" value="">

                                                            <div class="d-grid gap-2">
                                                                <button type="submit" class="btn btn-primary btn-lg">
                                                                    <i class="fas fa-save me-2"></i>Registrar Estudiante
                                                                </button>
                                                                <a href="${pageContext.request.contextPath}/admin/panel.jsp"
                                                                    class="btn btn-outline-secondary">
                                                                    <i class="fas fa-arrow-left me-2"></i>Volver al
                                                                    Panel
                                                                </a>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>

                                                <div class="col-md-7">
                                                    <div class="list-card">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-4">
                                                            <h4 class="mb-0">Estudiantes Registrados</h4>
                                                            <select id="filterSeccion" class="form-select w-auto">
                                                                <option value=""> Todas las secciones</option>
                                                                <% if (secciones !=null) { for (AsistenciaSeccion
                                                                    seccion : secciones) { %>
                                                                    <option value="<%= seccion.getId() %>">
                                                                        <%= seccion.getNombre() %>
                                                                    </option>
                                                                    <% } } %>
                                                            </select>
                                                        </div>

                                                        <div id="studentsList">
                                                            <div class="text-center py-5 text-muted">
                                                                <i class="bi bi-people display-1"></i>
                                                                <p class="mt-3">Selecciona una sección para ver los
                                                                    estudiantes</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </main>
                                    </div>
                                </div>

                                <!-- Modal de Edición -->
                                <div class="modal fade" id="editarEstudianteModal" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header bg-primary text-white">
                                                <h5 class="modal-title"><i class="fas fa-edit me-2"></i>Editar
                                                    Estudiante</h5>
                                                <button type="button" class="btn-close btn-close-white"
                                                    data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form id="editarEstudianteForm">
                                                    <input type="hidden" id="editEstudianteId">
                                                    <div class="mb-3">
                                                        <label class="form-label">Nombre Completo</label>
                                                        <input type="text" class="form-control" id="editNombre"
                                                            required>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Sección</label>
                                                        <select class="form-select" id="editSeccionId" required>
                                                            <% if (secciones !=null) { for (AsistenciaSeccion s :
                                                                secciones) { %>
                                                                <option value="<%= s.getId() %>">
                                                                    <%= s.getNombre() %>
                                                                </option>
                                                                <% } } %>
                                                        </select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Código (Opcional)</label>
                                                        <input type="text" class="form-control" id="editCodigo">
                                                    </div>
                                                </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Cancelar</button>
                                                <button type="button" class="btn btn-primary"
                                                    onclick="guardarEdicion()">Guardar Cambios</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </div>
                                </div>
                                </div>
                                </main>
                                </div>
                                </div>

                                <script
                                    src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                                <script>
                                    console.log('Script cargado v2.0 - con URLSearchParams');

                                    document.addEventListener('DOMContentLoaded', function () {
                                        const form = document.getElementById('studentForm');

                                        form.addEventListener('submit', function (e) {
                                            // Prevenir envío estándar (CRÍTICO)
                                            e.preventDefault();
                                            console.log('Envío de formulario interceptado');

                                            const seccionId = document.getElementById('seccionId').value;
                                            const nombreCompleto = document.getElementById('nombreCompleto').value;
                                            const codigo = document.getElementById('codigo').value;

                                            if (!seccionId || !nombreCompleto) {
                                                alert('Por favor complete todos los campos obligatorios');
                                                return;
                                            }

                                            // Preparar datos para x-www-form-urlencoded
                                            const params = new URLSearchParams();
                                            params.append('seccionId', seccionId);
                                            params.append('nombreCompleto', nombreCompleto);
                                            params.append('codigo', codigo || '');

                                            console.log('Enviando datos:', params.toString());

                                            const btnSubmit = form.querySelector('button[type="submit"]');
                                            const btnOriginalText = btnSubmit.innerHTML;
                                            btnSubmit.disabled = true;
                                            btnSubmit.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Guardando...';

                                            fetch('${pageContext.request.contextPath}/RegistrarEstudianteServlet', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded'
                                                },
                                                body: params.toString()
                                            })
                                                .then(response => response.json())
                                                .then(data => {
                                                    console.log('Respuesta:', data);
                                                    if (data.success) {
                                                        alert('✅ ' + data.message);
                                                        form.reset();
                                                        // Recargar lista si hay filtro activo
                                                        const filterSeccion = document.getElementById('filterSeccion');
                                                        if (filterSeccion && filterSeccion.value) {
                                                            loadStudents(filterSeccion.value);
                                                        } else {
                                                            // Si no hay filtro, seleccionar la sección que acabamos de usar
                                                            filterSeccion.value = seccionId;
                                                            loadStudents(seccionId);
                                                        }
                                                    } else {
                                                        alert('❌ ' + data.message);
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error('Error:', err);
                                                    alert('❌ Error de conexión: ' + err.message);
                                                })
                                                .finally(() => {
                                                    btnSubmit.disabled = false;
                                                    btnSubmit.innerHTML = btnOriginalText;
                                                });
                                        });

                                        // --- Lógica de la lista de estudiantes ---
                                        document.getElementById('filterSeccion').addEventListener('change', function () {
                                            loadStudents(this.value);
                                        });

                                        // Al seleccionar sección en formulario, actualizar filtro
                                        document.getElementById('seccionId').addEventListener('change', function () {
                                            const filter = document.getElementById('filterSeccion');
                                            filter.value = this.value;
                                            loadStudents(this.value);
                                        });
                                    });

                                    function loadStudents(seccionId) {
                                        const listContainer = document.getElementById('studentsList');

                                        if (!seccionId) {
                                            listContainer.innerHTML = `
                    <div class="text-center py-5 text-muted">
                        <i class="bi bi-people display-1"></i>
                        <p class="mt-3">Selecciona una sección para ver los estudiantes</p>
                    </div>`;
                                            return;
                                        }

                                        listContainer.innerHTML = '<div class="text-center py-4"><div class="spinner-border text-primary" role="status"></div><p class="mt-2">Cargando...</p></div>';

                                        fetch('${pageContext.request.contextPath}/GetEstudiantesAsistenciaServlet?seccionId=' + seccionId + '&fechaClase=2026-01-01')
                                            .then(r => r.json())
                                            .then(data => {
                                                if (data.success && data.estudiantes && data.estudiantes.length > 0) {
                                                    let html = '';
                                                    data.estudiantes.forEach(est => {
                                                        // Escapar comillas para evitar errores en onclick
                                                        const safeNombre = est.nombreCompleto.replace(/"/g, "&quot;");
                                                        const safeCodigo = (est.codigo || '').replace(/"/g, "&quot;");

                                                        html += `
                                <div class="student-item">
                                    <div class="d-flex align-items-center">
                                        <div class="me-3">
                                            <div class="fw-bold">\${est.nombreCompleto}</div>
                                            \${est.codigo ? '<small class="text-muted">Código: ' + est.codigo + '</small>' : ''}
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center gap-2">
                                        <span class="badge bg-primary badge-section me-2">\${est.seccionNombre || 'Sección'}</span>
                                        <button class="btn btn-sm btn-outline-warning" 
                                            onclick="abrirModalEdicion(\${est.id}, '\${safeNombre}', '\${safeCodigo}', \${est.seccionId})">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" 
                                            onclick="eliminarEstudiante(\${est.id})">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>`;
                                                    });
                                                    listContainer.innerHTML = html;
                                                } else {
                                                    listContainer.innerHTML = `
                            <div class="text-center py-5 text-muted">
                                <i class="bi bi-inbox display-1"></i>
                                <p class="mt-3">No hay estudiantes registrados en esta sección</p>
                            </div>`;
                                                }
                                            })
                                            .catch(err => {
                                                console.error(err);
                                                listContainer.innerHTML = '<div class="alert alert-danger">Error al cargar la lista de estudiantes</div>';
                                            });
                                    }

                                    // --- Funciones para Editar y Eliminar ---

                                    let modalEdicion;

                                    document.addEventListener('DOMContentLoaded', () => {
                                        modalEdicion = new bootstrap.Modal(document.getElementById('editarEstudianteModal'));
                                    });

                                    function abrirModalEdicion(id, nombre, codigo, seccionId) {
                                        document.getElementById('editEstudianteId').value = id;
                                        document.getElementById('editNombre').value = nombre;
                                        document.getElementById('editCodigo').value = codigo;
                                        document.getElementById('editSeccionId').value = seccionId;
                                        modalEdicion.show();
                                    }

                                    function guardarEdicion() {
                                        const id = document.getElementById('editEstudianteId').value;
                                        const nombre = document.getElementById('editNombre').value;
                                        const codigo = document.getElementById('editCodigo').value;
                                        const seccionId = document.getElementById('editSeccionId').value;

                                        if (!nombre) { alert("El nombre es obligatorio"); return; }

                                        const params = new URLSearchParams();
                                        params.append('id', id);
                                        params.append('nombre', nombre);
                                        params.append('codigo', codigo);
                                        params.append('seccionId', seccionId);

                                        fetch('${pageContext.request.contextPath}/EditarEstudianteServlet', {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                            body: params.toString()
                                        })
                                            .then(r => r.json())
                                            .then(data => {
                                                if (data.success) {
                                                    alert("✅ Actualizado correctamente");
                                                    modalEdicion.hide();
                                                    // Recargar lista
                                                    loadStudents(document.getElementById('filterSeccion').value);
                                                } else {
                                                    alert("❌ Error: " + data.message);
                                                }
                                            })
                                            .catch(err => alert("Error de conexión"));
                                    }

                                    function eliminarEstudiante(id) {
                                        if (!confirm("¿Estás seguro de que deseas eliminar este estudiante? Esta acción no se puede deshacer.")) return;

                                        fetch('${pageContext.request.contextPath}/EliminarEstudianteServlet', {
                                            method: 'POST',
                                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                            body: 'id=' + id
                                        })
                                            .then(r => r.json())
                                            .then(data => {
                                                if (data.success) {
                                                    alert("🗑️ Estudiante eliminado");
                                                    loadStudents(document.getElementById('filterSeccion').value);
                                                } else {
                                                    alert("❌ Error: " + data.message);
                                                }
                                            })
                                            .catch(err => alert("Error de conexión"));
                                    }
                                </script>
                            </body>

                            </html>