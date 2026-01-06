<%@ page contentType="text/html; charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <fmt:setLocale value="es" />
            <fmt:setBundle basename="mensajes" />
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <title>
                    <fmt:message key="titulo.intranet" /> - Academia NivelA1
                </title>
                <link rel="icon" type="image/png" href="img/LOGOS.png" />
                <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
                <link
                    href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
                    rel="stylesheet">
                <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>
                <style>
                    :root {
                        --primary-color: #000d83;
                        --secondary-color: #3ec4ff;
                        --gradient-hero: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
                        --white: #ffffff;
                        --shadow-lg: 0 10px 40px rgba(0, 0, 0, 0.15);
                        --shadow-xl: 0 20px 60px rgba(0, 0, 0, 0.2);
                    }

                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: 'Poppins', sans-serif;
                        min-height: 100vh;
                        background: var(--gradient-hero);
                        position: relative;
                        overflow: hidden;
                    }

                    /* Animated Background Pattern */
                    body::before {
                        content: '';
                        position: absolute;
                        top: 0;
                        left: 0;
                        right: 0;
                        bottom: 0;
                        background: url('data:image/svg+xml,<svg width="100" height="100" xmlns="http://www.w3.org/2000/svg"><defs><pattern id="grid" width="100" height="100" patternUnits="userSpaceOnUse"><path d="M 100 0 L 0 0 0 100" fill="none" stroke="rgba(255,255,255,0.05)" stroke-width="1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grid)"/></svg>');
                        opacity: 0.3;
                        animation: moveGrid 20s linear infinite;
                    }

                    @keyframes moveGrid {
                        0% {
                            transform: translate(0, 0);
                        }

                        100% {
                            transform: translate(50px, 50px);
                        }
                    }

                    /* Floating Orbs */
                    .orb {
                        position: absolute;
                        border-radius: 50%;
                        background: rgba(255, 255, 255, 0.1);
                        backdrop-filter: blur(20px);
                        animation: float 15s ease-in-out infinite;
                    }

                    .orb-1 {
                        width: 300px;
                        height: 300px;
                        top: -150px;
                        left: -150px;
                        animation-delay: 0s;
                    }

                    .orb-2 {
                        width: 200px;
                        height: 200px;
                        bottom: -100px;
                        right: -100px;
                        animation-delay: 5s;
                    }

                    .orb-3 {
                        width: 150px;
                        height: 150px;
                        top: 50%;
                        right: 10%;
                        animation-delay: 10s;
                    }

                    @keyframes float {

                        0%,
                        100% {
                            transform: translate(0, 0) scale(1);
                        }

                        33% {
                            transform: translate(30px, -30px) scale(1.1);
                        }

                        66% {
                            transform: translate(-20px, 20px) scale(0.9);
                        }
                    }

                    .login-container {
                        position: relative;
                        z-index: 10;
                        min-height: 100vh;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        padding: 2rem;
                    }

                    .login-card {
                        background: rgba(255, 255, 255, 0.95);
                        backdrop-filter: blur(20px);
                        border-radius: 30px;
                        box-shadow: var(--shadow-xl);
                        width: 100%;
                        max-width: 480px;
                        padding: 3rem 2.5rem;
                        animation: slideUp 0.8s ease;
                        border: 1px solid rgba(255, 255, 255, 0.3);
                    }

                    @keyframes slideUp {
                        from {
                            opacity: 0;
                            transform: translateY(30px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    .logo-container {
                        text-align: center;
                        margin-bottom: 2rem;
                    }

                    .logo-img {
                        width: 80px;
                        height: 80px;
                        object-fit: contain;
                        margin-bottom: 1rem;
                        animation: fadeIn 0.8s ease 0.2s both;
                    }

                    @keyframes fadeIn {
                        from {
                            opacity: 0;
                        }

                        to {
                            opacity: 1;
                        }
                    }

                    .brand-name {
                        font-size: 2rem;
                        font-weight: 800;
                        background: var(--gradient-hero);
                        -webkit-background-clip: text;
                        -webkit-text-fill-color: transparent;
                        background-clip: text;
                        margin-bottom: 0.5rem;
                        animation: fadeIn 0.8s ease 0.3s both;
                    }

                    .brand-tagline {
                        color: #6c757d;
                        font-size: 0.95rem;
                        font-weight: 400;
                        animation: fadeIn 0.8s ease 0.4s both;
                    }

                    .welcome-text {
                        text-align: center;
                        margin-bottom: 2rem;
                        animation: fadeIn 0.8s ease 0.5s both;
                    }

                    .welcome-text h2 {
                        font-size: 1.5rem;
                        font-weight: 700;
                        color: var(--primary-color);
                        margin-bottom: 0.5rem;
                    }

                    .welcome-text p {
                        color: #6c757d;
                        font-size: 0.9rem;
                    }

                    .form-group {
                        margin-bottom: 1.5rem;
                        animation: fadeIn 0.8s ease 0.6s both;
                    }

                    .form-label {
                        display: block;
                        font-weight: 600;
                        color: var(--primary-color);
                        margin-bottom: 0.5rem;
                        font-size: 0.9rem;
                    }

                    .input-wrapper {
                        position: relative;
                    }

                    .input-icon {
                        position: absolute;
                        left: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        color: #6c757d;
                        font-size: 1.1rem;
                    }

                    .form-control {
                        width: 100%;
                        padding: 1rem 1rem 1rem 3rem;
                        border: 2px solid #e0e0e0;
                        border-radius: 15px;
                        font-size: 0.95rem;
                        transition: all 0.3s ease;
                        background: var(--white);
                    }

                    .form-control:focus {
                        outline: none;
                        border-color: var(--secondary-color);
                        box-shadow: 0 0 0 4px rgba(62, 196, 255, 0.1);
                    }

                    .password-toggle {
                        position: absolute;
                        right: 1rem;
                        top: 50%;
                        transform: translateY(-50%);
                        background: none;
                        border: none;
                        color: #6c757d;
                        cursor: pointer;
                        font-size: 1.1rem;
                        transition: color 0.3s ease;
                    }

                    .password-toggle:hover {
                        color: var(--secondary-color);
                    }

                    .btn-login {
                        width: 100%;
                        padding: 1rem;
                        background: var(--gradient-hero);
                        color: var(--white);
                        border: none;
                        border-radius: 15px;
                        font-size: 1rem;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        box-shadow: 0 5px 20px rgba(0, 13, 131, 0.3);
                        animation: fadeIn 0.8s ease 0.7s both;
                    }

                    .btn-login:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 8px 30px rgba(0, 13, 131, 0.4);
                    }

                    .btn-login:active {
                        transform: translateY(0);
                    }

                    .alert {
                        border-radius: 15px;
                        padding: 1rem 1.25rem;
                        margin-bottom: 1.5rem;
                        border: none;
                        display: flex;
                        align-items: center;
                        gap: 0.75rem;
                        animation: shake 0.5s ease;
                    }

                    @keyframes shake {

                        0%,
                        100% {
                            transform: translateX(0);
                        }

                        25% {
                            transform: translateX(-10px);
                        }

                        75% {
                            transform: translateX(10px);
                        }
                    }

                    .alert-danger {
                        background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
                        color: #c62828;
                    }

                    .alert-warning {
                        background: linear-gradient(135deg, #fff8e1 0%, #ffe082 100%);
                        color: #f57c00;
                    }

                    .alert i {
                        font-size: 1.2rem;
                    }

                    .divider {
                        text-align: center;
                        margin: 2rem 0 1.5rem;
                        position: relative;
                    }

                    .divider::before {
                        content: '';
                        position: absolute;
                        left: 0;
                        top: 50%;
                        width: 100%;
                        height: 1px;
                        background: #e0e0e0;
                    }

                    .divider span {
                        background: rgba(255, 255, 255, 0.95);
                        padding: 0 1rem;
                        position: relative;
                        color: #6c757d;
                        font-size: 0.85rem;
                    }

                    .back-home {
                        text-align: center;
                        margin-top: 1.5rem;
                        animation: fadeIn 0.8s ease 0.8s both;
                    }

                    .back-home a {
                        color: var(--primary-color);
                        text-decoration: none;
                        font-weight: 500;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        transition: all 0.3s ease;
                    }

                    .back-home a:hover {
                        color: var(--secondary-color);
                        gap: 0.75rem;
                    }

                    /* Responsive */
                    @media (max-width: 576px) {
                        .login-card {
                            padding: 2rem 1.5rem;
                        }

                        .brand-name {
                            font-size: 1.75rem;
                        }

                        .welcome-text h2 {
                            font-size: 1.25rem;
                        }
                    }

                    /* Loading State */
                    .btn-login.loading {
                        position: relative;
                        color: transparent;
                    }

                    .btn-login.loading::after {
                        content: '';
                        position: absolute;
                        width: 20px;
                        height: 20px;
                        top: 50%;
                        left: 50%;
                        margin-left: -10px;
                        margin-top: -10px;
                        border: 3px solid rgba(255, 255, 255, 0.3);
                        border-top-color: white;
                        border-radius: 50%;
                        animation: spin 0.8s linear infinite;
                    }

                    @keyframes spin {
                        to {
                            transform: rotate(360deg);
                        }
                    }
                </style>
            </head>

            <body>
                <!-- Floating Orbs -->
                <div class="orb orb-1"></div>
                <div class="orb orb-2"></div>
                <div class="orb orb-3"></div>

                <div class="login-container">
                    <div class="login-card">
                        <!-- Logo & Brand -->
                        <div class="logo-container">
                            <img src="img/LOGOS.png" alt="Logo Academia NivelA1" class="logo-img">
                            <div class="brand-name">NivelA1</div>
                            <p class="brand-tagline">Tu academia de confianza</p>
                        </div>

                        <!-- Welcome Text -->
                        <div class="welcome-text">
                            <h2>¡Bienvenido de vuelta!</h2>
                            <p>Ingresa tus credenciales para acceder</p>
                        </div>

                        <!-- Alerts -->
                        <c:if test="${param.error == 'credenciales'}">
                            <div class="alert alert-danger">
                                <i class="fas fa-exclamation-circle"></i>
                                <span>
                                    <fmt:message key="error.credenciales" />
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${param.error == 'rol'}">
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle"></i>
                                <span>
                                    <fmt:message key="error.rol" />
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${param.error == 'sesion'}">
                            <div class="alert alert-warning">
                                <i class="fas fa-clock"></i>
                                <span>Tu sesión ha expirado. Por favor inicia sesión nuevamente.</span>
                            </div>
                        </c:if>
                        <c:if test="${param.error == 'permisos'}">
                            <div class="alert alert-danger">
                                <i class="fas fa-lock"></i>
                                <span>No tienes permisos para acceder a esa sección.</span>
                            </div>
                        </c:if>

                        <!-- Login Form -->
                        <form action="${pageContext.request.contextPath}/LoginServlet" method="post" id="loginForm">
                            <div class="form-group">
                                <label for="correo" class="form-label">Correo Electrónico</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-envelope input-icon"></i>
                                    <input type="email" class="form-control" id="correo" name="correo" required
                                        placeholder="ejemplo@correo.com" autocomplete="email" />
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="password" class="form-label">Contraseña</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-lock input-icon"></i>
                                    <input type="password" class="form-control" id="password" name="password" required
                                        placeholder="Ingresa tu contraseña" autocomplete="current-password" />
                                    <button type="button" class="password-toggle" onclick="togglePassword()"
                                        tabindex="-1">
                                        <i class="fas fa-eye" id="passwordIcon"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="submit" class="btn-login" id="loginBtn">
                                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
                            </button>
                        </form>

                        <!-- Divider -->
                        <div class="divider">
                            <span>o</span>
                        </div>

                        <!-- Back to Home -->
                        <div class="back-home">
                            <a href="index.jsp">
                                <i class="fas fa-arrow-left"></i>
                                Volver al inicio
                            </a>
                        </div>
                    </div>
                </div>

                <script>
                    function togglePassword() {
                        const passwordField = document.getElementById('password');
                        const passwordIcon = document.getElementById('passwordIcon');

                        if (passwordField.type === 'password') {
                            passwordField.type = 'text';
                            passwordIcon.className = 'fas fa-eye-slash';
                        } else {
                            passwordField.type = 'password';
                            passwordIcon.className = 'fas fa-eye';
                        }
                    }

                    // Add loading state on form submit
                    document.getElementById('loginForm').addEventListener('submit', function () {
                        const btn = document.getElementById('loginBtn');
                        btn.classList.add('loading');
                        btn.disabled = true;
                    });

                    // Add enter key support for password toggle
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Enter' && document.activeElement.id !== 'loginBtn') {
                            e.preventDefault();
                            document.getElementById('loginForm').requestSubmit();
                        }
                    });
                </script>
            </body>

            </html>