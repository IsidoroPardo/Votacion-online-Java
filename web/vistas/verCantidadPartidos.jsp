<%-- 
    Document   : verCantidadPartidos
    Created on : 2 dic 2025, 10:34:15
    Author     : isido
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Partido"%>
<%!String partidos="";%>
<%
    ArrayList<Partido> todosPartidos = (ArrayList)session.getAttribute("todosPartidos");
    partidos = "Se podrá votar a: ";
    for (int i = 0; i < todosPartidos.size(); i++) {
        if (i<(todosPartidos.size()-1)) {
                partidos += todosPartidos.get(i).getSiglas() + ", ";
        }
        
        else{
            partidos += todosPartidos.get(i).getSiglas();
        }
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cantidad partidos</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>CANTIDAD DE PARTIDOS</h1>
        <br>
        <br>
        <br>
        <p><%=partidos%></p>
        <br>
        <br>
        <br>
        <a href='indexAnalista.jsp'>Volver a inicio</a>
        </center>
    </body>
</html>
