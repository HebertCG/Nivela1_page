<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="es">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Consulta de Asistencia Semanal - Academia NivelA1</title>
            <link rel="icon" type="image/png" href="img/LOGOS.png" />

            <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
                rel="stylesheet">
            <script src="https://kit.fontawesome.com/f054896dbd.js" crossorigin="anonymous"></script>

            <style>
                :root {
                    --primary-color: #000d83;
                    --secondary-color: #3ec4ff;
                    --success-color: #28a745;
                    --danger-color: #dc3545;
                    --warning-color: #fd7e14;
                    --info-color: #007bff;
                    --light-bg: #F1F4FD;
                    --white: #ffffff;
                    --text-dark: #1a1a2e;
                    --gradient-hero: linear-gradient(135deg, #000d83 0%, #3ec4ff 100%);
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
                }

                .hero-section {
                    background: var(--gradient-hero);
                    padding: 3rem 0 2rem;
                    text-align: center;
                    color: var(--white);
                }

                .hero-section h1 {
                    font-size: clamp(1.8rem, 4vw, 2.5rem);
                    font-weight: 900;
                    margin-bottom: 0.5rem;
                }

                .hero-section p {
                    font-size: 1.1rem;
                    opacity: 0.95;
                }

                .main-content {
                    padding: 2rem 0 3rem;
                }

                .filter-card {
                    background: var(--white);
                    border-radius: 20px;
                    padding: 2rem;
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                    margin-bottom: 2rem;
                }

                .filter-label {
                    font-weight: 600;
                    color: var(--primary-color);
                    margin-bottom: 0.5rem;
                    display: block;
                }

                .form-select-modern {
                    border: 2px solid #e0e0e0;
                    border-radius: 10px;
                    padding: 0.75rem 1rem;
                    font-size: 1rem;
                    transition: all 0.3s ease;
                }

                .form-select-modern:focus {
                    border-color: var(--secondary-color);
                    box-shadow: 0 0 0 0.2rem rgba(62, 196, 255, 0.25);
                }

                .attendance-card {
                    background: var(--white);
                    border-radius: 20px;
                    padding: 2rem;
                    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                    overflow-x: auto;
                }

                .table-weekly {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 1rem;
                }

                .table-weekly thead th {
                    background: var(--primary-color);
                    color: var(--white);
                    padding: 1rem;
                    font-weight: 600;
                    text-align: center;
                    border: 1px solid #dee2e6;
                    position: sticky;
                    top: 0;
                    z-index: 10;
                }

                .table-weekly thead th:first-child {
                    text-align: left;
                    min-width: 200px;
                }

                .table-weekly tbody tr {
                    transition: all 0.3s ease;
                }

                .table-weekly tbody tr:nth-child(even) {
                    background: #f8f9fa;
                }

                .table-weekly tbody tr:hover {
                    background: #e9ecef;
                    transform: scale(1.01);
                    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                }

                .table-weekly tbody td {
                    padding: 1rem;
                    border: 1px solid #dee2e6;
                    text-align: center;
                }

                .table-weekly tbody td:first-child {
                    text-align: left;
                    font-weight: 600;
                    color: var(--text-dark);
                }

                .estado-cell {
                    padding: 0.5rem;
                    border-radius: 8px;
                    font-weight: 600;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                    min-width: 100px;
                    justify-content: center;
                }

                .estado-asistio {
                    background-color: #d4edda;
                    color: #155724;
                }

                .estado-falto {
                    background-color: #f8d7da;
                    color: #721c24;
                }

                .estado-tardanza {
                    background-color: #fff3cd;
                    color: #856404;
                }

                .estado-justificada {
                    background-color: #d1ecf1;
                    color: #0c5460;
                }

                .estado-sin-registro {
                    background-color: #e9ecef;
                    color: #6c757d;
                }

                .loading {
                    text-align: center;
                    padding: 3rem;
                }

                .spinner-border {
                    width: 3rem;
                    height: 3rem;
                    border-width: 0.3rem;
                }

                .empty-state {
                    text-align: center;
                    padding: 3rem;
                    color: #6c757d;
                }

                .empty-state i {
                    font-size: 4rem;
                    margin-bottom: 1rem;
                    opacity: 0.3;
                }

                @media (max-width: 768px) {
                    .table-weekly {
                        font-size: 0.85rem;
                    }

                    .table-weekly thead th,
                    .table-weekly tbody td {
                        padding: 0.5rem;
                    }

                    .estado-cell {
                        min-width: 80px;
                        font-size: 0.8rem;
                    }
                }
            </style>
        </head>

        <body>

            <section class="hero-section">
                <div class="container">
                    <h1><i class="fas fa-calendar-week"></i> Consulta de Asistencia Semanal</h1>
                    <p>Revisa la asistencia de toda la semana</p>
                </div>
            </section>

            <section class="main-content">
                <div class="container">

                    <div class="filter-card">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="filter-label">Sección:</label>
                                <select id="seccionSelect" class="form-select form-select-modern">
                                    <option value="">Seleccione una sección</option>
                                    <c:forEach items="${secciones}" var="seccion">
                                        <option value="${seccion.id}">${seccion.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="filter-label">Semana:</label>
                                <select id="semanaSelect" class="form-select form-select-modern">
                                    <option value="">Seleccione una semana</option>
                                    <c:forEach items="${semanas}" var="semana">
                                        <option value="${semana.id}">Semana ${semana.numeroSemana} - ${semana.nombre}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="mt-3">
                            <button class="btn btn-primary" onclick="loadAttendance()">
                                <i class="fas fa-search"></i> Consultar Asistencia
                            </button>
                        </div>
                    </div>

                    <div class="attendance-card" id="attendanceCard" style="display: none;">
                        <div id="loadingDiv" class="loading" style="display: none;">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">Cargando...</span>
                            </div>
                            <p class="mt-3">Cargando asistencia...</p>
                        </div>

                        <div id="attendanceTable"></div>

                        <div id="emptyState" class="empty-state" style="display: none;">
                            <i class="fas fa-inbox"></i>
                            <h4>No hay datos disponibles</h4>
                            <p>No se encontraron registros de asistencia para esta semana</p>
                        </div>
                    </div>

                </div>
            </section>

            <script src="assets/bootstrap/js/bootstrap.bundle.min.js"></script>
            <script>
                let currentSeccionId = null;
                let currentSemanaId = null;

                function loadAttendance() {
                    currentSeccionId = document.getElementById('seccionSelect').value;
                    currentSemanaId = document.getElementById('semanaSelect').value;

                    if (!currentSeccionId || !currentSemanaId) {
                        alert('Por favor selecciona una sección y una semana');
                        return;
                    }

                    document.getElementById('attendanceCard').style.display = 'block';
                    document.getElementById('loadingDiv').style.display = 'block';
                    document.getElementById('attendanceTable').innerHTML = '';
                    document.getElementById('emptyState').style.display = 'none';

                    fetch('AsistenciaPublicaServlet?action=getData&seccionId=' + currentSeccionId + '&semanaId=' + currentSemanaId)
                        .then(response => {
                            if (!response.ok) {
                                return response.text().then(text => { throw new Error(text) });
                            }
                            return response.json();
                        })
                        .then(data => {
                            document.getElementById('loadingDiv').style.display = 'none';

                            if (data.success && data.estudiantes.length > 0) {
                                renderTable(data);
                            } else {
                                const msg = data.message ? data.message : 'No se encontraron registros de asistencia para esta semana';
                                document.getElementById('emptyState').innerHTML = `
                                    <i class="fas fa-exclamation-circle text-warning"></i>
                                    <h4>Aviso</h4>
                                    <p>${msg}</p>
                                `;
                                document.getElementById('emptyState').style.display = 'block';
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            document.getElementById('loadingDiv').style.display = 'none';

                            document.getElementById('emptyState').innerHTML = `
                                <i class="fas fa-bug text-danger"></i>
                                <h4>Error del Sistema</h4>
                                <p class="text-danger">${error.message}</p>
                            `;
                            document.getElementById('emptyState').style.display = 'block';
                        });
                }

                function renderTable(data) {
                    const diasClase = data.diasClase;
                    const estudiantes = data.estudiantes;

                    let html = '<table class="table-weekly">';

                    html += '<thead><tr>';
                    html += '<th>Estudiante</th>';
                    diasClase.forEach(dia => {
                        html += '<th>' + dia + '</th>';
                    });
                    html += '</tr></thead>';

                    html += '<tbody>';
                    estudiantes.forEach(est => {
                        html += '<tr>';
                        html += '<td>' + est.nombre + '</td>';

                        diasClase.forEach(dia => {
                            let estadoHtml = '';
                            let found = false;

                            for (let fecha in est.asistencias) {
                                // Pass the string directly to avoid timezone issues/Date object mismatches
                                let diaSemana = getDiaSemana(fecha);

                                if (diaSemana === dia) {
                                    let estado = est.asistencias[fecha];
                                    estadoHtml = getEstadoHtml(estado);
                                    found = true;
                                    break;
                                }
                            }

                            if (!found) {
                                estadoHtml = '<span class="estado-cell estado-sin-registro"><i class="fas fa-minus"></i> Sin registro</span>';
                            }

                            html += '<td>' + estadoHtml + '</td>';
                        });

                        html += '</tr>';
                    });
                    html += '</tbody>';
                    html += '</table>';

                    document.getElementById('attendanceTable').innerHTML = html;
                }

                function getEstadoHtml(estado) {
                    const estados = {
                        'asistio': '<span class="estado-cell estado-asistio"><i class="fas fa-check-circle"></i> Asistió</span>',
                        'falto': '<span class="estado-cell estado-falto"><i class="fas fa-times-circle"></i> Faltó</span>',
                        'tardanza': '<span class="estado-cell estado-tardanza"><i class="fas fa-clock"></i> Tardanza</span>',
                        'justificada': '<span class="estado-cell estado-justificada"><i class="fas fa-file-alt"></i> Justificada</span>'
                    };

                    return estados[estado] || '<span class="estado-cell estado-sin-registro">-</span>';
                }

                function getDiaSemana(fechaStr) {
                    // Parse manually to avoid UTC/Timezone issues
                    // fechaStr comes as "YYYY-MM-DD"
                    if (!fechaStr) return '';
                    const partes = fechaStr.split('-');
                    const year = parseInt(partes[0]);
                    const month = parseInt(partes[1]) - 1; // Months are 0-11
                    const day = parseInt(partes[2]);

                    const fechaObj = new Date(year, month, day);
                    const dias = ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'];
                    return dias[fechaObj.getDay()];
                }
            </script>
        </body>

        </html>