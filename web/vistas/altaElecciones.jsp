<%-- 
    Document   : altaElecciones
    Created on : 13 nov 2025, 11:58:47
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Seguridad de que solo entra un usuario administrador
    Usuario iniciado = (Usuario) session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if (!rol.equals("admin")) {
        session.setAttribute("mensajeError", "Usted no tiene permiso para entrar a esta función");
        response.sendRedirect("../vistaError.jsp");
    }

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alta Elecciones</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>Alta Elecciones</h1>
        <form action="../AltaEleccionesServlet">
            <label for="descripcion">Descripción elecciones: </label>
            <input type="text" name="descripcion" id="descripcion" required>
            <br>
            <br>
            <label for="fechaInicio">Fecha inicio (aaaa-mm-dd): </label>
            <input type="text" name="fechaInicio" id="fechaInicio" required>
            <br>
            <br>
            <label for="fechaFin">Fecha fin (aaaa-mm-dd): </label>
            <input type="text" name="fechaFin" id="fechaFin" required>
            <br>
            <br>
            <input type="submit" name="altaElecciones" value="Alta Elecciones">
            <br>
            <br>
            <a href="indexAdmin.jsp">Volver al inicio de Administrador</a>
        </form>
        </center>
    </body> 
</html>
