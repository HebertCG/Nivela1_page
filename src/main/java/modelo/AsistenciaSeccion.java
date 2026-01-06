package modelo;

import java.io.Serializable;

public class AsistenciaSeccion implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String nombre;
    private String descripcion;
    private int orden;
    private boolean activo;

    // Constructores
    public AsistenciaSeccion() {
    }

    public AsistenciaSeccion(int id, String nombre, String descripcion, int orden, boolean activo) {
        this.id = id;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.orden = orden;
        this.activo = activo;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "AsistenciaSeccion{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", orden=" + orden +
                ", activo=" + activo +
                '}';
    }
}
