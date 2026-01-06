<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <fmt:setLocale value="es" />
        <fmt:setBundle basename="mensajes" />

        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>
                <fmt:message key="titulo.servicios" /> - Academia NivelA1
            </title>
            <link rel="icon" type="image/png" href="img/LOGOS.png" />

            <!-- Bootstrap CSS -->
            <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">

            <!-- Google Fonts -->
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">

            <!-- Font Awesome -->
            <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>

            <style>
                :root {
                    --primary-color: #000d83;
                    --secondary-color: #3ec4ff;
                    --accent-color: #ff5d5d;
                    --dark-bg: #0d0541;
                    --light-bg: #F1F4FD;
                    --text-dark: #1a1a2e;
                    --text-light: #6c757d;
                    --white: #ffffff;
                    --card-bg: #ffffff;
                    --navbar-bg: rgba(255, 255, 255, 0.95);
                    --gradient-hero: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                    --shadow-sm: 0 2px 10px rgba(0, 0, 0, 0.05);
                    --shadow-md: 0 5px 20px rgba(0, 0, 0, 0.1);
                    --shadow-lg: 0 10px 40px rgba(0, 0, 0, 0.15);
                }

                /* Dark Mode Variables */
                [data-theme="dark"] {
                    --light-bg: #0f0f23;
                    --text-dark: #e0e0e0;
                    --text-light: #b0b0b0;
                    --card-bg: #1a1a2e;
                    --navbar-bg: rgba(26, 26, 46, 0.95);
                    --shadow-sm: 0 2px 10px rgba(0, 0, 0, 0.3);
                    --shadow-md: 0 5px 20px rgba(0, 0, 0, 0.4);
                    --shadow-lg: 0 10px 40px rgba(0, 0, 0, 0.5);
                }

                /* Theme Toggle Button */
                .theme-toggle {
                    width: 45px;
                    height: 45px;
                    border-radius: 50%;
                    background: var(--gradient-hero);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    margin-left: 1rem;
                    transition: all 0.3s ease;
                    box-shadow: var(--shadow-md);
                }

                .theme-toggle:hover {
                    transform: scale(1.1);
                    box-shadow: var(--shadow-lg);
                }

                .theme-toggle i {
                    color: var(--white);
                    font-size: 1.2rem;
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
                    animation: pulse-social 2s infinite;
                }

                .social-whatsapp:hover i {
                    color: white;
                }

                @keyframes pulse-social {

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

                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Poppins', sans-serif;
                    background-color: var(--light-bg);
                    color: var(--text-dark);
                    overflow-x: hidden;
                }

                /* NAVBAR */
                .navbar-modern {
                    background: var(--navbar-bg);
                    backdrop-filter: blur(10px);
                    box-shadow: var(--shadow-sm);
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

                .navbar-brand-modern {
                    font-size: 1.8rem;
                    font-weight: 800;
                    background: var(--gradient-hero);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                }

                .nav-link-modern {
                    color: var(--text-dark) !important;
                    font-weight: 500;
                    padding: 0.5rem 1rem !important;
                    margin: 0 0.25rem;
                    border-radius: 8px;
                    transition: all 0.3s ease;
                }

                .nav-link-modern:hover,
                .nav-link-modern.active {
                    color: var(--secondary-color) !important;
                    background: rgba(62, 196, 255, 0.1);
                }

                /* HERO SECTION */
                .hero-services {
                    background: var(--gradient-hero);
                    padding: 4rem 0;
                    color: var(--white);
                    text-align: center;
                }

                .hero-services h1 {
                    font-size: clamp(2rem, 5vw, 3.5rem);
                    font-weight: 900;
                    margin-bottom: 1rem;
                }

                .hero-services p {
                    font-size: 1.2rem;
                    max-width: 700px;
                    margin: 0 auto 2rem;
                    opacity: 0.95;
                }

                /* TEACHER SECTIONS */
                .teacher-section {
                    padding: 4rem 0;
                }

                .section-title {
                    font-size: 2rem;
                    font-weight: 800;
                    color: var(--primary-color);
                    margin-bottom: 2.5rem;
                    padding-bottom: 1rem;
                    border-bottom: 3px solid var(--secondary-color);
                    display: inline-block;
                }

                .teacher-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                    gap: 2rem;
                    margin-bottom: 3rem;
                }

                .teacher-card {
                    background: var(--card-bg);
                    border-radius: 20px;
                    overflow: hidden;
                    box-shadow: var(--shadow-md);
                    transition: all 0.3s ease;
                    cursor: pointer;
                }

                .teacher-card:hover {
                    transform: translateY(-10px);
                    box-shadow: var(--shadow-lg);
                }

                .teacher-image {
                    width: 100%;
                    height: 280px;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    position: relative;
                    overflow: hidden;
                }

                .teacher-image img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .teacher-image::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(180deg, transparent 0%, rgba(0, 0, 0, 0.3) 100%);
                }

                .teacher-info {
                    padding: 1.5rem;
                    text-align: center;
                }

                .teacher-name {
                    font-size: 1.2rem;
                    font-weight: 700;
                    color: var(--text-dark);
                    margin-bottom: 0.5rem;
                }

                .teacher-subject {
                    font-size: 0.9rem;
                    color: var(--text-light);
                    font-weight: 500;
                }

                /* PROGRAMS SECTION */
                .programs-section {
                    padding: 5rem 0;
                    background: var(--light-bg);
                }

                .section-title-main {
                    font-size: 2.5rem;
                    font-weight: 800;
                    color: var(--text-dark);
                    text-align: center;
                    margin-bottom: 3rem;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                }

                .programs-wrapper {
                    display: flex;
                    gap: 3rem;
                    align-items: center;
                    max-width: 1400px;
                    margin: 0 auto;
                }

                .programs-grid {
                    display: grid;
                    grid-template-columns: repeat(2, 1fr);
                    gap: 1rem;
                    flex: 1;
                }

                .programs-image {
                    flex-shrink: 0;
                    width: 350px;
                }

                .programs-image img {
                    width: 100%;
                    height: auto;
                    border-radius: 20px;
                    box-shadow: var(--shadow-lg);
                    transition: all 0.4s ease;
                }

                .programs-image img:hover {
                    transform: scale(1.05);
                    box-shadow: 0 20px 60px rgba(0, 13, 131, 0.3);
                }

                .program-card {
                    position: relative;
                    background: linear-gradient(135deg, rgba(44, 62, 80, 0.9) 0%, rgba(52, 73, 94, 0.9) 100%),
                        url('img/fondo.png') center/cover;
                    padding: 1rem 1.5rem;
                    border-radius: 10px 0 10px 0;
                    color: var(--white);
                    min-height: 70px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    overflow: hidden;
                    transition: all 0.3s ease;
                    box-shadow: var(--shadow-md);
                    clip-path: polygon(0 0, 85% 0, 100% 50%, 85% 100%, 0 100%);
                    cursor: pointer;
                }

                .program-card::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(255, 255, 255, 0) 100%);
                    opacity: 0;
                    transition: opacity 0.3s ease;
                }

                .program-card:hover {
                    transform: translateX(10px);
                    box-shadow: var(--shadow-lg);
                }

                .program-card:hover::before {
                    opacity: 1;
                }

                .program-card-cyan {
                    background: linear-gradient(135deg, rgba(0, 188, 212, 0.9) 0%, rgba(0, 172, 193, 0.9) 100%),
                        url('img/fondo.png') center/cover;
                }

                .program-card-light {
                    background: linear-gradient(135deg, rgba(224, 224, 224, 0.9) 0%, rgba(189, 189, 189, 0.9) 100%),
                        url('img/fondo.png') center/cover;
                    color: var(--text-dark);
                }

                .program-card-purple {
                    background: linear-gradient(135deg, rgba(123, 31, 162, 0.9) 0%, rgba(106, 27, 154, 0.9) 100%),
                        url('img/fondo.png') center/cover;
                }

                .program-card-dark-purple {
                    background: linear-gradient(135deg, rgba(74, 20, 140, 0.9) 0%, rgba(49, 27, 146, 0.9) 100%),
                        url('img/fondo.png') center/cover;
                }

                .program-content {
                    text-align: center;
                    z-index: 2;
                    position: relative;
                }

                .program-content h3 {
                    font-size: 1rem;
                    font-weight: 800;
                    margin: 0 0 0.2rem 0;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                .program-content p {
                    font-size: 0.7rem;
                    margin: 0;
                    opacity: 0.9;
                    font-weight: 500;
                }

                /* Teachers Header */
                .teachers-header {
                    padding: 4rem 0 2rem;
                    background: var(--light-bg);
                    text-align: center;
                }

                .teachers-header .section-title-main {
                    color: var(--primary-color);
                    margin-bottom: 1rem;
                }

                .section-subtitle {
                    font-size: 1.1rem;
                    color: var(--text-light);
                    max-width: 600px;
                    margin: 1rem auto 0;
                }

                /* Modal Styles */
                .scholarship-modal {
                    display: none;
                    position: fixed;
                    z-index: 9999;
                    left: 0;
                    top: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.8);
                    animation: fadeIn 0.3s ease;
                }

                .scholarship-modal.active {
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .modal-content {
                    background: var(--card-bg);
                    border-radius: 25px;
                    max-width: 700px;
                    width: 90%;
                    max-height: 85vh;
                    overflow-y: auto;
                    box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
                    animation: slideUp 0.4s ease;
                    position: relative;
                    scrollbar-width: none;
                    /* Firefox */
                    -ms-overflow-style: none;
                    /* IE and Edge */
                }

                .modal-content::-webkit-scrollbar {
                    display: none;
                    /* Chrome, Safari, Opera */
                }

                .modal-header {
                    background: var(--gradient-hero);
                    color: var(--white);
                    padding: 2.5rem;
                    border-radius: 25px 25px 0 0;
                    position: relative;
                }

                .modal-header h2 {
                    margin: 0;
                    font-size: 2rem;
                    font-weight: 800;
                }

                .modal-close {
                    position: absolute;
                    top: 1.5rem;
                    right: 1.5rem;
                    background: rgba(255, 255, 255, 0.2);
                    border: none;
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    cursor: pointer;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    transition: all 0.3s ease;
                    color: var(--white);
                    font-size: 1.5rem;
                }

                .modal-close:hover {
                    background: rgba(255, 255, 255, 0.3);
                    transform: rotate(90deg);
                }

                .modal-body {
                    padding: 2.5rem;
                    color: var(--text-dark);
                }

                .modal-section {
                    margin-bottom: 2rem;
                }

                .modal-section h3 {
                    color: var(--primary-color);
                    font-size: 1.3rem;
                    font-weight: 700;
                    margin-bottom: 1rem;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .modal-section h3 i {
                    color: var(--secondary-color);
                }

                .modal-section p,
                .modal-section ul {
                    color: var(--text-light);
                    line-height: 1.8;
                    margin: 0;
                }

                .modal-section ul {
                    padding-left: 1.5rem;
                }

                .modal-section ul li {
                    margin-bottom: 0.5rem;
                }

                .modal-highlight {
                    background: linear-gradient(135deg, rgba(62, 196, 255, 0.1) 0%, rgba(0, 13, 131, 0.1) 100%);
                    padding: 1.5rem;
                    border-radius: 15px;
                    border-left: 4px solid var(--secondary-color);
                    margin-top: 1rem;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                    }

                    to {
                        opacity: 1;
                    }
                }

                @keyframes slideUp {
                    from {
                        transform: translateY(50px);
                        opacity: 0;
                    }

                    to {
                        transform: translateY(0);
                        opacity: 1;
                    }
                }

                /* FOOTER */
                .footer-modern {
                    background: var(--dark-bg);
                    color: var(--white);
                    padding: 4rem 0 2rem;
                }

                .footer-logo {
                    font-size: 1.8rem;
                    font-weight: 800;
                    background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    background-clip: text;
                    margin-bottom: 1rem;
                }

                .footer-text {
                    color: rgba(255, 255, 255, 0.7);
                    line-height: 1.7;
                }

                .footer-title {
                    font-size: 1.2rem;
                    font-weight: 700;
                    margin-bottom: 1.5rem;
                }

                .footer-link {
                    color: rgba(255, 255, 255, 0.7);
                    text-decoration: none;
                    display: block;
                    margin-bottom: 0.75rem;
                    transition: all 0.3s ease;
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
                    width: 45px;
                    height: 45px;
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
                    margin-top: 3rem;
                    padding-top: 2rem;
                    text-align: center;
                    color: rgba(255, 255, 255, 0.6);
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
                        animation: pulse-social 2s infinite;
                    }

                    .social-whatsapp i {
                        color: white !important;
                    }

                    /* Becas section optimization */
                    .programs-wrapper {
                        flex-direction: column;
                        gap: 2rem;
                    }

                    .programs-grid {
                        grid-template-columns: 1fr;
                        gap: 1.5rem;
                    }

                    .programs-image {
                        display: none;
                    }

                    .program-card {
                        min-height: 90px;
                        padding: 1.5rem 2rem;
                    }

                    .program-content h3 {
                        font-size: 1.1rem;
                    }

                    .program-content p {
                        font-size: 0.85rem;
                    }

                    /* Teachers section */
                    .teacher-grid {
                        grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                        gap: 1.5rem;
                    }

                    .hero-services {
                        padding: 3rem 0;
                    }

                    .teacher-section {
                        padding: 3rem 0;
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
            <nav class="navbar navbar-modern navbar-expand-lg">
                <div class="container">
                    <a class="navbar-brand navbar-brand-modern" href="index.jsp">NivelA1</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto">
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern" href="index.jsp">Inicio</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern active" href="servicios.jsp">
                                    <fmt:message key="titulo.servicios" />
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link nav-link-modern" href="ciclos.jsp">Ciclos</a>
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
            <section class="hero-services">
                <div class="container">
                    <h1>Nuestros Servicios</h1>
                    <p>Programas de preparación diseñados para tu éxito académico</p>
                </div>
            </section>

            <!-- PROGRAMS SECTION -->
            <section class="programs-section" id="becas">
                <div class="container">
                    <h2 class="section-title-main">Preparamos Becas</h2>
                    <div class="programs-wrapper">
                        <div class="programs-grid">
                            <div class="program-card" onclick="openModal('piura450')" data-aos="fade-up"
                                data-aos-delay="100">
                                <div class="program-content">
                                    <h3>BECA PIURA 450</h3>
                                </div>
                                <div class="program-arrow"></div>
                            </div>

                            <div class="program-card program-card-cyan" onclick="openModal('udepIEP')"
                                data-aos="fade-up" data-aos-delay="200">
                                <div class="program-content">
                                    <h3>BECA UDEP</h3>
                                    <p>Instituciones Públicas y Privadas - IEP</p>
                                </div>
                                <div class="program-arrow"></div>
                            </div>

                            <div class="program-card" onclick="openModal('semibecas')" data-aos="fade-up"
                                data-aos-delay="300">
                                <div class="program-content">
                                    <h3>BECAS SEMIBECAS</h3>
                                </div>
                                <div class="program-arrow"></div>
                            </div>

                            <div class="program-card program-card-light" onclick="openModal('pae')" data-aos="fade-up"
                                data-aos-delay="100">
                                <div class="program-content">
                                    <h3>PAE</h3>
                                    <p>Prueba de Aptitud Escolar</p>
                                </div>
                                <div class="program-arrow"></div>
                            </div>

                            <div class="program-card program-card-purple" onclick="openModal('taa')" data-aos="fade-up"
                                data-aos-delay="200">
                                <div class="program-content">
                                    <h3>TAA</h3>
                                    <p>Test de Aptitud Académica</p>
                                </div>
                                <div class="program-arrow"></div>
                            </div>

                            <div class="program-card program-card-dark-purple" onclick="openModal('udepHijo')"
                                data-aos="fade-up" data-aos-delay="300">
                                <div class="program-content">
                                    <h3>BECA UDEP</h3>
                                    <p>Hijo/Docente</p>
                                </div>
                                <div class="program-arrow"></div>
                            </div>
                        </div>

                        <div class="programs-image" data-aos="fade-left">
                            <img src="img/fondo_2.png" alt="Estudiantes NivelA1">
                        </div>
                    </div>
                </div>
            </section>

            <!-- TEACHERS HEADER -->
            <section class="teachers-header" id="docentes">
                <div class="container">
                    <h2 class="section-title-main">Nuestros Docentes</h2>
                    <p class="section-subtitle">Conoce al equipo de profesionales que te guiarán hacia el éxito
                        académico</p>
                </div>
            </section>

            <!-- ARITMÉTICA SECTION -->
            <section class="teacher-section">
                <div class="container">
                    <h2 class="section-title">Aritmética</h2>
                    <div class="teacher-grid">
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Ernesto Chamorro</div>
                                <div class="teacher-subject">Aritmética</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">André Usaqui</div>
                                <div class="teacher-subject">Aritmética</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Dennis Ayarquispe</div>
                                <div class="teacher-subject">Aritmética</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Jean Paul Barrionuevo</div>
                                <div class="teacher-subject">Aritmética</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ÁLGEBRA SECTION -->
            <section class="teacher-section" style="background: var(--white);">
                <div class="container">
                    <h2 class="section-title">Álgebra</h2>
                    <div class="teacher-grid">
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Renzo Soto</div>
                                <div class="teacher-subject">Álgebra</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Yhon Figueroa</div>
                                <div class="teacher-subject">Álgebra</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Ronald Mamani</div>
                                <div class="teacher-subject">Álgebra</div>
                            </div>
                        </div>
                        <div class="teacher-card">
                            <div class="teacher-image">
                                <img src="img/teacher-placeholder.jpg" alt="Profesor"
                                    onerror="this.style.display='none'">
                            </div>
                            <div class="teacher-info">
                                <div class="teacher-name">Luis Cantos</div>
                                <div class="teacher-subject">Álgebra</div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- SCHOLARSHIP MODALS -->

            <!-- BECA PIURA 450 Modal -->
            <div id="piura450Modal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>BECA PIURA 450</h2>
                        <button class="modal-close" onclick="closeModal('piura450')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Iniciativa de la Asociación Civil Piura 450 en alianza con la UDEP, destinada a jóvenes
                                con alto rendimiento académico y vocación para la docencia.</p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>100% de cobertura en pensiones académicas</li>
                                <li>Formación en Facultad de Ciencias de la Educación</li>
                                <li>Carreras: Educación Inicial, Primaria y Secundaria</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>Estudiante de 5° secundaria o egresado</li>
                                <li>Máximo 18 años</li>
                                <li>Alto rendimiento académico</li>
                                <li>Vocación para la docencia</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Fechas 2026</h3>
                            <div class="modal-highlight">
                                <p><strong>Próximas convocatorias:</strong> Consulta UDEP Conecta para fechas exactas
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- BECA UDEP IEP Modal -->
            <div id="udepIEPModal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>BECA UDEP - IEP</h2>
                        <button class="modal-close" onclick="closeModal('udepIEP')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Beca para estudiantes destacados de Instituciones Educativas Públicas y Privadas con
                                excelencia académica y necesidad económica.</p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>Cobertura parcial o total de pensiones</li>
                                <li>Acceso a todas las carreras UDEP</li>
                                <li>Apoyo académico personalizado</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>Alumno de 5° o egresado (máx. 18 años)</li>
                                <li>Capacidad académica y humana</li>
                                <li>Necesidad económica comprobable</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Fechas 2026-I</h3>
                            <div class="modal-highlight">
                                <p><strong>Regularización:</strong> Hasta 15 enero 2026</p>
                                <p><strong>Inicio:</strong> Marzo 2026</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- BECAS SEMIBECAS Modal -->
            <div id="semibecasModal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>BECAS Y SEMIBECAS UDEP</h2>
                        <button class="modal-close" onclick="closeModal('semibecas')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Programa de ayuda económica UDEP para estudiantes con alto rendimiento sin recursos
                                suficientes.</p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>Becas (100%) o Semibecas (parcial)</li>
                                <li>Todas las carreras UDEP</li>
                                <li>Programa de apoyo estudiantil</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>5° secundaria o egresado (máx. 18 años)</li>
                                <li>Capacidad académica y humana</li>
                                <li>Necesidad económica</li>
                                <li>Aprobar evaluaciones (académica y socioeconómica)</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Fechas 2026-I</h3>
                            <div class="modal-highlight">
                                <p><strong>Regularización:</strong> Hasta 15 enero 2026</p>
                                <p><strong>Inicio:</strong> Marzo 2026</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- PAE Modal -->
            <div id="paeModal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>PAE - Prueba de Aptitud Escolar</h2>
                        <button class="modal-close" onclick="closeModal('pae')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Examen de admisión anticipada UDEP para estudiantes de 4° y 5° de secundaria.</p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>Admisión anticipada a la UDEP</li>
                                <li>Alumnos de 5°: inician en marzo siguiente</li>
                                <li>Alumnos de 4°: aseguran vacante</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>Cursar 4° o 5° de secundaria</li>
                                <li>Documentación completa (DNI, notas, foto)</li>
                                <li>Puntaje mínimo en examen</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Fechas 2025</h3>
                            <div class="modal-highlight">
                                <p><strong>Inscripciones:</strong> 22 julio - 14 agosto 2025</p>
                                <p><strong>Examen:</strong> Agosto 2025</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TAA Modal -->
            <div id="taaModal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>TAA - Test de Aptitud Académica</h2>
                        <button class="modal-close" onclick="closeModal('taa')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Examen de admisión regular de la Universidad de Piura que evalúa capacidades académicas.
                            </p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>Modalidad de admisión regular</li>
                                <li>Acceso a todas las carreras</li>
                                <li>Evaluaciones todo el año</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>Secundaria culminada o cursando 5°</li>
                                <li>Documentación completa</li>
                                <li>Aprobar con puntaje mínimo</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Fechas 2026-I</h3>
                            <div class="modal-highlight">
                                <p><strong>Examen:</strong> 9 enero 2026</p>
                                <p><strong>Lima:</strong> Cierre 7 enero (5pm)</p>
                                <p><strong>Piura:</strong> Cierre 4 enero</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- BECA UDEP Hijo/Docente Modal -->
            <div id="udepHijoModal" class="scholarship-modal">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2>BECA UDEP - Hijo/Docente</h2>
                        <button class="modal-close" onclick="closeModal('udepHijo')">×</button>
                    </div>
                    <div class="modal-body">
                        <div class="modal-section">
                            <h3><i class="fas fa-graduation-cap"></i> ¿Qué es?</h3>
                            <p>Beca especial para hijos de docentes y personal de instituciones educativas con convenio
                                UDEP.</p>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-star"></i> Beneficios</h3>
                            <ul>
                                <li>Descuento especial en pensiones</li>
                                <li>Acceso preferencial a carreras</li>
                                <li>Proceso simplificado</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-clipboard-check"></i> Requisitos</h3>
                            <ul>
                                <li>Hijo/a de docente con convenio UDEP</li>
                                <li>Documentación de relación laboral</li>
                                <li>Requisitos académicos de admisión</li>
                            </ul>
                        </div>
                        <div class="modal-section">
                            <h3><i class="fas fa-calendar-alt"></i> Información</h3>
                            <div class="modal-highlight">
                                <p>Consulta con Oficina de Admisión UDEP para plazos específicos de tu institución</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                            <a href="#becas" class="footer-link">Preparamos Becas</a>
                            <a href="#docentes" class="footer-link">Nuestros Docentes</a>
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

            <!-- Theme Toggle Script -->
            <script>
                // Theme Toggle Functionality
                const themeToggle = document.getElementById('themeToggle');
                const themeIcon = document.getElementById('themeIcon');
                const htmlElement = document.documentElement;

                // Check for saved theme preference or default to 'light'
                const currentTheme = localStorage.getItem('theme') || 'light';
                htmlElement.setAttribute('data-theme', currentTheme);

                // Update icon based on current theme
                if (currentTheme === 'dark') {
                    themeIcon.classList.remove('fa-moon');
                    themeIcon.classList.add('fa-sun');
                }

                // Toggle theme on button click
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

            <!-- Modal Control Script -->
            <script>
                function openModal(modalId) {
                    const modal = document.getElementById(modalId + 'Modal');
                    if (modal) {
                        modal.classList.add('active');
                        document.body.style.overflow = 'hidden';
                    }
                }

                function closeModal(modalId) {
                    const modal = document.getElementById(modalId + 'Modal');
                    if (modal) {
                        modal.classList.remove('active');
                        document.body.style.overflow = 'auto';
                    }
                }

                // Close modal when clicking outside
                window.onclick = function (event) {
                    if (event.target.classList.contains('scholarship-modal')) {
                        event.target.classList.remove('active');
                        document.body.style.overflow = 'auto';
                    }
                }

                // Close modal with ESC key
                document.addEventListener('keydown', function (event) {
                    if (event.key === 'Escape') {
                        const activeModal = document.querySelector('.scholarship-modal.active');
                        if (activeModal) {
                            activeModal.classList.remove('active');
                            document.body.style.overflow = 'auto';
                        }
                    }
                });
            </script>
        </body>

        </html>