<%-- 
    Document   : registroUsuario
    Created on : 5 nov 2025, 18:22:35
    Author     : isido
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registro de usuario</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
        
    </head>
    <body>
    <center>
        <h1>Registro de usuarios</h1>
        <form method="post" action="../registroUsuariosServlet" accept-charset="UTF-8">
            <label for="dni">Introduzca su DNI</label>
            <input type="text" name="dni" id="dni" required>
            <br>
            <br>
            <label for="contra">Introduzca una contraseña</label>
            <input type="text" name="contra" id="contra" required>
            <br>
            <br>
            <label for="contra2">Repita la contraseña</label>
            <input type="text" name="contra2" id="contra2" required>
            <br>
            <br>
            <input type="submit" name="registro" value="Registrarse">
            
        </form>
    </center>
    </body>
</html>
