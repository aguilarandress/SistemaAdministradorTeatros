package sistemateatros.models;

public class AgentTheater {
    private int id;
    private String nombre;
    private String fechaNacimiento;
    private char sexo;
    private int idTeatro;
    private String direccion;
    private String telefonoCasa;
    private String telefonoCelular;
    private String telefonoOtro;
    private String email;
    private String username;
    private char[] password;

    public AgentTheater() { }

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

    public int getIdTeatro() { return idTeatro; }

    public void setIdTeatro(int idTeatro) { this.idTeatro = idTeatro; }

    public String getUsername() { return username; }

    public void setUsername(String username) { this.username = username; }

    public char[] getPassword() { return password; }

    public void setPassword(char[] password) { this.password = password; }
}
