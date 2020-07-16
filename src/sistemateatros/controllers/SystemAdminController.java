package sistemateatros.controllers;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.Bloque;
import sistemateatros.models.Teatro;
import sistemateatros.validators.TeatroValidator;
import sistemateatros.views.SystemAdminView;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
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
        this.systemAdminView.getTabbedPane().addChangeListener(new CambiarPaneListener());
        this.systemAdminView.getAgregarTeatroBtn().addActionListener(new AgregarTeatroListener());
        this.systemAdminView.getAgregarBloqueBtn().addActionListener(new AgregarBloqueListener());
    }

    /**
     * Change listener para cuando se cambia de tab
     */
    private class CambiarPaneListener implements ChangeListener {
        @Override
        public void stateChanged(ChangeEvent e) {
            // Verificar cual tabbed pane se esta cargando
            if (systemAdminView.getTabbedPane().getSelectedIndex() == 1) {
                onAgregarBloqueSelected();
            }
        }
    }

    /**
     * Evento cuando se selecciona el tab para agregar bloques
     */
    private void onAgregarBloqueSelected() {
        // Obtener teatros
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
        // TODO: Verificar que sucede si no hay teatros
        for (int i = 0; i < teatros.size(); i++) {
            this.systemAdminView.getTeatroAgregarBloqueBox().addItem(teatros.get(i));
        }
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

    /**
     * Action Listener cuando se agrega un bloque nuevo
     */
    private class AgregarBloqueListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            Teatro teatroSeleccionado = (Teatro) systemAdminView.getTeatroAgregarBloqueBox().getSelectedItem();
            String nombreBloque = systemAdminView.getNombreBloqueField().getText();
            Bloque bloque = new Bloque();
            bloque.setNombre(nombreBloque);
            bloque.setIdTeatro(teatroSeleccionado.getId());
            // Validar bloque
            ArrayList<String> errores = TeatroValidator.validarBloque(bloque);
            if (errores.size() > 0) {
                systemAdminView.displayMessage(errores.get(0), false);
                return;
            }
            // Crear el bloque
            TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
            teatrosJDBC.setConnection(DatabaseConnection.getConnection());
            teatrosJDBC.crearBloque(bloque);
            systemAdminView.displayMessage("Bloque creado!", true);
            systemAdminView.clearAgregarBloqueFields();
        }
    }

}
