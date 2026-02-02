<%-- 
    Document   : indexAdmin
    Created on : 8 nov 2025, 11:46:02
    Author     : isido
--%>

<%@page import="modelos.Censo"%>
<%@page import="modelos.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // nos guardamos todas las cookies en un array
    Cookie[] cookies = request.getCookies();
    String nombUsu="";
    // recorremos todas las cookies buscando la que queremos
    for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("nombUsu")) {
                    nombUsu=cookies[i].getValue();
            }
    }
    
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
        <title>ADMIN INDEX</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
        
    </head>
    <body>
    <center>
        <h1>BIENVENIDO ADMINISTRADOR</h1>
        <br>
        <p>Hola <%=nombUsu%> ¿Qué quiere hacer?</p>
        <br>
        <br>

        <form action="../GestionRutasServlet"> 
            <table>
                <tr>
                    <th><label for="GestionPartidos">Gestión Censo</label></th>
                    <th><label for="GestionPartidos">Gestión Partidos</label></th>
                    <th><label for="GestionCandidatos">Gestión Candidatos</label></th>
                    <th><label for="GestionElecciones">Gestión Elecciones</label></th>
                    <th><label for="Votar">Votar</label></th>
                    <th><label for="GestionPartidos">Mostrar resultados</label></th>
                </tr>
                <tr>
                    <td><input class="proceso" type="submit" name="action" value="Censo completo"></td>
                    <td><input class="funciona" type="submit" name="action" value="Dar de alta un partido"></td>
                    <td><input class="funciona" type="submit" name="action" value="Dar de alta un candidato"></td>
                    <td><input class="funciona" type="submit" name="action" value="Crear nuevas elecciones"></td>
                    <td><input class="funciona" type="submit" name="action" value="Votar"></td> 
                    <td><input class="funciona" type="submit" name="action" value="Mostrar resultados"></td>
                </tr>
                <tr>
                    <td><!--<input class="proceso" type="submit" name="action" value="Censo Comunidad">--></td>
                    <td><input class="funciona" type="submit" name="action" value="Ver partidos"></td>
                    <td><input class="funciona" type="submit" name="action" value="Ver candidatos"></td>
                    <td><input class="funciona" type="submit" name="action" value="Abrir elecciones"></td> 
                </tr>
                <tr>
                    <td><!--<input class="proceso" type="submit" name="action" value="Censo Localidad">--></td>
                    <td></td>
                    <td></td>
                    <td><input class="funciona" type="submit" name="action" value="Finalizar elecciones"></td> 
                </tr>
       
            </table> 
            </form>
            <br>
            <br>
            <a href="../salir.jsp">Salir de la aplicacion</a>
    </center>
</body>
</html>
