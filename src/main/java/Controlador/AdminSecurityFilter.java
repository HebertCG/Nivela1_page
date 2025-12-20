package Controlador;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.Usuario;

/**
 * Filtro de seguridad para proteger todas las rutas /admin/*
 * Redirige a login si no hay sesión activa
 */
@WebFilter("/admin/*")
public class AdminSecurityFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización del filtro
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Obtener la sesión (sin crear una nueva)
        HttpSession session = httpRequest.getSession(false);

        // Verificar si hay usuario logueado
        Usuario usuario = null;
        if (session != null) {
            usuario = (Usuario) session.getAttribute("usuario");
        }

        // Si no hay usuario logueado, redirigir a login
        if (usuario == null) {
            // Guardar la URL original para redirigir después del login
            String requestedUrl = httpRequest.getRequestURI();
            if (httpRequest.getQueryString() != null) {
                requestedUrl += "?" + httpRequest.getQueryString();
            }

            if (session == null) {
                session = httpRequest.getSession(true);
            }
            session.setAttribute("redirectAfterLogin", requestedUrl);

            // Redirigir a la página de login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=sesion");
            return;
        }

        // Verificar si el usuario tiene rol de administrador (id_rol = 1)
        // Si quieres permitir otros roles, agrega más condiciones aquí
        if (usuario.getIdRol() != 1) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp?error=permisos");
            return;
        }

        // Si todo está bien, continuar con la solicitud
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Limpieza del filtro
    }
}
