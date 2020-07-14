package sistemateatros;

import sistemateatros.authmanager.AuthenticationManager;
import sistemateatros.controllers.AuthenticationController;

public class Main {

    public static void main(String[] args) {
        // AuthenticationSetup
        AuthenticationManager.loadAuthenticationUsers();
        // Start application
        AuthenticationController authenticationController = new AuthenticationController();
    }

}
