/*
    CLASE PARA EL ACCESO A LA BASE DE DATOS DE LAS ELECCIONES 
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import modelos.Usuario;
import java.security.MessageDigest;
import java.math.BigInteger;
import java.time.LocalDate;
import java.time.Period;
import javax.servlet.http.HttpSession;
import modelos.Candidato;
import modelos.Censo;
import modelos.CensoCandidato;
import modelos.Elecciones;
import modelos.Escrutinio;
import modelos.Localidad;
import modelos.Comunidad;
import modelos.MenorEdadException;
import modelos.Participacion;
import modelos.Partido;
import modelos.Recuento;

/**
 *
 * @author isido
 */
public class ConexionBBDD {

    // 
    private String url;
    private String usuario;
    private String contrasena;
    // generar como los apuntes
    private Connection conexion;
    private Statement sentencia;
    // me da la respuesta de un SELECT
    private ResultSet resultado;
    // declaración para las sentecias preparadas
    private PreparedStatement sentenciaPreparada;
    private String sal = "J54g5J4h54J68J78H79kLG";

    //Constructor
    public ConexionBBDD() throws ClassNotFoundException, SQLException {
        // bbdd creada en PhpMyAdmin  // para lo de las tildes
        this.url = "jdbc:mysql://localhost:3306/bbdd_ipm_elecciones?useUnicode=true&characterEncoding=UTF-8";
        this.usuario = "root";
        this.contrasena = "";

        // ESTO ES SIEMPRE IGUAL 
        // Cargar el driver para que Java y MySQL se entiendan
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Se obtiene una conexión con la base de datos 
        this.conexion = DriverManager.getConnection(this.url, this.usuario, this.contrasena);
        // Se crea un Statement, para realizar las acciones
        this.sentencia = this.conexion.createStatement();
    }

    // para que se actualice la info en las sesiones al añadir o cambiar cosas en la bbdd
    public void actualizarInfo(HttpSession miSesion) throws SQLException, Exception {

        ArrayList<Partido> todosPartidos = new ArrayList();
        todosPartidos = getTodosPartidos();
        miSesion.setAttribute("todosPartidos", todosPartidos);

        ArrayList<Candidato> todosCandidatos = new ArrayList();
        todosCandidatos = getTodosCandidatos();
        miSesion.setAttribute("todosCandidatos", todosCandidatos);

        Elecciones EleccionesAbiertas = getEleccionesAbiertas();
        miSesion.setAttribute("eleccionesAbiertas", EleccionesAbiertas);

        ArrayList<Elecciones> eleccionesCerradas = new ArrayList();
        eleccionesCerradas = getEleccionesCerradas();
        miSesion.setAttribute("todasEleccionesCerradas", eleccionesCerradas);

        ArrayList<Localidad> todasLocalidades = new ArrayList();
        todasLocalidades = getTodasLocalidades();
        miSesion.setAttribute("todasLocalidades", todasLocalidades);

        ArrayList<Comunidad> todasComunidades = new ArrayList();
        todasComunidades = getTodasComunidades();
        miSesion.setAttribute("todasComunidades", todasComunidades);

        //cerrarConexion();
    }

    // Metodo para iniciar sesión
    public Usuario inicioSesion(String usuario, String contra) throws SQLException, Exception {

        String orden = "SELECT * FROM usuarios WHERE dni = ?;";
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.sentenciaPreparada.setString(1, usuario);
        this.resultado = this.sentenciaPreparada.executeQuery();

        String contraBBDD = "";
        String usuarioBBDD = "";
        String rolBBDD = "";
        int votado = 0;
        while (this.resultado.next()) {
            contraBBDD = this.resultado.getString("contra");
            usuarioBBDD = this.resultado.getString("dni");
            rolBBDD = this.resultado.getString("rol");
            votado = this.resultado.getInt("votado");
        }

        if (usuarioBBDD == "") {
            throw new Exception("Usuario o contraseña incorrectos");
        } else if (!contra.equals(contraBBDD)) {
            throw new Exception("Usuario o contraseña incorrectos");
        }

        Usuario iniciado = new Usuario(usuarioBBDD, contraBBDD, rolBBDD, votado);

        return iniciado;
    }

