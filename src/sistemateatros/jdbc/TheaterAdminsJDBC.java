package sistemateatros.jdbc;

import sistemateatros.daos.TeatroAdminsDAO;
import sistemateatros.models.TheaterAdmin;

import java.sql.*;

/**
 * Implementacion JDBC para obtener administradores de teatro
 */
public class TheaterAdminsJDBC implements TeatroAdminsDAO {

    private Connection connection;

    /**
     * Configura la conexion para acceder a la base de datos
     * @param connection La conexion de la base de datos
     */
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    /**
     * Obtiene un administrador de teatro por su Id
     * @param id El id que se desea buscar
     * @return El administrador de teatro con el Id
     */
    @Override
    public TheaterAdmin getTheaterAdminById(int id) {
        try {
            // Prepare query
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByIdTeatroAdministradores ?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            // Verificar si existe
            boolean theaterAdminFound = resultSet.next();
            if (!theaterAdminFound) {
                return null;
            }
            // Get theater admin info
            TheaterAdmin theaterAdmin = new TheaterAdmin();
            theaterAdmin.setId(resultSet.getInt("Id"));
            return theaterAdmin;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Obtiene un administrador de teatro por su nombre
     * @param nombre El nombre que se desea buscar
     * @return El administrador de teatro con el nombre
     */
    @Override
    public TheaterAdmin getTheaterAdminByNombre(String nombre) {
        try {
            // Prepare query
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByNombreTeatroAdministradores ?");
            preparedStatement.setString(1, nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            // Verificar si existe
            boolean theaterAdminFound = resultSet.next();
            if (!theaterAdminFound) {
                return null;
            }
            // Get theater admin info
            TheaterAdmin theaterAdmin = new TheaterAdmin();
            theaterAdmin.setNombre(resultSet.getString("Nombre"));
            return theaterAdmin;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Obtiene un administrador de teatro por su username
     * @param username El username que se desea buscar
     * @return El usuario con el username
     */
    @Override
    public TheaterAdmin getTheaterAdminByUsername(String username) {
        try {
            // Prepare query
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByUsuarioTeatroAdministradores ?");
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            // Verificar si existe
            boolean theaterAdminFound = resultSet.next();
            if (!theaterAdminFound) {
                return null;
            }
            // Get theater admin info
            TheaterAdmin theaterAdmin = new TheaterAdmin();
            theaterAdmin.setUsername(resultSet.getString("Usuario"));
            return theaterAdmin;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Crea un administrador del teatro nuevo
     * @param theaterAdmin El nuevo administrador de teatro
     */
    @Override
    public void createTheaterAdmin(TheaterAdmin theaterAdmin) {
        try {
            // Prepare query
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateTeatroAdministradores ?, " +
                    "?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?");
            preparedStatement.setInt(1,theaterAdmin.getId());
            preparedStatement.setString(2, theaterAdmin.getNombre());
            preparedStatement.setInt(3,theaterAdmin.getIdTeatro());
            // Configurar fecha
            java.sql.Date date = new java.sql.Date(theaterAdmin.getFechaNacimiento().getTime());
            preparedStatement.setDate(4,date);
            preparedStatement.setString(5,String.valueOf(theaterAdmin.getSexo()));
            preparedStatement.setString(6,theaterAdmin.getDireccion());
            if (!(theaterAdmin.getTelefonoCasa() == null)) {
                preparedStatement.setString(7,theaterAdmin.getTelefonoCasa());
            }
            else {
                preparedStatement.setNull(7, Types.VARCHAR);
            }
            if (!(theaterAdmin.getTelefonoCelular() == null)) {
                preparedStatement.setString(8, theaterAdmin.getTelefonoCelular());
            }
            else {
                preparedStatement.setNull(8, Types.VARCHAR);
            }
            if (!(theaterAdmin.getTelefonoOtro() == null)) {
                preparedStatement.setString(9,theaterAdmin.getTelefonoOtro());
            }
            else {
                preparedStatement.setNull(9, Types.VARCHAR);
            }
            preparedStatement.setString(10,theaterAdmin.getEmail());
            preparedStatement.setString(11,theaterAdmin.getUsername());
            preparedStatement.setString(12,theaterAdmin.getPassword());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
