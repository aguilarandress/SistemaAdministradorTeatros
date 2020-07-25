package sistemateatros.models;

public class Asiento {
    private int AsientoId;
    private String FilaId;
    private int BloqueId;

    public int getAsientoId() { return AsientoId; }

    public void setAsientoId(int asientoId) { AsientoId = asientoId; }

    public String getFilaId() { return FilaId; }

    public void setFilaId(String filaId) { FilaId = filaId; }

    public int getBloqueId() { return BloqueId; }

    public void setBloqueId(int bloqueId) { BloqueId = bloqueId; }

    @Override
    public String toString() {
        return String.valueOf(this.getAsientoId()+this.getFilaId()+this.getBloqueId());
    }
}
