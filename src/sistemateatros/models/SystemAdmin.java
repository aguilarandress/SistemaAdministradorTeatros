package sistemateatros.models;

public class SystemAdmin extends User {
    private int id;
    private String nombre;
    private String fechaNacimiento;
    private char sexo;
    private String direccion;
    private String telefonoCasa;
    private String telefonoCelular;
    private String telefonoOtro;
    private String email;

    public SystemAdmin() { }

    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getFechaNacimiento() {
        return fechaNacimiento;
    }

    public char getSexo() {
        return sexo;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getTelefonoCasa() {
        return telefonoCasa;
    }

    public String getTelefonoCelular() {
        return telefonoCelular;
    }

    public String getTelefonoOtro() {
        return telefonoOtro;
    }

    public String getEmail() {
        return email;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setFechaNacimiento(String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public void setSexo(char sexo) {
        this.sexo = sexo;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setTelefonoCasa(String telefonoCasa) {
        this.telefonoCasa = telefonoCasa;
    }

    public void setTelefonoCelular(String telefonoCelular) {
        this.telefonoCelular = telefonoCelular;
    }

    public void setTelefonoOtro(String telefonoOtro) {
        this.telefonoOtro = telefonoOtro;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
