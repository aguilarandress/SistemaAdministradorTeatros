package sistemateatros.authmanager;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import sistemateatros.models.User;

/**
 * Clase para leer los usuarios del archivo de configuracion
 */
public class AuthenticationManager {

    private static User sysAdmin;
    // TODO: Definir la cuenta para el agente de teatro
    // TODO: Definir la cuenta para el administrador de teatro

    /**
     * Carga los usuarios para la base de datos
     */
    public static void loadAuthenticationUsers() {
        // JSON parser object to parse read file
        JSONParser jsonParser = new JSONParser();
        try (FileReader reader = new FileReader("config/auth.json"))
        {
            // Read JSON file
            Object jsonObj = jsonParser.parse(reader);
            JSONObject authenticationUsers = (JSONObject) jsonObj;
            // Get sysadmin account
            Object sysAdminObj = authenticationUsers.get("sysadmin");
            JSONObject sysAdminJSON = (JSONObject) sysAdminObj;
            // Get sysadmin credentials
            String sysAdminUsername = (String) sysAdminJSON.get("user");
            String sysAdminPassword = (String) sysAdminJSON.get("password");
            sysAdmin = new User(sysAdminUsername, sysAdminPassword);

            // TODO: Obtener cuenta del administrador de teatros
            // TODO: Obtener cuenta del agente de teatro
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    /**
     * Obtiene la cuenta para el administrador del sistema
     * @return La cuenta del administrador del sistema
     */
    public static User getSysAdmin() {
        return sysAdmin;
    }
}
