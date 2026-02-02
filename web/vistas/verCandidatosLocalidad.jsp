<%-- 
    Document   : verCandidatosLocalidad
    Created on : 2 dic 2025, 11:11:46
    Author     : isido
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelos.Localidad"%>
<%@page import="java.util.ArrayList"%>
<%!boolean muestraTabla = false;%>
<%
    ArrayList<Localidad> todasLocalidades = new ArrayList();
    todasLocalidades = (ArrayList<Localidad>) session.getAttribute("todasLocalidades");
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Candidatos por localidad</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>CANDIDATOS POR LOCALIDAD</h1>
        <br>
        <br>
        <form action="../VerCandidatosLocalidadServlet">
            <label for="localidad">Localidad: </label>
            <select name="localidad" id="localidad">
                <option value="0"></option>
                <% for (int i = 0; i < todasLocalidades.size(); i++) {%>
                <option value="<%=todasLocalidades.get(i).getIdLocalidad() %>"><%=todasLocalidades.get(i).getNombreLocalidad() %></option>
                <%}%>
            </select>   
            <br><br>
            <button type="submit">Ver candidatos</button>
        
        
        
        
        </form>
        </center>
    </body>
</html>
