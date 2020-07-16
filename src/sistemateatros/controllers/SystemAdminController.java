package sistemateatros.controllers;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.Teatro;
import sistemateatros.validators.TeatroValidator;
import sistemateatros.views.SystemAdminView;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

/**
 * Controlador para el administrador del sistema
 */
public class SystemAdminController {

    private SystemAdminView systemAdminView;

    public SystemAdminController() {
        this.systemAdminView = new SystemAdminView();
        this.systemAdminView.setVisible();
        // Set event listeners
        this.systemAdminView.getAgregarTeatroBtn().addActionListener(new AgregarTeatroListener());
    }

    /**
     * Listener para agregar teatros
     */
    private class AgregarTeatroListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            Teatro teatroNuevo = new Teatro();
            teatroNuevo.setNombre(systemAdminView.getTeatroNombreField().getText());
            teatroNuevo.setTelefonoAdministracion(systemAdminView.getTelefonoAdministracionField().getText());
            teatroNuevo.setTelefonoBoleteria(systemAdminView.getTelefonoBoleteriaField().getText());
            teatroNuevo.setCorreo(systemAdminView.getTeatroCorreoField().getText());
            teatroNuevo.setSitioWeb(systemAdminView.getTeatroSitioWebField().getText());
            // Validar teatro
            ArrayList<String> errores = TeatroValidator.validarTeatro(teatroNuevo);
            if (errores.size() > 0) {
                systemAdminView.displayMessage(errores.get(0), false);
                return;
            }
            // Crear el teatro
            TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
            teatrosJDBC.setConnection(DatabaseConnection.getConnection());
            teatrosJDBC.crearTeatro(teatroNuevo);
            systemAdminView.displayMessage("Teatro creado!", true);
            systemAdminView.clearAgregarTeatroFields();
        }
    }

}
