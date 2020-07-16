package sistemateatros.daos;

import sistemateatros.models.Teatro;

import java.sql.Connection;

public interface TeatrosDAO {
    public void setConnection(Connection connection);
    public Teatro getTeatroByNombre(String nombre);
    public void crearTeatro(Teatro teatro);
}
