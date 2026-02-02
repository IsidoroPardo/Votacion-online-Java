<%-- 
    Inicio de sesión con opción a ir a registrarse
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inicio Sesión - Elecciones 2025</title>
        <link rel="stylesheet" type="text/css" href="vistas/estilo.css">
    </head>
    <center>
    <body>
        <h1>Bienvenido a la página de votación online</h1>
        
        <form name="inicioSesion" action="InicioSesionServlet" method="post">
            <h2>Inicio de sesión</h2>
            <label for="usuario">Dni</label>
            <input type="text" name="usuario" id="usuario">
            <br>
            <br>
            <label for="contra">Contraseña</label>
            <input type="text" name="contra" id="contra">
            <br>
            <br>
            <input type="submit" value="Iniciar sesión">
        </form>
        <br>
        <label for="registro">¿No tienes una cuenta?</label>
        <br>
        <a href="vistas/registroUsuario.jsp" name="registro">Pulsa aquí para registrarte</a>
        
    </center>
    </body>
</html>

