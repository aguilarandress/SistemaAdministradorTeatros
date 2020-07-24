package sistemateatros.daos;

import sistemateatros.models.*;
import sun.jvm.hotspot.runtime.arm.ARMCurrentFrameGuess;

import java.sql.Connection;
import java.util.ArrayList;

public interface TeatrosDAO {
    public void setConnection(Connection connection);
    public Teatro getTeatroByNombre(String nombre);
    public Teatro getTeatroByID(int Id);
    public ArrayList<Teatro> getTeatros();
    public Bloque getBloqueByNombre(int idTeatro, String nombre);
    public ArrayList<Bloque> getBloquesByIdTeatro(int idTeatro);
    public Fila getFilaByLetra(String letra, int idBloque);
    public void crearBloque(Bloque bloque);
    public void crearFila(Fila fila);
    public void crearTeatro(Teatro teatro);
    public ArrayList<Fila> getFilasByBloque(Bloque bloque);
    public ArrayList<Asiento> getAsientosByFila(Fila fila, Presentacion presentacion);
}
