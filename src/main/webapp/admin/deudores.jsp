<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="modelo.Preinscripcion" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                    <% List<Preinscripcion> preinscripciones = (List<Preinscripcion>)
                            request.getAttribute("preinscripciones");
                            String filtroActual = (String) request.getAttribute("filtroActual");
                            String gradoActual = (String) request.getAttribute("gradoActual");
                            Double totalEsperado = (Double) request.getAttribute("totalEsperado");
                            Double totalRecaudado = (Double) request.getAttribute("totalRecaudado");
                            Double totalPendiente = (Double) request.getAttribute("totalPendiente");

                            if (filtroActual == null) filtroActual = "todos";
                            if (gradoActual == null) gradoActual = "";
                            if (totalEsperado == null) totalEsperado = 0.0;
                            if (totalRecaudado == null) totalRecaudado = 0.0;
                            if (totalPendiente == null) totalPendiente = 0.0;

                            double porcentajeRecaudado = totalEsperado > 0 ? (totalRecaudado / totalEsperado) * 100 : 0;
                            int porcentajeRecaudadoInt = (int) Math.round(porcentajeRecaudado);

                            pageContext.setAttribute("totalEsperado", totalEsperado);
                            pageContext.setAttribute("totalRecaudado", totalRecaudado);
                            pageContext.setAttribute("totalPendiente", totalPendiente);
                            pageContext.setAttribute("porcentajeRecaudado", porcentajeRecaudado);
                            pageContext.setAttribute("porcentajeRecaudadoInt", porcentajeRecaudadoInt);
                            %>
                            <!DOCTYPE html>
                            <html lang="es">

                            <head>
                                <meta charset="UTF-8">
                                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                                <title>Control Financiero - Academia Nivel A1</title>
                                <link href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css"
                                    rel="stylesheet">
                                <link rel="stylesheet"
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
                                <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                                <style>
                                    body {
                                        background: #F3F4F6;
                                        font-family: 'Segoe UI', system-ui, sans-serif;
                                    }

                                    .dashboard-header {
                                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                        color: white;
                                        padding: 2rem;
                                        border-radius: 12px;
                                        margin-bottom: 2rem;
                                    }

                                    .metrics-grid {
                                        display: grid;
                                        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                                        gap: 1.5rem;
                                        margin-bottom: 2rem;
                                    }

                                    .metric-card {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 1.5rem;
                                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                        transition: transform 0.2s;
                                    }

                                    .metric-card:hover {
                                        transform: translateY(-4px);
                                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                                    }

                                    .metric-label {
                                        color: #6B7280;
                                        font-size: 0.875rem;
                                        font-weight: 500;
                                        margin-bottom: 0.5rem;
                                    }

                                    .metric-value {
                                        font-size: 2rem;
                                        font-weight: 700;
                                        color: #111827;
                                    }

                                    .metric-icon {
                                        width: 48px;
                                        height: 48px;
                                        border-radius: 12px;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        font-size: 1.5rem;
                                        margin-bottom: 1rem;
                                    }

                                    .icon-esperado {
                                        background: #DBEAFE;
                                        color: #1E40AF;
                                    }

                                    .icon-recaudado {
                                        background: #D1FAE5;
                                        color: #059669;
                                    }

                                    .icon-pendiente {
                                        background: #FEE2E2;
                                        color: #DC2626;
                                    }

                                    .progress-section {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 1.5rem;
                                        margin-bottom: 2rem;
                                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                    }

                                    .progress-bar-custom {
                                        height: 24px;
                                        border-radius: 12px;
                                        background: #E5E7EB;
                                        overflow: hidden;
                                    }

                                    .progress-fill {
                                        height: 100%;
                                        background: linear-gradient(90deg, #10B981 0%, #059669 100%);
                                        transition: width 0.5s ease;
                                        display: flex;
                                        align-items: center;
                                        justify-content: center;
                                        color: white;
                                        font-weight: 600;
                                        font-size: 0.875rem;
                                    }

                                    .filters-section {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 1.5rem;
                                        margin-bottom: 2rem;
                                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                    }

                                    .filter-btn {
                                        padding: 0.5rem 1.25rem;
                                        border-radius: 8px;
                                        border: 2px solid #E5E7EB;
                                        background: white;
                                        color: #374151;
                                        font-weight: 500;
                                        cursor: pointer;
                                        transition: all 0.2s;
                                    }

                                    .filter-btn:hover {
                                        border-color: #667eea;
                                        color: #667eea;
                                    }

                                    .filter-btn.active {
                                        background: #667eea;
                                        border-color: #667eea;
                                        color: white;
                                    }

                                    .table-container {
                                        background: white;
                                        border-radius: 12px;
                                        padding: 1.5rem;
                                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                                        overflow-x: auto;
                                    }

                                    .data-table {
                                        width: 100%;
                                        border-collapse: collapse;
                                    }

                                    .data-table th {
                                        background: #F9FAFB;
                                        padding: 1rem;
                                        text-align: left;
                                        font-weight: 600;
                                        color: #374151;
                                        border-bottom: 2px solid #E5E7EB;
                                        white-space: nowrap;
                                    }

                                    .data-table td {
                                        padding: 1rem;
                                        border-bottom: 1px solid #E5E7EB;
                                        color: #6B7280;
                                    }

                                    .data-table tr:hover {
                                        background: #F9FAFB;
                                    }

                                    .badge-status {
                                        padding: 0.25rem 0.75rem;
                                        border-radius: 9999px;
                                        font-size: 0.75rem;
                                        font-weight: 600;
                                    }

                                    .badge-pagado {
                                        background: #D1FAE5;
                                        color: #059669;
                                    }

                                    .badge-pendiente {
                                        background: #FEF3C7;
                                        color: #D97706;
                                    }

                                    .badge-vencido {
                                        background: #FEE2E2;
                                        color: #DC2626;
                                    }

                                    .empty-state {
                                        text-align: center;
                                        padding: 4rem 2rem;
                                        color: #9CA3AF;
                                    }

                                    .empty-state i {
                                        font-size: 4rem;
                                        margin-bottom: 1rem;
                                    }
                                </style>
                            </head>

                            <body>
                                <div class="container-fluid p-4">
                                    <!-- Header -->
                                    <div class="dashboard-header">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <h1 class="mb-2"><i class="bi bi-cash-stack"></i> Control Financiero
                                                </h1>
                                                <p class="mb-0 opacity-75">Gestión completa de pagos y deudores - Ciclo
                                                    Verano 2026</p>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/admin/panel.jsp"
                                                class="btn btn-light">
                                                <i class="bi bi-arrow-left"></i> Volver al Panel
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Métricas Principales -->
                                    <div class="metrics-grid">
                                        <div class="metric-card">
                                            <div class="metric-icon icon-esperado"><i class="bi bi-calculator"></i>
                                            </div>
                                            <div class="metric-label">Total Esperado</div>
                                            <div class="metric-value">S/.
                                                <fmt:formatNumber value="${totalEsperado}" pattern="#,##0.00" />
                                            </div>
                                        </div>
                                        <div class="metric-card">
                                            <div class="metric-icon icon-recaudado"><i class="bi bi-check-circle"></i>
                                            </div>
                                            <div class="metric-label">Total Recaudado</div>
                                            <div class="metric-value">S/.
                                                <fmt:formatNumber value="${totalRecaudado}" pattern="#,##0.00" />
                                            </div>
                                        </div>
                                        <div class="metric-card">
                                            <div class="metric-icon icon-pendiente"><i
                                                    class="bi bi-exclamation-triangle"></i></div>
                                            <div class="metric-label">Total Pendiente</div>
                                            <div class="metric-value">S/.
                                                <fmt:formatNumber value="${totalPendiente}" pattern="#,##0.00" />
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Barra de Progreso -->
                                    <div class="progress-section">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="mb-0">Progreso de Recaudación</h5>
                                            <span class="badge bg-primary"
                                                style="font-size: 1rem; padding: 0.5rem 1rem;">
                                                <fmt:formatNumber value="${porcentajeRecaudado}" pattern="#0.0" />%
                                            </span>
                                        </div>
                                        <div class="progress-bar-custom">
                                            <div class="progress-fill" style="width: ${porcentajeRecaudadoInt}%">
                                                <c:if test="${porcentajeRecaudado > 10}">
                                                    <fmt:formatNumber value="${porcentajeRecaudado}" pattern="#0.0" />%
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Filtros -->
                                    <div class="filters-section">
                                        <div class="row g-3">
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold">Estado de Pago</label>
                                                <div class="btn-group w-100" role="group">
                                                    <c:url value="/admin/ListarDeudores" var="urlTodos">
                                                        <c:param name="filtro" value="todos" />
                                                        <c:if test="${not empty gradoActual}">
                                                            <c:param name="grado" value="${gradoActual}" />
                                                        </c:if>
                                                    </c:url>
                                                    <c:url value="/admin/ListarDeudores" var="urlPagados">
                                                        <c:param name="filtro" value="pagados" />
                                                        <c:if test="${not empty gradoActual}">
                                                            <c:param name="grado" value="${gradoActual}" />
                                                        </c:if>
                                                    </c:url>
                                                    <c:url value="/admin/ListarDeudores" var="urlDeudores">
                                                        <c:param name="filtro" value="deudores" />
                                                        <c:if test="${not empty gradoActual}">
                                                            <c:param name="grado" value="${gradoActual}" />
                                                        </c:if>
                                                    </c:url>

                                                    <button type="button"
                                                        class="filter-btn ${filtroActual == 'todos' ? 'active' : ''}"
                                                        onclick="window.location.href='${urlTodos}'">Todos</button>
                                                    <button type="button"
                                                        class="filter-btn ${filtroActual == 'pagados' ? 'active' : ''}"
                                                        onclick="window.location.href='${urlPagados}'">Pagados</button>
                                                    <button type="button"
                                                        class="filter-btn ${filtroActual == 'deudores' ? 'active' : ''}"
                                                        onclick="window.location.href='${urlDeudores}'">Deudores</button>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label fw-bold">Filtrar por Grado</label>
                                                <select class="form-select" id="filtroGrado"
                                                    onchange="aplicarFiltroGrado()">
                                                    <option value="">Todos los grados</option>
                                                    <option value="6to Prim - 1ro Sec"
                                                        ${gradoActual=='6to Prim - 1ro Sec' ? 'selected' : '' }>6to Prim
                                                        - 1ro Sec</option>
                                                    <option value="2do Sec - 3ro Sec" ${gradoActual=='2do Sec - 3ro Sec'
                                                        ? 'selected' : '' }>2do Sec - 3ro Sec</option>
                                                    <option value="4to Sec - 5to Sec" ${gradoActual=='4to Sec - 5to Sec'
                                                        ? 'selected' : '' }>4to Sec - 5to Sec</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Tabla de Datos -->
                                    <div class="table-container">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h5 class="mb-0">Detalle Completo (<%= preinscripciones !=null ?
                                                    preinscripciones.size() : 0 %> registros)</h5>
                                            <button class="btn btn-success" onclick="exportarExcel()">
                                                <i class="bi bi-file-earmark-excel"></i> Exportar Excel
                                            </button>
                                        </div>

                                        <% if (preinscripciones !=null && !preinscripciones.isEmpty()) { %>
                                            <table class="data-table">
                                                <thead>
                                                    <tr>
                                                        <th>Fecha Reg.</th>
                                                        <th>DNI</th>
                                                        <th>Alumno</th>
                                                        <th>Grado</th>
                                                        <th>Carrera</th>
                                                        <th>Apoderado</th>
                                                        <th>Email Apod.</th>
                                                        <th>Tel. 1</th>
                                                        <th>Tel. 2</th>
                                                        <th>Modalidad</th>
                                                        <th>Método</th>
                                                        <th>Total</th>
                                                        <th>Pagado</th>
                                                        <th>Saldo</th>
                                                        <th>Límite 2da</th>
                                                        <th>Estado</th>
                                                        <th>Acciones</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (Preinscripcion p : preinscripciones) { String
                                                        estadoBadge=p.getSaldoPendiente()==0 ? "badge-pagado"
                                                        : "badge-pendiente" ; String
                                                        estadoTexto=p.getSaldoPendiente()==0 ? "Pagado" : "Pendiente" ;
                                                        %>
                                                        <tr>
                                                            <td>
                                                                <fmt:formatDate value="<%= p.getFechaRegistro() %>"
                                                                    pattern="dd/MM/yyyy HH:mm" />
                                                            </td>
                                                            <td><strong>
                                                                    <%= p.getDni() %>
                                                                </strong></td>
                                                            <td>
                                                                <%= p.getNombres() %>
                                                                    <%= p.getApellidos() %>
                                                            </td>
                                                            <td>
                                                                <%= p.getGrado() !=null ? p.getGrado() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= p.getCarrera() %>
                                                            </td>
                                                            <td>
                                                                <%= p.getNombreApoderado() %>
                                                                    <%= p.getApellidoApoderado() %>
                                                            </td>
                                                            <td>
                                                                <%= p.getEmailApoderado() !=null ? p.getEmailApoderado()
                                                                    : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= p.getTelefonoApoderado() !=null ?
                                                                    p.getTelefonoApoderado() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= p.getTelefono2Apoderado() !=null ?
                                                                    p.getTelefono2Apoderado() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= p.getModalidadPago() %>
                                                            </td>
                                                            <td>
                                                                <%= p.getMetodoPago() !=null ? p.getMetodoPago() : "-"
                                                                    %>
                                                            </td>
                                                            <td>S/.
                                                                <fmt:formatNumber value="<%= p.getMontoTotal() %>"
                                                                    pattern="#,##0.00" />
                                                            </td>
                                                            <td>S/.
                                                                <fmt:formatNumber value="<%= p.getMontoPagado() %>"
                                                                    pattern="#,##0.00" />
                                                            </td>
                                                            <td>S/.
                                                                <fmt:formatNumber value="<%= p.getSaldoPendiente() %>"
                                                                    pattern="#,##0.00" />
                                                            </td>
                                                            <td>
                                                                <%= p.getFechaLimite2daCuota() !=null ? new
                                                                    java.text.SimpleDateFormat("dd/MM/yyyy").format(p.getFechaLimite2daCuota())
                                                                    : "-" %>
                                                            </td>
                                                            <td><span class="badge-status <%= estadoBadge %>">
                                                                    <%= estadoTexto %>
                                                                </span></td>
                                                            <td>
                                                                <% if (p.getSaldoPendiente()> 0) { %>
                                                                    <button class="btn btn-sm btn-success"
                                                                        onclick="confirmarPago(<%= p.getId() %>, <%= p.getSaldoPendiente() %>, '<%= p.getNombres() %> <%= p.getApellidos() %>', <%= p.getMontoTotal() %>, <%= p.getMontoPagado() %>)">
                                                                        <i class="bi bi-check-circle"></i> Pagar
                                                                    </button>
                                                                    <% } else { %>
                                                                        <span class="text-success"><i
                                                                                class="bi bi-check-circle-fill"></i></span>
                                                                        <% } %>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                </tbody>
                                            </table>
                                            <% } else { %>
                                                <div class="empty-state">
                                                    <i class="bi bi-inbox"></i>
                                                    <h4>No hay registros</h4>
                                                    <p>No se encontraron preinscripciones con los filtros seleccionados.
                                                    </p>
                                                </div>
                                                <% } %>
                                    </div>
                                </div>

                                <script>
                                    function aplicarFiltroGrado() {
                                        const grado = document.getElementById('filtroGrado').value;
                                        const filtroActual = '${filtroActual}';
                                        const url = '${pageContext.request.contextPath}/admin/ListarDeudores?filtro=' + filtroActual;
                                        if (grado) {
                                            window.location.href = url + '&grado=' + encodeURIComponent(grado);
                                        } else {
                                            window.location.href = url;
                                        }
                                    }

                                    function exportarExcel() {
                                        const filtro = '${filtroActual}';
                                        const grado = '${gradoActual}';
                                        let url = '${pageContext.request.contextPath}/admin/ExportarExcelDeudores?filtro=' + filtro;
                                        if (grado) {
                                            url += '&grado=' + encodeURIComponent(grado);
                                        }
                                        window.location.href = url;
                                    }

                                    function confirmarPago(id, saldo, nombreAlumno, montoTotal, montoPagado) {
                                        var htmlContent = '<div style="text-align: left; padding: 15px;">' +
                                            '<div style="background: #F0FDF4; padding: 15px; border-radius: 10px; margin-bottom: 15px;">' +
                                            '<h5 style="margin: 0 0 10px 0; color: #166534;">' +
                                            '<i class="bi bi-person-fill"></i> ' + nombreAlumno +
                                            '</h5>' +
                                            '</div>' +
                                            '<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 15px;">' +
                                            '<div style="background: #DBEAFE; padding: 12px; border-radius: 8px; text-align: center;">' +
                                            '<div style="font-size: 0.75rem; color: #1E40AF;">Deuda Total</div>' +
                                            '<div style="font-size: 1.2rem; font-weight: bold; color: #1E40AF;">S/. ' + montoTotal.toFixed(2) + '</div>' +
                                            '</div>' +
                                            '<div style="background: #D1FAE5; padding: 12px; border-radius: 8px; text-align: center;">' +
                                            '<div style="font-size: 0.75rem; color: #059669;">Ya Pagado</div>' +
                                            '<div style="font-size: 1.2rem; font-weight: bold; color: #059669;">S/. ' + montoPagado.toFixed(2) + '</div>' +
                                            '</div>' +
                                            '</div>' +
                                            '<div style="background: #FEF3C7; padding: 15px; border-radius: 8px; text-align: center; margin-bottom: 15px;">' +
                                            '<div style="font-size: 0.85rem; color: #92400E;">Monto a Pagar Ahora</div>' +
                                            '<div style="font-size: 1.8rem; font-weight: bold; color: #B45309;">S/. ' + saldo.toFixed(2) + '</div>' +
                                            '</div>' +
                                            '<div style="background: #FEE2E2; padding: 12px; border-radius: 8px; border-left: 4px solid #DC2626;">' +
                                            '<small style="color: #991B1B;">' +
                                            '<i class="bi bi-exclamation-triangle-fill"></i> ' +
                                            '<strong>Importante:</strong> Verifique que el monto coincida con el comprobante de pago antes de confirmar. Esta accion actualizara el saldo del alumno.' +
                                            '</small>' +
                                            '</div>' +
                                            '</div>';

                                        Swal.fire({
                                            title: '<i class="bi bi-cash-stack text-success"></i> Confirmar Pago',
                                            html: htmlContent,
                                            showCancelButton: true,
                                            confirmButtonColor: '#059669',
                                            cancelButtonColor: '#6B7280',
                                            confirmButtonText: '<i class="bi bi-check-circle"></i> Confirmar Pago',
                                            cancelButtonText: '<i class="bi bi-x-circle"></i> Cancelar',
                                            width: 500
                                        }).then(function (result) {
                                            if (result.isConfirmed) {
                                                window.location.href = '${pageContext.request.contextPath}/admin/ConfirmarPagoDeuda?id=' + id + '&monto=' + saldo;
                                            }
                                        });
                                    }
                                </script>
                            </body>

                            </html>