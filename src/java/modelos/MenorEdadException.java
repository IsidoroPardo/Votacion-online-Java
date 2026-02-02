/*
*/
package modelos;

/**
 *
 * @author isido
 */
public class MenorEdadException extends Exception{
    // la excepcion de si es menor
    private String mensaje;
    
    public MenorEdadException() throws Exception{
        this.mensaje = "No puede registrar este DNI por ser menor de edad";
    }
    public String getMensaje(){
        return this.mensaje;
    }
}
