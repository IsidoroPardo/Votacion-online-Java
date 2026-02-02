<%-- 
    Document   : salir
    Created on : 23 nov 2025, 17:46:03
    Author     : isido
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie[] cookies = request.getCookies();
    String nombreUsu="";
    for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("nombUsu")) {
                    nombreUsu=cookies[i].getValue();
                }
        }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cerrar sesión</title>
        <link rel="stylesheet" type="text/css" href="vistas/estilo.css">
    </head>
    <body>
        <center>
        <h1>Gracias por tu tiempo <%=nombreUsu%></h1>
        <br>
        <br>
        <br>
        <br>
        <br>
        <a href="indexNew.jsp">Volver a iniciar sesión</a>
        </center>
    </body>
</html>
