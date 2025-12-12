<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String sidebarActive = (String) request.getAttribute("sidebarActive");
    if (sidebarActive == null) sidebarActive = "";
%>

<style>
/* ==========================================
   SIDEBAR DOCENTE - ESTILOS AUTOCONTENIDOS
   ========================================== */

:root {
    --docente-primary: #2D1B69;
    --docente-secondary: #3D2A7A;
    --docente-accent: #00D9C0;
    --docente-hover: rgba(61, 42, 122, 0.8);
    --sidebar-width: 280px;
    --sidebar-collapsed: 80px;
    --transition-speed: 0.3s;
}

.docente-sidebar {
    position: fixed;
    top: 0;
    left: 0;
    width: var(--sidebar-width);
    height: 100vh;
    background: linear-gradient(180deg, var(--docente-primary) 0%, var(--docente-secondary) 100%);
    color: white;
    display: flex;
    flex-direction: column;
    transition: width var(--transition-speed) ease;
    z-index: 1000;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.docente-sidebar[data-collapsed="true"] {
    width: var(--sidebar-collapsed);
}

.sidebar-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 1.5rem 1rem;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-toggle {
    background: var(--docente-accent);
    border: none;
    border-radius: 12px;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;
    color: white;
    font-size: 1.5rem;
}

.sidebar-toggle:hover {
    background: #00c4b0;
    transform: scale(1.05);
}

.sidebar-logo-container {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    transition: opacity var(--transition-speed) ease;
}

.docente-sidebar[data-collapsed="true"] .sidebar-logo-container {
    opacity: 0;
    pointer-events: none;
}

.sidebar-logo-icon {
    width: 40px;
    height: 40px;
    background: var(--docente-accent);
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    font-size: 1.2rem;
}

.sidebar-logo-text {
    display: flex;
    flex-direction: column;
}

.sidebar-logo-nivel {
    font-size: 0.75rem;
    opacity: 0.8;
    letter-spacing: 1px;
}

.sidebar-logo-nivel-big {
    font-size: 1.5rem;
    font-weight: bold;
    line-height: 1;
}

.sidebar-logo-academia {
    font-size: 0.85rem;
    opacity: 0.9;
}

.sidebar-nav {
    flex: 1;
    padding: 1rem 0;
    overflow-y: auto;
    overflow-x: hidden;
}

.sidebar-nav::-webkit-scrollbar {
    width: 4px;
}

.sidebar-nav::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.2);
    border-radius: 4px;
}

.nav-link {
    position: relative;
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 1.5rem;
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: all 0.3s ease;
    margin: 0.25rem 1rem;
    border-radius: 12px;
}

.nav-link:hover {
    background: var(--docente-hover);
    color: white;
}

.nav-link.active {
    background: var(--docente-hover);
    color: white;
}

.nav-link.active .nav-indicator {
    opacity: 1;
}

