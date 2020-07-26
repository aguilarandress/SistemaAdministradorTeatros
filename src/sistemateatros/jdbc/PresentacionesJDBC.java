package sistemateatros.jdbc;

import sistemateatros.daos.PresentacionesDAO;
import sistemateatros.models.Bloque;
import sistemateatros.models.Presentacion;
import sistemateatros.models.PresentacionCartelera;
import sistemateatros.models.Produccion;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class PresentacionesJDBC implements PresentacionesDAO {
    private Connection connection;
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    @Override
    public ArrayList<Presentacion> getPresentByProdId(int Id) {
        ArrayList<Presentacion> presentacions = new ArrayList<Presentacion>();
        try
        {

            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByProduccionIdPresentaciones ?");
            preparedStatement.setInt(1, Id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next())
            {
                Presentacion presentacion = new Presentacion();
                presentacion.setId(resultSet.getInt("ProduccionId"));
                presentacion.setPresentId(resultSet.getInt("PresentacionId"));
                presentacion.setFecha(resultSet.getDate("Fecha"));
                presentacion.setHora(resultSet.getString("Hora"));
                presentacions.add(presentacion);

            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return presentacions;
    }

    @Override
    public ResultSet getRawPresentByProdId(int Id) {
        try
        {

            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByProduccionIdPresentaciones ?");
            preparedStatement.setInt(1, Id);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void addPresentacion(Presentacion presentacion) {
        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreatePresentacion ?,?,?,?");
            preparedStatement.setInt(1,presentacion.getId());
            preparedStatement.setInt(2,presentacion.getPresentId());

            java.sql.Date date = new java.sql.Date(presentacion.getFecha().getTime());
            preparedStatement.setDate(3,date);

            try
            {
                SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
                Date hora = parser.parse(presentacion.getHora());
                preparedStatement.setTime(4,new Time(hora.getTime()));
                preparedStatement.execute();
            }
            catch ( ParseException e)
            {
                e.printStackTrace();
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public boolean validateDate(Presentacion presentacion) {

        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateDatePresentaciones ?,?,?");
            preparedStatement.setInt(1,presentacion.getId());
            java.sql.Date date = new java.sql.Date(presentacion.getFecha().getTime());
            preparedStatement.setDate(2,date);

            try
            {
                SimpleDateFormat parser = new SimpleDateFormat("HH:mm");
                Date hora = parser.parse(presentacion.getHora());
                preparedStatement.setTime(3,new Time(hora.getTime()));
                ResultSet resultSet = preparedStatement.executeQuery();
                boolean presenFound= resultSet.next();
                if (!presenFound) {

                    return false;
                }
                return true;
            }
            catch ( ParseException e)
            {
                e.printStackTrace();
            }

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ArrayList<Presentacion> getPresentByProdIdView(Produccion produccion) {
        ArrayList<Presentacion> presentacions = new ArrayList<Presentacion>();
        try
        {

            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByProduccionIdPresentacionView ?");
            preparedStatement.setInt(1, produccion.getId());
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next())
            {
                Presentacion presentacion = new Presentacion();
                presentacion.setId(resultSet.getInt("ProduccionId"));
                presentacion.setPresentId(resultSet.getInt("PresentacionId"));
                presentacion.setFecha(resultSet.getDate("Fecha"));
                presentacion.setHora(resultSet.getString("Hora"));
                presentacions.add(presentacion);
            }
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return presentacions;


    }
    /**
     * Obtiene las presentaciones de la cartelera por fecha
     * @param fechaInicial La fecha inicial
     * @param fechaFinal La fecha final
     * @return Las presentaciones de la cartelera
     */
    @Override
    public ArrayList<PresentacionCartelera> getPresentacionesCarteleraByFechas(Date fechaInicial, Date fechaFinal) {
        try {
            // Prepare statement
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetPresentacionesDisponibles ?, ?");
            preparedStatement.setDate(1, new java.sql.Date(fechaInicial.getTime()));
            preparedStatement.setDate(2, new java.sql.Date(fechaFinal.getTime()));
            ResultSet resultSet = preparedStatement.executeQuery();
            // Get results
            ArrayList<PresentacionCartelera> presentaciones = new ArrayList<>();
            while (resultSet.next()) {
                PresentacionCartelera presentacionCartelera = new PresentacionCartelera();
                presentacionCartelera.setProduccionId(resultSet.getInt("ProduccionId"));
                presentacionCartelera.setPresentacionId(resultSet.getInt("PresentacionId"));
                presentacionCartelera.setNombreProduccion(resultSet.getString("NombreProduccion"));
                presentacionCartelera.setTeatroId(resultSet.getInt("IdTeatro"));
                presentacionCartelera.setNombreTeatro(resultSet.getString("NombreTeatro"));
                presentacionCartelera.setEstado(resultSet.getString("Estado"));
                presentacionCartelera.setTipo(resultSet.getString("Tipo"));
                presentacionCartelera.setFecha(resultSet.getString("Fecha"));
                presentacionCartelera.setHora(resultSet.getString("Hora"));
                presentacionCartelera.setDescripcion(resultSet.getString("Descripcion"));
                presentaciones.add(presentacionCartelera);
            }
            return presentaciones;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Obtiene los precios de cada bloque de una produccion
     * @param produccionId el id de la produccion
     * @return Los precios de los bloques
     */
    @Override
    public ArrayList<Bloque> getBloquePreciosByProduccionId(int produccionId) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByIdProduccionBloquePrecios ?");
            preparedStatement.setInt(1, produccionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            // Get results
            ArrayList<Bloque> bloques = new ArrayList<>();
            while (resultSet.next()) {
                Bloque bloque = new Bloque();
                Double d=resultSet.getDouble("Monto");
                bloque.setPrecio(d.floatValue());
                bloque.setNombre(resultSet.getString("Nombre"));
                bloques.add(bloque);
            }
            return bloques;
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
