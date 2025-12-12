<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="modelo.Usuario, java.time.LocalDate, java.time.format.DateTimeFormatter, java.util.Locale" %>
        <% Usuario estudiante=(Usuario) session.getAttribute("usuario"); String nombreEstudiante=(estudiante !=null) ?
            estudiante.getNombre() + " " + estudiante.getApellido() : "Estudiante" ; String
            inicialEstudiante=(estudiante !=null && estudiante.getNombre() !=null && !estudiante.getNombre().isEmpty())
            ? estudiante.getNombre().substring(0, 1).toUpperCase() : "E" ; LocalDate hoy=LocalDate.now();
            DateTimeFormatter formatter=DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", new Locale("es", "ES"
            )); String fechaFormateada=hoy.format(formatter); fechaFormateada=fechaFormateada.substring(0,
            1).toUpperCase() + fechaFormateada.substring(1); %>

            <style>
                /* ==========================================
   TOPBAR ESTUDIANTE - ESTILOS COMPLETOS
   ========================================== */

                .dashboard-topbar {
                    position: sticky;
                    top: 0;
                    background: white;
                    padding: 1.25rem 2rem;
                    display: flex;
                    align-items: center;
                    justify-content: space-between;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
                    z-index: 900;
                    gap: 1rem;
                }

                .btn-icon {
                    background: transparent;
                    border: none;
                    width: 40px;
                    height: 40px;
                    border-radius: 10px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    color: #6c757d;
                    position: relative;
                }

                .btn-icon:hover {
                    background: #f8f9fa;
                    color: #1A1A2E;
                }

                .topbar-info {
                    display: flex;
                    flex-direction: column;
                    gap: 0.25rem;
                }

                .topbar-date {
                    color: #6c757d;
                    font-size: 0.875rem;
                    margin: 0;
                }

                .topbar-greeting {
                    font-size: 1.1rem;
                    font-weight: 600;
                    color: #1A1A2E;
                    margin: 0;
                }

                .topbar-greeting .text-uppercase {
                    color: #00D9C0;
                }

                .topbar-actions {
                    display: flex;
                    align-items: center;
                    gap: 1.5rem;
                }

                .notification-dot {
                    position: absolute;
                    top: 8px;
                    right: 8px;
                    width: 8px;
                    height: 8px;
                    background: #ff3b30;
                    border: 2px solid white;
                    border-radius: 50%;
                    animation: pulse 2s infinite;
                }

                @keyframes pulse {

                    0%,
                    100% {
                        opacity: 1;
                    }

                    50% {
                        opacity: 0.5;
                    }
                }

                .user-pill {
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                    padding: 0.5rem 1rem;
                    background: #f8f9fa;
                    border-radius: 50px;
                    cursor: pointer;
                    transition: all 0.3s ease;
                }

                .user-pill:hover {
                    background: #e9ecef;
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }

                .user-avatar {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: linear-gradient(135deg, #1A1A2E, #00D9C0);
                    color: white;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-weight: bold;
                    font-size: 1rem;
                }

                .user-pill p {
                    font-size: 0.95rem;
                    color: #1A1A2E;
                    line-height: 1.2;
                    margin: 0;
                }

                .user-pill small {
                    font-size: 0.75rem;
                    color: #6c757d;
                }

                .user-pill i {
                    color: #6c757d;
                    font-size: 0.875rem;
                }

                /* Responsive */
                @media (max-width: 768px) {
                    .dashboard-topbar {
                        padding: 1rem 1.25rem;
                    }

                    .topbar-greeting {
                        font-size: 0.95rem;
                    }

                    .topbar-date {
                        font-size: 0.75rem;
                    }

                    .user-pill {
                        padding: 0.35rem 0.75rem;
                    }

                    .user-avatar {
                        width: 35px;
                        height: 35px;
                        font-size: 0.875rem;
                    }

                    .user-pill p {
                        font-size: 0.85rem;
                    }

                    .user-pill div:not(.user-avatar) {
                        display: none;
                    }

                    .user-pill i {
                        display: none;
                    }
                }

                @media (max-width: 576px) {
                    .topbar-actions {
                        gap: 0.75rem;
                    }

                    .topbar-info {
                        display: none;
                    }
                }
            </style>

            <header class="dashboard-topbar">
                <div class="d-flex align-items-center gap-3">
                    <button class="btn btn-icon d-lg-none" id="sidebarToggle" aria-label="Abrir menú">
                        <i class="bi bi-list"></i>
                    </button>
                    <div class="topbar-info">
                        <p class="topbar-date">
                            <%= fechaFormateada %>
                        </p>
                        <h6 class="topbar-greeting">Bienvenido de vuelta, <span class="text-uppercase">
                                <%= nombreEstudiante %>
                            </span></h6>
                    </div>
                </div>

                <div class="topbar-actions">
                    <div class="position-relative">
                        <button class="btn btn-icon" aria-label="Notificaciones">
                            <i class="bi bi-bell"></i>
                        </button>
                        <span class="notification-dot"></span>
                    </div>

                    <div class="user-pill">
                        <div class="user-avatar">
                            <%= inicialEstudiante %>
                        </div>
                        <div>
                            <p class="mb-0 fw-semibold text-uppercase">
                                <%= nombreEstudiante %>
                            </p>
                            <small class="text-muted">Estudiante</small>
                        </div>
                        <i class="bi bi-chevron-down"></i>
                    </div>
                </div>
            </header>