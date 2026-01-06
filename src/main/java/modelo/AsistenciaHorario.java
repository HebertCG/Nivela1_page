package modelo;

import java.io.Serializable;

public class AsistenciaHorario implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int seccionId;
    private String diaSemana;

    // Para joins
    private String nombreSeccion;

    // Constructores
    public AsistenciaHorario() {
    }

    public AsistenciaHorario(int id, int seccionId, String diaSemana) {
        this.id = id;
        this.seccionId = seccionId;
        this.diaSemana = diaSemana;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSeccionId() {
        return seccionId;
    }

    public void setSeccionId(int seccionId) {
        this.seccionId = seccionId;
    }

    public String getDiaSemana() {
        return diaSemana;
    }

    public void setDiaSemana(String diaSemana) {
        this.diaSemana = diaSemana;
    }

    public String getNombreSeccion() {
        return nombreSeccion;
    }

    public void setNombreSeccion(String nombreSeccion) {
        this.nombreSeccion = nombreSeccion;
    }

    @Override
    public String toString() {
        return "AsistenciaHorario{" +
                "id=" + id +
                ", seccionId=" + seccionId +
                ", diaSemana='" + diaSemana + '\'' +
                '}';
    }
}
