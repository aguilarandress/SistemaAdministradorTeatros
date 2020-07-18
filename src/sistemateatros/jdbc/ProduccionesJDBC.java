package sistemateatros.jdbc;

import jdk.tools.jlink.internal.PathResourcePoolEntry;
import sistemateatros.daos.ProduccionesDAO;
import sistemateatros.models.Produccion;

import javax.imageio.plugins.jpeg.JPEGImageReadParam;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

public class ProduccionesJDBC implements ProduccionesDAO {
    private Connection connection;
    @Override
    public void setConnection(Connection connection) {this.connection=connection; }

    @Override
    public ArrayList<String> getTipos() {
        try {
            ArrayList<String> tipos = new ArrayList<String>();
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetProduccionesTipos");
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean userFound = resultSet.next();

            while(userFound)
            {
                Integer codigo = resultSet.getInt("Id");
                String nombre = resultSet.getString("Nombre");
                tipos.add(codigo.toString() +"-"+nombre);
                userFound=resultSet.next();
            }
            return tipos;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void AddProd(Produccion produccion) {
        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC  CreateProduccion ? ,?, ?, ?, ?, ?, ?");

            preparedStatement.setString(1,produccion.getDescripcion());
            SimpleDateFormat sdf1 = new SimpleDateFormat("MM/dd/yyyy");
            java.sql.Date dateI = new java.sql.Date(produccion.getFechaI().getTime());
            preparedStatement.setDate(2,dateI);
            java.sql.Date dateF = new java.sql.Date(produccion.getFechaF().getTime());
            preparedStatement.setDate(3,dateF);
            preparedStatement.setString(4,produccion.getNombre());
            preparedStatement.setInt(5,produccion.getIdEstado());
            preparedStatement.setInt(6,produccion.getIdTeatro());
            preparedStatement.setInt(7,produccion.getIdTipo());
            preparedStatement.execute();
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Produccion> getProducciones() {

        try
        {
            ArrayList<Produccion> producciones = new ArrayList<Produccion>() ;
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC getProducciones");
            ResultSet resultSet = preparedStatement.executeQuery();
            while(resultSet.next())
            {
                Produccion produccion = new Produccion();
                produccion.setNombre(resultSet.getString("Nombre"));
                producciones.add(produccion);
            }
            return producciones;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean validarNombre(String nombre) {
        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateNameProducciones ?");
            preparedStatement.setString(1,nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean prodFound = resultSet.next();
            if (!prodFound) {

                return false;
            }
            return true;
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Produccion getProdByName(String nombre) {
        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByNombreProduccion ? ");
            preparedStatement.setString(1,nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean prodFound = resultSet.next();
            if(!prodFound)
            {
                return null;
            }
            Produccion produccion = new Produccion();
            produccion.setNombre(resultSet.getString("Nombre"));
            produccion.setId(resultSet.getInt("Id"));
            produccion.setIdTeatro(resultSet.getInt("IdTeatro"));
            produccion.setFechaI(resultSet.getDate("FechaInicial"));
            produccion.setFechaF(resultSet.getDate("FechaFinal"));
            produccion.setDescripcion(resultSet.getString("Descripcion"));
            produccion.setIdEstado(resultSet.getInt("IdEstado"));
            produccion.setIdTipo(resultSet.getInt("IdTipo"));
            return produccion;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return null;
    }
}
