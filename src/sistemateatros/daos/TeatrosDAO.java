package sistemateatros.daos;

import sistemateatros.models.Bloque;
import sistemateatros.models.Teatro;

import java.sql.Connection;
import java.util.ArrayList;

public interface TeatrosDAO {
    public void setConnection(Connection connection);
    public Teatro getTeatroByNombre(String nombre);
    public ArrayList<Teatro> getTeatros();
    public Bloque getBloqueByNombre(int idTeatro, String nombre);
    public ArrayList<Bloque> getBloquesByIdTeatro(int idTeatro);
    public void crearBloque(Bloque bloque);
    public void crearTeatro(Teatro teatro);
}
