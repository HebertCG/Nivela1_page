<%@ page import="modelo.Usuario" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="verificarAdmin.jsp" %>
<% 
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("../login.jsp");
        return;
    }
    request.setAttribute("sidebarActive", "administradores");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Administradores</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        :root { --admin-accent: #8B5CF6; --color-bg: #F3F4F6; --color-surface: #FFFFFF; --color-border: #E5E7EB; }
        body { font-family: "Segoe UI", system-ui, sans-serif; background: var(--color-bg); margin: 0; color: #1A1A1A; }
        .dashboard-layout { min-height: 100vh; background: var(--color-bg); }
        .content-wrapper { flex: 1; display: flex; flex-direction: column; background: var(--color-bg); margin-left: 280px; transition: margin-left 0.3s ease; min-height: 100vh; }
        .admin-sidebar[data-collapsed="true"] ~ .content-wrapper { margin-left: 80px; }
        .dashboard-main { flex: 1; padding: 2rem; }
        .page-header { margin-bottom: 2rem; }
        .page-title { font-size: 2rem; font-weight: 700; color: #1A1A1A; margin: 0 0 0.5rem 0; }
        .page-subtitle { color: #6B7280; margin: 0; }
        .content-card { background: white; border-radius: 16px; padding: 2rem; border: 1px solid var(--color-border); box-shadow: 0 1px 3px rgba(0,0,0,0.05); margin-bottom: 2rem; }
        .card-header-custom { display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem; padding-bottom: 1rem; border-bottom: 2px solid #F3F4F6; }
        .card-icon { width: 48px; height: 48px; background: linear-gradient(135deg, #8B5CF6, #7C3AED); border-radius: 12px; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem; }
        .card-title-custom { font-size: 1.5rem; font-weight: 700; color: #1A1A1A; margin: 0; }
        .form-label { font-weight: 600; color: #374151; margin-bottom: 0.5rem; }
        .form-control { border: 1px solid #D1D5DB; border-radius: 8px; padding: 0.75rem 1rem; transition: all 0.3s ease; }
        .form-control:focus { border-color: var(--admin-accent); box-shadow: 0 0 0 3px rgba(139,92,246,0.1); }
        .btn-primary-custom { background: linear-gradient(135deg, #8B5CF6, #7C3AED); border: none; color: white; padding: 0.75rem 2rem; border-radius: 10px; font-weight: 600; transition: all 0.3s ease; }
        .btn-primary-custom:hover { transform: translateY(-2px); box-shadow: 0 8px 16px rgba(139,92,246,0.3); }
        .btn-secondary-custom { background: #6B7280; border: none; color: white; padding: 0.75rem 2rem; border-radius: 10px; font-weight: 600; transition: all 0.3s ease; }
        .btn-secondary-custom:hover { background: #4B5563; transform: translateY(-2px); }
        .table-container { overflow-x: auto; border-radius: 12px; border: 1px solid var(--color-border); }
        .table-custom { width: 100%; margin: 0; }
        .table-custom thead { background: #F9FAFB; }
        .table-custom th { padding: 1rem; font-weight: 600; color: #374151; border-bottom: 2px solid #E5E7EB; white-space: nowrap; }
        .table-custom td { padding: 1rem; color: #6B7280; border-bottom: 1px solid #F3F4F6; }
        .table-custom tbody tr:hover { background: #F9FAFB; }
        .btn-action { padding: 0.5rem 1rem; border-radius: 8px; font-size: 0.875rem; font-weight: 600; border: none; transition: all 0.3s ease; }
        .btn-edit { background: #3B82F6; color: white; }
        .btn-edit:hover { background: #2563EB; transform: translateY(-2px); }
        .btn-delete { background: #EF4444; color: white; }
        .btn-delete:hover { background: #DC2626; transform: translateY(-2px); }
        .empty-state { text-align: center; padding: 3rem 1rem; color: #9CA3AF; }
        .empty-state i { font-size: 4rem; margin-bottom: 1rem; opacity: 0.5; }
        @media (max-width: 991.98px) { .content-wrapper { margin-left: 0 !important; } .dashboard-main { padding: 1.5rem 1rem; } }
    </style>
</head>
<body>
    <div class="dashboard-layout d-flex">
        <%@ include file="sidebar-admin.jsp" %>
        <div class="content-wrapper">
            <%@ include file="topbar-admin.jsp" %>
            <main class="dashboard-main">
                <div class="page-header">
                    <h1 class="page-title">Gestion de Administradores</h1>
                    <p class="page-subtitle">Registra y administra los administradores del sistema</p>
                </div>
                <c:if test="${not empty mensaje}">
                    <div class="alert alert-${tipoMensaje == 'error' ? 'danger' : 'success'} alert-dismissible fade show">
                        ${mensaje}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <div class="content-card">
                    <div class="card-header-custom">
                        <div class="card-icon"><i class="bi bi-shield-plus"></i></div>
                        <h2 class="card-title-custom">Registrar nuevo administrador</h2>
                    </div>
                    <form action="${pageContext.request.contextPath}/RegistrarAdministrador" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Nombre</label>
                                <input type="text" class="form-control" name="nombre" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Apellido</label>
                                <input type="text" class="form-control" name="apellido" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Correo institucional</label>
                                <input type="email" class="form-control" name="correo" placeholder="a1@academiaA1.com" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Contrasena</label>
                                <input type="password" class="form-control" name="contrasena" required>
                            </div>
                            <div class="col-12">
                                <div class="d-flex gap-2 justify-content-end">
                                    <button type="reset" class="btn btn-secondary-custom">Limpiar</button>
                                    <button type="submit" class="btn btn-primary-custom">
                                        <i class="bi bi-check-circle me-2"></i>Registrar Administrador
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="content-card">
                    <div class="card-header-custom">
                        <div class="card-icon"><i class="bi bi-list-ul"></i></div>
                        <h2 class="card-title-custom">Administradores registrados</h2>
                    </div>
                    <c:choose>
                        <c:when test="${not empty administradores}">
                            <div class="table-container">
                                <table class="table-custom">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>Apellido</th>
                                            <th>Correo</th>
                                            <th>Contrasena</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="admin" items="${administradores}">
                                            <tr>
                                                <td>${admin.id}</td>
                                                <td>${admin.nombre}</td>
                                                <td>${admin.apellido}</td>
                                                <td>${admin.correo}</td>
                                                <td>••••••••</td>
                                                <td>
                                                    <div class="d-flex gap-2">
                                                        <button class="btn-action btn-edit">
                                                            <i class="bi bi-pencil"></i> Editar
                                                        </button>
                                                        <button class="btn-action btn-delete">
                                                            <i class="bi bi-trash"></i> Eliminar
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="bi bi-inbox"></i>
                                <h5>No hay administradores registrados</h5>
                                <p>Los administradores que registres apareceran aqui</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
