/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class Recuento {
    private String partido;
    private int votos;
    
    public Recuento(String partido, int votos){
        this.partido = partido;
        this.votos = votos;
    }
    
    public int getVotos(){
        return this.votos;
    }
    
    public String getPartido(){
        return this.partido;
    }
    
    
}
