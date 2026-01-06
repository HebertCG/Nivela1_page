package modelo;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class AsistenciaRegistro implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int estudianteId;
    private int semanaId;
    private Date fechaClase; // Nueva: fecha específica de la clase
    private String estado; // Nueva: 'asistio', 'falto', 'tardanza', 'justificada'
    private boolean presente; // Deprecated: mantener por compatibilidad
    private String observaciones;
    private Timestamp fechaRegistro;
    private String usuarioRegistro;

    // Para joins
    private String nombreEstudiante;
    private String nombreSemana;
    private int numeroSemana;

    // Constructores
    public AsistenciaRegistro() {
    }

    public AsistenciaRegistro(int id, int estudianteId, int semanaId, boolean presente, String observaciones) {
        this.id = id;
        this.estudianteId = estudianteId;
        this.semanaId = semanaId;
        this.presente = presente;
        this.observaciones = observaciones;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getEstudianteId() {
        return estudianteId;
    }

    public void setEstudianteId(int estudianteId) {
        this.estudianteId = estudianteId;
    }

    public int getSemanaId() {
        return semanaId;
    }

    public void setSemanaId(int semanaId) {
        this.semanaId = semanaId;
    }

    public Date getFechaClase() {
        return fechaClase;
    }

    public void setFechaClase(Date fechaClase) {
        this.fechaClase = fechaClase;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public boolean isPresente() {
        return presente;
    }

    public void setPresente(boolean presente) {
        this.presente = presente;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getUsuarioRegistro() {
        return usuarioRegistro;
    }

    public void setUsuarioRegistro(String usuarioRegistro) {
        this.usuarioRegistro = usuarioRegistro;
    }

    public String getNombreEstudiante() {
        return nombreEstudiante;
    }

    public void setNombreEstudiante(String nombreEstudiante) {
        this.nombreEstudiante = nombreEstudiante;
    }

    public String getNombreSemana() {
        return nombreSemana;
    }

    public void setNombreSemana(String nombreSemana) {
        this.nombreSemana = nombreSemana;
    }

    public int getNumeroSemana() {
        return numeroSemana;
    }

    public void setNumeroSemana(int numeroSemana) {
        this.numeroSemana = numeroSemana;
    }

    @Override
    public String toString() {
        return "AsistenciaRegistro{" +
                "id=" + id +
                ", estudianteId=" + estudianteId +
                ", semanaId=" + semanaId +
                ", presente=" + presente +
                ", observaciones='" + observaciones + '\'' +
                '}';
    }
}
