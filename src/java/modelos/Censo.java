/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelos;

/**
 *
 * @author isido
 */
public class Censo {
    private String dni;
    private String nombreCompleto;
    private String nombre;
    private String fechaNacimiento;
    private String direccion;
    private int idLocalidad;

    public Censo(String dni, String nombreCompleto, String fechaNacimiento, String direccion, int idLocalidad) {
        this.dni = dni;
        this.nombreCompleto = nombreCompleto;
        setNombre();
        this.fechaNacimiento = fechaNacimiento;
        this.direccion = direccion;
        this.idLocalidad = idLocalidad;
    }
    
    private void setNombre(){
        String nombre="";
        for (int i = 0; i < this.nombreCompleto.length(); i++) {
            char letra = this.nombreCompleto.charAt(i);
            if (letra==' ') {
                nombre = this.nombreCompleto.substring(0, i);
            }
        }
        this.nombre=nombre;
    }
    
    public String getNombre(){
        return this.nombre;
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

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getIdLocalidad() {
        return idLocalidad;
    }

    public void setIdLocalidad(int idLocalidad) {
        this.idLocalidad = idLocalidad;
    }
    
    
    
}