    public Censo guardarDatosCidadano(Usuario iniciado) throws SQLException {
        String orden = "SELECT * FROM censo WHERE dni = ?;";
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.sentenciaPreparada.setString(1, iniciado.getDni());
        this.resultado = this.sentenciaPreparada.executeQuery();

        String dniBBDD = "";
        String nombreCompBBDD = "";
        String fechaNacBBDD = "";
        String direccionBBDD = "";
        int idLocalidadBBDD = 0;
        while (this.resultado.next()) {
            dniBBDD = this.resultado.getString("dni");
            nombreCompBBDD = this.resultado.getString("nombre_completo");
            fechaNacBBDD = this.resultado.getString("fecha_nacimiento");
            direccionBBDD = this.resultado.getString("direccion");
            idLocalidadBBDD = this.resultado.getInt("id_localidad");
        }

        Censo Ciudadano = new Censo(dniBBDD, nombreCompBBDD, fechaNacBBDD, direccionBBDD, idLocalidadBBDD);

        return Ciudadano;
    }

    // Metodo para dar de alta un usuario
    public int altaUsuario(Usuario nuevo) throws Exception {
        int filas = 0;
        if (estaRegistrado(nuevo.getDni())) {
            throw new Exception("Este dni ya está registrado en la aplicación");
        } else if (!estaCensado(nuevo.getDni())) {
            throw new Exception("Este dni no está en el censo, pruebe con otro");
        } else if (esMenor(nuevo.getDni())) {
            throw new MenorEdadException();
        } else {
            System.out.println("entro en altaUsuario exitoso");
            String orden = "INSERT INTO usuarios (dni, contra, rol, votado) VALUES (?, ?, ?, ?); ";
            String dni = nuevo.getDni();
            String contra = encriptadoMD5(nuevo.getContra());
            this.sentenciaPreparada = this.conexion.prepareStatement(orden);
            this.sentenciaPreparada.setString(1, dni);
            this.sentenciaPreparada.setString(2, contra);
            this.sentenciaPreparada.setString(3, "user");
            this.sentenciaPreparada.setInt(4, 0);
            filas = this.sentenciaPreparada.executeUpdate();
        }
        return filas;
    }

    public boolean estaRegistrado(String dniAuditado) throws Exception {
        boolean registrado = false;
        String orden = "SELECT * FROM usuarios; ";
        // preparamos la sentencia preparada con la orden SQL
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.resultado = this.sentenciaPreparada.executeQuery(orden);

        // creamos array y le metemos todos los dnis de la tabla
        ArrayList<String> dniUsers = new ArrayList<String>();
        while (this.resultado.next()) {
            String dni = this.resultado.getString("dni");
            dniUsers.add(dni);
        }
        // buscamos si el dni del usuario está en la tabla 
        for (int i = 0; i < dniUsers.size(); i++) {
            if (dniUsers.get(i).equals(dniAuditado)) {
                registrado = true;
            }
        }
        return registrado;
    }

    public boolean esMenor(String dniAuditado) throws Exception {
        boolean menor = false;
        String orden = "SELECT fecha_nacimiento FROM censo WHERE dni = ?; ";
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.sentenciaPreparada.setString(1, dniAuditado);
        this.resultado = this.sentenciaPreparada.executeQuery();

        ArrayList<String> fechas = new ArrayList<String>();
        // hay que hacer un .next con el resultado para que apunte al primer valor
        while (this.resultado.next()) {
            String fecha = this.resultado.getString("fecha_nacimiento");
            fechas.add(fecha);
        }

        // Procesador de fechas: de String a LocalDate a Period a nº de años del usuario
        String fechaStr = fechas.get(0);
        // fecha ejemplo: 2014-11-19 (son todas así)
        // 0123456789
        System.out.println("anio = " + fechaStr.substring(0, 4));
        System.out.println("mes = " + Integer.parseInt(fechaStr.substring(5, 7)));
        System.out.println("dia = " + fechaStr.substring(8));

        int anio = Integer.parseInt(fechaStr.substring(0, 4));
        int mes = Integer.parseInt(fechaStr.substring(5, 7));
        int dia = Integer.parseInt(fechaStr.substring(8));
        LocalDate fechaProc = LocalDate.of(anio, mes, dia);
        LocalDate fechaHoy = LocalDate.now();
        Period diferencia = fechaProc.until(fechaHoy);

        if (diferencia.getYears() < 18) {
            menor = true;
        }
        return menor;
    }

