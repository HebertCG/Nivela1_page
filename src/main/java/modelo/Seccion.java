package modelo;

public class Seccion {
    private int id;
    private int idHorario;
    private String nombre;
    private int idGrupo;
    private String nombreGrupo;
    private int alumnosActuales;
    private int capacidadMaxima;

    public Seccion() {
        this.capacidadMaxima = 45;
        this.alumnosActuales = 0;
    }

    public Seccion(String nombre, int idGrupo) {
        this();
        this.nombre = nombre;
        this.idGrupo = idGrupo;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdHorario() {
        return idHorario;
    }

    public void setIdHorario(int idHorario) {
        this.idHorario = idHorario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getIdGrupo() {
        return idGrupo;
    }

    public void setIdGrupo(int idGrupo) {
        this.idGrupo = idGrupo;
    }

    public String getNombreGrupo() {
        return nombreGrupo;
    }

    public void setNombreGrupo(String nombreGrupo) {
        this.nombreGrupo = nombreGrupo;
    }

    public int getAlumnosActuales() {
        return alumnosActuales;
    }

    public void setAlumnosActuales(int alumnosActuales) {
        this.alumnosActuales = alumnosActuales;
    }

    public int getCapacidadMaxima() {
        return capacidadMaxima;
    }

    public void setCapacidadMaxima(int capacidadMaxima) {
        this.capacidadMaxima = capacidadMaxima;
    }

    // Métodos de utilidad
    public int getCapacidadDisponible() {
        return capacidadMaxima - alumnosActuales;
    }

    public boolean estaLlena() {
        return alumnosActuales >= capacidadMaxima;
    }

    public double getPorcentajeOcupacion() {
        return (alumnosActuales * 100.0) / capacidadMaxima;
    }
}
