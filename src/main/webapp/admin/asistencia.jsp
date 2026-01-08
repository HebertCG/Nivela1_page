<%@page import="DAO.AsistenciaSeccionDAO" %>
    <%@page import="DAO.AsistenciaSemanaDAO" %>
        <%@page import="modelo.AsistenciaSeccion" %>
            <%@page import="modelo.AsistenciaSemana" %>
                <%@page import="java.util.List" %>
                    <%@page contentType="text/html" pageEncoding="UTF-8" %>
                        <% if (session.getAttribute("usuario")==null) { response.sendRedirect("../login.jsp"); return; }
                            AsistenciaSeccionDAO seccionDAO=new AsistenciaSeccionDAO(); AsistenciaSemanaDAO
                            semanaDAO=new AsistenciaSemanaDAO(); List<AsistenciaSeccion> secciones =
                            seccionDAO.listarTodas();
                            List<AsistenciaSemana> semanas = semanaDAO.listarTodas();
                                AsistenciaSemana semanaActiva = semanaDAO.obtenerActiva();
                                %>
                                <!DOCTYPE html>
                                <html lang="es">

                                <head>
                                    <meta charset="UTF-8">
                                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                    <title>Tomar Asistencia Semanal - Academia NivelA1</title>
                                    <link rel="icon" type="image/png"
                                        href="${pageContext.request.contextPath}/img/LOGOS.png" />
                                    <link rel="stylesheet"
                                        href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                                    <link rel="stylesheet"
                                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                                    <script src="https://kit.fontawesome.com/f054896dbd.js"
                                        crossorigin="anonymous"></script>

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

                                        .filter-card,
                                        .attendance-card {
                                            background: white;
                                            padding: 2rem;
                                            border-radius: 10px;
                                            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                                            margin-bottom: 2rem;
                                        }

                                        /* Grid de Asistencia */
                                        .attendance-table th,
                                        .attendance-table td {
                                            text-align: center;
                                            vertical-align: middle;
                                        }

                                        .attendance-table th {
                                            background-color: #f8f9fa;
                                        }

                                        .student-name-col {
                                            text-align: left !important;
                                            min-width: 250px;
                                        }

                                        .disabled-day {
                                            background-color: #e9ecef !important;
                                            cursor: not-allowed;
                                        }

                                        /* Toolbar de Herramientas */
                                        .attendance-toolbar {
                                            background: white;
                                            padding: 1rem;
                                            border-radius: 12px;
                                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                                            margin-bottom: 1.5rem;
                                            display: flex;
                                            justify-content: center;
                                            gap: 1rem;
                                            position: sticky;
                                            top: 10px;
                                            z-index: 100;
                                            border: 1px solid #e9ecef;
                                            flex-wrap: wrap;
                                        }

                                        .tool-btn {
                                            padding: 0.6rem 1.5rem;
                                            border-radius: 50px;
                                            border: 2px solid transparent;
                                            font-weight: 600;
                                            cursor: pointer;
                                            transition: all 0.2s;
                                            display: flex;
                                            align-items: center;
                                            gap: 0.5rem;
                                            opacity: 0.7;
                                            background: #f8f9fa;
                                        }

                                        .tool-btn:hover {
                                            opacity: 1;
                                            transform: translateY(-2px);
                                        }

                                        .tool-btn.active {
                                            opacity: 1;
                                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
                                            transform: scale(1.05);
                                        }

                                        .tool-asistio.active {
                                            background-color: #28a745;
                                            color: white;
                                            border-color: #28a745;
                                        }

                                        .tool-falto.active {
                                            background-color: #dc3545;
                                            color: white;
                                            border-color: #dc3545;
                                        }

                                        .tool-tardanza.active {
                                            background-color: #fd7e14;
                                            color: white;
                                            border-color: #fd7e14;
                                        }

                                        .tool-justificada.active {
                                            background-color: #17a2b8;
                                            color: white;
                                            border-color: #17a2b8;
                                        }

                                        /* Colores de botones inactivos en toolbar */
                                        .tool-asistio {
                                            color: #28a745;
                                            border-color: #28a745;
                                        }

                                        .tool-falto {
                                            color: #dc3545;
                                            border-color: #dc3545;
                                        }

                                        .tool-tardanza {
                                            color: #fd7e14;
                                            border-color: #fd7e14;
                                        }

                                        .tool-justificada {
                                            color: #17a2b8;
                                            border-color: #17a2b8;
                                        }

                                        /* Celdas de la grilla */
                                        .attendance-cell-btn {
                                            width: 100%;
                                            height: 40px;
                                            min-width: 40px;
                                            border: none;
                                            border-radius: 4px;
                                            cursor: crosshair;
                                            /* Cursor para pintar */
                                            transition: transform 0.1s;
                                        }

                                        .attendance-cell-btn:active {
                                            transform: scale(0.95);
                                        }

                                        /* Estados en celda */
                                        .status-falto {
                                            background-color: #ffebee;
                                            border: 1px solid #ffcdd2;
                                            color: #c62828;
                                        }

                                        .status-asistio {
                                            background-color: #e8f5e9;
                                            border: 1px solid #c8e6c9;
                                            color: #2e7d32;
                                        }

                                        .status-tardanza {
                                            background-color: #fff3e0;
                                            border: 1px solid #ffe0b2;
                                            color: #ef6c00;
                                        }

                                        .status-justificada {
                                            background-color: #e0f7fa;
                                            border: 1px solid #b2ebf2;
                                            color: #00838f;
                                        }

                                        .status-falto::after {
                                            content: "✕";
                                            font-weight: bold;
                                        }

                                        .status-asistio::after {
                                            content: "✓";
                                            font-weight: bold;
                                        }

                                        .status-tardanza::after {
                                            content: "⏱";
                                            font-weight: bold;
                                        }

                                        .status-justificada::after {
                                            content: "📄";
                                            font-weight: bold;
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
                                                    <h2><i class="fas fa-calendar-week"></i> Asistencia Semanal</h2>
                                                    <p class="mb-0">Registra la asistencia de toda la semana en una sola
                                                        vista</p>
                                                </div>

                                                <div class="filter-card">
                                                    <div class="row g-3 align-items-end">
                                                        <div class="col-md-5">
                                                            <label class="form-label fw-bold">Sección:</label>
                                                            <select id="seccionSelect" class="form-select">
                                                                <option value="">Seleccione una sección...</option>
                                                                <% if (secciones !=null) { for (AsistenciaSeccion
                                                                    seccion : secciones) { %>
                                                                    <option value="<%= seccion.getId() %>">
                                                                        <%= seccion.getNombre() %>
                                                                    </option>
                                                                    <% } } %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-5">
                                                            <label class="form-label fw-bold">Semana:</label>
                                                            <select id="semanaSelect" class="form-select">
                                                                <option value="">Seleccione semana...</option>
                                                                <% if (semanas !=null) { for (AsistenciaSemana semana :
                                                                    semanas) { String selected=(semanaActiva !=null &&
                                                                    semana.getId()==semanaActiva.getId()) ? "selected"
                                                                    : "" ; %>
                                                                    <option value="<%= semana.getId() %>" <%=selected %>
                                                                        >
                                                                        Semana <%= semana.getNumeroSemana() %> - <%=
                                                                                semana.getNombre() %>
                                                                    </option>
                                                                    <% } } %>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <button class="btn btn-primary w-100"
                                                                onclick="loadWeeklyAttendance()">
                                                                <i class="fas fa-search me-2"></i>Cargar
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="loading" class="text-center py-5" style="display: none;">
                                                    <div class="spinner-border text-primary" role="status"></div>
                                                    <p class="mt-2">Cargando datos...</p>
                                                </div>

                                                <div class="attendance-card" id="attendanceGrid" style="display: none;">

                                                    <!-- TOOLBAR DE PINTURA -->
                                                    <div class="attendance-toolbar">
                                                        <span
                                                            class="text-muted align-self-center me-2">Herramienta:</span>
                                                        <div class="tool-btn tool-asistio active"
                                                            onclick="selectTool('asistio')">
                                                            <i class="fas fa-check"></i> ASISTIÓ
                                                        </div>
                                                        <div class="tool-btn tool-falto" onclick="selectTool('falto')">
                                                            <i class="fas fa-times"></i> FALTÓ
                                                        </div>
                                                        <div class="tool-btn tool-tardanza"
                                                            onclick="selectTool('tardanza')">
                                                            <i class="fas fa-clock"></i> TARDANZA
                                                        </div>
                                                        <div class="tool-btn tool-justificada"
                                                            onclick="selectTool('justificada')">
                                                            <i class="fas fa-file-alt"></i> JUSTIFICADA
                                                        </div>
                                                    </div>

                                                    <form id="attendanceForm">
                                                        <div class="table-responsive">
                                                            <table
                                                                class="table table-bordered table-hover attendance-table">
                                                                <thead id="gridHeader">
                                                                    <!-- Se llena dinámicamente -->
                                                                </thead>
                                                                <tbody id="gridBody">
                                                                    <!-- Se llena dinámicamente -->
                                                                </tbody>
                                                            </table>
                                                        </div>

                                                        <div class="mt-4 text-end">
                                                            <button type="submit" class="btn btn-success btn-lg">
                                                                <i class="fas fa-save me-2"></i>Guardar Cambios
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div id="emptyState" class="text-center py-5">
                                                    <i class="bi bi-grid-3x3 display-1 text-muted"></i>
                                                    <h4 class="text-muted mt-3">Selecciona sección y semana para ver la
                                                        grilla</h4>
                                                </div>
                                            </main>
                                        </div>
                                    </div>

                                    <script
                                        src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                                    <script>
                                        console.log('Script Asistencia Semanal v4.0 - Paint Mode');

                                        let currentData = null;
                                        let activeTool = 'asistio'; // Herramienta por defecto

                                        function selectTool(toolName) {
                                            activeTool = toolName;
                                            // Actualizar visualmente la toolbar
                                            document.querySelectorAll('.tool-btn').forEach(btn => {
                                                btn.classList.remove('active');
                                                if (btn.classList.contains('tool-' + toolName)) {
                                                    btn.classList.add('active');
                                                }
                                            });
                                        }

                                        function loadWeeklyAttendance() {
                                            const seccionId = document.getElementById('seccionSelect').value;
                                            const semanaId = document.getElementById('semanaSelect').value;

                                            if (!seccionId || !semanaId) {
                                                alert('Selecciona sección y semana');
                                                return;
                                            }

                                            document.getElementById('loading').style.display = 'block';
                                            document.getElementById('attendanceGrid').style.display = 'none';
                                            document.getElementById('emptyState').style.display = 'none';

                                            // Agregamos timestamp para evitar cache del navegador
                                            const timestamp = new Date().getTime();
                                            fetch('${pageContext.request.contextPath}/GetAsistenciaSemanalServlet?seccionId=' + seccionId + '&semanaId=' + semanaId + '&_t=' + timestamp)
                                                .then(r => r.json())
                                                .then(data => {
                                                    document.getElementById('loading').style.display = 'none';
                                                    if (data.success) {
                                                        currentData = data;
                                                        renderGrid(data);
                                                        document.getElementById('attendanceGrid').style.display = 'block';
                                                    } else {
                                                        alert('Error: ' + data.message);
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error(err);
                                                    document.getElementById('loading').style.display = 'none';
                                                    alert('Error conexión');
                                                });
                                        }

                                        function renderGrid(data) {
                                            const thead = document.getElementById('gridHeader');
                                            const tbody = document.getElementById('gridBody');

                                            // 1. Construir Header
                                            let headerHtml = '<tr><th class="student-name-col">Estudiante</th>';
                                            data.dias.forEach(dia => {
                                                const disabledClass = dia.habilitado ? '' : 'disabled-day';
                                                headerHtml += `
                    <th class="\${disabledClass}">
                        <span class="dia-header">\${dia.nombre}</span>
                        <span class="fecha-sub text-muted font-monospace">\${dia.fecha ? dia.fecha.substring(5) : ''}</span>
                    </th>`;
                                            });
                                            headerHtml += '</tr>';
                                            thead.innerHTML = headerHtml;

                                            // 2. Construir Body
                                            let bodyHtml = '';

                                            if (!data.estudiantes || data.estudiantes.length === 0) {
                                                bodyHtml = '<tr><td colspan="8" class="text-center py-4">No hay estudiantes en esta sección</td></tr>';
                                            } else {
                                                data.estudiantes.forEach(est => {
                                                    bodyHtml += '<tr>';
                                                    bodyHtml += `<td class="student-name-col fw-bold">
                                    \${est.nombreCompleto || 'Sin Nombre'}
                                    \${est.codigo ? '<div class="small text-muted">' + est.codigo + '</div>' : ''}
                                 </td>`;

                                                    data.dias.forEach(dia => {
                                                        if (dia.habilitado) {
                                                            // Buscar estado existente. Si no existe, es 'falto' por defecto (o null)
                                                            const registro = data.registros.find(r => r.estudianteId === est.id && r.fecha === dia.fecha);
                                                            const estadoActual = registro ? registro.estado : 'falto';

                                                            bodyHtml += `
                                <td class="p-1">
                                    <div class="attendance-cell-btn status-\${estadoActual}" 
                                         onmousedown="paintCell(this)"
                                         onmouseover="if(event.buttons===1) paintCell(this)" 
                                         data-estudiante="\${est.id}" 
                                         data-fecha="\${dia.fecha}"
                                         data-status="\${estadoActual}">
                                    </div>
                                </td>`;
                                                        } else {
                                                            bodyHtml += `<td class="disabled-day"></td>`;
                                                        }
                                                    });

                                                    bodyHtml += '</tr>';
                                                });
                                            }
                                            tbody.innerHTML = bodyHtml;
                                        }

                                        function paintCell(div) {
                                            // Aplicar la herramienta activa
                                            div.dataset.status = activeTool;

                                            // Actualizar clases
                                            div.classList.remove('status-asistio', 'status-falto', 'status-tardanza', 'status-justificada');
                                            div.classList.add('status-' + activeTool);
                                        }

                                        // Manejar guardado
                                        document.getElementById('attendanceForm').addEventListener('submit', function (e) {
                                            e.preventDefault();

                                            if (!currentData) return;

                                            const btn = this.querySelector('button[type="submit"]');
                                            const originalText = btn.innerHTML;
                                            btn.disabled = true;
                                            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Guardando...';

                                            // Recolectar datos
                                            const allCells = document.querySelectorAll('.attendance-cell-btn');
                                            const registrosParaGuardar = [];

                                            allCells.forEach(cell => {
                                                registrosParaGuardar.push({
                                                    estudianteId: cell.dataset.estudiante,
                                                    fecha: cell.dataset.fecha,
                                                    estado: cell.dataset.status,
                                                    presente: (cell.dataset.status === 'asistio' || cell.dataset.status === 'tardanza') // Consideramos tardanza como presente para conteos simples
                                                });
                                            });

                                            const semanaId = document.getElementById('semanaSelect').value;
                                            const params = new URLSearchParams();
                                            params.append('semanaId', semanaId);
                                            params.append('data', JSON.stringify(registrosParaGuardar));

                                            fetch('${pageContext.request.contextPath}/GuardarAsistenciaSemanalServlet', {
                                                method: 'POST',
                                                headers: {
                                                    'Content-Type': 'application/x-www-form-urlencoded'
                                                },
                                                body: params.toString()
                                            })
                                                .then(r => r.json())
                                                .then(res => {
                                                    if (res.success) {
                                                        alert('✅ ' + res.message);
                                                    } else {
                                                        alert('❌ ' + res.message);
                                                    }
                                                })
                                                .catch(err => {
                                                    console.error(err);
                                                    alert('❌ Error al guardar');
                                                })
                                                .finally(() => {
                                                    btn.disabled = false;
                                                    btn.innerHTML = originalText;
                                                });
                                        });
                                    </script>
                                </body>

                                </html>