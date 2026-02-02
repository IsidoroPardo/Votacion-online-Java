<%-- 
    Document   : altaCandidato
    Created on : 11 nov 2025, 19:16:34
    Author     : isido
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Usuario"%>
<%@page import="modelos.Partido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%  
    ArrayList<Partido> todosPartidos = (ArrayList)session.getAttribute("todosPartidos");
    
    // Seguridad de que solo entra un usuario administrador
    Usuario iniciado = (Usuario)session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if(!rol.equals("admin")){
        session.setAttribute("mensajeError", "Usted no tiene permiso para entrar a esta función");
        response.sendRedirect("../vistaError.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta Candidato</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>ALTA DE CANDIDATO</h1>
        
        <form action="../AltaCandidatoServlet">
            <label for="dni">Dni del candidato: </label>
            <input type="text" name="dni" id="dni" required>
            <br>
            <br>
            <label for="nombreCompleto">Nombre Completo del Candidato: </label>
            <input type="text" name="nombreCompleto" id="nombreCompleto" required>
            <br>
            <br>
            <label for="siglas">Partido al que pertenece: </label>
            <select name="siglas" id="siglas" required>
                <% for (int i = 0; i < todosPartidos.size(); i++) {%>
                <option value="<%=todosPartidos.get(i).getSiglas() %>"><%=todosPartidos.get(i).getDescripcion() %></option>     
                <%}%>
            </select>
            <br>
            <br>
            <label for="orden">Orden del candidato: </label>
            <select name="orden" id="orden" required>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
            </select>
            <br>
            <br>
            <br>
            <input type="submit" name="altaCandidato" value="Alta Candidato">
            <br>
            <br>
            <a href="indexAdmin.jsp">Volver al inicio de Administrador</a>
        </form>
        
    </center>
    </body>
</html>
