package sistemateatros.models;

public class PresentacionCartelera {
    private String nombreProduccion;
    private int presentacionId;
    private int produccionId;
    private int teatroId;
    private String nombreTeatro;
    private String estado;
    private String tipo;
    private String fecha;
    private String hora;
    private String descripcion;

    public PresentacionCartelera() { }



    public String getNombreProduccion() {
        return nombreProduccion;
    }

    public void setNombreProduccion(String nombreProduccion) {
        this.nombreProduccion = nombreProduccion;
    }

    public int getPresentacionId() {
        return presentacionId;
    }

    public void setPresentacionId(int presentacionId) {
        this.presentacionId = presentacionId;
    }

    public int getProduccionId() {
        return produccionId;
    }

    public void setProduccionId(int produccionId) {
        this.produccionId = produccionId;
    }

    public int getTeatroId() {
        return teatroId;
    }

    public void setTeatroId(int teatroId) {
        this.teatroId = teatroId;
    }

    public String getNombreTeatro() {
        return nombreTeatro;
    }

    public void setNombreTeatro(String nombreTeatro) {
        this.nombreTeatro = nombreTeatro;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}
