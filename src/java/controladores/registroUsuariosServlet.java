/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Usuario;
import dao.ConexionBBDD;

/**
 *
 * @author isido
 */
public class registroUsuariosServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            // para las tildes
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            
            HttpSession miSesion = request.getSession(true);
            
            String boton = request.getParameter("registro");
            if (boton.equalsIgnoreCase("Registrarse")) {
                String dni = request.getParameter("dni");
                String contra = request.getParameter("contra");
                String contra2 = request.getParameter("contra2");
                
                if(contra.equals(contra2)){
                    Usuario nuevo = new Usuario(dni,contra,"user");
                    try{
                        ConexionBBDD bbdd = new ConexionBBDD();
                        int filas = bbdd.altaUsuario(nuevo);
                        bbdd.cerrarConexion();
                        
                        if (filas==1) {
                            miSesion.setAttribute("mensajeCorrecto", "Alta de usuario efectuada");
                            response.sendRedirect("vistaMensaje.jsp");
                        } else {
                            miSesion.setAttribute("mensajeError", "ERROR: No se ha podido dar de alta al usuario");
                            response.sendRedirect("vistaError.jsp");
                        }
                        
                    } catch(ClassNotFoundException notFound) {
                        miSesion.setAttribute("mensajeError", notFound.getMessage());
                        response.sendRedirect("vistaError.jsp");
                    } catch(SQLException eSQL){
                        miSesion.setAttribute("mensajeError", eSQL.getMessage());
                        response.sendRedirect("vistaError.jsp");
                    } catch(Exception exc){
                        miSesion.setAttribute("mensajeError", exc.getMessage());
                        response.sendRedirect("vistaError.jsp");
                    }
                    
                }
                
                else{
                    miSesion.setAttribute("mensajeError", "Las contraseñas deben coincidir");
                    response.sendRedirect("vistaError.jsp");
                }
                
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

}
