<%-- 
    Document   : vistaError
    Created on : 5 nov 2025, 18:23:47
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!String enlace = "";%>
<%!String alta = "";%>
<%
    String error = (String)session.getAttribute("mensajeError");
    
    Usuario iniciado = (Usuario) session.getAttribute("usuario");
    
    String rol = "";
    if(iniciado != null){
        rol = iniciado.getRol();
    }
    
    if(!rol.equals("")){
        if (rol.equals("admin")) {
            enlace = "<a href='vistas/indexAdmin.jsp'>Volver a inicio</a>";
        }
        else if(rol.equals("analista")){
            enlace = "<a href='vistas/indexAnalista.jsp'>Volver a inicio</a>";
            alta = "<a href='vistas/altaPartido.jsp'>Dar de alta a un partido</a>";
        }
        else {
            enlace = "<a href='vistas/indexUser.jsp'>Volver a inicio</a>";
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ERROR</title>
        <link rel="stylesheet" type="text/css" href="vistas/estilo.css">
    </head>
    <body>
        <center>
        <h1>HA OCURRIDO UN ERROR</h1>
        <br>
        <br>
        <br>
        <h2><%=error%></h2>
        <br>
        <%=alta%>
        <br>
        <br>
        <%=enlace%>
        <br>
        <br>
        </center>
    </body>
</html>
