<%-- 
    Document   : verCanidatos
    Created on : 12 nov 2025, 10:36:33
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="modelos.Candidato"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace;%>
<%!int tamanio=0;%>
<%
    ArrayList<Candidato> candidatosPartido = (ArrayList)session.getAttribute("todosCandidatos");
    
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
        <title>Todos los Candidatos</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>TODOS LOS CANDIDATOS</h1>
        <table>
            <tr>
                <th>DNI</th>
                <th>NOMBRE COMPLETO</th>
                <th>SIGLAS DEL PARTIDO</th>
                <th>ORDEN</th>
            </tr>
            
            <%for (int j = 0; j < candidatosPartido.size(); j++) { %>
            <tr>
                <td><%=candidatosPartido.get(j).getDni() %></td>
                <td><%=candidatosPartido.get(j).getNombreCompleto() %></td>
                <td><%=candidatosPartido.get(j).getSiglasPartido() %></td>
                <td><%=candidatosPartido.get(j).getOrden() %></td>
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



