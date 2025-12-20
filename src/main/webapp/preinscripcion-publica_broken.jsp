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
                --secondary: #14B8A6;
            }

            body {
                font-family: "Segoe UI", system-ui, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 2rem 1rem;
            }

            .form-container {
                background: white;
                border-radius: 24px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                max-width: 700px;
                width: 100%;
                margin: 0 auto;
                padding: 2rem;
            }

            .logo-header {
                text-align: center;
                margin-bottom: 2rem;
            }

            .logo-img {
                max-width: 150px;
                margin-bottom: 1rem;
            }

            .section-banner {
                width: 100%;
                border-radius: 12px;
                margin-bottom: 1.5rem;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            }

            .form-section {
                margin-bottom: 2.5rem;
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #1A1A1A;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.75rem;
            }

            .section-icon {
                width: 40px;
                height: 40px;
                background: linear-gradient(135deg, var(--primary), #7C3AED);
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.25rem;
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

            .file-upload-wrapper {
                position: relative;
                overflow: hidden;
                display: inline-block;
                width: 100%;
            }

            .file-upload-input {
                position: absolute;
                left: -9999px;
            }

            .file-upload-label {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.75rem;
                padding: 1rem;
                border: 2px dashed #D1D5DB;
                border-radius: 12px;
                background: #F9FAFB;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .file-upload-label:hover {
                border-color: var(--primary);
                background: #F3F4F6;
            }

            .file-upload-label.has-file {
                border-color: #10B981;
                background: #D1FAE5;
            }

            .btn-submit {
                background: linear-gradient(135deg, var(--primary), #7C3AED);
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
                text-align: center;
            }

            .success-message.show {
                display: block;
            }

            .payment-info {
                background: #FEF3C7;
                border-left: 4px solid #F59E0B;
                padding: 1rem;
                border-radius: 8px;
                margin-bottom: 1rem;
            }

            .payment-number {
                background: #EDE9FE;
                border: 2px solid var(--primary);
                padding: 1rem;
                border-radius: 12px;
                text-align: center;
                margin-bottom: 1rem;
            }

            .payment-number-value {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--primary);
                letter-spacing: 2px;
            }

            .info-note {
                background: #DBEAFE;
                border-left: 4px solid #3B82F6;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                font-size: 0.875rem;
                color: #1E40AF;
                margin-top: 0.5rem;
            }

            #otraCarreraInput {
                display: none;
                margin-top: 0.75rem;
            }

            @media (max-width: 768px) {
                .form-container {
                    padding: 1.5rem;
                }

                .help-images {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>

    <body>
        <div class="form-container">
            <div class="logo-header">
                <img src="${pageContext.request.contextPath}/img/LOGOSECU.png" alt="Academia Nivel A1" class="logo-img">
                <h1 style="font-size: 2rem; font-weight: 700; color: #1A1A1A; margin: 0;">Preinscripcion Verano 2026
                </h1>
                <p style="color: #6B7280; margin-top: 0.5rem;">Completa todos los datos para tu preinscripcion</p>
            </div>

            <div class="success-message ${param.success == 'true' ? 'show' : ''}">
                <div style="font-size: 3rem; color: #10B981; margin-bottom: 0.5rem;"><i
                        class="bi bi-check-circle-fill"></i></div>
                <h5 style="color: #065F46; margin-bottom: 0.5rem;">Preinscripcion exitosa</h5>
                <p style="color: #047857; margin: 0;">Tu solicitud ha sido registrada. Te contactaremos pronto.</p>
            </div>

            <form action="${pageContext.request.contextPath}/RegistrarPreinscripcionPublica" method="post"
                enctype="multipart/form-data">

                <div class="form-section">
                    <img src="${pageContext.request.contextPath}/img/banner-alumno.png" alt="Datos del Alumno"
                        class="section-banner">
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
                            <div class="info-note">
                                <i class="bi bi-info-circle me-1"></i>
                                Verifica que el correo sea correcto. Se enviaran credenciales para acceder al intranet
                                institucional.
                            </div>
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
                            <label class="form-label">Grado que cursa en 2026 <span class="text-danger">*</span></label>
                            <select class="form-select" name="grado" required>
                                <option value="">Selecciona grado</option>
                                <option value="6to Prim - 1ro Sec">6to Prim - 1ro Sec</option>
                                <option value="2do Sec - 3ro Sec">2do Sec - 3ro Sec</option>
                                <option value="4to Sec - 5to Sec">4to Sec - 5to Sec</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Carrera de Interes <span class="text-danger">*</span></label>
                            <select class="form-select" name="carrera" id="carreraSelect" required
                                onchange="toggleOtraCarrera()">
                                <option value="">Selecciona una carrera</option>
                                <option value="Medicina">Medicina</option>
                                <option value="Ingenieria">Ingenieria</option>
                                <option value="Derecho">Derecho</option>
                                <option value="Otros">Otros</option>
                            </select>
                            <input type="text" class="form-control" name="otraCarrera" id="otraCarreraInput"
                                maxlength="100" placeholder="Especifica la carrera">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <img src="${pageContext.request.contextPath}/img/banner-apoderado.png" alt="Datos del Apoderado"
                        class="section-banner">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Nombre del Apoderado <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="nombreApoderado" required maxlength="100">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Apellido del Apoderado <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="apellidoApoderado" required maxlength="100">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Telefono de Referencia 1 <span
                                    class="text-danger">*</span></label>
                            <input type="tel" class="form-control" name="telefono1Apoderado" required pattern="[0-9]{9}"
                                maxlength="9" placeholder="987654321">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Telefono de Referencia 2 <span
                                    class="text-danger">*</span></label>
                            <input type="tel" class="form-control" name="telefono2Apoderado" required pattern="[0-9]{9}"
                                maxlength="9" placeholder="987654321">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Email del Apoderado <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="emailApoderado" required maxlength="100"
                                placeholder="apoderado@email.com">
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <div class="section-title">
                        <div class="section-icon"><i class="bi bi-credit-card"></i></div>
                        <span>Datos de Pago</span>
                    </div>
                    <div class="payment-info">
                        <i class="bi bi-info-circle me-2"></i>
                        <strong>Importante:</strong> Realiza el pago y sube el comprobante para completar tu
                        preinscripcion.
                    </div>
                    <div class="payment-number">
                        <div style="font-size: 0.875rem; color: #6B7280; margin-bottom: 0.5rem;">Numero para Yape o
                            Plin:</div>
                        <div class="payment-number-value">955 908 590</div>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Metodo de Pago <span class="text-danger">*</span></label>
                            <select class="form-select" name="metodoPago" required>
                                <option value="">Selecciona metodo</option>
                                <option value="yape">Yape</option>
                                <option value="plin">Plin</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Numero de Operacion <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="referenciaPago" required maxlength="50"
                                placeholder="Numero de operacion">
                            <div class="collapsible-help">
                                <div class="help-toggle" onclick="toggleHelp()">
                                    <span style="font-size: 0.875rem; color: #6B7280;">¿Donde encuentro el numero de
                                        operacion?</span>
                                    <i class="bi bi-chevron-down" id="helpIcon"></i>
                                </div>
                                <div class="help-content" id="helpContent">
                                    <p style="font-size: 0.875rem; color: #374151; margin-bottom: 0.5rem;">El numero de
                                        operacion aparece en tu comprobante de pago:</p>
                                    <div class="help-images">
                                        <div>
                                            <p
                                                style="font-size: 0.75rem; font-weight: 600; color: #6B7280; margin-bottom: 0.5rem;">
                                                Ejemplo Yape:</p>
                                            <img src="${pageContext.request.contextPath}/img/ejemployape.png"
                                                alt="Ejemplo Yape">
                                        </div>
                                        <div>
                                            <p
                                                style="font-size: 0.75rem; font-weight: 600; color: #6B7280; margin-bottom: 0.5rem;">
                                                Ejemplo Plin:</p>
                                            <img src="${pageContext.request.contextPath}/img/ejemploplin.png"
                                                alt="Ejemplo Plin">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Comprobante de Pago <span class="text-danger">*</span></label>
                            <div class="file-upload-wrapper">
                                <input type="file" id="comprobante" name="comprobante" class="file-upload-input"
                                    accept="image/*,.pdf" required>
                                <label for="comprobante" class="file-upload-label" id="fileLabel">
                                    <i class="bi bi-cloud-upload" style="font-size: 1.5rem;"></i>
                                    <span id="fileName">Selecciona o toma una foto del comprobante</span>
                                </label>
                            </div>
                            <small class="text-muted">Formatos: JPG, PNG, PDF (Max 10MB)</small>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="bi bi-send me-2"></i>Enviar Preinscripcion
                </button>

                <div class="text-center mt-3">
                    <small class="text-muted">
                        <i class="bi bi-shield-check me-1"></i>
                        Tus datos estan protegidos y seran usados solo para fines academicos
                    </small>
                </div>
            </form>
        </div>
        <script>
            document.getElementById('comprobante').addEventListener('change', function (e) {
                const label = document.getElementById('fileLabel');
                const fileName = document.getElementById('fileName');
                if (this.files && this.files[0]) {
                    fileName.textContent = this.files[0].name;
                    label.classList.add('has-file');
                } else {
                    fileName.textContent = 'Selecciona o toma una foto del comprobante';
                    label.classList.remove('has-file');
                }
            });

            function toggleOtraCarrera() {
                const select = document.getElementById('carreraSelect');
                const input = document.getElementById('otraCarreraInput');
                if (select.value === 'Otros') {
                    input.style.display = 'block';
                    input.required = true;
                } else {
                    input.style.display = 'none';
                    input.required = false;
                    input.value = '';
                }
            }

            function toggleHelp() {
                const content = document.getElementById('helpContent');
                const icon = document.getElementById('helpIcon');
                if (content.classList.contains('show')) {
                    content.classList.remove('show');
                    icon.className = 'bi bi-chevron-down';
                } else {
                    content.classList.add('show');
                    icon.className = 'bi bi-chevron-up';
                }
            }
        </script>
    </body>

    </html>