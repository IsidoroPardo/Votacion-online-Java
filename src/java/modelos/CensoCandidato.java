/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class CensoCandidato extends Censo{
    
    private String partido;
    
    public CensoCandidato(String dni, String nombreCompleto, String fechaNacimiento, String direccion, int idLocalidad, String partido) {
        super(dni, nombreCompleto, fechaNacimiento, direccion, idLocalidad);
        this.partido = partido;
    }

    public String getPartido() {
        return partido;
    }
    
}
