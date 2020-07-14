package sistemateatros;

import org.mindrot.jbcrypt.BCrypt;
import sistemateatros.authmanager.AuthenticationManager;
import sistemateatros.controllers.AuthenticationController;
import sistemateatros.database.DatabaseConnection;

public class Main {

    public static void main(String[] args) {
        // Authentication Setup
        AuthenticationManager.loadAuthenticationUsers();

        // Start application
        AuthenticationController authenticationController = new AuthenticationController();
    }


}
