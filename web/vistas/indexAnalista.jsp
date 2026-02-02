<%-- 
    Document   : indexAnalista
    Created on : 2 dic 2025, 9:58:07
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie[] cookies = request.getCookies();
    String nombreUsu = "";
    for (int i = 0; i < cookies.length; i++) {
        if (cookies[i].getName().equals("nombUsu")) {
            nombreUsu = cookies[i].getValue();
        }
    }
    System.out.println("ESTOY AQUÍ");
    Usuario iniciado = (Usuario) session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if (!rol.equals("analista")) {
        session.setAttribute("mensajeError", "Usted no tiene permiso para entrar a esta función");
        response.sendRedirect("../vistaError.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index analista</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>BIENVENID@ ANALISTA <%=nombreUsu%></h1> 
        <br>
        <br>
        <form action="../GestionRutasServlet"> 
            <table>
                <tr>
                    <th><label for="CheckPartidos">Partidos</label></th>
                    <th><label for="CandidatosLocalidad">Candidatos</label></th>
                    <th><label for="GetParticipacion">Participación</label></th>
                    <th><label for="GetParticipacion">Ganador elecciones</label></th>
                   <!-- <th><label for="VerParticipacion">Ver % de participación</label></th> -->
                </tr>
                <tr>
                    <td ><input class="btn" type="submit" name="action" value="Ver partidos"></td>
                    <td ><input class="btn" type="submit" name="action" value="Ver candidatos"></td>
                    <td ><input class="btn" type="submit" name="action" value="Procesar Participacion"></td> 
                    <td ><input class="btn" type="submit" name="action" value="Crear Cookie"></td> 
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td ><input class="btn" type="submit" name="action" value="Ver Participacion"></td>
                    <td ><input class="btn" type="submit" name="action" value="Ver Cookie"></td>
                </tr>

            </table> 
            <br>
            <br>
            <a href="../salir.jsp">Salir de la aplicacion</a>
        </center>
    </body>
</html>
