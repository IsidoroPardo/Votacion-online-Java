/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class Candidato {
    private String dni;
    private String nombreCompleto;
    private String siglasPartido;
    private String orden;
    private int ordenInt;

    public Candidato(String dni, String nombreCompleto, String siglasPartido, String orden) {
        this.dni = dni;
        this.nombreCompleto = nombreCompleto;
        this.siglasPartido = siglasPartido;
        this.orden = orden;
        this.ordenInt = Integer.parseInt(orden);
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getSiglasPartido() {
        return siglasPartido;
    }

    public void setSiglasPartido(String siglasPartido) {
        this.siglasPartido = siglasPartido;
    }

    public String getOrden() {
        return orden;
    }

    public void setOrden(String orden) {
        this.orden = orden;
    }

    public int getOrdenInt() {
        return ordenInt;
    }

    public void setOrdenInt(int ordenInt) {
        this.ordenInt = ordenInt;
    }
    
}
