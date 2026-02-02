<%-- 
    Document   : verResultados
    Created on : 20 nov 2025, 12:14:46
    Author     : isido
--%>

<%@page import="modelos.Usuario"%>
<%@page import="modelos.Recuento"%>
<%@page import="modelos.Localidad"%>
<%@page import="modelos.Candidato"%>
<%@page import="modelos.Comunidad"%>
<%@page import="modelos.Partido"%>
<%@page import="modelos.Escrutinio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelos.Elecciones"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!boolean muestraTabla = false;%>
<%!String enlace = "";%>
<%!String presidente = "";%>
<%!String partido = "";%>
<%!String siglasPartido = "";%>
<%!int votos = 0;%>
<%
    ArrayList<Elecciones> eleccionesCerradas = new ArrayList();
    ArrayList<Partido> todosPartidos = new ArrayList();
    ArrayList<Candidato> todosCandidatos = new ArrayList();
    ArrayList<Localidad> todasLocalidades = new ArrayList();
    ArrayList<Comunidad> todasComunidades = new ArrayList();

    eleccionesCerradas = (ArrayList<Elecciones>) session.getAttribute("todasEleccionesCerradas");
    
    Usuario iniciado = (Usuario)session.getAttribute("usuario");
    String rol = iniciado.getRol();
    if(rol.equals("admin")){
        enlace="<a href='indexAdmin.jsp'>Volver a inicio</a>";
    } else enlace="<a href='indexUser.jsp'>Volver a inicio</a>";
    
    if (eleccionesCerradas.isEmpty()) {
        session.setAttribute("mensajeError", "No hay elecciones finalizadas, disculpe las molestias.");
        response.sendRedirect("../vistaError.jsp");
    } else {

        todasLocalidades = (ArrayList<Localidad>) session.getAttribute("todasLocalidades");
        todasComunidades = (ArrayList<Comunidad>) session.getAttribute("todasComunidades");
        todosCandidatos = (ArrayList<Candidato>) session.getAttribute("todosCandidatos");
        todosPartidos = (ArrayList<Partido>) session.getAttribute("todosPartidos");

        Cookie[] cookies = request.getCookies();
        String pasoEscrutinio = "";

        for (int i = 0; i < cookies.length; i++) {
            if (cookies[i].getName().equals("cookiePasoEscru")) {
                pasoEscrutinio = cookies[i].getValue();
            }
        }

        if (pasoEscrutinio.equals("true")) {
            
            Recuento masVotado = (Recuento) session.getAttribute("masVotado");
            siglasPartido = masVotado.getPartido();
            votos = masVotado.getVotos();
            System.out.println(siglasPartido);
            String siglas = "";
            for (int i = 0; i < todosCandidatos.size(); i++) {

                if (((todosCandidatos.get(i).getSiglasPartido()).equalsIgnoreCase(masVotado.getPartido())
                        && (todosCandidatos.get(i).getOrden().equalsIgnoreCase("1")))) {

                    presidente = todosCandidatos.get(i).getNombreCompleto();
                    siglas = todosCandidatos.get(i).getSiglasPartido();
                }
            }
            for (int i = 0; i < todosPartidos.size(); i++) {
                if (todosPartidos.get(i).getSiglas().equals(siglas)) {
                    partido = todosPartidos.get(i).getDescripcion();
                }
            }
            muestraTabla = true;
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resultados del Escrutinio</title>
        <link rel="stylesheet" type="text/css" href="estilo.css">
    </head>
    <body>
    <center>
        <h1>Vista Resultados Electorales</h1>
        <form action="../ResultadosEscrutinioServlet">
            <label for="elecciones">Elecciones: </label>
            <select name="elecciones" id="elecciones">
                <option value="0"></option>
                <% for (int i = 0; i < eleccionesCerradas.size(); i++) {%>
                <option value="<%=eleccionesCerradas.get(i).getIdElecciones()%>"><%=eleccionesCerradas.get(i).getDescripcion()%></option>
                <%}%>
            </select>   
            <br><br>
            <label for="tipo">Tipo de Escrutinio: </label>
            <select name="tipo" id="tipo">
                <option value="null"></option>
                <option value="total">Total</option>
                <option value="loc">Por Localidades</option>
                <option value="com">Por Comunidades</option>
            </select>
            <br><br>
            <label for="loc">Localidad: </label>
            <select name="loc" id="loc">
                <option value="0"></option>
                <% for (int i = 0; i < todasLocalidades.size(); i++) {%>
                <option value="<%=todasLocalidades.get(i).getIdLocalidad()%>"><%=todasLocalidades.get(i).getNombreLocalidad()%></option>
                <%}%>
            </select>
            <br><br>
            <label for="com">Comunidad: </label>
            <select name="com" id="com">
                <option value="0"></option>
                <% for (int i = 0; i < todasComunidades.size(); i++) {%>
                <option value="<%=todasComunidades.get(i).getIdComunidad()%>"><%=todasComunidades.get(i).getNombreComunidad()%></option>
                <%}%>
            </select>
            <br><br>
            <button type="submit">Ver resultados</button>
        </form>
        <br>
        <br>
        <%if (muestraTabla) {%>
        <h2>Resultados elecciones:</h2>
        <p>El partido más votado ha sido  <%=siglasPartido%> con <%=votos%> votos</p>
        <p>El presidente del gobierno es <%=presidente%> por el <%=partido%></p>
        <%}%>
        <br>
        <br>
        <br>
        <%=enlace%>
    </center>
</body>
</html>
