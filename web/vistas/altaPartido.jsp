<%-- 
    Document   : altaPartido
    Created on : 10 nov 2025, 9:57:52
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario iniciado = (Usuario)session.getAttribute("usuario");
    String rol = iniciado.getRol();
    
    if(rol.equals("user")){
        session.setAttribute("mensajeError", "Usted no tiene permiso para entrar a esta función");
        response.sendRedirect("../vistaError.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta Partido</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>ALTA DE PARTIDO</h1>
        
        <form action="../AltaPartidoServlet">
            <label for="siglas">Siglas del partido: </label>
            <input type="text" name="siglas" id="siglas" required>
            <br>
            <br>
            <label for="descripcion">Descripción: </label>
            <input type="text" name="descripcion" id="descripcion" required>
            <br>
            <br>
            <label for="ruta">Nombre del PNG asociado: </label>
            <input type="text" name="ruta" id="ruta" required>
            <br>
            <br>
            <br>
            <input type="submit" value="Alta Partido">
            <br>
            <br>
            <a href="indexAdmin.jsp">Volver al inicio de Administrador</a>
            <br>
            <br>
            <br>
            <a href="indexAnalista.jsp">Volver al inicio de Analista</a>
        </form>
        
    </center>
    </body>
</html>
