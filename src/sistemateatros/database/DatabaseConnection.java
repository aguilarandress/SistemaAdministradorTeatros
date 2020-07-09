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
     * Sets config for server connection
     */
    public static void setupServerConnection() {
        dataSource.setServerName("localhost");
        dataSource.setPortNumber(1433);
        dataSource.setDatabaseName("SISTEMA_TEATROS");
    }

    /**
     * Se conecta a la base de datos como administrador del sistema
     */
    public static void connectAsSysAdmin() {
        // Get sysadmin credentials
        User sysAdmin = AuthenticationManager.getSysAdmin();
        dataSource.setUser(sysAdmin.getUsername());
        dataSource.setPassword(sysAdmin.getPassword());
        createDatabaseConnection();
    }

    // TODO: Implementar conexion a base de datos con admin teatro
    // TODO: Implementar conexion a base de datos con agente teatro

    /**
     * Crea la conexion a la base de datos
     */
    private static void createDatabaseConnection() {
        try {
            connection = dataSource.getConnection();
            System.out.println("Connected successfuly...");
        } catch (SQLException e) {
            System.out.println("**ERROR** En la conexion a la base");
            e.printStackTrace();
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
