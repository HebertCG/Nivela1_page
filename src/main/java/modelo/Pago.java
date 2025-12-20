package modelo;

import java.sql.Timestamp;

/**
 * Modelo para representar un pago individual de preinscripción
 */
public class Pago {

    private int id;
    private int idPreinscripcion;
    private int numeroCuota; // 1 o 2
    private double monto;
    private String metodoPago;
    private String referenciaPago;
    private String comprobantePago;
    private Timestamp fechaPago;
    private String registradoPor; // "admin" o "sistema"
    private String notas;

    public Pago() {
    }

    public Pago(int idPreinscripcion, int numeroCuota, double monto, String metodoPago,
            String referenciaPago, String comprobantePago, String registradoPor) {
        this.idPreinscripcion = idPreinscripcion;
        this.numeroCuota = numeroCuota;
        this.monto = monto;
        this.metodoPago = metodoPago;
        this.referenciaPago = referenciaPago;
        this.comprobantePago = comprobantePago;
        this.registradoPor = registradoPor;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPreinscripcion() {
        return idPreinscripcion;
    }

    public void setIdPreinscripcion(int idPreinscripcion) {
        this.idPreinscripcion = idPreinscripcion;
    }

    public int getNumeroCuota() {
        return numeroCuota;
    }

    public void setNumeroCuota(int numeroCuota) {
        this.numeroCuota = numeroCuota;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getReferenciaPago() {
        return referenciaPago;
    }

    public void setReferenciaPago(String referenciaPago) {
        this.referenciaPago = referenciaPago;
    }

    public String getComprobantePago() {
        return comprobantePago;
    }

    public void setComprobantePago(String comprobantePago) {
        this.comprobantePago = comprobantePago;
    }

    public Timestamp getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(Timestamp fechaPago) {
        this.fechaPago = fechaPago;
    }

    public String getRegistradoPor() {
        return registradoPor;
    }

    public void setRegistradoPor(String registradoPor) {
        this.registradoPor = registradoPor;
    }

    public String getNotas() {
        return notas;
    }

    public void setNotas(String notas) {
        this.notas = notas;
    }
}
