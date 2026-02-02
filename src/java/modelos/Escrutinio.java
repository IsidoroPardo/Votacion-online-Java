/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class Escrutinio {
    private int idEscrutinio;
    private int idElecciones;
    private String partido;
    private int localidad;
    private int comunidad;

    public Escrutinio(int idEscrutinio, int idElecciones, String partido, int localidad, int comunidad) {
        this.idEscrutinio= idEscrutinio; 
        this.idElecciones = idElecciones;
        this.partido = partido;
        this.localidad = localidad;
        this.comunidad = comunidad;
    }
    
    public Escrutinio(int idElecciones, String partido, int localidad, int comunidad) {
        this.idElecciones = idElecciones;
        this.partido = partido;
        this.localidad = localidad;
        this.comunidad = comunidad;
    }
    
    public int getIdEscrutinio() {
        return idEscrutinio;
    }

    public void setIdEscrutinio(int idEscrutinio) {
        this.idEscrutinio = idEscrutinio;
    }

    public int getIdElecciones() {
        return idElecciones;
    }

    public void setIdElecciones(int idElecciones) {
        this.idElecciones = idElecciones;
    }

    public String getPartido() {
        return partido;
    }

    public void setPartido(String partido) {
        this.partido = partido;
    }

    public int getLocalidad() {
        return localidad;
    }

    public void setLocalidad(int localidad) {
        this.localidad = localidad;
    }

    public int getComunidad() {
        return comunidad;
    }

    public void setComunidad(int comunidad) {
        this.comunidad = comunidad;
    }

    @Override
    public String toString() {
        return "Escrutinio{" + "idEscrutinio=" + idEscrutinio + ", idElecciones=" + idElecciones + ", partido=" + partido + ", localidad=" + localidad + ", comunidad=" + comunidad + '}';
    }

    


}

