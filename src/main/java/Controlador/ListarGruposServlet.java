package Controlador;

import DAO.GrupoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Grupo;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListarGruposServlet", urlPatterns = {"/ListarGruposServlet"})
public class ListarGruposServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("GET recibido en ListarGruposServlet");
        

        String accion = request.getParameter("accion");
        
        if ("eliminar".equals(accion)) {
            eliminarGrupo(request, response);
            return;
        }
        

        cargarGrupos(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("🚀 POST recibido en ListarGruposServlet");
        

        cargarGrupos(request, response);
    }

    private void cargarGrupos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            GrupoDAO grupoDAO = new GrupoDAO();
            
    
            String carreraFiltro = request.getParameter("carrera");
            
            List<Grupo> grupos;
            
            if (carreraFiltro != null && !carreraFiltro.trim().isEmpty()) {
                System.out.println("🔍 Filtrando grupos por carrera: " + carreraFiltro);
                grupos = grupoDAO.listarGruposPorCarrera(carreraFiltro);
                request.setAttribute("selectedCarrera", carreraFiltro);
            } else {
                System.out.println("📋 Cargando todos los grupos");
                grupos = grupoDAO.listarGrupos();
            }
            
            System.out.println("✅ Grupos encontrados: " + grupos.size());
            
   
            request.setAttribute("grupos", grupos);
            

            request.getRequestDispatcher("/admin/grupos.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.out.println("❌ Error al cargar grupos: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("mensajeError", "Error al cargar los grupos: " + e.getMessage());
            request.getRequestDispatcher("/admin/grupos.jsp").forward(request, response);
        }
    }
    

    private void eliminarGrupo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idGrupoStr = request.getParameter("idGrupo");
        
        if (idGrupoStr == null || idGrupoStr.trim().isEmpty()) {
            request.setAttribute("mensajeError", "ID de grupo no válido");
            cargarGrupos(request, response);
            return;
        }
        
        try {
            int idGrupo = Integer.parseInt(idGrupoStr);
            GrupoDAO grupoDAO = new GrupoDAO();
            
            System.out.println("🗑️ Intentando eliminar grupo con ID: " + idGrupo);
            

            boolean eliminado = grupoDAO.eliminarGrupo(idGrupo);
            
            if (eliminado) {
                System.out.println("✅ Grupo eliminado exitosamente");
                request.setAttribute("mensajeExito", "Grupo eliminado exitosamente");
            } else {
                System.out.println("❌ No se pudo eliminar el grupo");
                request.setAttribute("mensajeError", "No se pudo eliminar el grupo");
            }
            
        } catch (NumberFormatException e) {
            System.out.println("❌ ID de grupo inválido: " + idGrupoStr);
            request.setAttribute("mensajeError", "ID de grupo inválido");
        } catch (Exception e) {
            System.out.println("❌ Error al eliminar grupo: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al eliminar grupo: " + e.getMessage());
        }
        

        cargarGrupos(request, response);
    }
}
