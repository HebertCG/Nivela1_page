package modelo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class AsistenciaSemana implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int numeroSemana;
    private String nombre;
    private Date fechaInicio;
    private Date fechaFin;
    private boolean activa;
    private Timestamp fechaCreacion;

    // Constructores
    public AsistenciaSemana() {
    }

    public AsistenciaSemana(int id, int numeroSemana, String nombre, Date fechaInicio, Date fechaFin, boolean activa) {
        this.id = id;
        this.numeroSemana = numeroSemana;
        this.nombre = nombre;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.activa = activa;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumeroSemana() {
        return numeroSemana;
    }

    public void setNumeroSemana(int numeroSemana) {
        this.numeroSemana = numeroSemana;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(Date fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public Date getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(Date fechaFin) {
        this.fechaFin = fechaFin;
    }

    public boolean isActiva() {
        return activa;
    }

    public void setActiva(boolean activa) {
        this.activa = activa;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Override
    public String toString() {
        return "AsistenciaSemana{" +
                "id=" + id +
                ", numeroSemana=" + numeroSemana +
                ", nombre='" + nombre + '\'' +
                ", fechaInicio=" + fechaInicio +
                ", fechaFin=" + fechaFin +
                ", activa=" + activa +
                '}';
    }
}
