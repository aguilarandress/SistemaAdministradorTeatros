package sistemateatros.daos;

import sistemateatros.models.Presentacion;
import sistemateatros.models.Produccion;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

public interface PresentacionesDAO {
    public void setConnection(Connection connection);
    public ArrayList<Presentacion> getPresentByProdId(int Id);
    public ResultSet getRawPresentByProdId (int Id);
    public void addPresentacion(Presentacion presentacion);
    public boolean validateDate (Presentacion presentacion);
    public ArrayList<Presentacion> getPresentByProdIdView(Produccion produccion);
}
