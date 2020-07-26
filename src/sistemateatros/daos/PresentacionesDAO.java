package sistemateatros.daos;

import sistemateatros.models.Bloque;
import sistemateatros.models.Presentacion;
import sistemateatros.models.PresentacionCartelera;
import sistemateatros.models.Produccion;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public interface PresentacionesDAO {
    public void setConnection(Connection connection);
    public ArrayList<Presentacion> getPresentByProdId(int Id);
    public ResultSet getRawPresentByProdId (int Id);
    public void addPresentacion(Presentacion presentacion);
    public boolean validateDate (Presentacion presentacion);
    public ArrayList<Presentacion> getPresentByProdIdView(Produccion produccion);
    public ArrayList<PresentacionCartelera> getPresentacionesCarteleraByFechas(Date fechaInicial, Date fechaFinal);
    public ArrayList<Bloque> getBloquePreciosByProduccionId(int produccionId);
}

