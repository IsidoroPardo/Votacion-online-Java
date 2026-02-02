/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
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
import modelos.Escrutinio;

/**
 *
 * @author isido
 */
public class RegistroVotoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            // para las tildes
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
            HttpSession miSesion = request.getSession(true);
            
            String dni = request.getParameter("dni");
            String siglas= request.getParameter("partido");
            
            try{
                ConexionBBDD bbdd = new ConexionBBDD();
                
                // controlar que funciona o redirigir
                
                int localidad = bbdd.getLocalidadDeUser(dni);
                int comunidad = bbdd.getComunidadDeLocalidad(localidad);
                int idEleccionesAbierta = ((Elecciones)miSesion.getAttribute("eleccionesAbiertas")).getIdElecciones();
                System.out.println("DATOS LOC, COM Y IDELEC: "+localidad + ", "+ comunidad +", "+ idEleccionesAbierta);
                                        // int idElecciones, String partido, int localidad, int comunidad
                Escrutinio papeleta = new Escrutinio(idEleccionesAbierta, siglas, localidad, comunidad);    
                System.out.println(papeleta.toString());
                if(bbdd.registrarVoto(papeleta)>0){
                    bbdd.haVotado(dni);
                    miSesion.setAttribute("mensajeCorrecto", "Su voto se ha registrado con éxito");
                    response.sendRedirect("vistaMensaje.jsp");
                } else {
                miSesion.setAttribute("mensajeError", "No se ha podido registrar su voto, intentelo de nuevo más tarde");
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
