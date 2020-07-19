package sistemateatros.models;

public class Fila {
    private String letra;
    private int numeroAsientos;
    private int bloqueId;

    public Fila() { }


    public int getNumeroAsientos() {
        return numeroAsientos;
    }

    public String getLetra() {
        return letra;
    }

    public void setLetra(String letra) {
        this.letra = letra;
    }

    public int getBloqueId() {
        return bloqueId;
    }

    public void setBloqueId(int bloqueId) {
        this.bloqueId = bloqueId;
    }

    public void setNumeroAsientos(int numeroAsientos) {
        this.numeroAsientos = numeroAsientos;
    }
}
