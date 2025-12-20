<%@ page import="modelo.Usuario" %>
    <%@ page session="true" %>
        <%@ page import="DAO.UsuarioDAO" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
                <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                    <%@ include file="verificarEstudiante.jsp" %>
                        <% if ("true".equals(request.getParameter("logout"))) { session.invalidate();
                            response.sendRedirect("../login.jsp"); return; }
                            request.setAttribute("sidebarActive", "horario" ); %>
                            <!DOCTYPE html>
                            <html lang="es">

                            <head>
                                <meta charset="UTF-8">
                                <title>Mi Horario</title>
                                <link rel="stylesheet"
                                    href="${pageContext.request.contextPath}/assets/bootstrap/css/bootstrap.min.css">
                                <link rel="stylesheet"
                                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
                                <style>
                                    :root {
                                        --color-bg: #F3F4F6;
                                        --color-surface: #FFFFFF;
                                        --color-border: #E5E7EB;
                                        --color-muted: #6B7280;
                                        --color-accent: #00C2CB;
                                        --color-accent-2: #00A63E;
                                        --color-sidebar-top: #1E1B4B;
                                        --color-sidebar-bottom: #2F0059;
                                        --color-sidebar-text: #FFFFFFB2;
                                    }

                                    body {
                                        font-family: "Segoe UI", "Inter", system-ui, -apple-system, sans-serif;
                                        background: var(--color-bg);
                                        margin: 0;
                                        color: #1A1A1A;
                                    }

                                    .dashboard-layout {
                                        min-height: 100vh;
                                        background: var(--color-bg);
                                    }

                                    .content-wrapper {
                                        flex: 1;
                                        display: flex;
                                        flex-direction: column;
                                        background: var(--color-bg);
                                        margin-left: 280px;    transition: margin-left 0.3s ease;    min-height: 100vh;}

                                    .dashboard-main {
                                        flex: 1;
                                        padding: 2rem;
                                    }

                                    @media (max-width: 991.98px) {
                                        .dashboard-main {
                                            padding: 1.5rem 1rem 2rem;
                                        }
                                    }
                                    .estudiante-sidebar[data-collapsed="true"] ~ .content-wrapper {
                                        margin-left: 80px;
                                    }

                                    @media (max-width: 991.98px) {
                                        .content-wrapper {
                                            margin-left: 0 !important;
                                        }
                                    }

/* Schedule/Horario Styles */
.schedule-hero {
    margin-bottom: 2rem;
}

.schedule-hero h1 {
    font-size: 2rem;
    font-weight: 700;
    color: #1A1A1A;
}

.schedule-wrapper {
    background: var(--color-surface);
    border-radius: 20px;
    padding: 1.5rem;
    border: 1px solid var(--color-border);
}

.schedule-grid {
    display: grid;
    grid-template-columns: 60px repeat(6, 1fr);
    gap: 0;
    position: relative;
    overflow-x: auto;
}

.schedule-hours {
    display: flex;
    flex-direction: column;
    border-right: 1px solid var(--color-border);
    padding-right: 0.5rem;
}

.hour-slot {
    height: 64px;
    display: flex;
    align-items: flex-start;
    justify-content: flex-end;
    font-size: 0.75rem;
    color: var(--color-muted);
    padding-top: 0.25rem;
    border-bottom: 1px solid #f3f4f6;
}

.schedule-days {
    display: contents;
}

.schedule-day {
    border-right: 1px solid var(--color-border);
    position: relative;
}

.schedule-day:last-child {
    border-right: none;
}

.day-header {
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: 600;
    font-size: 0.875rem;
    color: #374151;
    border-bottom: 2px solid var(--color-border);
    background: #f9fafb;
}

.day-header.is-today {
    background: #dbeafe;
    color: #1e40af;
    font-weight: 700;
}

.day-body {
    position: relative;
    background: white;
}

.schedule-events {
    display: none;
}

