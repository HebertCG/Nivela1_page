<%@ page import="modelo.Usuario, java.time.LocalDate, java.time.format.DateTimeFormatter, java.util.Locale" %>
    <% Usuario admin=(Usuario) session.getAttribute("usuario"); String nombreAdmin=(admin !=null) ? admin.getNombre()
        + " " + admin.getApellido() : "Administrador" ; String primerNombre=(admin !=null && admin.getNombre() !=null) ?
        admin.getNombre() : "Admin" ; String inicialAdmin=(admin !=null && admin.getNombre() !=null &&
        !admin.getNombre().isEmpty()) ? admin.getNombre().substring(0, 1).toUpperCase() : "A" ; LocalDate
        hoy=LocalDate.now(); DateTimeFormatter formatter=DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", new
        Locale("es", "ES" )); String fechaFormateada=hoy.format(formatter); fechaFormateada=fechaFormateada.substring(0,
        1).toUpperCase() + fechaFormateada.substring(1); %>
        <style>
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
                color: #8B5CF6;
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
                background: linear-gradient(135deg, #8B5CF6, #7C3AED);
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

                .user-pill div:not(.user-avatar) {
                    display: none;
                }
            }

            @media (max-width: 576px) {
                .topbar-info {
                    display: none;
                }
            }
        </style>
        <header class="dashboard-topbar">
            <div class="d-flex align-items-center gap-3">
                <button class="btn btn-icon d-lg-none" id="sidebarToggle" aria-label="Abrir menu">
                    <i class="bi bi-list"></i>
                </button>
                <div class="topbar-info">
                    <p class="topbar-date">
                        <%= fechaFormateada %>
                    </p>
                    <h6 class="topbar-greeting">Bienvenido, <span class="text-uppercase">
                            <%= primerNombre %>
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
                        <%= inicialAdmin %>
                    </div>
                    <div>
                        <p class="mb-0 fw-semibold text-uppercase">
                            <%= nombreAdmin %>
                        </p>
                        <small class="text-muted">Administrador</small>
                    </div>
                    <i class="bi bi-chevron-down"></i>
                </div>
            </div>
        </header>