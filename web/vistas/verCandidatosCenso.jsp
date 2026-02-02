<%-- 
    Document   : verCandidatosCenso
    Created on : 2 dic 2025, 11:51:53
    Author     : isido
--%>

<%@page import="modelos.CensoCandidato"%>
<%@page import="java.util.ArrayList"%>
<%!String nomLocalidad="PENDIENTE";%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<CensoCandidato> todosCensoCandidatos = new ArrayList();
    todosCensoCandidatos = (ArrayList<CensoCandidato>) session.getAttribute("todosCandidatosLocalidad");
    //nomLocalidad = todosCensoCandidatos.get(0).
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Candidatos Censo</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>Candidatos por <%=nomLocalidad%></h1>
        <br>
        <br>
        <table>
            <tr>
                <th>DNI</th>
                <th>NOMBRE COMPLETO</th>
                <th>FECHA NACIMIENTO</th>
                <th>DIRECCIÓN</th>
                <th>SIGLAS DEL PARTIDO</th>
            </tr>
            
            <%for (int j = 0; j < todosCensoCandidatos.size(); j++) { %>
            <tr>
                <td><%=todosCensoCandidatos.get(j).getDni() %></td>
                <td><%=todosCensoCandidatos.get(j).getNombreCompleto() %></td>
                <td><%=todosCensoCandidatos.get(j).getFechaNacimiento() %></td>
                <td><%=todosCensoCandidatos.get(j).getDireccion() %></td>
                <td><%=todosCensoCandidatos.get(j).getPartido() %></td>
            </tr>
                <%}%>
            
        </table>
                <a href="indexAnalista.jsp">Volver a inicio</a>
        </center>
    </body>
</html>
