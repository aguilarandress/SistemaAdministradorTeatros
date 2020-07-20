package sistemateatros.jdbc;

import sistemateatros.daos.AuthenticationDAO;
import sistemateatros.models.SystemAdmin;
import sistemateatros.models.TheaterAdmin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Clase para realizar acciones de autenticacion
 */
public class AuthenticationJDBC implements AuthenticationDAO {

    private Connection connection;

    /**
     * Configura la conexion que debe usar
     * @param connection La conexion de la base de datos
     */
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    /**
     * Obtiene el administrador del sistema por nombre de usuario
     * @param username El username del administrador del sistema
     * @return El administrador del sistema
     */
    @Override
    public SystemAdmin getSystemAdminByUsername(String username) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByUsernameSistemaAdministradores ?");
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean userFound = resultSet.next();
            if (!userFound) {
                return null;
            }
            SystemAdmin systemAdmin = new SystemAdmin();
            systemAdmin.setUsername(resultSet.getString("Usuario"));
            systemAdmin.setPassword(resultSet.getString("Password"));
            return systemAdmin;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public TheaterAdmin getTheaterAdminByUsername(String username)
    {
        try
        {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByUsuarioTeatroAdministradores ?");
            preparedStatement.setString(1,username);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean userFound = resultSet.next();
            if (!userFound) {
                return null;
            }
            TheaterAdmin theaterAdmin = new TheaterAdmin();
            theaterAdmin.setUsername(resultSet.getString("Usuario"));
            theaterAdmin.setPassword(resultSet.getString("Password"));
            theaterAdmin.setNombre(resultSet.getString("Nombre"));
            theaterAdmin.setIdTeatro(resultSet.getInt("IdTeatro"));
            return theaterAdmin;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return  null;
    }
}