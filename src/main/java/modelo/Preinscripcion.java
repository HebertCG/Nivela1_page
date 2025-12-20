package modelo;

public class Preinscripcion {

    private int id;
    private java.sql.Timestamp fechaRegistro;
    private String nombres, apellidos, correo, dni;
    private String telefono, direccion, colegio, carrera, estado;
    private int intentos;
    private String origen;
    private String grado;
    private String nombreApoderado;
    private String apellidoApoderado;
    private String emailApoderado;
    private String telefonoApoderado;
    private String telefono2Apoderado;
    private String metodoPago;
    private String referenciaPago;
    private String comprobantePago;

    // Campos para sistema de cuotas
    private String modalidadPago; // "contado" o "cuotas"
    private double montoTotal;
    private double montoPagado;
    private double saldoPendiente;
    private String estadoPago; // "completo", "pendiente", "vencido"
    private java.sql.Date fechaLimite2daCuota;

    public Preinscripcion() {
    }

    public Preinscripcion(String nombres, String apellidos, String correo, String dni,
            String telefono, String direccion, String colegio, String carrera) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.correo = correo;
        this.dni = dni;
        this.telefono = telefono;
        this.direccion = direccion;
        this.colegio = colegio;
        this.carrera = carrera;
        this.estado = "pendiente";
    }

    public Preinscripcion(int intentos) {
        this.intentos = intentos;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public java.sql.Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(java.sql.Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public String getNombres() {
        return nombres;
    }

    // Alias para compatibilidad con JSP que usa ${preinscripcion.nombre}
    public String getNombre() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    // Alias para compatibilidad con JSP que usa ${preinscripcion.apellido}
    public String getApellido() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getCorreo() {
        return correo;
    }

    // Alias para compatibilidad con JSP que usa ${preinscripcion.email}
    public String getEmail() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getColegio() {
        return colegio;
    }

    public void setColegio(String colegio) {
        this.colegio = colegio;
    }

    public String getCarrera() {
        return carrera;
    }

    public void setCarrera(String carrera) {
        this.carrera = carrera;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getIntentos() {
        return intentos;
    }

    public void setIntentos(int intentos) {
        this.intentos = intentos;
    }

    public String getOrigen() {
        return origen;
    }

    public void setOrigen(String origen) {
        this.origen = origen;
    }

    public String getNombreApoderado() {
        return nombreApoderado;
    }

    public void setNombreApoderado(String nombreApoderado) {
        this.nombreApoderado = nombreApoderado;
    }

    public String getApellidoApoderado() {
        return apellidoApoderado;
    }

    public void setApellidoApoderado(String apellidoApoderado) {
        this.apellidoApoderado = apellidoApoderado;
    }

    public String getEmailApoderado() {
        return emailApoderado;
    }

    public void setEmailApoderado(String emailApoderado) {
        this.emailApoderado = emailApoderado;
    }

    public String getTelefonoApoderado() {
        return telefonoApoderado;
    }

    public void setTelefonoApoderado(String telefonoApoderado) {
        this.telefonoApoderado = telefonoApoderado;
    }

    public String getTelefono2Apoderado() {
        return telefono2Apoderado;
    }

    public void setTelefono2Apoderado(String telefono2Apoderado) {
        this.telefono2Apoderado = telefono2Apoderado;
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

    public String getGrado() {
        return grado;
    }

    public void setGrado(String grado) {
        this.grado = grado;
    }

    public String getModalidadPago() {
        return modalidadPago;
    }

    public void setModalidadPago(String modalidadPago) {
        this.modalidadPago = modalidadPago;
    }

    public double getMontoTotal() {
        return montoTotal;
    }

    public void setMontoTotal(double montoTotal) {
        this.montoTotal = montoTotal;
    }

    public double getMontoPagado() {
        return montoPagado;
    }

    public void setMontoPagado(double montoPagado) {
        this.montoPagado = montoPagado;
    }

    public double getSaldoPendiente() {
        return saldoPendiente;
    }

    public void setSaldoPendiente(double saldoPendiente) {
        this.saldoPendiente = saldoPendiente;
    }

    public String getEstadoPago() {
        return estadoPago;
    }

    public void setEstadoPago(String estadoPago) {
        this.estadoPago = estadoPago;
    }

    public java.sql.Date getFechaLimite2daCuota() {
        return fechaLimite2daCuota;
    }

    public void setFechaLimite2daCuota(java.sql.Date fechaLimite2daCuota) {
        this.fechaLimite2daCuota = fechaLimite2daCuota;
    }
}