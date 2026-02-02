<%-- 
    Document   : verPartidos
    Created on : 11 nov 2025, 13:56:37
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Partido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace="";%>
<%
    ArrayList<Partido> todosPartidos = (ArrayList)session.getAttribute("todosPartidos");
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
        <title>VER PARTIDOS</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>LISTA CON TODOS LOS PARTIDOS</h1>
        <br>
        <br>
        <br>
        <table>
            <tr> 
                <th>Siglas</th>
                <th>Descripción</th>
                <th>Imagen</th>
            </tr>
            <% for (int i = 0; i < todosPartidos.size(); i++) {%>
            <tr>
                <td><%=todosPartidos.get(i).getSiglas() %></td>
                <td><%=todosPartidos.get(i).getDescripcion() %></td>
                <td><img src="<%=todosPartidos.get(i).getRutaImagen() %>" alt="imagen partido" /></td>
            </tr>
            <%}%>
        </table>
        <br>
        <br>
        <br>
        <%=enlace%>
    </center>
    </body>
</html>
