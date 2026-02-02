<%-- 
    Document   : verParticipacion
    Created on : 2 dic 2025, 13:42:52
    Author     : isido
--%>

<%@page import="modelos.Participacion"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    ArrayList<Participacion> todaParticipacion = (ArrayList)session.getAttribute("todaParticipacion");
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datos Participación</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>Datos de participación</h1>
        <table>
            <tr>
                <th>ID LOCALIDAD</th>
                <th>NÚMERO DE CENSADOS</th>
                <th>TOTAL DE VOTOS</th>
                <th>PORCENTAJE DE PARTICIPACIÓN</th>
            </tr>
            
            <%for (int j = 0; j < todaParticipacion.size(); j++) { %>
            <tr>
                <td><%=todaParticipacion.get(j).getIdLocalidad() %></td>
                <td><%=todaParticipacion.get(j).getNumeroCensados() %></td>
                <td><%=todaParticipacion.get(j).getTotalVotos() %></td>
                <td><%=(todaParticipacion.get(j).getTotalVotos()*100)/todaParticipacion.get(j).getNumeroCensados()%>%</td>
            </tr>
                <%}%>
        </table>
        <br>
        <br>
            <a href='indexAnalista.jsp'>Volver a inicio</a>
        </center>
    </body>
</html>
