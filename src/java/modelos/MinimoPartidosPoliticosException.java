/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class MinimoPartidosPoliticosException extends Exception {
    // la excepcion si hay menos de 4 partidos políticos
    private String mensaje;
    
    public MinimoPartidosPoliticosException() {
        this.mensaje = "No se cumple el mínimo de 4 partidos políticos registrados";
    }
    public String getMessage(){
       // this.mensaje = "No se cumple el mínimo de 4 partidos políticos registrados";
        return this.mensaje;
    }
}
