package sistemateatros.database;

import java.sql.Connection;
import java.sql.SQLException;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import sistemateatros.authmanager.AuthenticationManager;
import sistemateatros.models.User;

/**
 * Clase para manipular la conexion a la base de datos
 */
public class DatabaseConnection {

    private static Connection connection;
    private static SQLServerDataSource dataSource = new SQLServerDataSource();

    /**
     * Se conecta a la base de datos como administrador del sistema
     */
    public static void connectAsSysAdmin() {
        dataSource.setServerName(AuthenticationManager.getHost());
        dataSource.setPortNumber(AuthenticationManager.getPort());
        dataSource.setDatabaseName(AuthenticationManager.getDatabaseName());
        // Get sysadmin credentials
        User sysAdmin = AuthenticationManager.getSysAdmin();
        dataSource.setUser(sysAdmin.getUsername());
        dataSource.setPassword(sysAdmin.getPassword());
        try {
            connection = dataSource.getConnection();
            System.out.println("Connected successfuly...");
        } catch (SQLException e) {
            System.out.println("**ERROR** En la conexion a la base");
            e.printStackTrace();
        }
    }

    /**
     * Se conecta a la base de datos como administrador del teatro
     */
    public static void connectAsTeatroAdmin() {
        dataSource.setServerName(AuthenticationManager.getHost());
        dataSource.setPortNumber(AuthenticationManager.getPort());
        dataSource.setDatabaseName(AuthenticationManager.getDatabaseName());
        // Get theateradmin credentials
        User teaAdmin = AuthenticationManager.getTeatroAdmin();
        dataSource.setUser(teaAdmin.getUsername());
        dataSource.setPassword(teaAdmin.getPassword());
        try {
            connection = dataSource.getConnection();
            System.out.println("Connected successfuly...");
        } catch (SQLException e) {
            System.out.println("**ERROR** En la conexion a la base");
            e.printStackTrace();
        }
    }

    /**
     * Se conecta a la base de datos como agente de teatro
     */
    public static void connectAsAgenteTeatro() {
        dataSource.setServerName(AuthenticationManager.getHost());
        dataSource.setPortNumber(AuthenticationManager.getPort());
        dataSource.setDatabaseName(AuthenticationManager.getDatabaseName());
        // Get theateradmin credentials
        User teatroAgente = AuthenticationManager.getTeatroAgente();
        dataSource.setUser(teatroAgente.getUsername());
        dataSource.setPassword(teatroAgente.getPassword());
        try {
            connection = dataSource.getConnection();
            System.out.println("Connected successfuly...");
        } catch (SQLException e) {
            System.out.println("**ERROR** En la conexion a la base");
            e.printStackTrace();
        }
    }

    /**
     * Se desconecta del servidor de la base de datos
     */
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
                System.out.println("Disconnected successfuly...");
            } catch (SQLException e) {
                System.out.println("**ERROR** Al desconectarse de la base de datos");
                e.printStackTrace();
            }
        }
    }

    /**
     * Obtiene la conexion a la base de datos
     * @return La conexion
     */
    public static Connection getConnection() {
        return connection;
    }
}