    public boolean estaCensado(String dniAuditado) throws Exception {
        boolean censado = false;
        System.out.println("entro metodo estaCensado");
        String orden = "SELECT dni FROM censo; ";
        // preparamos la sentencia preparada con la orden SQL 
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.resultado = this.sentenciaPreparada.executeQuery();
        System.out.println("ejecuto la sentencia en estaCensado");
        ArrayList<String> dnis = new ArrayList<String>();
        // hay que hacer un .next con el resultado para que apunte al primer valor
        while (this.resultado.next()) {
            String nombre = this.resultado.getString("dni");
            dnis.add(nombre);
        }
        // buscamos si el dni está en la tabla
        for (int i = 0; i < dnis.size(); i++) {
            if (dnis.get(i).equals(dniAuditado)) {
                censado = true;
            }
        }
        return censado;
    }

    public int haVotado(String dni) throws SQLException, Exception {
        int filas = 0;

        String ordenSQL = "UPDATE `usuarios` SET `votado`= 1 WHERE dni = ?; ";

        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, dni);
        filas = this.sentenciaPreparada.executeUpdate();

        return filas;
    }

    // Método de encriptado de contraseñas
    public String encriptadoMD5(String contra) {
        String contraHex = "";
        contra = contra + this.sal;
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashBytes = md.digest(contra.getBytes());

            // Convertir el array de bytes a una cadena hexadecimal
            BigInteger bigInt = new BigInteger(1, hashBytes);
            contraHex = bigInt.toString(16);

            // Rellenar con ceros a la izquierda para que siempre tenga 32 caracteres
            while (contraHex.length() < 32) {
                contraHex = "0" + contraHex;
            }

            // System.out.println("Texto original: " + texto);
            // System.out.println("Hash MD5: " + contraHex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contraHex;
    }

    //Metodo para dar de alta un partido
    public int altaPartido(String siglas, String descrp, String ruta) throws SQLException {
        int filas = 0;

        String orden = "INSERT INTO partidos VALUES (?, ?, ?);";
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.sentenciaPreparada.setString(1, siglas);
        this.sentenciaPreparada.setString(2, descrp);
        this.sentenciaPreparada.setString(3, ruta);
        filas = this.sentenciaPreparada.executeUpdate();

        return filas;
    }

    // Metodo para obtener todos los partidos guardados en la bbdd
    public ArrayList<Partido> getTodosPartidos() throws SQLException {
        ArrayList<Partido> todosPartidos = new ArrayList<Partido>();
        String orden = "SELECT * FROM partidos;";

        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.resultado = this.sentenciaPreparada.executeQuery();

        String siglas = "";
        String descrp = "";
        String ruta = "";

        while (this.resultado.next()) {
            siglas = this.resultado.getString("Siglas");
            descrp = this.resultado.getString("Descripcion");
            ruta = this.resultado.getString("Rutas");
            todosPartidos.add(new Partido(siglas, descrp, ruta));
        }

        return todosPartidos;
    }

    // Metodo para obtener todos los candidatos ordenados por partidos
    public ArrayList<Candidato> getTodosCandidatos() throws SQLException {
        //String ordenSQL = "SELECT * FROM CANDIDATOS;";

        // aquí lo vamos a ordenar
        ArrayList<Partido> todosPartidos = getTodosPartidos();
        ArrayList<Candidato> candidatosOrdenados = new ArrayList();
        //ArrayList<ArrayList> candidatosPorPartido = new ArrayList();
        for (int i = 0; i < todosPartidos.size(); i++) {
            String siglas = todosPartidos.get(i).getSiglas();
            String ordenSQL = "SELECT * FROM candidatos WHERE siglas_partido = ?;";

            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setString(1, siglas);
            this.resultado = this.sentenciaPreparada.executeQuery();

            while (this.resultado.next()) {
                String dni = this.resultado.getString("dni");
                String nombreCompleto = this.resultado.getString("nombre_candidato");
                String siglasPartido = this.resultado.getString("siglas_partido");
                String orden = this.resultado.getString("orden");
                Candidato cand = new Candidato(dni, nombreCompleto, siglasPartido, orden);
                candidatosOrdenados.add(cand);
            }
        }
        // candidatosPorPartido.add(candidatosOrdenados);

        return candidatosOrdenados;
    }

    public int altaCandidato(Candidato nuevo) throws Exception {
        int filas = 0;

        if (!estaCensado(nuevo.getDni())) {
            throw new Exception("Este dni no está en el censo, pruebe con otro");
        } else if (esMenor(nuevo.getDni())) {
            throw new Exception("No puede ser un candidato, " + nuevo.getNombreCompleto() + " menor de edad");
        } else if (estaInscrito(nuevo.getDni())) {
            throw new Exception("Este DNI ya está inscrito en la BBDD como candidato");
        } else {
            System.out.println("entro en altaUsuario exitoso");
            String ordenSQL = "INSERT INTO candidatos (dni, nombre_candidato, siglas_partido, orden) VALUES (?, ?, ?, ?);";

            String dni = nuevo.getDni();
            String nombreCompleto = nuevo.getNombreCompleto();
            String siglasPartido = nuevo.getSiglasPartido();
            String orden = nuevo.getOrden();

            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setString(1, dni);
            this.sentenciaPreparada.setString(2, nombreCompleto);
            this.sentenciaPreparada.setString(3, siglasPartido);
            this.sentenciaPreparada.setString(4, orden);
            filas = this.sentenciaPreparada.executeUpdate();
            System.out.println("ejecuto la sentencia de altaCandidato");
        }
        return filas;
    }

    public int altaElecciones(Elecciones nuevas) throws Exception {
        int filas = 0;

        String ordenCheck = "SELECT * FROM elecciones WHERE estado = ? OR estado = ?; ";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenCheck);
        this.sentenciaPreparada.setString(1, "abierta");
        this.sentenciaPreparada.setString(2, "cerrada");
        this.resultado = this.sentenciaPreparada.executeQuery();

        int nResuls = 0;

        while (this.resultado.next()) {
            nResuls++;
        }

        if (nResuls == 0) {

            String ordenSQL = "INSERT INTO elecciones VALUES (null, ?, ?, ?, ?); ";

            String descripcion = nuevas.getDescripcion();
            String fechaIni = nuevas.getFechaInicio();
            String fechaFin = nuevas.getFechaFin();
            String estado = nuevas.getEstado();

            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setString(1, descripcion);
            this.sentenciaPreparada.setString(2, fechaIni);
            this.sentenciaPreparada.setString(3, fechaFin);
            this.sentenciaPreparada.setString(4, estado);
            filas = this.sentenciaPreparada.executeUpdate();

            return filas;
        } else {
            throw new Exception("No puede dar de alta otras elecciones, ya hay unas sin finalizar");
        }
    }

    public int abrirElecciones() throws Exception {
        int filas = 0;

        String ordenSQL = "UPDATE `elecciones` SET `estado`='abierta' WHERE estado = ?";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, "cerrada");
        filas = this.sentenciaPreparada.executeUpdate();

        return filas;
    }

    public int finalizarElecciones() throws Exception {
        int filas = 0;

        String ordenSQL = "UPDATE `elecciones` SET `estado`='finalizada' WHERE estado = ?";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, "abierta");
        filas = this.sentenciaPreparada.executeUpdate();

        return filas;
    }

    public Elecciones getEleccionesAbiertas() throws SQLException, Exception {

        String ordenSQL = "SELECT * FROM elecciones WHERE estado = ?; ";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, "abierta");
        this.resultado = this.sentenciaPreparada.executeQuery();

        int idElecciones = 0;
        String descripcion = "";
        String fechaFin = "";
        String fechaIni = "";
        String estado = "";

        while (this.resultado.next()) {
            idElecciones = this.resultado.getInt("id_elecciones");
            descripcion = this.resultado.getString("descripcion");
            fechaIni = this.resultado.getString("fecha_inicio");
            fechaFin = this.resultado.getString("fecha_fin");
            estado = this.resultado.getString("estado");
        }

        Elecciones EleccionAbierta = new Elecciones(idElecciones, descripcion, fechaIni, fechaFin, estado);

        return EleccionAbierta;
    }

    public ArrayList<Elecciones> getEleccionesCerradas() throws SQLException, Exception {
        String ordenSQL = "SELECT * FROM elecciones WHERE estado = ?; ";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, "finalizada");
        this.resultado = this.sentenciaPreparada.executeQuery();

        int idElecciones = 0;
        String descripcion = "";
        String fechaFin = "";
        String fechaIni = "";
        String estado = "";
        ArrayList<Elecciones> eleccionesCerradas = new ArrayList();

        while (this.resultado.next()) {
            idElecciones = this.resultado.getInt("id_elecciones");
            descripcion = this.resultado.getString("descripcion");
            fechaIni = this.resultado.getString("fecha_inicio");
            fechaFin = this.resultado.getString("fecha_fin");
            estado = this.resultado.getString("estado");
            eleccionesCerradas.add(new Elecciones(idElecciones, descripcion, fechaIni, fechaFin, estado));
        }

        return eleccionesCerradas;
    }

    public boolean estaInscrito(String dniAuditado) throws Exception {
        boolean inscrito = false;
        String orden = "SELECT dni FROM candidatos; ";
        // preparamos la sentencia preparada con la orden SQL 
        this.sentenciaPreparada = this.conexion.prepareStatement(orden);
        this.resultado = this.sentenciaPreparada.executeQuery();
        ArrayList<String> dnis = new ArrayList<String>();
        // hay que hacer un .next con el resultado para que apunte al primer valor
        while (this.resultado.next()) {
            String nombre = this.resultado.getString("dni");
            dnis.add(nombre);
        }
        // buscamos si el dni está en la tabla
        String dniCenso = dniAuditado;
        for (int i = 0; i < dnis.size(); i++) {
            if (dnis.get(i).equals(dniCenso)) {
                inscrito = true;
            }
        }
        return inscrito;
    }

    public int getLocalidadDeUser(String dni) throws SQLException, Exception {
        int localidad = 0;

        String ordenSQL = "SELECT * FROM censo WHERE dni = ? ;";

        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, dni);
        this.resultado = this.sentenciaPreparada.executeQuery();

        while (this.resultado.next()) {
            localidad = this.resultado.getInt("id_localidad");
        }

        return localidad;
    }

    public int getComunidadDeLocalidad(int localidad) throws SQLException, Exception {
        int comunidad = 0;

        String ordenSQL = "SELECT * FROM localidades WHERE id_localidad = ? ;";

        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setInt(1, localidad);
        this.resultado = this.sentenciaPreparada.executeQuery();

        while (this.resultado.next()) {
            comunidad = this.resultado.getInt("id_comunidad");
        }

        return comunidad;
    }

    public int registrarVoto(Escrutinio papeleta) throws SQLException, Exception {
        int filas = 0;

        String ordenSQL = "INSERT INTO `escrutinio`(`id_escritinio`, `id_elecciones`, `partido`, `localidad`, `comunidad`) "
                + "VALUES (null, ?, ?, ?, ?)";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setInt(1, papeleta.getIdElecciones());
        this.sentenciaPreparada.setString(2, papeleta.getPartido());
        this.sentenciaPreparada.setInt(3, papeleta.getLocalidad());
        this.sentenciaPreparada.setInt(4, papeleta.getComunidad());
        filas = this.sentenciaPreparada.executeUpdate();

        return filas;
    }

    public ArrayList<Localidad> getTodasLocalidades() throws SQLException, Exception {
        ArrayList<Localidad> todasLocalidades = new ArrayList();

        String ordenSQL = "SELECT * FROM localidades;";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.resultado = this.sentenciaPreparada.executeQuery();

        while (this.resultado.next()) {
            int idLocalidad = this.resultado.getInt("id_localidad");
            String nombLoc = this.resultado.getString("nombre_localidad");
            int idComunidad = this.resultado.getInt("id_comunidad");
            todasLocalidades.add(new Localidad(idLocalidad, nombLoc, idComunidad));
        }

        return todasLocalidades;
    }

    public ArrayList<Comunidad> getTodasComunidades() throws SQLException, Exception {
        ArrayList<Comunidad> todasComunidades = new ArrayList();

        String ordenSQL = "SELECT * FROM comunidades";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.resultado = this.sentenciaPreparada.executeQuery();

        while (this.resultado.next()) {
            int idComunidad = this.resultado.getInt("id_comunidad");
            String nombCom = this.resultado.getString("nombre_comunidad");
            todasComunidades.add(new Comunidad(idComunidad, nombCom));
        }

        return todasComunidades;
    }

    public Recuento getRecuentoVotos(int elecciones, String tipo, int loc, int com) throws SQLException, Exception {
        String partido = "";
        int votos = 0;
        System.out.println("entro en la función getRecuentoVotos");
        System.out.println(tipo);
        String ordenSQL = "";
        Recuento masVotado;

        if (tipo.trim().equalsIgnoreCase("total")) {
            System.out.println("Entro en el IF");
            ordenSQL = "SELECT partido, COUNT(*) AS total_votos, localidad, comunidad FROM escrutinio "
                    + "WHERE id_elecciones = ? GROUP BY partido ORDER BY total_votos DESC LIMIT 1;";
            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setInt(1, elecciones);
            this.resultado = this.sentenciaPreparada.executeQuery();

            while (this.resultado.next()) {
                partido = this.resultado.getString("partido");
                votos = this.resultado.getInt("total_votos");
                System.out.println("DEBUG → partido=" + partido + " votos=" + votos);
            }
        } else if (tipo.equals("loc")) {
            ordenSQL = "SELECT partido, COUNT(*) AS total_votos, localidad, comunidad FROM escrutinio "
                    + "WHERE id_elecciones = ? AND localidad = ? GROUP BY partido ORDER BY total_votos DESC LIMIT 1;";
            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setInt(1, elecciones);
            this.sentenciaPreparada.setInt(2, loc);
            this.resultado = this.sentenciaPreparada.executeQuery();
            while (this.resultado.next()) {
                partido = this.resultado.getString("partido");
                votos = this.resultado.getInt("total_votos");
            }
        } else {
            // tenemos que meter el id concreto de la localidad/comunidad que nos da el SERVLET
            ordenSQL = "SELECT partido, COUNT(*) AS total_votos FROM escrutinio "
                    + "WHERE id_elecciones = ? AND comunidad = ? GROUP BY partido ORDER BY total_votos DESC LIMIT 1;";
            this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
            this.sentenciaPreparada.setInt(1, elecciones);
            this.sentenciaPreparada.setInt(2, com);
            this.resultado = this.sentenciaPreparada.executeQuery();
            while (this.resultado.next()) {
                partido = this.resultado.getString("partido");
                votos = this.resultado.getInt("total_votos");
            }
        }

        System.out.println(partido);
        System.out.println(votos);
        masVotado = new Recuento(partido, votos);

        return masVotado;
    }
    
    public ArrayList<Censo> getTodosCensados()throws SQLException, Exception{
        ArrayList<Censo> todosCensados = new ArrayList();
        
        String ordenSQL = "SELECT * FROM CENSO";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.resultado = this.sentenciaPreparada.executeQuery();
        
        String dni;
        String nombreCompleto;
        String fechaNacimiento;
        String direccion;
        int idLocalidad;
        
        while (this.resultado.next()) {
                dni = this.resultado.getString("dni");
                nombreCompleto = this.resultado.getString("nombre_completo");
                fechaNacimiento = this.resultado.getString("fecha_nacimiento");
                direccion = this.resultado.getString("direccion");
                idLocalidad = this.resultado.getInt("id_localidad");
                todosCensados.add(new Censo(dni, nombreCompleto, fechaNacimiento, direccion, idLocalidad));
            }
        return todosCensados;
    }

    public ArrayList<CensoCandidato> getCandidatosLocalidad(int localidad)throws SQLException, Exception{
        
        // SOLO ME TRAIGO UNO DE LA BBDD
        
        System.out.println("localidad " + localidad);
        
        ArrayList<CensoCandidato> todosCandidatosLocalidad = new ArrayList();
        
        String ordenSQL = "SELECT * FROM censo WHERE id_localidad = ? ;" ;
        
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setInt(1, localidad);
        this.resultado = this.sentenciaPreparada.executeQuery();
        
        String dni;
        String nombreCompleto;
        String fechaNacimiento;
        String direccion;
        int idLocalidad;
        String partido="";
        
        
        while (this.resultado.next()) {
                dni = this.resultado.getString("dni");
                System.out.println("dni censado "+ dni);
                nombreCompleto = this.resultado.getString("nombre_completo");
                fechaNacimiento = this.resultado.getString("fecha_nacimiento");
                direccion = this.resultado.getString("direccion");
                idLocalidad = this.resultado.getInt("id_localidad");
                partido = getSiglasCandidato(dni);
                
                if (partido.equals("NO HAY PARTIDO")) {}
                
                else{
                CensoCandidato nuevo = new CensoCandidato(dni,nombreCompleto,fechaNacimiento,direccion,idLocalidad,partido); 
                todosCandidatosLocalidad.add(nuevo);
                }
        }
        System.out.println("candidatos guardados: "+todosCandidatosLocalidad.size());
        return todosCandidatosLocalidad;
    }
    
    public String getSiglasCandidato(String dni)throws SQLException, Exception{
        String ordenSQL = "SELECT * FROM candidatos WHERE dni = ?;";
        
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setString(1, dni);
        ResultSet otro = this.sentenciaPreparada.executeQuery();
        
        String partido="NO HAY PARTIDO";
        
        while (otro.next()) {
            partido = otro.getString("siglas_partido");
        }
        
        return partido;
        
    }
    
    public int procesarParticipacion(int elecciones, int localidad)throws SQLException, Exception{
        int filas=0;
        
        String ordenCensados = "SELECT COUNT(dni) FROM censo WHERE id_localidad = ? ;";
        
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenCensados);
        this.sentenciaPreparada.setInt(1, localidad);
        this.resultado = this.sentenciaPreparada.executeQuery();
        
        int numeroCensados=0;
        
        while (this.resultado.next()) {
            numeroCensados = this.resultado.getInt(1) ;
        }
        System.out.println(numeroCensados);
        
        
        String ordenVotos = "SELECT COUNT(id_elecciones) FROM escrutinio WHERE localidad = ? AND id_elecciones = ? ; ;";
        
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenVotos);
        this.sentenciaPreparada.setInt(1, localidad);
        this.sentenciaPreparada.setInt(2, elecciones);
        this.resultado = this.sentenciaPreparada.executeQuery();
        
        int totalVotos=0;
        
        while (this.resultado.next()) {
            totalVotos = this.resultado.getInt(1) ;
        }
        System.out.println(totalVotos);
        
        String ordenSQL = "INSERT INTO `participacion`(`id_localidad`, `numero_censados`, `total_votos`) "
                + "VALUES ( ? , ? , ? )";
        
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.sentenciaPreparada.setInt(1, localidad);
        this.sentenciaPreparada.setInt(2, numeroCensados);
        this.sentenciaPreparada.setInt(3, totalVotos);
        
        filas = this.sentenciaPreparada.executeUpdate();
        
        return filas;
    }
    
    public ArrayList<Participacion> getParticipacion()throws SQLException, Exception{
        ArrayList<Participacion> datos = new ArrayList();
        
        String ordenSQL = "SELECT * FROM PARTICIPACION;";
        this.sentenciaPreparada = this.conexion.prepareStatement(ordenSQL);
        this.resultado = this.sentenciaPreparada.executeQuery();
        
        int idLocalidad;
        int totalVotos;
        int numeroCensados;
        
        while (this.resultado.next()) {
            idLocalidad = this.resultado.getInt("id_localidad");
            totalVotos = this.resultado.getInt("total_votos");
            numeroCensados = this.resultado.getInt("numero_censados");
            Participacion nueva = new Participacion(idLocalidad, numeroCensados, totalVotos);
            datos.add(nueva);
        }
        
        return datos;
    }
    
    
    // Metodo para cerrar la conexión a la BBDD
    public void cerrarConexion() throws SQLException {
        // siempre se cierra primero la sentencia y luego la conexión
        this.sentencia.close();
        this.conexion.close();
    }
}