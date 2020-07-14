package sistemateatros.controllers;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.views.AuthenticationView;

/**
 * Authentication Controller class
 */
public class AuthenticationController {

    private AuthenticationView authenticationView;

    public AuthenticationController() {
        this.authenticationView = new AuthenticationView();
        this.authenticationView.setVisible();
        // Set action listeners
        this.authenticationView.getLoginSysAdminBtn().addActionListener(new SystemAdminLoginListener());
    }

    private class SystemAdminLoginListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Create connection
            DatabaseConnection.connectAsSysAdmin();
            // Get user credentials
            String username = authenticationView.getUsername();
            String password = authenticationView.getPassword();
            authenticationView.displayMessage("Logging in...", true);
            // TODO: Verificar si todo coincide
        }
    }

}
