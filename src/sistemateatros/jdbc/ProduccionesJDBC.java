package sistemateatros.jdbc;

import sistemateatros.daos.ProduccionesDAO;
import sistemateatros.models.Produccion;

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
}
