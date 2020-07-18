package sistemateatros.daos;

import sistemateatros.models.Produccion;

import java.sql.Connection;
import java.util.ArrayList;

public interface ProduccionesDAO {
    public void setConnection(Connection connection);
    public ArrayList<String> getTipos();
    public void AddProd(Produccion produccion);
    public ArrayList<Produccion> getProducciones();
    public boolean validarNombre (String nombre);
    public Produccion getProdByName(String nombre);

}
