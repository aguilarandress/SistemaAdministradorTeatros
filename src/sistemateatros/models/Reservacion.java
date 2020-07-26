package sistemateatros.models;

import java.util.Date;

public class Reservacion {
    private String nombreCliente;
    private String correo;
    private String telefono;
    private String numeroTarjeta;
    private int CVC;
    private Date expiracion;
    private boolean efectivo;
    private double monto;

    public String getNombreCliente() { return nombreCliente; }

    public void setNombreCliente(String nombreCliente) { this.nombreCliente = nombreCliente; }

    public String getCorreo() { return correo; }

    public void setCorreo(String correo) { this.correo = correo; }

    public String getTelefono() { return telefono; }

    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getNumeroTarjeta() { return numeroTarjeta; }

    public void setNumeroTarjeta(String numeroTarjeta) { this.numeroTarjeta = numeroTarjeta; }

    public int getCVC() { return CVC; }

    public void setCVC(int CVC) { this.CVC = CVC; }

    public Date getExpiracion() { return expiracion; }

    public void setExpiracion(Date expiracion) { this.expiracion = expiracion; }

    public boolean isEfectivo() {
        return efectivo;
    }

    public void setEfectivo(boolean efectivo) {
        this.efectivo = efectivo;
    }

    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }
}
