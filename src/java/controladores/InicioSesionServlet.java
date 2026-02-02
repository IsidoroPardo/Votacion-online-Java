/*

 */
package controladores;

import dao.ConexionBBDD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelos.Censo;
import modelos.Usuario;

/**
 *
 * @author isido
 */
public class InicioSesionServlet extends HttpServlet {

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

                String usuario = request.getParameter("usuario");
                String contraPlana = request.getParameter("contra");
                String contraMD5 = bbdd.encriptadoMD5(contraPlana);

                Usuario iniciado = bbdd.inicioSesion(usuario, contraMD5);
                miSesion.setAttribute("usuario", iniciado);
                // CAMBIAR POR UNA COOKIE
                
                Censo ciudadano = bbdd.guardarDatosCidadano(iniciado);
                
                // Creamos la cookie
                Cookie cookieNom = new Cookie("nombUsu", ciudadano.getNombre());
                response.addCookie(cookieNom);
                
                String pasoEscrutinio = "false";
                Cookie cookiePasoEscru = new Cookie("cookiePasoEscru", pasoEscrutinio);
                response.addCookie(cookiePasoEscru);
                
                bbdd.actualizarInfo(miSesion);
                
                if (iniciado.getRol().equals("user")) {
                    response.sendRedirect("vistas/indexUser.jsp");
                } 
                else if(iniciado.getRol().equals("analista")){
                    response.sendRedirect("vistas/indexAnalista.jsp");
                }
                else {
                    response.sendRedirect("vistas/indexAdmin.jsp");
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
