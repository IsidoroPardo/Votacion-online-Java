<%-- 
    Document   : procesarParticipacion
    Created on : 2 dic 2025, 12:49:15
    Author     : isido
--%>

<%@page import="modelos.Elecciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelos.Localidad"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<Localidad> todasLocalidades = new ArrayList();
    todasLocalidades = (ArrayList<Localidad>) session.getAttribute("todasLocalidades");
    
    ArrayList<Elecciones> eleccionesCerradas = new ArrayList();
    eleccionesCerradas = (ArrayList<Elecciones>) session.getAttribute("todasEleccionesCerradas");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Procesar Participación</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>Elige una localidad para añadir a la tabla Participación</h1>
        <br>
        <br>
        <form action="../AltaParticipacionServlet">
            <label for="localidad">Localidad: </label>
            <select name="localidad" id="localidad">
                <option value="0"></option>
                <% for (int i = 0; i < todasLocalidades.size(); i++) {%>
                <option value="<%=todasLocalidades.get(i).getIdLocalidad() %>"><%=todasLocalidades.get(i).getNombreLocalidad()%></option>
                <%}%>
            </select>   
            <br><br>
            <label for="elecciones">Eliga unas elecciones: </label>
            <select name="elecciones" id="elecciones">
                <option value="0"></option>
                <% for (int i = 0; i < eleccionesCerradas.size(); i++) {%>
                <option value="<%=eleccionesCerradas.get(i).getIdElecciones()%>"><%=eleccionesCerradas.get(i).getDescripcion()%></option>
                <%}%>
            </select>
            <br><br>
            <button type="submit">Añadir participación</button>
        </center>
    </body>
</html>
