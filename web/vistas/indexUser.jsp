<%-- 
    Document   : indexUser
    Created on : 8 nov 2025, 11:45:50
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="modelos.Censo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Cookie[] cookies = request.getCookies();
    String nombreUsu = "";
    for (int i = 0; i < cookies.length; i++) {
        if (cookies[i].getName().equals("nombUsu")) {
            nombreUsu = cookies[i].getValue();
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>USER INDEX</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>BIENVENIDO USUARIO</h1>
        <br>
        <p>Hola, <%=nombreUsu%></p> 
        <br>
        <br>
        <form action="../GestionRutasServlet"> 
            <table>
                <tr>
                    <th><label for="GestionPartidos">Información Partidos</label></th>
                    <th><label for="GestionCandidatos">Información Candidatos</label></th>
                    <th><label for="Votar">Votar</label></th>
                    <th><label for="GestionPartidos">Mostrar resultados</label></th>
                </tr>
                <tr>
                    <td><input class="btn" type="submit" name="action" value="Comprobar partidos"></td>
                    <td><input class="btn" type="submit" name="action" value="Ver candidatos"></td>
                    <td><input class="btn" type="submit" name="action" value="Votar"></td> 
                    <td><input class="btn" type="submit" name="action" value="Mostrar resultados"></td>
                </tr>

            </table> 
            <br>
            <br>
            <a href="../salir.jsp">Salir de la aplicacion</a>
        </form>
    </center>
</body>
</html>
