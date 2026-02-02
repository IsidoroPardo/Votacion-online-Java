/*
 */
package controladores;

import dao.ConexionBBDD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.MinimoPartidosPoliticosException;
import modelos.Partido;
import modelos.Usuario;

/**
 *
 * @author isido
 */
public class DatosTodosPartidosServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            // para las tildes
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            HttpSession miSesion = request.getSession(true);

            try {
                ConexionBBDD bbdd = new ConexionBBDD();
                ArrayList<Partido> todosPartidos = new ArrayList();
                
                todosPartidos = bbdd.getTodosPartidos();
                bbdd.cerrarConexion();
                
                if(todosPartidos.isEmpty()){
                    throw new Exception("No hay partidos guardados o no se han encontrado en la BBDD");
                }
                else{
                    miSesion.setAttribute("todosPartidos", todosPartidos);
                    Usuario iniciado = (Usuario) miSesion.getAttribute("usuario");
                    String rol = iniciado.getRol();
                    
                    if(rol.equals("analista")){
                        if (todosPartidos.size()<4) {
                            throw new MinimoPartidosPoliticosException();
                        }
                        
                        response.sendRedirect("vistas/verCantidadPartidos.jsp"); 
                    } 
                    else{
                    response.sendRedirect("vistas/verPartidos.jsp"); 
                    }
                }
                
            } catch (ClassNotFoundException notFound) {
                miSesion.setAttribute("mensajeError", notFound.getMessage());
                response.sendRedirect("vistaError.jsp");
            } catch (SQLException eSQL) {
                miSesion.setAttribute("mensajeError", eSQL.getMessage());
                response.sendRedirect("vistaError.jsp");
            } catch (MinimoPartidosPoliticosException ex) {
                miSesion.setAttribute("mensajeError", ex.getMessage());
                response.sendRedirect("vistaError.jsp");
            } catch (Exception exc) {
                miSesion.setAttribute("mensajeError", exc.getMessage());
                response.sendRedirect("vistaError.jsp");
            }
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

    private Exception MinimoPartidosPoliticosException() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
