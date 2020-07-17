package sistemateatros.models;

public class Bloque {
    private int id;
    private String nombre;
    private int idTeatro;

    public Bloque() {

    }

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

    public int getIdTeatro() {
        return idTeatro;
    }

    public void setIdTeatro(int idTeatro) {
        this.idTeatro = idTeatro;
    }

    @Override
    public String toString() {
        return this.nombre;
    }
}
