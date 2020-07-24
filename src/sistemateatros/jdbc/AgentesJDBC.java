package sistemateatros.jdbc;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import sistemateatros.daos.AgentesDAO;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Bloque;
import sistemateatros.models.Produccion;

public class AgentesJDBC implements AgentesDAO {
    private Connection connection;
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean existeCedula(int cedula) {
        try {


            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateIdTeatroAgentes ?");
            preparedStatement.setInt(1, cedula);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return false;
            }
            return true;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public ArrayList<Bloque> getBloquePreciosByProdId(int ProdId) {
        try
        {
        ArrayList<Bloque> bloques = new ArrayList<Bloque>() ;
        PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByProdIdBloquePrecios ?");
        preparedStatement.setInt(1,ProdId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next())
        {
            Bloque bloque = new Bloque();
            bloque.setNombre(resultSet.getString("BloqueNombre"));
            bloque.setPrecio(resultSet.getBigDecimal("Monto").floatValue());
            bloque.setId(resultSet.getInt("BloqueId"));
            bloque.setIdProd(resultSet.getInt("IdProduccion"));
            bloques.add(bloque);
        }
        return bloques;
    }
        catch (SQLException e)
    {
        e.printStackTrace();
    }
        return null;
    }

    @Override
    public boolean verificarUsername(String username) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateUsername ?");
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return  false;
            }
            return true;
        }


        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean verificarNombre(String nombre) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateNameTeatroAgentes ?");
            preparedStatement.setString(1, nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return false;
            }
            return true;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return  true ;
    }

    @Override
    public void AddAgente(AgentTheater agentTheater) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateTeatroAgentes ?,?,?,?,?,?,?,?,?,?,?,?");
            preparedStatement.setInt(1,agentTheater.getCedula());
            preparedStatement.setString(2, agentTheater.getNombre());
            preparedStatement.setInt(3,agentTheater.getIdTeatro());

            java.sql.Date date = new java.sql.Date(agentTheater.getFechaNacimiento().getTime());
            preparedStatement.setDate(4,date);


            preparedStatement.setString(5,String.valueOf(agentTheater.getSexo()));
            preparedStatement.setString(6,agentTheater.getDireccion());
            preparedStatement.setString(7,agentTheater.getEmail());
            preparedStatement.setString(8,agentTheater.getUsername());
            preparedStatement.setString(9,String.valueOf(agentTheater.getPassword()));
            if (!(agentTheater.getTelefonoCasa()==null))
            {
                preparedStatement.setString(10,agentTheater.getTelefonoCasa());
            }
            else
            {
                preparedStatement.setNull(10, Types.VARCHAR);
            }
            if (!(agentTheater.getTelefonoCelular()==null))
            {
                preparedStatement.setString(11,agentTheater.getTelefonoCelular());
            }
            else
            {
                preparedStatement.setNull(

                        11, Types.VARCHAR);
            }
            if (!(agentTheater.getTelefonoOtro()==null))
            {
                preparedStatement.setString(12,agentTheater.getTelefonoOtro());
            }
            else
            {
                preparedStatement.setNull(12, Types.VARCHAR);
            }
            preparedStatement.execute();

        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }

    }
}
