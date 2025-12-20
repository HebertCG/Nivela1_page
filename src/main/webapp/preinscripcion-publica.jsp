<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Preinscripcion - Academia Nivel A1</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                background: #EFF6FF;
                border-left: 3px solid #3B82F6;
                padding: 0.5rem 0.75rem;
                border-radius: 6px;
                font-size: 0.8rem;
                color: #1E40AF;
                margin-top: 0.5rem;
                line-height: 1.4;
            }

            .info-note i {
                font-size: 0.875rem;
            }

            .collapsible-help {
                margin-top: 0.75rem;
            }

            .help-toggle {
                background: #F9FAFB;
                border: 1px solid #E5E7EB;
                padding: 0.625rem 0.875rem;
                border-radius: 8px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: space-between;
                transition: all 0.2s ease;
                font-size: 0.875rem;
                color: #6B7280;
            }

            .help-toggle:hover {
                background: #F3F4F6;
                border-color: #D1D5DB;
            }

            .help-content {
                display: none;
                margin-top: 0.75rem;
                padding: 1rem;
                background: white;
                border: 1px solid #E5E7EB;
                border-radius: 8px;
            }

            .help-content.show {
                display: block;
            }

            .help-content p {
                margin: 0 0 0.75rem 0;
            }

            .help-images {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 0.75rem;
            }

            .help-images img {
                width: 100%;
                border-radius: 6px;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
                border: 1px solid #E5E7EB;
            }

            .help-images p {
                margin: 0 0 0.5rem 0;
                text-align: center;
            }

            #otraCarreraInput {
                display: none;
                margin-top: 0.75rem;
            }

            .price-highlight {
                background: #FEF3C7;
                padding: 0.75rem;
                border-radius: 8px;
                margin-top: 0.75rem;
                text-align: center;
            }

            .price-highlight strong {
                color: #D97706;
                font-size: 1.1rem;
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

                        <!-- Información de Precios -->
                        <div class="col-12">
                            <div
                                style="background: linear-gradient(135deg, #FEF3C7, #FDE68A); border-left: 4px solid #F59E0B; padding: 1rem; border-radius: 10px; margin-top: 0.5rem;">
                                <h6
                                    style="color: #92400E; font-weight: 700; margin-bottom: 0.75rem; font-size: 0.95rem;">
                                    <i class="bi bi-info-circle-fill me-2"></i>Precios de Preinscripción Verano 2026
                                </h6>
                                <div
                                    style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 0.75rem;">
                                    <div
                                        style="background: white; padding: 0.75rem; border-radius: 8px; border: 1px solid #FCD34D;">
                                        <div
                                            style="color: #7C3AED; font-weight: 700; font-size: 0.85rem; margin-bottom: 0.5rem;">
                                            6to Primaria - 1ro Sec | 2do - 3ro Sec</div>
                                        <div style="color: #374151; font-size: 0.8rem; line-height: 1.6;">
                                            <strong>Contado:</strong> S/. 400.00<br>
                                            <strong>Cuotas:</strong> S/. 500.00 (1ra: S/. 300 + 2da: S/. 200)
                                        </div>
                                    </div>
                                    <div
                                        style="background: white; padding: 0.75rem; border-radius: 8px; border: 1px solid #FCD34D;">
                                        <div
                                            style="color: #7C3AED; font-weight: 700; font-size: 0.85rem; margin-bottom: 0.5rem;">
                                            4to Secundaria - 5to Sec</div>
                                        <div style="color: #374151; font-size: 0.8rem; line-height: 1.6;">
                                            <strong>Contado:</strong> S/. 500.00<br>
                                            <strong>Cuotas:</strong> S/. 600.00 (1ra: S/. 400 + 2da: S/. 200)
                                        </div>
                                    </div>
                                </div>
                                <div
                                    style="margin-top: 0.75rem; padding: 0.5rem; background: #FFFBEB; border-radius: 6px;">
                                    <small style="color: #92400E; font-weight: 600;">
                                        <i class="bi bi-calendar-event me-1"></i>
                                        2da cuota: Fecha límite 30 de enero 2026
                                    </small>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Grado que cursa en 2026 <span class="text-danger">*</span></label>
                            <select class="form-select" name="grado" id="grado" required>
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
                        <strong>Importante:</strong> Realizado el pago, se revisará en la entidad bancaria y se le
                        enviará mensaje al WhatsApp del número del apoderado para confirmar pago y la boleta.
                    </div>
                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Modalidad de Pago <span class="text-danger">*</span></label>
                            <select class="form-select" name="modalidadPago" id="modalidadPago" required>
                                <option value="">Selecciona modalidad</option>
                                <option value="contado">Pago al Contado</option>
                                <option value="cuotas">Pago en 2 Cuotas</option>
                            </select>
                        </div>
                    </div>

                    <div class="payment-number" style="margin-top: 1rem;">
                        <div style="font-size: 0.95rem; font-weight: 600; color: #374151; margin-bottom: 1rem;">
                            <i class="bi bi-qr-code me-2"></i>Escanea para pagar con cualquier billetera digital
                        </div>
                        <div style="text-align: center;">
                            <img src="${pageContext.request.contextPath}/img/qrgeneral.jpg" alt="QR de Pago"
                                style="max-width: 250px; width: 100%; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">
                        </div>
                        <div style="font-size: 0.8rem; color: #6B7280; margin-top: 0.75rem; text-align: center;">
                            <i class="bi bi-info-circle me-1"></i>Compatible con Yape, Plin, BIM y otras billeteras
                        </div>
                    </div>
                    <div class="row g-3" style="margin-top: 1rem;">
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
                                placeholder="Codigo de operacion (letras y numeros)">
                            <div class="collapsible-help">
                                <div class="help-toggle" onclick="toggleHelp()">
                                    <span>¿Donde encuentro el numero de operacion?</span>
                                    <i class="bi bi-chevron-down" id="helpIcon"></i>
                                </div>
                                <div class="help-content" id="helpContent">
                                    <p style="font-size: 0.875rem; color: #374151;">El numero de operacion aparece en tu
                                        comprobante de pago:</p>
                                    <div class="help-images">
                                        <div>
                                            <p style="font-size: 0.75rem; font-weight: 600; color: #6B7280;">Ejemplo
                                                Yape:</p>
                                            <img src="${pageContext.request.contextPath}/img/ejemployape.png"
                                                alt="Ejemplo Yape">
                                        </div>
                                        <div>
                                            <p style="font-size: 0.75rem; font-weight: 600; color: #6B7280;">Ejemplo
                                                Plin:</p>
                                            <img src="${pageContext.request.contextPath}/img/ejemploplin.png"
                                                alt="Ejemplo Plin">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Comprobante de Pago</label>
                            <input type="file" id="comprobante" name="comprobante" class="file-upload-input"
                                accept="image/*,.pdf" capture="environment">
                            <label for="comprobante" class="file-upload-label" id="fileLabel">
                                <i class="bi bi-cloud-upload" style="font-size: 1.5rem;"></i>
                                <span id="fileName">Selecciona o toma una foto del comprobante</span>
                            </label>
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

        <script>
            // Manejar mensajes de éxito y error con SweetAlert2
            window.addEventListener('DOMContentLoaded', function () {
                const urlParams = new URLSearchParams(window.location.search);
                const success = urlParams.get('success');
                const error = urlParams.get('error');

                if (success === 'true') {
                    Swal.fire({
                        icon: 'success',
                        title: '¡Preinscripción Exitosa!',
                        html: 'Tu solicitud ha sido registrada correctamente.<br><br><strong>Próximos pasos:</strong><br>Se revisará el pago en la entidad bancaria y se te enviará un mensaje al WhatsApp del apoderado para confirmar el pago y enviar la boleta.',
                        confirmButtonText: 'Entendido',
                        confirmButtonColor: '#8B5CF6'
                    }).then(() => {
                        // Limpiar URL
                        window.history.replaceState({}, document.title, window.location.pathname);
                    });
                } else if (error) {
                    let errorTitle = 'Error en el Registro';
                    let errorMessage = 'Ocurrió un error al procesar tu preinscripción.';

                    switch (error) {
                        case 'duplicate':
                            errorTitle = 'Registro Duplicado';
                            errorMessage = 'El <strong>DNI</strong> o el <strong>número de operación</strong> ya están registrados en el sistema.<br><br>Si crees que esto es un error, contacta con la academia.';
                            break;
                        case 'database':
                            errorTitle = 'Error de Base de Datos';
                            errorMessage = 'Hubo un problema al conectar con la base de datos. Por favor, intenta nuevamente más tarde.';
                            break;
                        case 'unknown':
                            errorTitle = 'Error Desconocido';
                            errorMessage = 'Ocurrió un error inesperado. Por favor, contacta con la academia.';
                            break;
                    }

                    Swal.fire({
                        icon: 'error',
                        title: errorTitle,
                        html: errorMessage,
                        confirmButtonText: 'Entendido',
                        confirmButtonColor: '#EF4444'
                    }).then(() => {
                        // Limpiar URL
                        window.history.replaceState({}, document.title, window.location.pathname);
                    });
                }
            });
        </script>
    </body>

    </html>