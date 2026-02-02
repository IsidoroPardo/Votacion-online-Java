/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class Participacion {
    private int idLocalidad;
    private int numeroCensados;
    private int totalVotos;

    public Participacion(int idLocalidad, int numeroCensados, int totalVotos) {
        this.idLocalidad = idLocalidad;
        this.numeroCensados = numeroCensados;
        this.totalVotos = totalVotos;
    }

    public int getIdLocalidad() {
        return idLocalidad;
    }

    public int getNumeroCensados() {
        return numeroCensados;
    }

    public int getTotalVotos() {
        return totalVotos;
    }
    
    
    
    
}
