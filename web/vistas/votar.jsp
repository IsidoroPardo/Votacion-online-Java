<%-- 
    Document   : votar
    Created on : 17 nov 2025, 9:09:08
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Elecciones"%>
<%@page import="modelos.Partido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace;%>
<%
    String descElec = ((Elecciones) session.getAttribute("eleccionesAbiertas")).getDescripcion();
    if (descElec.equals("")) {
            session.setAttribute("mensajeCorrecto", "Aún no ha elecciones abiertas.");
            response.sendRedirect("../vistaMensaje.jsp");
        }
    
    // GESTIONAR QUE HAYA VOTADO CON LO QUE SEA QUE DEVUELVE LA BBDD
    int votado = ((Usuario) session.getAttribute("usuario")).getVotado();
    System.out.println(votado);
    if (votado==1) {
            session.setAttribute("mensajeError", "Lo siento, ústed ya ha votado.");
            response.sendRedirect("../vistaError.jsp");
        }
    
    ArrayList<Partido> todosPartidos = (ArrayList<Partido>) session.getAttribute("todosPartidos");
    Usuario user = (Usuario) session.getAttribute("usuario");
    
    Usuario iniciado = (Usuario)session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if(rol.equals("admin")){
        enlace="<a href='indexAdmin.jsp'>Volver a inicio</a>";
    } else enlace="<a href='indexUser.jsp'>Volver a inicio</a>";
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Votar</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>VOTA A UN PARTIDO</h1>
        <br>
        <p>Ústed va a votar en las <%=descElec%></p>
        <br>
        <br>
        <br>
        <form action="../RegistroVotoServlet">
            <input type="text" value="<%=user.getDni()%>" hidden="" name="dni"/>
            <table>
                <tr>
                    <th>Logo</th>
                    <th>Partido</th>
                    <th>Votar</th>
                </tr>

                <%for (int i = 0; i < todosPartidos.size(); i++) {%>
                <tr>
                    <td><img src="<%=todosPartidos.get(i).getRutaImagen()%>"></td>
                    <td><p><%=todosPartidos.get(i).getDescripcion()%></p></td>
                    <td><input type="radio" value="<%=todosPartidos.get(i).getSiglas()%>" name="partido"/></td>
                <tr>
                    <%}%>
            </table>
            <br>
            <br>
            <br>
            <input class="votar" type="submit" value="votar">
        </form>
            <br>
            <br>
            <br>
        <%=enlace%>
    </center>
</body>
</html>
