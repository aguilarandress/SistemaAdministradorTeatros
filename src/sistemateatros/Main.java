package sistemateatros;

import sistemateatros.authmanager.AuthenticationManager;
import sistemateatros.database.DatabaseConnection;

public class Main {

    public static void main(String[] args) {
        // Database and authentication setup
        AuthenticationManager.loadAuthenticationUsers();
        DatabaseConnection.setupServerConnection();
    }
}
