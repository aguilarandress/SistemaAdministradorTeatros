package sistemateatros.controllers;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import org.mindrot.jbcrypt.BCrypt;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AuthenticationJDBC;
import sistemateatros.models.SystemAdmin;
import sistemateatros.models.TheaterAdmin;
import sistemateatros.views.AuthenticationView;

import javax.xml.crypto.Data;

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
        this.authenticationView.getLoginTeaAdminBtn().addActionListener(new AdministradorTeatroLoginListener());
    }

    private class SystemAdminLoginListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Create connection
            DatabaseConnection.closeConnection();
            DatabaseConnection.connectAsSysAdmin();
            // Get user credentials
            String username = authenticationView.getUsername();
            String password = authenticationView.getPassword();
            // Obtener administrador del sistema
            AuthenticationJDBC authenticationJDBC = new AuthenticationJDBC();
            authenticationJDBC.setConnection(DatabaseConnection.getConnection());
            SystemAdmin systemAdmin = authenticationJDBC.getSystemAdminByUsername(username);
            if (systemAdmin == null) {
                authenticationView.displayMessage("No user found...", false);
                return;
            }
            if (!BCrypt.checkpw(password, systemAdmin.getPassword())) {
                authenticationView.displayMessage("Incorrrect password", false);
                return;
            }
            authenticationView.displayMessage("Loggin in...", true);
            // TODO Abrir el system admin controller
        }
    }

    private class AdministradorTeatroLoginListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Create connection
            DatabaseConnection.closeConnection();
            DatabaseConnection.connectAsTeatroAdmin();
            String username = authenticationView.getTheaterUsername();
            String password = authenticationView.getTheaterPassword();
            //Obtener Admministradores de teatros
            AuthenticationJDBC authenticationJDBC = new AuthenticationJDBC();
            authenticationJDBC.setConnection(DatabaseConnection.getConnection());

            TheaterAdmin theaterAdmin = authenticationJDBC.getTheaterAdminByUsername(username);

            if (theaterAdmin == null) {
                authenticationView.displayMessage("No user found...", false);
                return;
            }

            if (!BCrypt.checkpw(password, theaterAdmin.getPassword())) {
                authenticationView.displayMessage("Incorrrect password", false);
                return;
            }
            authenticationView.displayMessage("Loggin in...", true);
            TheaterAdminController theaterAdminController= new TheaterAdminController();
            theaterAdminController.setAdmin(theaterAdmin.getNombre());
            theaterAdminController.setIdTeatro(theaterAdmin.getIdTeatro());
            authenticationView.hide();
            // TODO: Crear el controlador de admin teatro
        }
    }
}