.schedule-event {
    position: absolute;
    left: 4px;
    right: 4px;
    border-radius: 8px;
    padding: 0.5rem;
    color: white;
    font-size: 0.75rem;
    overflow: hidden;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.schedule-event:hover {
    transform: scale(1.02);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 10;
}

.schedule-event--teal {
    background: linear-gradient(135deg, #14b8a6, #0d9488);
}

.schedule-event--cyan {
    background: linear-gradient(135deg, #06b6d4, #0891b2);
}

.schedule-event--purple {
    background: linear-gradient(135deg, #8b5cf6, #7c3aed);
}

.event-code {
    font-weight: 700;
    font-size: 0.85rem;
    margin: 0;
}

.event-name {
    font-size: 0.75rem;
    font-weight: 600;
    margin: 0.25rem 0;
}

.event-time {
    font-size: 0.7rem;
    opacity: 0.9;
    margin: 0;
}

.schedule-legend {
    display: flex;
    gap: 1.5rem;
    flex-wrap: wrap;
    padding-top: 1rem;
    border-top: 1px solid var(--color-border);
}

.legend-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.875rem;
    color: #374151;
}

.legend-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}

.legend-dot.teal {
    background: #14b8a6;
}

.legend-dot.cyan {
    background: #06b6d4;
}

.legend-dot.purple {
    background: #8b5cf6;
}

.section-card {
    background: var(--color-surface);
    border-radius: 20px;
    border: 1px solid var(--color-border);
    padding: 2rem;
}

.btn-secondary {
    background: #6B7280;
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
    display: inline-block;
}

.btn-secondary:hover {
    background: #4B5563;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

@media (max-width: 991.98px) {
    .schedule-grid {
        grid-template-columns: 50px repeat(6, minmax(100px, 1fr));
    }
    
    .schedule-event {
        font-size: 0.65rem;
        padding: 0.35rem;
    }
    
    .event-code {
        font-size: 0.75rem;
    }
}

@media (max-width: 768px) {
    .schedule-grid {
        grid-template-columns: 40px repeat(6, minmax(80px, 1fr));
    }
    
    .hour-slot {
        font-size: 0.65rem;
    }
    
    .day-header {
        font-size: 0.75rem;
        height: 40px;
    }
}

                                </style>
                            </head>

                            <body>
                                <c:set var="days"
                                    value="${fn:split('Lunes,Martes,Miércoles,Jueves,Viernes,Sábado', ',')}"></c:set>
                                <c:set var="colors" value="${fn:split('teal,cyan,purple', ',')}"></c:set>
                                <c:set var="hourStart" value="7" />
                                <c:set var="hourEnd" value="20" />
                                <div class="dashboard-layout d-flex">
                                    <%@ include file="sidebar-estudiante.jsp" %>
                                        <div class="content-wrapper">
                                            <%@ include file="topbar-estudiante.jsp" %>
                                                <main class="dashboard-main">
                                                    <div class="schedule-hero">
                                                        <div>
                                                            <p class="text-muted mb-1">Semana actual: 12 - Del 27 de
                                                                octubre al 2 de noviembre</p>
                                                            <h1 class="mb-0">Mi Horario</h1>
                                                        </div>
                                                    </div>

                                                    <c:choose>
                                                        <c:when test="${not empty horario}">
                                                            <div class="schedule-wrapper section-card">
                                                                <div class="schedule-grid" data-start="${hourStart}"
                                                                    data-end="${hourEnd}"
                                                                    style="--grid-start:${hourStart}; --grid-end:${hourEnd};">
                                                                    <div class="schedule-hours">
                                                                        <c:forEach begin="${hourStart}" end="${hourEnd}"
                                                                            var="hour">
                                                                            <div class="hour-slot">${hour lt 10 ? '0' :
                                                                                ''}${hour}:00</div>
                                                                        </c:forEach>
                                                                    </div>
                                                                    <div class="schedule-days">
                                                                        <c:forEach var="day" items="${days}"
                                                                            varStatus="status">
                                                                            <div class="schedule-day"
                                                                                data-day-key="${fn:toLowerCase(day)}">
                                                                                <div
                                                                                    class="day-header ${status.index == 2 ? 'is-today' : ''}">
                                                                                    ${day}
                                                                                </div>
                                                                                <div class="day-body"></div>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                    <div class="schedule-events">
                                                                        <c:forEach var="clase" items="${horario}"
                                                                            varStatus="status">
                                                                            <c:set var="colorIdx"
                                                                                value="${status.index % fn:length(colors)}" />
                                                                            <div class="schedule-event schedule-event--${colors[colorIdx]}"
                                                                                data-day="${clase.dia}"
                                                                                data-day-key="${fn:toLowerCase(clase.dia)}"
                                                                                data-start="${clase.horaInicio}"
                                                                                data-end="${clase.horaFin}">
                                                                                <p class="event-code mb-1">
                                                                                    ${clase.curso}</p>
                                                                                <h6 class="event-name mb-1">
                                                                                    ${clase.seccion != null ?
                                                                                    clase.seccion : 'Sección A'}</h6>
                                                                                <p class="event-time mb-0">
                                                                                    ${clase.horaInicio} -
                                                                                    ${clase.horaFin}</p>
                                                                                <small
                                                                                    class="text-white-50">${clase.profesor}</small>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <div class="schedule-legend mt-3">
                                                                    <div class="legend-item">
                                                                        <span class="legend-dot teal"></span>
                                                                        Matemáticas
                                                                    </div>
                                                                    <div class="legend-item">
                                                                        <span class="legend-dot cyan"></span> Física
                                                                    </div>
                                                                    <div class="legend-item">
                                                                        <span class="legend-dot purple"></span>
                                                                        Laboratorios / Otros
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="section-card text-center">
                                                                <h5>No se encontraron horarios activos</h5>
                                                                <p class="text-muted mb-0">Cuando tengas clases
                                                                    asignadas se mostrarán aquí.</p>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>

                                                    <div class="text-center mt-4">
                                                        <a href="${pageContext.request.contextPath}/estudiante/panel.jsp"
                                                            class="btn btn-secondary px-4">Volver al panel</a>
                                                    </div>
                                                </main>
                                        </div>
                                </div>
                                <script
                                    src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.bundle.min.js"></script>
                                <script>
                                    (function () {
                                        var grid = document.querySelector('.schedule-grid');
                                        if (!grid) {
                                            return;
                                        }
                                        var startHour = parseInt(grid.dataset.start, 10) || 7;
                                        var endHour = parseInt(grid.dataset.end, 10) || 20;
                                        var totalHours = endHour - startHour;
                                        var hourHeight = grid.dataset.hourHeight ? parseFloat(grid.dataset.hourHeight) : 64;

                                        function normalizeDay(value) {
                                            return (value || '')
                                                .toString()
                                                .toLowerCase()
                                                .normalize('NFD')
                                                .replace(/[^a-z]/g, '');
                                        }

                                        document.querySelectorAll('.schedule-event').forEach(function (eventEl) {
                                            var key = normalizeDay(eventEl.dataset.dayKey || eventEl.dataset.day);
                                            var column = Array.from(document.querySelectorAll('.schedule-day')).find(function (col) {
                                                return normalizeDay(col.dataset.dayKey) === key;
                                            });
                                            if (!column) {
                                                return;
                                            }
                                            var body = column.querySelector('.day-body');
                                            if (!body) {
                                                return;
                                            }
                                            var start = (eventEl.dataset.start || '07:00').split(':');
                                            var end = (eventEl.dataset.end || '08:00').split(':');
                                            var startMinutes = parseInt(start[0], 10) * 60 + parseInt(start[1], 10);
                                            var endMinutes = parseInt(end[0], 10) * 60 + parseInt(end[1], 10);
                                            var offset = startMinutes - startHour * 60;
                                            var duration = Math.max(endMinutes - startMinutes, 45);
                                            eventEl.style.top = (offset / 60) * hourHeight + 'px';
                                            eventEl.style.height = (duration / 60) * hourHeight - 8 + 'px';
                                            body.appendChild(eventEl);
                                        });

                                        document.querySelectorAll('.schedule-day').forEach(function (day) {
                                            var body = day.querySelector('.day-body');
                                            if (body) {
                                                body.style.height = totalHours * hourHeight + 'px';
                                            }
                                        });
                                    })();
                                </script>
                            </body>

                            </html>