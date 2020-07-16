package sistemateatros.models;

public class Teatro {
    private int id;
    private String nombre;
    private String correo;
    private String sitioWeb;
    private String telefonoAdministracion;
    private String telefonoBoleteria;

    public Teatro() {}

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setSitioWeb(String sitioWeb) {
        this.sitioWeb = sitioWeb;
    }

    public void setTelefonoAdministracion(String telefonoAdministracion) {
        this.telefonoAdministracion = telefonoAdministracion;
    }

    public void setTelefonoBoleteria(String telefonoBoleteria) {
        this.telefonoBoleteria = telefonoBoleteria;
    }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public String getSitioWeb() {
        return sitioWeb;
    }

    public String getTelefonoAdministracion() {
        return telefonoAdministracion;
    }

    public String getTelefonoBoleteria() {
        return telefonoBoleteria;
    }
}
