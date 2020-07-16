package sistemateatros.daos;

import sistemateatros.models.Teatro;

import java.sql.Connection;
import java.util.ArrayList;

public interface TeatrosDAO {
    public void setConnection(Connection connection);
    public Teatro getTeatroByNombre(String nombre);
    public ArrayList<Teatro> getTeatros();
    public void crearTeatro(Teatro teatro);
}
