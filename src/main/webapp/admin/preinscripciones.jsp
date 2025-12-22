<%@ page import="modelo.Usuario" %>
    <%@ page session="true" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <fmt:setTimeZone value="America/Lima" />
                <%@ include file="verificarAdmin.jsp" %>
                    <% request.setAttribute("sidebarActive", "preinscripciones" ); %>
                        <!DOCTYPE html>
                        <html lang="es">

                        <head>
                            <meta charset="UTF-8">
                            <meta name="viewport" content="width=device-width, initial-scale=1.0">
                            <title>Gestion de Inscripciones</title>
                            <link rel="icon" type="image/png" href="img/LOGOS.png" />
                            <link rel="stylesheet"
                                href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                            <link rel="stylesheet"
                                href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                            <style>
                                :root {
                                    --admin-accent: #8B5CF6;
                                    --color-bg: #F3F4F6;
                                }

                                body {
                                    font-family: "Segoe UI", system-ui, sans-serif;
                                    background: var(--color-bg);
                                    margin: 0;
                                }

                                .content-wrapper {
                                    margin-left: 280px;
                                    transition: margin-left 0.3s ease;
                                    min-height: 100vh;
                                }

                                .admin-sidebar[data-collapsed="true"]~.content-wrapper {
                                    margin-left: 80px;
                                }

                                .dashboard-main {
                                    padding: 2rem;
                                }

                                .page-title {
                                    font-size: 2rem;
                                    font-weight: 700;
                                    margin-bottom: 0.5rem;
                                }

                                .page-subtitle {
                                    color: #6B7280;
                                    margin-bottom: 2rem;
                                }

                                .content-card {
                                    background: white;
                                    border-radius: 16px;
                                    padding: 2rem;
                                    border: 1px solid #E5E7EB;
                                    margin-bottom: 2rem;
                                }

                                .card-header-custom {
                                    display: flex;
                                    align-items: center;
                                    gap: 1rem;
                                    margin-bottom: 1.5rem;
                                    padding-bottom: 1rem;
                                    border-bottom: 2px solid #F3F4F6;
                                }

                                .card-icon {
                                    width: 48px;
                                    height: 48px;
                                    background: linear-gradient(135deg, #F59E0B, #D97706);
                                    border-radius: 12px;
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    color: white;
                                    font-size: 1.5rem;
                                }

                                .card-title-custom {
                                    font-size: 1.5rem;
                                    font-weight: 700;
                                    margin: 0;
                                }

                                .form-label {
                                    font-weight: 600;
                                    color: #374151;
                                    margin-bottom: 0.5rem;
                                }

                                .form-control,
                                .form-select {
                                    border: 1px solid #D1D5DB;
                                    border-radius: 8px;
                                    padding: 0.75rem 1rem;
                                }

                                .form-control:focus,
                                .form-select:focus {
                                    border-color: var(--admin-accent);
                                    box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
                                }

                                .btn-primary-custom {
                                    background: linear-gradient(135deg, #F59E0B, #D97706);
                                    border: none;
                                    color: white;
                                    padding: 0.75rem 2rem;
                                    border-radius: 10px;
                                    font-weight: 600;
                                }

                                .btn-primary-custom:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 8px 16px rgba(245, 158, 11, 0.3);
                                }

                                .filter-tabs {
                                    display: flex;
                                    gap: 0.5rem;
                                    margin-bottom: 1.5rem;
                                    flex-wrap: wrap;
                                }

                                .filter-tab {
                                    padding: 0.75rem 1.5rem;
                                    border-radius: 10px;
                                    border: 2px solid #E5E7EB;
                                    background: white;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.3s ease;
                                }

                                .filter-tab.active {
                                    background: var(--admin-accent);
                                    color: white;
                                    border-color: var(--admin-accent);
                                }

                                .table-container {
                                    overflow-x: auto;
                                    border-radius: 12px;
                                    border: 1px solid #E5E7EB;
                                }

                                .table-custom {
                                    width: 100%;
                                    margin: 0;
                                }

                                .table-custom thead {
                                    background: #F9FAFB;
                                }

                                .table-custom th {
                                    padding: 1rem;
                                    font-weight: 600;
                                    color: #374151;
                                    border-bottom: 2px solid #E5E7EB;
                                    white-space: nowrap;
                                }

                                .table-custom td {
                                    padding: 1rem;
                                    color: #6B7280;
                                    border-bottom: 1px solid #F3F4F6;
                                }

                                .table-custom tbody tr:hover {
                                    background: #F9FAFB;
                                }

                                .badge-origen {
                                    padding: 0.375rem 0.75rem;
                                    border-radius: 999px;
                                    font-size: 0.75rem;
                                    font-weight: 600;
                                }

                                .badge-manual {
                                    background: #EDE9FE;
                                    color: #7C3AED;
                                }

                                .badge-online {
                                    background: #DBEAFE;
                                    color: #2563EB;
                                }

                                .badge-estado {
                                    padding: 0.375rem 0.75rem;
                                    border-radius: 999px;
                                    font-size: 0.75rem;
                                    font-weight: 600;
                                }

                                .badge-pendiente {
                                    background: #FEF3C7;
                                    color: #D97706;
                                }

                                .badge-aceptado {
                                    background: #D1FAE5;
                                    color: #059669;
                                }

                                .badge-rechazado {
                                    background: #FEE2E2;
                                    color: #DC2626;
                                }

                                .btn-action {
                                    padding: 0.5rem 1rem;
                                    border-radius: 8px;
                                    font-size: 0.875rem;
                                    font-weight: 600;
                                    border: none;
                                }

                                .btn-accept {
                                    background: #10B981;
                                    color: white;
                                }

                                .btn-reject {
                                    background: #EF4444;
                                    color: white;
                                }

                                .empty-state {
                                    text-align: center;
                                    padding: 3rem 1rem;
                                    color: #9CA3AF;
                                }

                                /* Tabla Responsive con scroll horizontal */
                                .table-container {
                                    overflow-x: auto;
                                    -webkit-overflow-scrolling: touch;
                                }

                                .table-responsive {
                                    min-width: 100%;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                    font-size: 0.875rem;
                                    white-space: nowrap;
                                }

                                table th {
                                    background: #F9FAFB;
                                    font-weight: 600;
                                    text-align: left;
                                    padding: 1rem 0.75rem;
                                    border-bottom: 2px solid #E5E7EB;
                                    position: sticky;
                                    top: 0;
                                    z-index: 10;
                                }

                                table td {
                                    padding: 1rem 0.75rem;
                                    border-bottom: 1px solid #F3F4F6;
                                    vertical-align: middle;
                                }

                                /* Ancho específico para columnas */
                                table th:nth-child(1),
                                table td:nth-child(1) {
                                    min-width: 130px;
                                }

                                /* Fecha */
                                table th:nth-child(2),
                                table td:nth-child(2) {
                                    min-width: 90px;
                                }

                                /* DNI */
                                table th:nth-child(3),
                                table td:nth-child(3) {
                                    min-width: 150px;
                                }

                                /* Nombre */
                                table th:nth-child(4),
                                table td:nth-child(4) {
                                    min-width: 110px;
                                }

                                /* Tel Apod */
                                table th:nth-child(5),
                                table td:nth-child(5) {
                                    min-width: 120px;
                                }

                                /* Num Op */
                                table th:nth-child(6),
                                table td:nth-child(6) {
                                    min-width: 100px;
                                }

                                /* Monto */
                                table th:nth-child(7),
                                table td:nth-child(7) {
                                    min-width: 90px;
                                }

                                /* Modalidad */
                                table th:nth-child(8),
                                table td:nth-child(8) {
                                    min-width: 180px;
                                }

                                /* Email */
                                table th:nth-child(9),
                                table td:nth-child(9) {
                                    min-width: 120px;
                                }

                                /* Carrera */
                                table th:nth-child(10),
                                table td:nth-child(10) {
                                    min-width: 90px;
                                }

                                /* Estado */
                                table th:nth-child(11),
                                table td:nth-child(11) {
                                    min-width: 80px;
                                }

                                /* Origen */
                                table th:nth-child(12),
                                table td:nth-child(12) {
                                    min-width: 280px;
                                }

                                /* Acciones */

                                /* Botones de acción en fila */
                                .btn-action {
                                    display: inline-block;
                                    margin: 0 2px;
                                    padding: 0.4rem 0.75rem;
                                    font-size: 0.8rem;
                                    white-space: nowrap;
                                }

                                .btn-edit {
                                    background: #3B82F6;
                                    border-color: #3B82F6;
                                    color: white;
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
                                <%@ include file="sidebar-admin.jsp" %>
                                    <div class="content-wrapper">
                                        <%@ include file="topbar-admin.jsp" %>
                                            <main class="dashboard-main">
                                                <h1 class="page-title">Gestion de Inscripciones</h1>
                                                <p class="page-subtitle">Registra manualmente o gestiona las solicitudes
                                                    online</p>

                                                <div class="content-card">
                                                    <div class="card-header-custom">
                                                        <div class="card-icon"><i class="bi bi-person-plus-fill"></i>
                                                        </div>
                                                        <h2 class="card-title-custom">Registro Manual</h2>
                                                    </div>
                                                    <form
                                                        action="${pageContext.request.contextPath}/RegistrarPreinscripcionManual"
                                                        method="post">
                                                        <div class="row g-3">
                                                            <!-- Datos del Alumno -->
                                                            <div class="col-12">
                                                                <h5
                                                                    style="color: #374151; font-weight: 600; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #F3F4F6;">
                                                                    <i class="bi bi-person-badge me-2"></i>Datos del
                                                                    Alumno
                                                                </h5>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Nombre <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" class="form-control" name="nombre"
                                                                    required maxlength="100">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Apellido <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" class="form-control" name="apellido"
                                                                    required maxlength="100">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Email</label>
                                                                <input type="email" class="form-control" name="email"
                                                                    maxlength="100" placeholder="ejemplo@email.com">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Direccion</label>
                                                                <input type="text" class="form-control" name="direccion"
                                                                    maxlength="200"
                                                                    placeholder="Calle, numero, distrito">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Colegio de Procedencia</label>
                                                                <input type="text" class="form-control" name="colegio"
                                                                    maxlength="150">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Grado que cursa en 2026 <span
                                                                        class="text-danger">*</span></label>
                                                                <select class="form-select" name="grado" id="gradoAdmin"
                                                                    required onchange="actualizarPrecioAdmin()">
                                                                    <option value="">Selecciona grado</option>
                                                                    <option value="6to Prim - 1ro Sec">6to Prim - 1ro
                                                                        Sec
                                                                    </option>
                                                                    <option value="2do Sec - 3ro Sec">2do Sec - 3ro Sec
                                                                    </option>
                                                                    <option value="4to Sec - 5to Sec">4to Sec - 5to Sec
                                                                    </option>
                                                                </select>
                                                            </div>

                                                            <!-- Información de Precios Admin -->
                                                            <div class="col-12">
                                                                <div
                                                                    style="background: #F0F9FF; border: 2px solid #3B82F6; padding: 0.875rem; border-radius: 10px; margin-top: 0.5rem;">
                                                                    <div
                                                                        style="font-size: 0.85rem; color: #1E40AF; font-weight: 600; margin-bottom: 0.5rem;">
                                                                        <i class="bi bi-cash-stack me-2"></i>Precios por
                                                                        Grado:
                                                                    </div>
                                                                    <div
                                                                        style="display: grid; grid-template-columns: 1fr 1fr; gap: 0.5rem; font-size: 0.8rem; color: #374151;">
                                                                        <div><strong>6to/1ro y 2do/3ro:</strong> Contado
                                                                            S/.400 | Cuotas S/.500</div>
                                                                        <div><strong>4to/5to:</strong> Contado S/.500 |
                                                                            Cuotas S/.600</div>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <label class="form-label">Carrera de Interes <span
                                                                        class="text-danger">*</span></label>
                                                                <select class="form-select" name="carrera"
                                                                    id="carreraSelect" required
                                                                    onchange="toggleOtraCarrera()">
                                                                    <option value="">Selecciona carrera</option>
                                                                    <option value="Medicina">Medicina</option>
                                                                    <option value="Ingenieria">Ingenieria</option>
                                                                    <option value="Derecho">Derecho</option>
                                                                    <option value="Otros">Otros</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-12" id="otraCarreraContainer"
                                                                style="display: none;">
                                                                <label class="form-label">Especifica la carrera</label>
                                                                <input type="text" class="form-control"
                                                                    name="otraCarrera" id="otraCarreraInput"
                                                                    maxlength="100" placeholder="Escribe la carrera">
                                                            </div>

                                                            <!-- Datos del Apoderado -->
                                                            <div class="col-12 mt-4">
                                                                <h5
                                                                    style="color: #374151; font-weight: 600; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #F3F4F6;">
                                                                    <i class="bi bi-people-fill me-2"></i>Datos del
                                                                    Apoderado
                                                                </h5>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Nombre del Apoderado <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" class="form-control"
                                                                    name="nombreApoderado" required maxlength="100">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Apellido del Apoderado <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" class="form-control"
                                                                    name="apellidoApoderado" required maxlength="100">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">DNI del Apoderado <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="text" class="form-control"
                                                                    name="dniApoderado" required pattern="[0-9]{8}"
                                                                    maxlength="8" placeholder="12345678">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Email del Apoderado</label>
                                                                <input type="email" class="form-control"
                                                                    name="emailApoderado" maxlength="100"
                                                                    placeholder="apoderado@email.com">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Telefono de Referencia 1 <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="tel" class="form-control"
                                                                    name="telefono1Apoderado" required
                                                                    pattern="[0-9]{9}" maxlength="9"
                                                                    placeholder="987654321">
                                                            </div>
                                                            <div class="col-md-4">
                                                                <label class="form-label">Telefono de Referencia 2 <span
                                                                        class="text-danger">*</span></label>
                                                                <input type="tel" class="form-control"
                                                                    name="telefono2Apoderado" required
                                                                    pattern="[0-9]{9}" maxlength="9"
                                                                    placeholder="987654321">
                                                            </div>

                                                            <!-- Datos de Pago -->
                                                            <div class="col-12 mt-4">
                                                                <h5
                                                                    style="color: #374151; font-weight: 600; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 2px solid #F3F4F6;">
                                                                    <i class="bi bi-credit-card me-2"></i>Datos de Pago
                                                                </h5>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Modalidad de Pago <span
                                                                        class="text-danger">*</span></label>
                                                                <select class="form-select" name="modalidadPago"
                                                                    id="modalidadPagoAdmin" required onchange="">
                                                                    <option value="">Selecciona modalidad</option>
                                                                    <option value="contado">Pago al Contado</option>
                                                                    <option value="cuotas">Pago en 2 Cuotas</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Metodo de Pago <span
                                                                        class="text-danger">*</span></label>
                                                                <select class="form-select" name="metodoPago" required>
                                                                    <option value="">Selecciona metodo</option>
                                                                    <option value="efectivo">Efectivo</option>
                                                                    <option value="transferencia">Transferencia</option>
                                                                    <option value="yape">Yape</option>
                                                                    <option value="plin">Plin</option>
                                                                </select>
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="form-label">Numero de Operacion</label>
                                                                <input type="text" class="form-control"
                                                                    name="referenciaPago" maxlength="50"
                                                                    placeholder="Opcional - Solo si aplica">
                                                                <small class="text-muted">Dejar vacio si es pago en
                                                                    efectivo</small>
                                                            </div>

                                                            <div class="col-12 mt-3">
                                                                <button type="submit" class="btn-primary-custom">
                                                                    <i class="bi bi-check-circle me-2"></i>Registrar
                                                                    Preinscripcion
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>

                                                <div class="content-card">
                                                    <div class="card-header-custom">
                                                        <div class="card-icon"><i class="bi bi-list-check"></i></div>
                                                        <h2 class="card-title-custom">Inscripciones</h2>
                                                    </div>
                                                    <div class="filter-tabs">
                                                        <button class="filter-tab active"
                                                            onclick="filtrar('todos')">Todos</button>
                                                        <button class="filter-tab"
                                                            onclick="filtrar('pendiente')">Pendientes</button>
                                                        <button class="filter-tab"
                                                            onclick="filtrar('aceptado')">Aceptados</button>
                                                        <button class="filter-tab"
                                                            onclick="filtrar('rechazado')">Rechazados</button>
                                                    </div>
                                                    <div class="table-container">
                                                        <table class="table-responsive">
                                                            <thead>
                                                                <tr>
                                                                    <th>Fecha Registro</th>
                                                                    <th>Nombre</th>
                                                                    <th>Tel. Apoderado</th>
                                                                    <th>DNI Apoderado</th>
                                                                    <th>Núm. Operación</th>
                                                                    <th>Monto Pagado</th>
                                                                    <th>Modalidad</th>
                                                                    <th>Voucher</th>
                                                                    <th>Estado</th>
                                                                    <th>Origen</th>
                                                                    <th>Acciones</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody id="tablaBody">
                                                                <c:choose>
                                                                    <c:when test="${not empty preinscripciones}">
                                                                        <c:forEach var="p" items="${preinscripciones}">
                                                                            <tr data-estado="${p.estado}">
                                                                                <td>
                                                                                    <fmt:formatDate
                                                                                        value="${p.fechaRegistro}"
                                                                                        pattern="dd/MM/yyyy HH:mm" />
                                                                                </td>
                                                                                <td>${p.nombre} ${p.apellido}</td>
                                                                                <td><strong
                                                                                        style="color: #059669;">${p.telefonoApoderado
                                                                                        != null ? p.telefonoApoderado :
                                                                                        '-'}</strong></td>
                                                                                <td><strong>${p.dniApoderado != null ?
                                                                                        p.dniApoderado : '-'}</strong>
                                                                                </td>
                                                                                <td><span
                                                                                        style="font-family: monospace; font-size: 0.9rem;">${p.referenciaPago
                                                                                        != null ? p.referenciaPago :
                                                                                        '-'}</span></td>
                                                                                <td><strong>S/.
                                                                                        <fmt:formatNumber
                                                                                            value="${p.montoPagado}"
                                                                                            pattern="#,##0.00" />
                                                                                    </strong></td>
                                                                                <td>
                                                                                    <span
                                                                                        class="badge ${p.modalidadPago == 'contado' ? 'bg-success' : 'bg-warning text-dark'}">
                                                                                        ${p.modalidadPago}
                                                                                    </span>
                                                                                </td>
                                                                                <td style="text-align: center;">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${not empty p.comprobantePago}">
                                                                                            <button
                                                                                                class="btn btn-sm btn-primary"
                                                                                                onclick="verVoucher('${pageContext.request.contextPath}/${p.comprobantePago}', '${p.nombre} ${p.apellido}', '${p.dni}', '${p.referenciaPago}', ${p.montoPagado}, ${p.montoTotal}, '${p.modalidadPago}', '${p.grado}')"
                                                                                                title="Ver comprobante">
                                                                                                <i
                                                                                                    class="bi bi-eye"></i>
                                                                                                Ver
                                                                                            </button>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span
                                                                                                style="color: #9CA3AF; font-size: 0.875rem;">Sin
                                                                                                voucher</span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </td>
                                                                                <td><span
                                                                                        class="badge-estado badge-${p.estado}">${p.estado}</span>
                                                                                </td>
                                                                                <td><span
                                                                                        class="badge-origen badge-${p.origen}">${p.origen}</span>
                                                                                </td>
                                                                                <td>
                                                                                    <c:if
                                                                                        test="${p.estado == 'pendiente'}">
                                                                                        <a href="${pageContext.request.contextPath}/AceptarPreinscripcion?id=${p.id}"
                                                                                            class="btn-action btn-accept">Aceptar</a>
                                                                                        <a href="${pageContext.request.contextPath}/RechazarPreinscripcion?id=${p.id}"
                                                                                            class="btn-action btn-reject">Rechazar</a>
                                                                                        <button
                                                                                            class="btn-action btn-edit"
                                                                                            onclick="editarPago(${p.id}, ${p.montoTotal}, ${p.montoPagado}, '${p.metodoPago}', '${p.modalidadPago}')"
                                                                                            style="background: #3B82F6; border-color: #3B82F6;">
                                                                                            ✏️ Editar
                                                                                        </button>
                                                                                    </c:if>
                                                                                </td>
                                                                            </tr>
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <tr>
                                                                            <td colspan="11" class="empty-state">No hay
                                                                                preinscripciones</td>
                                                                        </tr>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </tbody>
                                                        </table>
                                                    </div>

                                                    <!-- Paginación -->
                                                    <c:if test="${totalPaginas > 1}">
                                                        <div class="d-flex justify-content-between align-items-center mt-4 pt-3"
                                                            style="border-top: 1px solid #E5E7EB;">
                                                            <div class="text-muted">
                                                                Mostrando página <strong>${paginaActual}</strong> de
                                                                <strong>${totalPaginas}</strong>
                                                                (${totalRegistros} registros en total)
                                                            </div>
                                                            <nav aria-label="Paginación">
                                                                <ul class="pagination mb-0">
                                                                    <li
                                                                        class="page-item ${paginaActual == 1 ? 'disabled' : ''}">
                                                                        <a class="page-link"
                                                                            href="${pageContext.request.contextPath}/ListarPreinscripciones?pagina=${paginaActual - 1}"
                                                                            aria-label="Anterior">
                                                                            <span aria-hidden="true">&laquo;</span>
                                                                        </a>
                                                                    </li>

                                                                    <c:forEach begin="1" end="${totalPaginas}" var="i">
                                                                        <c:choose>
                                                                            <c:when test="${totalPaginas <= 7}">
                                                                                <li
                                                                                    class="page-item ${paginaActual == i ? 'active' : ''}">
                                                                                    <a class="page-link"
                                                                                        href="${pageContext.request.contextPath}/ListarPreinscripciones?pagina=${i}">${i}</a>
                                                                                </li>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <c:if
                                                                                    test="${i == 1 || i == totalPaginas || (i >= paginaActual - 2 && i <= paginaActual + 2)}">
                                                                                    <li
                                                                                        class="page-item ${paginaActual == i ? 'active' : ''}">
                                                                                        <a class="page-link"
                                                                                            href="${pageContext.request.contextPath}/ListarPreinscripciones?pagina=${i}">${i}</a>
                                                                                    </li>
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${i == 2 && paginaActual > 4}">
                                                                                    <li class="page-item disabled"><span
                                                                                            class="page-link">...</span>
                                                                                    </li>
                                                                                </c:if>
                                                                                <c:if
                                                                                    test="${i == totalPaginas - 1 && paginaActual < totalPaginas - 3}">
                                                                                    <li class="page-item disabled"><span
                                                                                            class="page-link">...</span>
                                                                                    </li>
                                                                                </c:if>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </c:forEach>

                                                                    <li
                                                                        class="page-item ${paginaActual == totalPaginas ? 'disabled' : ''}">
                                                                        <a class="page-link"
                                                                            href="${pageContext.request.contextPath}/ListarPreinscripciones?pagina=${paginaActual + 1}"
                                                                            aria-label="Siguiente">
                                                                            <span aria-hidden="true">&raquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </ul>
                                                            </nav>
                                                        </div>
                                                    </c:if>
                                                </div>
                                            </main>
                                    </div>
                            </div>


                            <!-- Modal Ver Voucher -->
                            <div class="modal fade" id="modalVoucher" tabindex="-1" aria-labelledby="modalVoucherLabel"
                                aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header"
                                            style="background: linear-gradient(135deg, #8B5CF6, #7C3AED); color: white;">
                                            <h5 class="modal-title" id="modalVoucherLabel">
                                                <i class="bi bi-receipt me-2"></i>Verificación de Comprobante
                                            </h5>
                                            <button type="button" class="btn-close btn-close-white"
                                                data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <!-- Columna izquierda: Imagen del voucher -->
                                                <div class="col-md-6">
                                                    <h6 class="mb-3"><i class="bi bi-image me-2"></i>Comprobante de Pago
                                                    </h6>
                                                    <div
                                                        style="border: 2px solid #E5E7EB; border-radius: 8px; padding: 10px; background: #F9FAFB;">
                                                        <img id="voucherImage" src="" alt="Comprobante"
                                                            style="width: 100%; border-radius: 4px;">
                                                    </div>
                                                    <div class="mt-2 text-center">
                                                        <a id="voucherDownload" href="" download
                                                            class="btn btn-sm btn-outline-primary">
                                                            <i class="bi bi-download"></i> Descargar
                                                        </a>
                                                    </div>
                                                </div>

                                                <!-- Columna derecha: Información de verificación -->
                                                <div class="col-md-6">
                                                    <h6 class="mb-3"><i class="bi bi-check-circle me-2"></i>Datos de
                                                        Verificación</h6>

                                                    <div class="card mb-3" style="border-left: 4px solid #8B5CF6;">
                                                        <div class="card-body">
                                                            <h6 class="card-subtitle mb-2 text-muted">Alumno</h6>
                                                            <p class="card-text mb-1"><strong
                                                                    id="voucherNombre"></strong></p>
                                                            <p class="card-text text-muted small">DNI: <span
                                                                    id="voucherDNI"></span></p>
                                                        </div>
                                                    </div>

                                                    <div class="card mb-3" style="border-left: 4px solid #10B981;">
                                                        <div class="card-body">
                                                            <h6 class="card-subtitle mb-2 text-muted">Número de
                                                                Operación</h6>
                                                            <p class="card-text"><strong
                                                                    style="font-family: monospace; font-size: 1.1rem;"
                                                                    id="voucherNumOperacion"></strong></p>
                                                        </div>
                                                    </div>

                                                    <div class="card mb-3" style="border-left: 4px solid #F59E0B;">
                                                        <div class="card-body">
                                                            <h6 class="card-subtitle mb-2 text-muted">Monto a Verificar
                                                            </h6>
                                                            <p class="card-text mb-1">
                                                                Pagó: <strong
                                                                    style="color: #059669; font-size: 1.2rem;">S/. <span
                                                                        id="voucherMontoPagado"></span></strong>
                                                            </p>
                                                            <p class="card-text mb-1">
                                                                Debe pagar: <strong style="color: #DC2626;">S/. <span
                                                                        id="voucherMontoEsperado"></span></strong>
                                                            </p>
                                                            <p class="card-text text-muted small">
                                                                Modalidad: <span id="voucherModalidad"></span> | Grado:
                                                                <span id="voucherGrado"></span>
                                                            </p>
                                                            <div id="voucherAlerta" class="alert mt-2"
                                                                style="display: none;"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Cerrar</button>
                                            <a id="btnAceptarVoucher" href="#" class="btn btn-success">
                                                <i class="bi bi-check-circle"></i> Aceptar Preinscripción
                                            </a>
                                            <a id="btnRechazarVoucher" href="#" class="btn btn-danger">
                                                <i class="bi bi-x-circle"></i> Rechazar
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Editar Datos de Pago -->
                            <div class="modal fade" id="modalEditarPago" tabindex="-1"
                                aria-labelledby="modalEditarPagoLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"
                                            style="background: linear-gradient(135deg, #3B82F6, #2563EB); color: white;">
                                            <h5 class="modal-title" id="modalEditarPagoLabel">
                                                <i class="bi bi-pencil-square me-2"></i>Editar Datos de Pago
                                            </h5>
                                            <button type="button" class="btn-close btn-close-white"
                                                data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <form id="formEditarPago"
                                            action="${pageContext.request.contextPath}/admin/ActualizarDatosPago"
                                            method="post">
                                            <div class="modal-body">
                                                <input type="hidden" id="editId" name="id">

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">
                                                        <i class="bi bi-calculator me-1"></i>Monto Total
                                                    </label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">S/.</span>
                                                        <input type="number" step="0.01" min="0" class="form-control"
                                                            id="editMontoTotal" name="montoTotal" required>
                                                    </div>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">
                                                        <i class="bi bi-cash-coin me-1"></i>Monto Pagado
                                                    </label>
                                                    <div class="input-group">
                                                        <span class="input-group-text">S/.</span>
                                                        <input type="number" step="0.01" min="0" class="form-control"
                                                            id="editMontoPagado" name="montoPagado" required>
                                                    </div>
                                                    <small class="text-muted">Este es el monto que el usuario ya
                                                        pagó</small>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">
                                                        <i class="bi bi-credit-card me-1"></i>Método de Pago
                                                    </label>
                                                    <select class="form-select" id="editMetodoPago" name="metodoPago"
                                                        required>
                                                        <option value="efectivo">Efectivo</option>
                                                        <option value="yape">Yape</option>
                                                        <option value="plin">Plin</option>
                                                        <option value="transferencia">Transferencia</option>
                                                    </select>
                                                </div>

                                                <div class="mb-3">
                                                    <label class="form-label fw-bold">
                                                        <i class="bi bi-calendar-check me-1"></i>Modalidad de Pago
                                                    </label>
                                                    <select class="form-select" id="editModalidad" name="modalidadPago"
                                                        required>
                                                        <option value="contado">Contado</option>
                                                        <option value="cuotas">Cuotas</option>
                                                    </select>
                                                </div>

                                                <div class="alert alert-warning" role="alert">
                                                    <i class="bi bi-exclamation-triangle me-2"></i>
                                                    <strong>Importante:</strong> Verifica los datos antes de guardar.
                                                    Estos cambios afectarán el registro financiero.
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Cancelar</button>
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="bi bi-save me-1"></i>Guardar Cambios
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            <script
                                src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                            <script>
                                function toggleOtraCarrera() {
                                    const select = document.getElementById('carreraSelect');
                                    const container = document.getElementById('otraCarreraContainer');
                                    const input = document.getElementById('otraCarreraInput');
                                    if (select.value === 'Otros') {
                                        container.style.display = 'block';
                                        input.required = true;
                                    } else {
                                        container.style.display = 'none';
                                        input.required = false;
                                        input.value = '';
                                    }
                                }

                                function filtrar(estado) {
                                    const tabs = document.querySelectorAll('.filter-tab');
                                    tabs.forEach(t => t.classList.remove('active'));
                                    event.target.classList.add('active');
                                    const filas = document.querySelectorAll('#tablaBody tr');
                                    filas.forEach(fila => {
                                        if (estado === 'todos' || fila.dataset.estado === estado) {
                                            fila.style.display = '';
                                        } else {
                                            fila.style.display = 'none';
                                        }
                                    });
                                }

                                // Función para ver el voucher y verificar el pago
                                function verVoucher(imagenUrl, nombre, dni, numOperacion, montoPagado, montoTotal, modalidad, grado, idPreinscripcion) {
                                    // Poblar imagen
                                    document.getElementById('voucherImage').src = imagenUrl;
                                    document.getElementById('voucherDownload').href = imagenUrl;

                                    // Poblar datos del alumno
                                    document.getElementById('voucherNombre').textContent = nombre;
                                    document.getElementById('voucherDNI').textContent = dni;
                                    document.getElementById('voucherNumOperacion').textContent = numOperacion || 'No registrado';

                                    // Poblar montos
                                    document.getElementById('voucherMontoPagado').textContent = montoPagado.toFixed(2);

                                    // Calcular monto esperado según modalidad
                                    let montoEsperado = montoPagado; // Por defecto
                                    const precios = {
                                        "6to Prim - 1ro Sec": { contado: 400, primeraCuota: 300 },
                                        "2do Sec - 3ro Sec": { contado: 400, primeraCuota: 300 },
                                        "4to Sec - 5to Sec": { contado: 500, primeraCuota: 400 }
                                    };

                                    if (precios[grado]) {
                                        montoEsperado = modalidad === 'contado' ? precios[grado].contado : precios[grado].primeraCuota;
                                    }

                                    document.getElementById('voucherMontoEsperado').textContent = montoEsperado.toFixed(2);
                                    document.getElementById('voucherModalidad').textContent = modalidad.charAt(0).toUpperCase() + modalidad.slice(1);
                                    document.getElementById('voucherGrado').textContent = grado;

                                    // Mostrar alerta si los montos no coinciden
                                    const alertaDiv = document.getElementById('voucherAlerta');
                                    if (Math.abs(montoPagado - montoEsperado) > 0.01) {
                                        alertaDiv.className = 'alert alert-warning mt-2';
                                        alertaDiv.style.display = 'block';
                                        alertaDiv.innerHTML = '<i class="bi bi-exclamation-triangle me-2"></i><strong>Atención:</strong> El monto pagado no coincide con el monto esperado.';
                                    } else {
                                        alertaDiv.className = 'alert alert-success mt-2';
                                        alertaDiv.style.display = 'block';
                                        alertaDiv.innerHTML = '<i class="bi bi-check-circle me-2"></i><strong>Correcto:</strong> El monto coincide.';
                                    }

                                    // Configurar botones de acción
                                    document.getElementById('btnAceptarVoucher').href = '${pageContext.request.contextPath}/AceptarPreinscripcion?dni=' + dni;
                                    document.getElementById('btnRechazarVoucher').href = '${pageContext.request.contextPath}/RechazarPreinscripcion?dni=' + dni;

                                    // Abrir modal
                                    const modal = new bootstrap.Modal(document.getElementById('modalVoucher'));
                                    modal.show();
                                }


                                // Función para abrir el modal de edición de pago
                                function editarPago(id, montoTotal, montoPagado, metodoPago, modalidadPago) {
                                    // Poblar el formulario con los datos actuales
                                    document.getElementById('editId').value = id;
                                    document.getElementById('editMontoTotal').value = montoTotal;
                                    document.getElementById('editMontoPagado').value = montoPagado;
                                    document.getElementById('editMetodoPago').value = metodoPago;
                                    document.getElementById('editModalidad').value = modalidadPago;

                                    // Abrir el modal
                                    const modal = new bootstrap.Modal(document.getElementById('modalEditarPago'));
                                    modal.show();
                                }

                                // Manejar mensajes de éxito y error con SweetAlert2
                                window.addEventListener('DOMContentLoaded', function () {
                                    const urlParams = new URLSearchParams(window.location.search);
                                    const error = urlParams.get('error');

                                    if (error) {
                                        let errorTitle = 'Error en el Registro';
                                        let errorMessage = 'Ocurrió un error al procesar la preinscripción.';

                                        switch (error) {
                                            case 'duplicate':
                                                errorTitle = 'Registro Duplicado';
                                                errorMessage = 'El <strong>DNI</strong> o el <strong>número de operación</strong> ya están registrados en el sistema.<br><br>Verifica los datos e intenta nuevamente.';
                                                break;
                                            case 'database':
                                                errorTitle = 'Error de Base de Datos';
                                                errorMessage = 'Hubo un problema al conectar con la base de datos. Por favor, intenta nuevamente.';
                                                break;
                                        }

                                        Swal.fire({
                                            icon: 'error',
                                            title: errorTitle,
                                            html: errorMessage,
                                            confirmButtonText: 'Entendido',
                                            confirmButtonColor: '#EF4444'
                                        }).then(() => {
                                            // Limpiar URL
                                            window.history.replaceState({}, document.title, window.location.pathname);
                                        });
                                    }
                                });
                            </script>
                        </body>

                        </html>