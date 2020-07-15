package sistemateatros.authmanager;

import io.github.cdimascio.dotenv.Dotenv;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.properties.EncryptableProperties;
import org.jasypt.salt.RandomSaltGenerator;
import sistemateatros.models.User;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

/**
 * Clase para leer los usuarios del archivo de configuracion
 */
public class AuthenticationManager {

    private static String host;
    private static int port;
    private static String databaseName;
    private static User sysAdmin;
    // TODO: Definir la cuenta para el agente de teatro
    // TODO: Definir la cuenta para el administrador de teatro

    /**
     * Carga los usuarios para la base de datos
     */
    public static void loadAuthenticationUsers() {
        // Get secret key
        Dotenv dotenv = Dotenv.load();
        String secretkey = dotenv.get("SECRET_KEY");
        // Create encryptor
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setPassword(secretkey);
        encryptor.setSaltGenerator(new RandomSaltGenerator());
        // Load properties file
        Properties props = new EncryptableProperties(encryptor);
        try {
            props.load(new FileInputStream("./config/application.properties"));
            // Get server properties
            host = props.getProperty("datasource.host");
            databaseName = props.getProperty("datasource.name");
            port = Integer.parseInt(props.getProperty("datasource.port"));
            // Get system admin properties
            sysAdmin = new User();
            sysAdmin.setUsername(props.getProperty("datasource.sysadminusername"));
            sysAdmin.setPassword(props.getProperty("datasource.sysadminpassword"));
            // TODO Obtener los datos del administrador de teatro
            // TODO Obtener los datos del agente de teatro
        } catch (FileNotFoundException e) {
            System.out.println("**ERROR** File not found...");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("**ERROR** IOException...");
            e.printStackTrace();
        }
    }

    public static int getPort() {
        return port;
    }

    public static String getDatabaseName() {
        return databaseName;
    }

    public static String getHost() {
        return host;
    }

    /**
     * Obtiene la cuenta para el administrador del sistema
     * @return La cuenta del administrador del sistema
     */
    public static User getSysAdmin() {
        return sysAdmin;
    }

}
