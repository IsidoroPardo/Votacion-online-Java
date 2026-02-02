/*
    CLASE USUARIO
    - DNI
    - CONTRAS
    - ROL
    - VOTADO
*/
package modelos;

/**
 *
 * @author isido
 */
public class Usuario {
    private String dni;
    private String contra;
    private String rol;
    private int votado;
    
    // constructor de usuarios normales
    public Usuario(String dni, String contra, String rol, int votado){
        this.dni = dni;
        this.contra = contra;
        this.rol = rol;
        this.votado = votado;
    }
    
    public Usuario(String dni, String contra, String rol){
        this.dni = dni;
        this.contra = contra;
        this.rol = rol;
    }
    
    // constructor de un admin
    /*public Usuario(String dni, String contra, String clave){
        if(clave.equals("admin1234")){
            this.dni = dni;
        this.contra = contra;
        this.rol = "admin";
        this.votado = 0;
        }
        else{}
    } */

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public int getVotado() {
        return votado;
    }

    public void setVotado(int votado) {
            this.votado = votado;
        
    }
    
    
    
    
}
