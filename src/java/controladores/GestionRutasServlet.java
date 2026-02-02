/*
 */
package controladores;

import dao.ConexionBBDD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Elecciones;

/**
 *
 * @author isido
 */
public class GestionRutasServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession miSesion = request.getSession(true);
        try (PrintWriter out = response.getWriter()) {
            
            String boton = request.getParameter("action");
            ConexionBBDD bbdd = new ConexionBBDD();
            bbdd.actualizarInfo(miSesion);
            bbdd.cerrarConexion();
            
            // String rol =
            
            switch(boton){ 
                // FUNCION ADMIN
                case "Dar de alta un partido":
                    response.sendRedirect("vistas/altaPartido.jsp");
                break;
                // FUNCION ADMIN
                case "Dar de alta un candidato":
                    response.sendRedirect("vistas/altaCandidato.jsp");
                break;
                // FUNCION ADMIN
                case "Crear nuevas elecciones":
                    response.sendRedirect("vistas/altaElecciones.jsp");
                break;
                // FUNCION ADMIN
                case "Finalizar elecciones":
                    response.sendRedirect("FinalizarEleccionesServlet");
                break;
                
                case "Votar":
                    String descripcion = ((Elecciones)miSesion.getAttribute("eleccionesAbiertas")).getDescripcion() ;
                    if (descripcion.isEmpty()) {
                        miSesion.setAttribute("mensajeError", "Aún no hay elecciones abiertas al voto. Disculpe las molestias");
                        response.sendRedirect("vistaError.jsp");
                    }else response.sendRedirect("vistas/votar.jsp");
                break;
                
                case "Ver partidos":
                    response.sendRedirect("DatosTodosPartidosServlet");
                break;
                case "Ver candidatos":
                    response.sendRedirect("DatosTodosCandidatos");
                break;
                // FUNCION ADMIN
                case "Abrir elecciones":
                    response.sendRedirect("AbrirEleccionesServlet");
                break;
                case "Censo completo":
                    response.sendRedirect("VerCensoCompletoServlet");
                break;
                case "Censo Comunidad":
                    response.sendRedirect("VerCensoComunidadServlet");
                break;
                case "Censo Localidad":
                    response.sendRedirect("VerCensoLocalidadServlet");
                break;
                case "Mostrar resultados":
                    response.sendRedirect("vistas/verResultados.jsp");
                break;
                
                // Funciones analísta
                /*case "Ver partidos":
                    response.sendRedirect("vistas/verResultados.jsp");
                break;*/
                
                /*case "":
                    response.sendRedirect("vistas/verResultados.jsp");
                break;*/
                
                case "Procesar Participacion":
                    response.sendRedirect("vistas/procesarParticipacion.jsp");
                break;
                
                case "Ver Participacion":
                    response.sendRedirect("DatosParticipacion");
                break;
                
                case "Crear Cookie":
                    response.sendRedirect("CrearCookieEleccionesServlet");
                break;
                
                case "Ver Cookie":
                    response.sendRedirect("vistas/verCookieGanador.jsp");
                break;
                
                /*case "":
                    String errorNav = "No se ha navegado correctamente a la página";
                    miSesion.setAttribute("mensajeError", errorNav);
                    response.sendRedirect("vistaError.jsp");
                break;*/
                
                default:
                    String error = "No se ha navegado correctamente a la página";
                    miSesion.setAttribute("mensajeError", error);
                    response.sendRedirect("vistaError.jsp");
                
            }
            } catch (ClassNotFoundException notFound) {
                miSesion.setAttribute("mensajeError", notFound.getMessage());
                response.sendRedirect("vistaError.jsp");
            } catch (SQLException eSQL) {
                miSesion.setAttribute("mensajeError", eSQL.getMessage());
                response.sendRedirect("vistaError.jsp");
            } catch (Exception exc) {
                miSesion.setAttribute("mensajeError", exc.getMessage());
                response.sendRedirect("vistaError.jsp");
            }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
