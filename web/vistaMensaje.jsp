<%-- 
    Document   : vistaMensaje
    Created on : 5 nov 2025, 18:24:01
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace = "";%>
<%
    String mensaje = (String) session.getAttribute("mensajeCorrecto");
    // String ruta = (String)session.getAttribute("ruta");

    Usuario iniciado = (Usuario) session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if (rol.equals("admin")) {
        enlace = "<a href='vistas/indexAdmin.jsp'>Volver a inicio</a>";
    } 
    if (rol.equals("analista")) {
        enlace = "<a href='vistas/indexAnalista.jsp'>Volver a inicio</a>";
    }
    else {
        enlace = "<a href='indexUser.jsp'>Volver a inicio</a>";
    }


%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mensaje</title>
        <link rel="stylesheet" type="text/css" href="vistas/estilo.css">
    </head>
    <body>
    <center>
        <h1>MENSAJE DE LA APLICACIÓN DE ELECCIONES</h1>
        <br>
        <br>
        <br>
        <h2><%=mensaje%></h2>
        <br>
        <br>
        <br>
        <%=enlace%>
        <br>
        <br>
    </center>
</body>
</html>
