<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="modelo.Usuario" %>
        <%@ page session="true" %>
            <%@ include file="verificarAdmin.jsp" %>
                <% request.setAttribute("sidebarActive", "administradores" ); %>
                    <!DOCTYPE html>
                    <html lang="es">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Editar Administrador</title>
                        <link rel="stylesheet"
                            href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                        <style>
                            :root {
                                --admin-accent: #8B5CF6;
                                --color-bg: #F3F4F6;
                                --color-border: #E5E7EB;
                            }

                            body {
                                font-family: "Segoe UI", system-ui, sans-serif;
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

                            .admin-sidebar[data-collapsed="true"]~.content-wrapper {
                                margin-left: 80px;
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
                            }

                            .page-subtitle {
                                color: #6B7280;
                                margin: 0;
                            }

                            .content-card {
                                background: white;
                                border-radius: 16px;
                                padding: 2rem;
                                border: 1px solid var(--color-border);
                                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
                                max-width: 700px;
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
                                background: linear-gradient(135deg, #8B5CF6, #7C3AED);
                                border-radius: 12px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                color: white;
                                font-size: 1.5rem;
                                flex-shrink: 0;
                            }

                            .card-title-custom {
                                font-size: 1.5rem;
                                font-weight: 700;
                                color: #1A1A1A;
                                margin: 0;
                            }

                            .form-label {
                                font-weight: 600;
                                color: #374151;
                                margin-bottom: 0.5rem;
                            }

                            .form-control {
                                border: 1px solid #D1D5DB;
                                border-radius: 8px;
                                padding: 0.75rem 1rem;
                                transition: all 0.3s ease;
                            }

                            .form-control:focus {
                                border-color: var(--admin-accent);
                                box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
                                outline: none;
                            }

                            .btn-save {
                                background: linear-gradient(135deg, #8B5CF6, #7C3AED);
                                border: none;
                                color: white;
                                padding: 0.75rem 2rem;
                                border-radius: 10px;
                                font-weight: 600;
                                transition: all 0.3s ease;
                                cursor: pointer;
                            }

                            .btn-save:hover {
                                transform: translateY(-2px);
                                box-shadow: 0 8px 16px rgba(139, 92, 246, 0.3);
                            }

                            .btn-cancel {
                                background: #6B7280;
                                border: none;
                                color: white;
                                padding: 0.75rem 2rem;
                                border-radius: 10px;
                                font-weight: 600;
                                transition: all 0.3s ease;
                                text-decoration: none;
                                display: inline-flex;
                                align-items: center;
                                gap: 0.4rem;
                            }

                            .btn-cancel:hover {
                                background: #4B5563;
                                transform: translateY(-2px);
                                color: white;
                            }

                            @media (max-width: 991.98px) {
                                .content-wrapper {
                                    margin-left: 0 !important;
                                }

                                .dashboard-main {
                                    padding: 1.5rem 1rem;
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
                                                <h1 class="page-title"><i class="bi bi-pencil-square me-2"></i>Editar
                                                    Administrador</h1>
                                                <p class="page-subtitle">Modifica los datos del administrador</p>
                                            </div>

                                            <div class="content-card">
                                                <div class="card-header-custom">
                                                    <div class="card-icon"><i class="bi bi-shield-check"></i></div>
                                                    <h2 class="card-title-custom">${admin.nombre} ${admin.apellido}</h2>
                                                </div>
                                                <form
                                                    action="${pageContext.request.contextPath}/ActualizarAdministradorServlet"
                                                    method="post">
                                                    <input type="hidden" name="id" value="${admin.id}">
                                                    <div class="row g-3">
                                                        <div class="col-md-6">
                                                            <label class="form-label">Nombre</label>
                                                            <input type="text" name="nombre" class="form-control"
                                                                value="${admin.nombre}" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label">Apellido</label>
                                                            <input type="text" name="apellido" class="form-control"
                                                                value="${admin.apellido}" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label">Correo institucional</label>
                                                            <input type="email" name="correo" class="form-control"
                                                                value="${admin.correo}" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label">Nueva contraseña</label>
                                                            <input type="password" name="password" class="form-control"
                                                                placeholder="Dejar en blanco para no cambiar">
                                                        </div>
                                                        <div class="col-12">
                                                            <div class="d-flex gap-2 justify-content-end mt-2">
                                                                <a href="${pageContext.request.contextPath}/ListarAdministradoresServlet"
                                                                    class="btn-cancel">
                                                                    <i class="bi bi-arrow-left"></i>Cancelar
                                                                </a>
                                                                <button type="submit" class="btn btn-save">
                                                                    <i class="bi bi-check-circle me-2"></i>Guardar
                                                                    cambios
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </main>
                                </div>
                        </div>
                        <script
                            src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                    </body>

                    </html>