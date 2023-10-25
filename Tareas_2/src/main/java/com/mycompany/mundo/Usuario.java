
package com.mycompany.mundo;

public class Usuario {
    
    private int cedula;
    private String nombre;
    private String contrasenia;

    // constructor vacio 
    public Usuario() {
    }
 
    // constructor con parametros 
    public Usuario(int cedula, String nombre, String contrasenia) {
        this.cedula = cedula;
        this.nombre = nombre;
        this.contrasenia = contrasenia;
    }

    public int getCedula() {
        return cedula;
    }

    public void setCedula(int cedula) {
        this.cedula = cedula;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }
    
}
