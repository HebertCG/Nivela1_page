<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <fmt:setLocale value="es" />
        <fmt:setBundle basename="mensajes" />

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Próximos Ciclos - Academia NivelA1</title>
            <link rel="icon" type="image/png" href="img/LOGOS.png" />

            <!-- Bootstrap CSS -->
            <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">

            <!-- Font Awesome -->
            <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>

            <!-- AOS Animation Library -->
            <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

            <style>
                :root {
                    --primary-color: #000d83;
                    --secondary-color: #3ec4ff;
                    --text-dark: #2c3e50;
                    --text-light: #6c757d;
                    --light-bg: #f8f9fa;
                    --card-bg: #ffffff;
                    --white: #ffffff;
                    --dark-bg: #1a1a2e;
                    --gradient-hero: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                    --shadow-sm: 0 2px 4px rgba(0, 0, 0, 0.1);
                    --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
                    --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.15);
                }

                /* Dark Mode Variables */
                [data-theme="dark"] {
                    --text-dark: #e0e0e0;
                    --text-light: #b0b0b0;
                    --light-bg: #1a1a2e;
                    --card-bg: #2d2d44;
                    --white: #1a1a2e;
                    --dark-bg: #0f0f1e;
                }

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Poppins', sans-serif;
                    background: var(--light-bg);
                    color: var(--text-dark);
                    overflow-x: hidden;
                }

                /* NAVBAR */
                .navbar-modern {
                    background: rgba(255, 255, 255, 0.95);
                    backdrop-filter: blur(10px);
                    box-shadow: var(--shadow-md);
                    padding: 1rem 0;
                    position: sticky;
                    top: 0;
                    z-index: 1000;
                    transition: all 0.3s ease;
                }

                [data-theme="dark"] .navbar-modern {
                    background: rgba(26, 26, 46, 0.95);
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
                }

                .navbar-brand {
                    font-size: 1.8rem;
                    font-weight: 800;
                    background: var(--gradient-hero);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .nav-link-modern {
                    color: var(--text-dark);
                    font-weight: 500;
                    margin: 0 0.5rem;
                    transition: all 0.3s ease;
                    position: relative;
                }

                .nav-link-modern:hover {
                    color: var(--primary-color);
                    transform: translateY(-2px);
                }

                .nav-link-modern.active {
                    color: var(--primary-color);
                    font-weight: 600;
                }

                /* Theme Toggle */
                .theme-toggle {
                    width: 45px;
                    height: 45px;
                    border-radius: 50%;
                    background: rgba(62, 196, 255, 0.1);
                    border: 2px solid var(--secondary-color);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    margin-left: 1rem;
                }

                .theme-toggle:hover {
                    transform: scale(1.1);
                    box-shadow: var(--shadow-lg);
                }

                .theme-toggle i {
                    font-size: 1.3rem;
                    color: var(--secondary-color);
                }

                /* Social Sidebar */
                .social-sidebar {
                    position: fixed;
                    right: 20px;
                    top: 50%;
                    transform: translateY(-50%);
                    z-index: 999;
                    display: flex;
                    flex-direction: column;
                    gap: 15px;
                }

                .social-sidebar-item {
                    width: 60px;
                    height: 60px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    text-decoration: none;
                    font-size: 1.5rem;
                    transition: all 0.3s ease;
                    position: relative;
                    background: rgba(255, 255, 255, 0.9);
                    backdrop-filter: blur(10px);
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .social-sidebar-item i {
                    color: #6c757d;
                    transition: all 0.3s ease;
                }

                .social-sidebar-item:hover {
                    transform: translateX(-10px) scale(1.1);
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
                }

                .social-facebook:hover {
                    background: linear-gradient(135deg, #1877f2 0%, #0c63d4 100%);
                }

                .social-facebook:hover i {
                    color: white;
                }

                .social-instagram:hover {
                    background: linear-gradient(135deg, #f09433 0%, #e6683c 25%, #dc2743 50%, #cc2366 75%, #bc1888 100%);
                }

                .social-instagram:hover i {
                    color: white;
                }

                .social-tiktok:hover {
                    background: linear-gradient(135deg, #000000 0%, #69C9D0 100%);
                }

                .social-tiktok:hover i {
                    color: white;
                }

                .social-whatsapp {
                    width: 70px;
                    height: 70px;
                }

                .social-whatsapp:hover {
                    background: linear-gradient(135deg, #25d366 0%, #128c7e 100%);
                    animation: pulse 2s infinite;
                }

                .social-whatsapp:hover i {
                    color: white;
                }

                @keyframes pulse {

                    0%,
                    100% {
                        transform: scale(1);
                        box-shadow: 0 0 0 0 rgba(37, 211, 102, 0.7);
                    }

                    50% {
                        transform: scale(1.05);
                        box-shadow: 0 0 0 10px rgba(37, 211, 102, 0);
                    }
                }

                /* HERO SECTION */
                .hero-ciclos {
                    background: var(--gradient-hero);
                    color: var(--white);
                    padding: 5rem 0 4rem;
                    text-align: center;
                    position: relative;
                    overflow: hidden;
                }

                .hero-ciclos::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320"><path fill="rgba(255,255,255,0.1)" d="M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>');
                    background-size: cover;
                    background-position: bottom;
                    opacity: 0.3;
                }

                .hero-ciclos h1 {
                    font-size: 3.5rem;
                    font-weight: 800;
                    margin-bottom: 1rem;
                    position: relative;
                    z-index: 2;
                }

                .hero-ciclos p {
                    font-size: 1.3rem;
                    opacity: 0.95;
                    position: relative;
                    z-index: 2;
                }

                /* CICLOS SECTION */
                .ciclos-section {
                    padding: 5rem 0;
                    background: var(--white);
                }

                .section-title {
                    font-size: 2.5rem;
                    font-weight: 800;
                    color: var(--primary-color);
                    text-align: center;
                    margin-bottom: 3rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .banners-container {
                    max-width: 1200px;
                    margin: 0 auto;
                    display: flex;
                    flex-direction: column;
                    gap: 2.5rem;
                }

                .banner-item {
                    position: relative;
                    border-radius: 20px;
                    overflow: hidden;
                    box-shadow: var(--shadow-lg);
                    transition: all 0.4s ease;
                }

                .banner-item:hover {
                    transform: translateY(-10px);
                    box-shadow: 0 20px 40px rgba(0, 13, 131, 0.2);
                }

                .banner-item img {
                    width: 100%;
                    height: auto;
                    display: block;
                    transition: transform 0.4s ease;
                }

                .banner-item:hover img {
                    transform: scale(1.05);
                }

                /* FOOTER */
                .footer-modern {
                    background: var(--dark-bg);
                    color: var(--white);
                    padding: 3rem 0 1.5rem;
                }

                .footer-logo {
                    font-size: 1.8rem;
                    font-weight: 800;
                    background: var(--gradient-hero);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                    margin-bottom: 1rem;
                }

                .footer-text {
                    color: rgba(255, 255, 255, 0.7);
                    font-size: 0.95rem;
                    line-height: 1.8;
                }

                .footer-title {
                    color: var(--white);
                    font-weight: 700;
                    margin-bottom: 1.5rem;
                    font-size: 1.1rem;
                }

                .footer-link {
                    color: rgba(255, 255, 255, 0.7);
                    text-decoration: none;
                    display: block;
                    margin-bottom: 0.8rem;
                    transition: all 0.3s ease;
                    font-size: 0.95rem;
                }

                .footer-link:hover {
                    color: var(--secondary-color);
                    padding-left: 5px;
                }

                .social-links {
                    display: flex;
                    gap: 1rem;
                }

                .social-link {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: rgba(255, 255, 255, 0.1);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    color: var(--white);
                    text-decoration: none;
                    transition: all 0.3s ease;
                }

                .social-link:hover {
                    background: var(--secondary-color);
                    transform: translateY(-3px);
                    color: var(--white);
                }

                .footer-bottom {
                    border-top: 1px solid rgba(255, 255, 255, 0.1);
                    margin-top: 2rem;
                    padding-top: 1.5rem;
                    text-align: center;
                }

                .footer-bottom p {
                    color: rgba(255, 255, 255, 0.6);
                    font-size: 0.9rem;
                }

                /* RESPONSIVE */
                @media (max-width: 768px) {

                    /* Hide all social icons except WhatsApp on mobile */
                    .social-facebook,
                    .social-instagram,
                    .social-tiktok {
                        display: none !important;
                    }

                    .social-sidebar {
                        right: 15px;
                        bottom: 20px;
                        top: auto;
                        transform: none;
                    }

                    .social-whatsapp {
                        width: 65px;
                        height: 65px;
                        font-size: 1.8rem;
                        background: linear-gradient(135deg, #25d366 0%, #128c7e 100%) !important;
                        animation: pulse 2s infinite;
                    }

                    .social-whatsapp i {
                        color: white !important;
                    }

                    .hero-ciclos h1 {
                        font-size: 2.5rem;
                    }

                    .hero-ciclos p {
                        font-size: 1.1rem;
                    }

                    .section-title {
                        font-size: 2rem;
                    }

                    .banners-container {
                        gap: 1.5rem;
                    }

                    /* Navbar responsive improvements */
                    .navbar-toggler {
                        border: none;
                        padding: 0.5rem;
                    }

                    .navbar-toggler:focus {
                        box-shadow: none;
                    }
                }
            </style>
        </head>

        <body>
            <!-- NAVBAR -->
            <nav class="navbar navbar-expand-lg navbar-modern">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">NivelA1</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern" href="servicios.jsp">Servicios</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern active" href="ciclos.jsp">Ciclos</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern" href="login.jsp" target="_blank">
                                    <i class="fas fa-user-circle"></i> Intranet
                                </a>
                            </li>
                        </ul>
                        <!-- Theme Toggle Button -->
                        <div class="theme-toggle" id="themeToggle" title="Cambiar tema">
                            <i class="fas fa-moon" id="themeIcon"></i>
                        </div>
                    </div>
                </div>
            </nav>

            <!-- SOCIAL SIDEBAR -->
            <div class="social-sidebar">
                <a href="https://www.facebook.com/grupodeestudiosa1" class="social-sidebar-item social-facebook"
                    target="_blank" title="Facebook">
                    <i class="fab fa-facebook-f"></i>
                </a>
                <a href="https://www.instagram.com/nivela_1/" class="social-sidebar-item social-instagram"
                    target="_blank" title="Instagram">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="https://www.tiktok.com/@nivela1_?lang=es-419" class="social-sidebar-item social-tiktok"
                    target="_blank" title="TikTok">
                    <i class="fab fa-tiktok"></i>
                </a>
                <a href="https://wa.me/51999999999" class="social-sidebar-item social-whatsapp" target="_blank"
                    title="WhatsApp">
                    <i class="fab fa-whatsapp"></i>
                </a>
            </div>

            <!-- HERO SECTION -->
            <section class="hero-ciclos">
                <div class="container">
                    <h1>Próximos Ciclos</h1>
                    <p>Conoce nuestros ciclos de preparación y asegura tu vacante</p>
                </div>
            </section>

            <!-- CICLOS SECTION -->
            <section class="ciclos-section">
                <div class="container">
                    <h2 class="section-title">Ciclos Disponibles</h2>
                    <div class="banners-container">
                        <div class="banner-item" data-aos="fade-up" data-aos-delay="100">
                            <img src="img/banner1.png" alt="Ciclo 1">
                        </div>
                        <div class="banner-item" data-aos="fade-up" data-aos-delay="200">
                            <img src="img/banner2.png" alt="Ciclo 2">
                        </div>
                        <div class="banner-item" data-aos="fade-up" data-aos-delay="300">
                            <img src="img/banner3.png" alt="Ciclo 3">
                        </div>
                        <div class="banner-item" data-aos="fade-up" data-aos-delay="400">
                            <img src="img/banner4.png" alt="Ciclo 4">
                        </div>
                    </div>
                </div>
            </section>

            <!-- FOOTER -->
            <footer class="footer-modern">
                <div class="container">
                    <div class="row g-4">
                        <div class="col-lg-4">
                            <div class="footer-logo">NivelA1</div>
                            <p class="footer-text">
                                Academia preuniversitaria líder en preparación para el ingreso a las mejores
                                universidades del país.
                            </p>
                            <div class="social-links mt-4">
                                <a href="https://www.facebook.com/grupodeestudiosa1" class="social-link"
                                    target="_blank">
                                    <i class="fab fa-facebook-f"></i>
                                </a>
                                <a href="https://www.instagram.com/nivela_1/" class="social-link" target="_blank">
                                    <i class="fab fa-instagram"></i>
                                </a>
                                <a href="https://www.tiktok.com/@nivela1_?lang=es-419" class="social-link"
                                    target="_blank">
                                    <i class="fab fa-tiktok"></i>
                                </a>
                                <a href="https://wa.me/51999999999" class="social-link" target="_blank">
                                    <i class="fab fa-whatsapp"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-6">
                            <h5 class="footer-title">Enlaces</h5>
                            <a href="index.jsp" class="footer-link">Inicio</a>
                            <a href="servicios.jsp" class="footer-link">Servicios</a>
                            <a href="ciclos.jsp" class="footer-link">Ciclos</a>
                            <a href="login.jsp" class="footer-link">Intranet</a>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5 class="footer-title">Información</h5>
                            <a href="index.jsp#beneficios" class="footer-link">Nuestros Beneficios</a>
                            <a href="servicios.jsp#becas" class="footer-link">Preparamos Becas</a>
                            <a href="servicios.jsp#docentes" class="footer-link">Nuestros Docentes</a>
                            <a href="ciclos.jsp" class="footer-link">Próximos Ciclos</a>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5 class="footer-title">Contacto</h5>
                            <p class="footer-text">
                                <i class="fas fa-map-marker-alt me-2"></i> Piura, Perú
                            </p>
                            <p class="footer-text">
                                <i class="fas fa-phone me-2"></i> +51 957 391 784
                            </p>
                            <p class="footer-text">
                                <i class="fas fa-envelope me-2"></i> info@nivela1.com
                            </p>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p class="mb-0">&copy; 2026 <strong>Academia NivelA1</strong> - Todos los derechos reservados
                        </p>
                    </div>
                </div>
            </footer>

            <!-- Scripts -->
            <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>

            <!-- AOS Animation -->
            <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
            <script>
                AOS.init({
                    duration: 800,
                    once: true,
                    offset: 100
                });
            </script>

            <!-- Theme Toggle Script -->
            <script>
                const themeToggle = document.getElementById('themeToggle');
                const themeIcon = document.getElementById('themeIcon');
                const htmlElement = document.documentElement;
                const currentTheme = localStorage.getItem('theme') || 'light';
                htmlElement.setAttribute('data-theme', currentTheme);
                if (currentTheme === 'dark') {
                    themeIcon.classList.remove('fa-moon');
                    themeIcon.classList.add('fa-sun');
                }
                themeToggle.addEventListener('click', function () {
                    let theme = htmlElement.getAttribute('data-theme');
                    if (theme === 'light') {
                        htmlElement.setAttribute('data-theme', 'dark');
                        localStorage.setItem('theme', 'dark');
                        themeIcon.classList.remove('fa-moon');
                        themeIcon.classList.add('fa-sun');
                    } else {
                        htmlElement.setAttribute('data-theme', 'light');
                        localStorage.setItem('theme', 'light');
                        themeIcon.classList.remove('fa-sun');
                        themeIcon.classList.add('fa-moon');
                    }
                });
            </script>
        </body>

        </html>