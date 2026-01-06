package modelo;

import java.io.Serializable;
import java.sql.Timestamp;

public class AsistenciaEstudiante implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private int seccionId;
    private String nombreCompleto;
    private String codigo;
    private int orden;
    private boolean activo;
    private Timestamp fechaRegistro;

    // Para joins
    private String nombreSeccion;

    // Constructores
    public AsistenciaEstudiante() {
    }

    public AsistenciaEstudiante(int id, int seccionId, String nombreCompleto, int orden, boolean activo) {
        this.id = id;
        this.seccionId = seccionId;
        this.nombreCompleto = nombreCompleto;
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

    public int getSeccionId() {
        return seccionId;
    }

    public void setSeccionId(int seccionId) {
        this.seccionId = seccionId;
    }

    public String getNombreCompleto() {
        return nombreCompleto;
    }

    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
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

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getNombreSeccion() {
        return nombreSeccion;
    }

    public void setNombreSeccion(String nombreSeccion) {
        this.nombreSeccion = nombreSeccion;
    }

    @Override
    public String toString() {
        return "AsistenciaEstudiante{" +
                "id=" + id +
                ", seccionId=" + seccionId +
                ", nombreCompleto='" + nombreCompleto + '\'' +
                ", orden=" + orden +
                ", activo=" + activo +
                '}';
    }
}
