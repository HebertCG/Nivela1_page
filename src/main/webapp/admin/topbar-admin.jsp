<%@ page import="modelo.Usuario, java.time.LocalDate, java.time.format.DateTimeFormatter, java.util.Locale" %>
    <% Usuario admin=(Usuario) session.getAttribute("usuario"); String nombreAdmin=(admin !=null) ? admin.getNombre()
        + " " + admin.getApellido() : "Administrador" ; String primerNombre=(admin !=null && admin.getNombre() !=null) ?
        admin.getNombre() : "Admin" ; String inicialAdmin=(admin !=null && admin.getNombre() !=null &&
        !admin.getNombre().isEmpty()) ? admin.getNombre().substring(0, 1).toUpperCase() : "A" ; LocalDate
        hoy=LocalDate.now(); DateTimeFormatter formatter=DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", new
        Locale("es", "ES" )); String fechaFormateada=hoy.format(formatter); fechaFormateada=fechaFormateada.substring(0,
        1).toUpperCase() + fechaFormateada.substring(1); %>

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

            .dashboard-topbar {
                position: sticky;
                top: 0;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                -webkit-backdrop-filter: blur(20px);
                padding: 1.25rem 2rem;
                display: flex;
                align-items: center;
                justify-content: space-between;
                box-shadow: 0 4px 20px rgba(0, 13, 131, 0.08);
                z-index: 900;
                gap: 1rem;
                border-bottom: 1px solid rgba(0, 13, 131, 0.05);
                font-family: 'Poppins', sans-serif;
            }

            .btn-icon {
                background: rgba(0, 13, 131, 0.05);
                border: none;
                width: 42px;
                height: 42px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                color: #000d83;
                position: relative;
                font-size: 1.25rem;
            }

            .btn-icon:hover {
                background: rgba(0, 13, 131, 0.1);
                color: #000d83;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 13, 131, 0.15);
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
                font-weight: 400;
            }

            .topbar-greeting {
                font-size: 1.15rem;
                font-weight: 600;
                color: #1a1a2e;
                margin: 0;
            }

            .topbar-greeting .text-gradient {
                background: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                font-weight: 700;
            }

            .topbar-actions {
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .notification-dot {
                position: absolute;
                top: 6px;
                right: 6px;
                width: 10px;
                height: 10px;
                background: linear-gradient(135deg, #ff5d5d 0%, #ff3b30 100%);
                border: 2px solid white;
                border-radius: 50%;
                animation: pulse 2s ease-in-out infinite;
            }

            @keyframes pulse {

                0%,
                100% {
                    transform: scale(1);
                    opacity: 1;
                }

                50% {
                    transform: scale(1.1);
                    opacity: 0.8;
                }
            }

            .search-container {
                position: relative;
                display: none;
            }

            .search-input {
                width: 280px;
                padding: 0.625rem 1rem 0.625rem 2.75rem;
                border: 1px solid rgba(0, 13, 131, 0.1);
                border-radius: 12px;
                background: rgba(255, 255, 255, 0.8);
                font-size: 0.9rem;
                transition: all 0.3s ease;
                font-family: 'Poppins', sans-serif;
            }

            .search-input:focus {
                outline: none;
                border-color: #3ec4ff;
                box-shadow: 0 0 0 3px rgba(62, 196, 255, 0.1);
                background: white;
            }

            .search-icon {
                position: absolute;
                left: 1rem;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                pointer-events: none;
            }

            .user-pill {
                position: relative;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding: 0.5rem 1rem;
                background: rgba(0, 13, 131, 0.05);
                border-radius: 50px;
                cursor: pointer;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                border: 1px solid rgba(0, 13, 131, 0.08);
            }

            .user-pill:hover {
                background: rgba(0, 13, 131, 0.08);
                box-shadow: 0 4px 12px rgba(0, 13, 131, 0.1);
                transform: translateY(-2px);
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                font-size: 1rem;
                box-shadow: 0 2px 8px rgba(0, 13, 131, 0.2);
            }

            .user-pill p {
                font-size: 0.95rem;
                color: #1a1a2e;
                line-height: 1.2;
                margin: 0;
                font-weight: 600;
            }

            .user-pill small {
                font-size: 0.75rem;
                color: #6c757d;
                font-weight: 400;
            }

            .user-pill i.bi-chevron-down {
                font-size: 0.875rem;
                color: #6c757d;
                transition: transform 0.3s ease;
            }

            .user-pill:hover i.bi-chevron-down {
                transform: translateY(2px);
            }

            /* User Dropdown */
            .user-dropdown {
                position: absolute;
                top: calc(100% + 0.5rem);
                right: 0;
                min-width: 220px;
                background: white;
                border-radius: 14px;
                box-shadow: 0 10px 40px rgba(0, 13, 131, 0.15);
                border: 1px solid rgba(0, 13, 131, 0.1);
                opacity: 0;
                visibility: hidden;
                transform: translateY(-10px);
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                z-index: 1000;
                overflow: hidden;
            }

            .user-dropdown.show {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .user-dropdown-header {
                padding: 1rem 1.25rem;
                border-bottom: 1px solid rgba(0, 13, 131, 0.08);
                background: rgba(0, 13, 131, 0.02);
            }

            .user-dropdown-header p {
                margin: 0;
                font-size: 0.95rem;
                font-weight: 600;
                color: #1a1a2e;
            }

            .user-dropdown-header small {
                font-size: 0.8rem;
                color: #6c757d;
            }

            .user-dropdown-item {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                padding: 0.875rem 1.25rem;
                color: #1a1a2e;
                text-decoration: none;
                transition: all 0.2s ease;
                border: none;
                background: none;
                width: 100%;
                text-align: left;
                font-family: 'Poppins', sans-serif;
                font-size: 0.95rem;
                cursor: pointer;
            }

            .user-dropdown-item:hover {
                background: rgba(0, 13, 131, 0.05);
                color: #000d83;
            }

            .user-dropdown-item i {
                font-size: 1.2rem;
                width: 20px;
                text-align: center;
            }

            .user-dropdown-item.logout-item {
                color: #ff5d5d;
                border-top: 1px solid rgba(0, 13, 131, 0.08);
            }

            .user-dropdown-item.logout-item:hover {
                background: rgba(255, 93, 93, 0.1);
                color: #ff3b30;
            }

            /* Mobile Responsive */
            @media (min-width: 992px) {
                .search-container {
                    display: block;
                }
            }

            @media (max-width: 768px) {
                .dashboard-topbar {
                    padding: 1rem 1.25rem;
                }

                .topbar-greeting {
                    font-size: 1rem;
                }

                .topbar-date {
                    font-size: 0.75rem;
                }

                .user-pill {
                    padding: 0.4rem 0.75rem;
                }

                .user-avatar {
                    width: 36px;
                    height: 36px;
                    font-size: 0.9rem;
                }

                .user-pill div:not(.user-avatar) {
                    display: none;
                }

                .user-pill i.bi-chevron-down {
                    display: none;
                }

                .user-dropdown {
                    min-width: 200px;
                }
            }

            @media (max-width: 576px) {
                .topbar-info {
                    display: none;
                }

                .btn-icon {
                    width: 38px;
                    height: 38px;
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
                    <h6 class="topbar-greeting">
                        Bienvenido, <span class="text-gradient">
                            <%= primerNombre %>
                        </span>
                    </h6>
                </div>
            </div>

            <div class="topbar-actions">
                <div class="search-container">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Buscar estudiantes, secciones..." />
                </div>

                <div class="position-relative">
                    <button class="btn btn-icon" aria-label="Notificaciones">
                        <i class="bi bi-bell"></i>
                    </button>
                    <span class="notification-dot"></span>
                </div>

                <div class="user-pill" id="userMenuToggle">
                    <div class="user-avatar">
                        <%= inicialAdmin %>
                    </div>
                    <div>
                        <p class="mb-0 text-uppercase">
                            <%= nombreAdmin %>
                        </p>
                        <small class="text-muted">Administrador</small>
                    </div>
                    <i class="bi bi-chevron-down"></i>

                    <!-- Dropdown Menu -->
                    <div class="user-dropdown" id="userDropdown">
                        <div class="user-dropdown-header">
                            <p class="mb-0 text-uppercase">
                                <%= nombreAdmin %>
                            </p>
                            <small>Administrador</small>
                        </div>
                        <a href="${pageContext.request.contextPath}/salir" class="user-dropdown-item logout-item">
                            <i class="bi bi-box-arrow-right"></i>
                            <span>Cerrar Sesión</span>
                        </a>
                    </div>
                </div>
            </div>
        </header>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const userMenuToggle = document.getElementById('userMenuToggle');
                const userDropdown = document.getElementById('userDropdown');

                if (userMenuToggle && userDropdown) {
                    // Toggle dropdown on click
                    userMenuToggle.addEventListener('click', function (e) {
                        e.stopPropagation();
                        userDropdown.classList.toggle('show');
                    });

                    // Close dropdown when clicking outside
                    document.addEventListener('click', function (e) {
                        if (!userMenuToggle.contains(e.target)) {
                            userDropdown.classList.remove('show');
                        }
                    });

                    // Prevent dropdown from closing when clicking inside it
                    userDropdown.addEventListener('click', function (e) {
                        e.stopPropagation();
                    });
                }
            });
        </script>