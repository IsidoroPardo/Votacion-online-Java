<%-- 
    Document   : verCensoCompleto
    Created on : 23 nov 2025, 17:11:02
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Censo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace;%>
<%
    ArrayList<Censo> todosCensados = (ArrayList)session.getAttribute("todosCensados");
    
    Usuario iniciado = (Usuario) session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if (rol.equals("admin")) {
        enlace = "<a href='indexAdmin.jsp'>Volver a inicio</a>";
    } else {
        enlace = "<a href='indexUser.jsp'>Volver a inicio</a>";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Censo Completo</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>TODOS LOS CENSADOS</h1>
        <table>
            <tr>
                <th>DNI</th>
                <th>NOMBRE COMPLETO</th>
                <th>FECHA NACIMIENTO</th>
                <th>DIRECCIÓN</th>
                <th>ID LOCALIDAD</th>
            </tr>
            
            <%for (int j = 0; j < todosCensados.size(); j++) { %>
            <tr>
                <td><%=todosCensados.get(j).getDni() %></td>
                <td><%=todosCensados.get(j).getNombreCompleto() %></td>
                <td><%=todosCensados.get(j).getFechaNacimiento() %></td>
                <td><%=todosCensados.get(j).getDireccion() %></td>
                <td><%=todosCensados.get(j).getIdLocalidad() %></td>
                
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
