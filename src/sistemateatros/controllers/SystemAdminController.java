package sistemateatros.controllers;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.Bloque;
import sistemateatros.models.Fila;
import sistemateatros.models.Teatro;
import sistemateatros.validators.TeatroValidator;
import sistemateatros.views.SystemAdminView;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.*;
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
        this.systemAdminView.getAgregarFilaBtn().addActionListener(new AgregarFilaListener());
        this.systemAdminView.getCapacidadFilaField().addKeyListener(new CapacidadFieldListener());
        this.systemAdminView.getSeleccionarTeatroAgregarFilaBox().addItemListener(new SeleccionarTeatroAgregarFilaListener());
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
            } else if (systemAdminView.getTabbedPane().getSelectedIndex() == 2) {
                onAgregarFilaSelected();
            }
        }
    }

    /**
     * Evento cuando se selecciona el tab para agregar bloques
     */
    private void onAgregarBloqueSelected() {
        this.systemAdminView.getTeatroAgregarBloqueBox().removeAllItems();
        // Obtener teatros
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
        // TODO: Probar esto bien
        if (teatros.size() == 0) {
            systemAdminView.getTabbedPane().setSelectedIndex(0);
        }
        for (int i = 0; i < teatros.size(); i++) {
            this.systemAdminView.getTeatroAgregarBloqueBox().addItem(teatros.get(i));
        }
    }

    private void onAgregarFilaSelected() {
        this.systemAdminView.getSeleccionarTeatroAgregarFilaBox().removeAllItems();
        this.systemAdminView.getSeleccionarBloqueAgregarFilaBox().removeAllItems();
        // Obtener teatros
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
        // TODO: Probar esto bien
        if (teatros.size() == 0) {
            systemAdminView.getTabbedPane().setSelectedIndex(0);
        }
        for (int i = 0; i < teatros.size(); i++) {
            // Verificar que el teatro tenga bloques
            if (teatrosJDBC.getBloquesByIdTeatro(teatros.get(i).getId()).size() > 0) {
                this.systemAdminView.getSeleccionarTeatroAgregarFilaBox().addItem(teatros.get(i));
            }
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

    private class AgregarFilaListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            Bloque bloqueSeleccionado = (Bloque) systemAdminView.getSeleccionarBloqueAgregarFilaBox().getSelectedItem();
            String letraFila = systemAdminView.getLetraFilaField().getText();
            if (systemAdminView.getCapacidadFilaField().getText().isEmpty()) {
                systemAdminView.displayMessage("Numero de asientos no valido", false);
                return;
            }
            int capacidadFila = Integer.parseInt(systemAdminView.getCapacidadFilaField().getText());
            Fila filaNueva = new Fila();
            filaNueva.setLetra(letraFila);
            filaNueva.setBloqueId(bloqueSeleccionado.getId());
            filaNueva.setNumeroAsientos(capacidadFila);
            // Validar fila
            // TODO: Validar que solo sean letra mayusculas y que no esten todas
            ArrayList<String> errores = TeatroValidator.validarFila(filaNueva);
            if (errores.size() > 0) {
                systemAdminView.displayMessage(errores.get(0), false);
                return;
            }
            // Crear fila y asientos
            TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
            teatrosJDBC.setConnection(DatabaseConnection.getConnection());
            teatrosJDBC.crearFila(filaNueva);
            systemAdminView.displayMessage("Fila creada!", true);
        }
    }

    private class CapacidadFieldListener extends KeyAdapter {
        @Override
        public void keyTyped(KeyEvent e) {
            char c = e.getKeyChar();
            if (!((c >= '0') && (c <= '9') ||
                    (c == KeyEvent.VK_BACK_SPACE) ||
                    (c == KeyEvent.VK_DELETE))) {
                e.consume();
            }
        }
    }

    private class SeleccionarTeatroAgregarFilaListener implements ItemListener {
        @Override
        public void itemStateChanged(ItemEvent e) {
            // Check for item selection
            if (e.getStateChange() == ItemEvent.SELECTED) {
                // Obtener teatro seleccionado
                Teatro teatroSeleccionado = (Teatro) systemAdminView.getSeleccionarTeatroAgregarFilaBox().getSelectedItem();
                TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
                teatrosJDBC.setConnection(DatabaseConnection.getConnection());
                ArrayList<Bloque> bloques = teatrosJDBC.getBloquesByIdTeatro(teatroSeleccionado.getId());
                systemAdminView.getSeleccionarBloqueAgregarFilaBox().removeAllItems();
                // Agregar bloques al combo box
                for (int i = 0; i < bloques.size(); i++) {
                    systemAdminView.getSeleccionarBloqueAgregarFilaBox().addItem(bloques.get(i));
                }
            }
        }
    }

}
