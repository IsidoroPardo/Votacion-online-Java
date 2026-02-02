<%-- 
    Document   : verCookieGanador
    Created on : 2 dic 2025, 14:02:01
    Author     : isido
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie[] cookies = request.getCookies();
    String partidoGanador="";
    for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("partidoGanador")) {
                    partidoGanador=cookies[i].getValue();
            }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cookie Ganador</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
        <center>
        <h1>El partido ganador es <%=partidoGanador%></h1>
        <br>
        <br>
        <br>
        <a href='vistas/indexAnalista.jsp'>Volver a inicio</a>
        </center>
    </body>
</html>
