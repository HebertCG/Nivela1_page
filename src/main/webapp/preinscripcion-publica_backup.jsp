<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Preinscripcion - Academia Nivel A1</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <style>
            :root {
                --primary: #8B5CF6;
                --primary-dark: #7C3AED;
                --secondary: #14B8A6;
                --bg: #F9FAFB;
            }

            body {
                font-family: "Segoe UI", system-ui, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 2rem 1rem;
            }

            .form-container {
                background: white;
                border-radius: 24px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                max-width: 600px;
                width: 100%;
                padding: 3rem;
            }

            .logo-section {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo-icon {
                width: 80px;
                height: 80px;
                background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                border-radius: 20px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 2.5rem;
                font-weight: bold;
                margin-bottom: 1rem;
            }

            .form-title {
                font-size: 2rem;
                font-weight: 700;
                color: #1A1A1A;
                margin-bottom: 0.5rem;
            }

            .form-subtitle {
                color: #6B7280;
                margin-bottom: 2rem;
            }

            .form-label {
                font-weight: 600;
                color: #374151;
                margin-bottom: 0.5rem;
            }

            .form-control,
            .form-select {
                border: 2px solid #E5E7EB;
                border-radius: 12px;
                padding: 0.875rem 1rem;
                transition: all 0.3s ease;
            }

            .form-control:focus,
            .form-select:focus {
                border-color: var(--primary);
                box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.1);
            }

            .btn-submit {
                background: linear-gradient(135deg, var(--primary), var(--primary-dark));
                border: none;
                color: white;
                padding: 1rem 2rem;
                border-radius: 12px;
                font-weight: 600;
                font-size: 1.1rem;
                width: 100%;
                transition: all 0.3s ease;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 12px 24px rgba(139, 92, 246, 0.4);
            }

            .success-message {
                background: #D1FAE5;
                border: 2px solid #10B981;
                border-radius: 12px;
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                display: none;
            }

            .success-message.show {
                display: block;
            }

            .success-icon {
                width: 48px;
                height: 48px;
                background: #10B981;
                border-radius: 50%;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5rem;
                margin-bottom: 1rem;
            }
        </style>
    </head>

    <body>
        <div class="form-container">
            <div class="logo-section">
                <div class="logo-icon">A1</div>
                <h1 class="form-title">Preinscripcion</h1>
                <p class="form-subtitle">Academia Nivel A1 - Completa tus datos para preinscribirte</p>
            </div>

            <div class="success-message ${param.success == 'true' ? 'show' : ''}">
                <div class="text-center">
                    <div class="success-icon">
                        <i class="bi bi-check-lg"></i>
                    </div>
                    <h5 style="color: #065F46; margin-bottom: 0.5rem;">Preinscripcion exitosa</h5>
                    <p style="color: #047857; margin: 0;">Tu solicitud ha sido registrada. Te contactaremos pronto.</p>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/RegistrarPreinscripcionPublica" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Nombre <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="nombre" required maxlength="100">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Apellido <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="apellido" required maxlength="100">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">DNI <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="dni" required pattern="[0-9]{8}" maxlength="8"
                            placeholder="12345678">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" name="email" required maxlength="100"
                            placeholder="ejemplo@email.com">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Direccion</label>
                        <input type="text" class="form-control" name="direccion" maxlength="200"
                            placeholder="Calle, numero, distrito">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Colegio de Procedencia</label>
                        <input type="text" class="form-control" name="colegio" maxlength="150">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Carrera de Interes <span class="text-danger">*</span></label>
                        <select class="form-select" name="carrera" required>
                            <option value="">Selecciona una carrera</option>
                            <option value="Ingenieria">Ingenieria</option>
                            <option value="Medicina">Medicina</option>
                            <option value="Derecho">Derecho</option>
                        </select>
                    </div>
                    <div class="col-12">
                        <button type="submit" class="btn-submit">
                            <i class="bi bi-send me-2"></i>Enviar Preinscripcion
                        </button>
                    </div>
                    <div class="col-12 text-center">
                        <small class="text-muted">
                            <i class="bi bi-shield-check me-1"></i>
                            Tus datos estan protegidos y seran usados solo para fines academicos
                        </small>
                    </div>
                </div>
            </form>
        </div>
        <script src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>