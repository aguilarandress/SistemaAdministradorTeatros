package sistemateatros.daos;

import sistemateatros.models.Bloque;
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
    public ArrayList<String> getEstados();
    public String getEstadoById(int Id);
    public void updateEstado(Produccion produccion);
    public void AddBloquePrecio(ArrayList<Bloque> bloques,int Id);
    public ArrayList<Produccion> getProdTIdView(int TeatroId);
}