.nav-indicator {
    position: absolute;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 4px;
    height: 32px;
    background: var(--docente-accent);
    border-radius: 0 4px 4px 0;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.docente-sidebar[data-collapsed="true"] .nav-indicator {
    display: none;
}

.nav-link i {
    font-size: 1.4rem;
    min-width: 24px;
    text-align: center;
}

.nav-text {
    font-size: 1rem;
    font-weight: 500;
    white-space: nowrap;
    transition: opacity var(--transition-speed) ease;
}

.docente-sidebar[data-collapsed="true"] .nav-text {
    opacity: 0;
    pointer-events: none;
    position: absolute;
}

.docente-sidebar[data-collapsed="true"] .nav-link {
    justify-content: center;
    padding: 1rem 0.5rem;
    margin: 0.25rem 0.5rem;
}

.docente-sidebar[data-collapsed="true"] .nav-link i {
    margin: 0;
}

.sidebar-footer {
    padding: 1rem;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.logout-link {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 1rem 1.5rem;
    color: rgba(255, 255, 255, 0.8);
    text-decoration: none;
    transition: all 0.3s ease;
    border-radius: 12px;
}

.logout-link:hover {
    background: rgba(255, 59, 48, 0.2);
    color: #ff3b30;
}

.logout-link i {
    font-size: 1.4rem;
    min-width: 24px;
    text-align: center;
}

.docente-sidebar[data-collapsed="true"] .logout-link {
    justify-content: center;
    padding: 1rem 0.5rem;
    margin: 0 0.5rem;
}

.docente-sidebar[data-collapsed="true"] .logout-link i {
    margin: 0;
}

.docente-sidebar[data-collapsed="true"] .logout-link .nav-text {
    display: none;
}

@media (max-width: 991.98px) {
    .docente-sidebar {
        width: 0;
        overflow: hidden;
    }

    .docente-sidebar.is-open {
        width: var(--sidebar-width);
    }

    .docente-sidebar[data-collapsed="true"] {
        width: 0;
    }

    .docente-sidebar.is-open[data-collapsed="true"] {
        width: var(--sidebar-width);
    }

    body.sidebar-open {
        overflow: hidden;
    }

    body.sidebar-open::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
    }
}

.main-content-wrapper {
    margin-left: var(--sidebar-width);
    transition: margin-left var(--transition-speed) ease;
    min-height: 100vh;
    background: #f5f6fa;
}

.docente-sidebar[data-collapsed="true"] ~ .main-content-wrapper {
    margin-left: var(--sidebar-collapsed);
}

@media (max-width: 991.98px) {
    .main-content-wrapper {
        margin-left: 0 !important;
    }
}
</style>

<aside class="docente-sidebar" id="docenteSidebar" data-collapsed="false" aria-label="Menú lateral">
  <div class="sidebar-header">
    <button class="sidebar-toggle" id="docenteSidebarToggle" type="button" aria-label="Abrir/cerrar menú" aria-expanded="true">
      <i class="bi bi-list"></i>
    </button>
    <div class="sidebar-logo-container">
      <div class="sidebar-logo-icon">A</div>
      <div class="sidebar-logo-text">
        <span class="sidebar-logo-nivel">NIVEL</span>
        <span class="sidebar-logo-nivel-big">A1</span>
        <span class="sidebar-logo-academia">ACADEMIA</span>
      </div>
    </div>
  </div>

  <nav class="sidebar-nav nav flex-column flex-grow-1">
    <a class="nav-link <%= "dashboard".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/Docente/Panel"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Dashboard">
      <span class="nav-indicator"></span>
      <i class="bi bi-grid-1x2-fill"></i>
      <span class="nav-text">Dashboard</span>
    </a>
    
    <a class="nav-link <%= "cursos".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/MisCursos"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Mis Cursos">
      <span class="nav-indicator"></span>
      <i class="bi bi-journal-bookmark"></i>
      <span class="nav-text">Mis Cursos</span>
    </a>
    
    <a class="nav-link <%= "horario".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/MiHorario"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Horario">
      <span class="nav-indicator"></span>
      <i class="bi bi-calendar3"></i>
      <span class="nav-text">Horario</span>
    </a>
    
    <a class="nav-link <%= "alumnos".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/EstudiantesSeccion"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Alumnos">
      <span class="nav-indicator"></span>
      <i class="bi bi-people"></i>
      <span class="nav-text">Alumnos</span>
    </a>
    
    <a class="nav-link <%= "calificar".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/Docente/Calificar"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Calificar">
      <span class="nav-indicator"></span>
      <i class="bi bi-clipboard-check"></i>
      <span class="nav-text">Calificar</span>
    </a>
    
    <a class="nav-link <%= "asistencia".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/Docente/Asistencia"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Asistencia">
      <span class="nav-indicator"></span>
      <i class="bi bi-calendar-check"></i>
      <span class="nav-text">Asistencia</span>
    </a>
    
    <a class="nav-link <%= "material".equalsIgnoreCase(sidebarActive) ? "active" : "" %>"
       href="${pageContext.request.contextPath}/docente/material"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Material">
      <span class="nav-indicator"></span>
      <i class="bi bi-folder-open"></i>
      <span class="nav-text">Material</span>
    </a>
  </nav>

  <div class="sidebar-footer">
    <a class="logout-link" href="${pageContext.request.contextPath}/salir"
       data-bs-toggle="tooltip" data-bs-placement="right" title="Cerrar Sesión">
      <i class="bi bi-box-arrow-right"></i>
      <span class="nav-text">Cerrar Sesión</span>
    </a>
  </div>
</aside>

<script>
  document.addEventListener('DOMContentLoaded', function () {
    var sidebar = document.getElementById('docenteSidebar');
    if (!sidebar) return;

    var internalToggle = document.getElementById('docenteSidebarToggle');
    var externalToggle = document.getElementById('sidebarToggle');
    var toggles = [internalToggle, externalToggle].filter(Boolean);
    var mq = window.matchMedia('(max-width: 991.98px)');
    
    // Inicializar tooltips
    var tooltipTriggerList = [].slice.call(sidebar.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
      return new bootstrap.Tooltip(tooltipTriggerEl, {
        trigger: 'hover',
        boundary: 'window'
      });
    });

    function setAriaExpanded(collapsed) {
      if (internalToggle) {
        internalToggle.setAttribute('aria-expanded', String(!collapsed));
      }
    }
    
    function updateTooltips(collapsed) {
      tooltipList.forEach(function(tooltip) {
        if (collapsed && !mq.matches) {
          tooltip.enable();
        } else {
          tooltip.disable();
          tooltip.hide();
        }
      });
    }

    function setMobileState(open) {
      sidebar.classList.toggle('is-open', open);
      document.body.classList.toggle('sidebar-open', open);
    }

    function closeMobileSidebar() {
      if (!sidebar.classList.contains('is-open')) return;
      setMobileState(false);
    }

    function toggleDesktopState() {
      var isCollapsed = sidebar.getAttribute('data-collapsed') === 'true';
      var nextState = !isCollapsed;
      sidebar.setAttribute('data-collapsed', String(nextState));
      setAriaExpanded(nextState);
      updateTooltips(nextState);
    }

    function handleToggle(event) {
      if (mq.matches) {
        event.preventDefault();
        var isOpen = sidebar.classList.contains('is-open');
        setMobileState(!isOpen);
      } else {
        toggleDesktopState();
      }
    }

    toggles.forEach(function (button) {
      button.addEventListener('click', handleToggle);
    });

    function handleBreakpointChange(e) {
      if (e.matches) {
        sidebar.setAttribute('data-collapsed', 'false');
        setAriaExpanded(false);
        updateTooltips(false);
      } else {
        setMobileState(false);
      }
    }

    if (typeof mq.addEventListener === 'function') {
      mq.addEventListener('change', handleBreakpointChange);
    } else if (typeof mq.addListener === 'function') {
      mq.addListener(handleBreakpointChange);
    }
    handleBreakpointChange(mq);

    sidebar.addEventListener('click', function (evt) {
      if (!mq.matches) return;
      if (evt.target.closest('.nav-link') || evt.target.closest('.logout-link')) {
        closeMobileSidebar();
      }
    });

    function handleOutsidePointer(evt) {
      if (!mq.matches) return;
      if (!sidebar.classList.contains('is-open')) return;
      var clickedToggle = toggles.some(function (btn) {
        return btn && btn.contains(evt.target);
      });
      if (clickedToggle || sidebar.contains(evt.target)) {
        return;
      }
      closeMobileSidebar();
    }

    document.addEventListener('pointerdown', handleOutsidePointer);
  });
</script>