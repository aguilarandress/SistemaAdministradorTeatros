package sistemateatros.controllers;

import org.mindrot.jbcrypt.BCrypt;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.jdbc.TheaterAdminsJDBC;
import sistemateatros.mapper.CargaDatos;
import sistemateatros.models.Bloque;
import sistemateatros.models.Fila;
import sistemateatros.models.Teatro;
import sistemateatros.models.TheaterAdmin;
import sistemateatros.validators.TeatroValidator;
import sistemateatros.validators.TheaterAdminValidator;
import sistemateatros.views.SystemAdminView;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import java.awt.event.*;
import java.io.File;
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
        this.systemAdminView.getCapacidadFilaField().addKeyListener(new NumeroEnteroFieldListener());
        this.systemAdminView.getCedulaAgregarAdminField().addKeyListener(new NumeroEnteroFieldListener());
        this.systemAdminView.getSeleccionarTeatroAgregarFilaBox().addItemListener(new SeleccionarTeatroAgregarFilaListener());
        this.systemAdminView.getAgregarAdminBtn().addActionListener(new AgregarAdminTeatroListener());
        this.systemAdminView.getCargaDatosBtn().addActionListener(new cargaDatosListener());
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
            } else if (systemAdminView.getTabbedPane().getSelectedIndex() == 3) {
                onAgregarAdminTeatroSelected();
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

    /**
     * Evento cuando se selecciona el tab para agregar filas
     */
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
        // Agregar teatros al combo box
        for (int i = 0; i < teatros.size(); i++) {
            // Verificar que el teatro tenga bloques
            if (teatrosJDBC.getBloquesByIdTeatro(teatros.get(i).getId()).size() > 0) {
                this.systemAdminView.getSeleccionarTeatroAgregarFilaBox().addItem(teatros.get(i));
            }
        }
    }

    private void onAgregarAdminTeatroSelected() {
        this.systemAdminView.getTeatroAgregarAdminCB().removeAllItems();
        // Obtener teatros
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
        // TODO: Probar esto bien
        if (teatros.size() == 0) {
            systemAdminView.getTabbedPane().setSelectedIndex(0);
        }
        for (int i = 0; i < teatros.size(); i++) {
            this.systemAdminView.getTeatroAgregarAdminCB().addItem(teatros.get(i));
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

    /**
     * Listener para agregar filas y asientos
     */
    private class AgregarFilaListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Obtener datos del formulario
            Bloque bloqueSeleccionado = (Bloque) systemAdminView.getSeleccionarBloqueAgregarFilaBox().getSelectedItem();
            String letraFila = systemAdminView.getLetraFilaField().getText();
            // Verificar el campo de capacidad
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
            // TODO: Agregar un check en la base de datos para que sea alfabetico
            ArrayList<String> errores = TeatroValidator.validarFila(filaNueva);
            if (errores.size() > 0) {
                systemAdminView.displayMessage(errores.get(0), false);
                return;
            }
            filaNueva.setLetra(letraFila.toUpperCase());
            // Crear fila y asientos
            TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
            teatrosJDBC.setConnection(DatabaseConnection.getConnection());
            teatrosJDBC.crearFila(filaNueva);
            systemAdminView.displayMessage("Fila creada!", true);
            systemAdminView.clearAgregarFilaFields();
        }
    }

    private class AgregarAdminTeatroListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Creaate theater admin
            TheaterAdmin newTheaterAdmin = new TheaterAdmin();
            // Verificar cedula vacia
            if (systemAdminView.getCedulaAgregarAdminField().getText().isEmpty()) {
                systemAdminView.displayMessage("Cedula invalida", false);
                return;
            }
            newTheaterAdmin.setId(Integer.parseInt(systemAdminView.getCedulaAgregarAdminField().getText()));
            newTheaterAdmin.setNombre(systemAdminView.getNombreAgregarAdminField().getText());
            // Obtener teatro
            Teatro teatroSeleccionado = (Teatro) systemAdminView.getTeatroAgregarAdminCB().getSelectedItem();
            newTheaterAdmin.setIdTeatro(teatroSeleccionado.getId());
            newTheaterAdmin.setFechaNacimiento(systemAdminView.getFechaNacimientoChooser().getDate());
            newTheaterAdmin.setSexo(systemAdminView.getSexoValue());
            newTheaterAdmin.setDireccion(systemAdminView.getDireccionAgregarAdminField().getText());
            newTheaterAdmin.setTelefonoCasa(
                    systemAdminView.getTelCasaAgregarAdminField().getText().isEmpty() ? null : systemAdminView.getTelCasaAgregarAdminField().getText());
            newTheaterAdmin.setTelefonoCelular(
                    systemAdminView.getTelCelularAgregarAdminField().getText().isEmpty() ? null : systemAdminView.getTelCelularAgregarAdminField().getText());
            newTheaterAdmin.setTelefonoOtro(
                    systemAdminView.getTelOtroAgregarAdminField().getText().isEmpty() ? null : systemAdminView.getTelOtroAgregarAdminField().getText());
            newTheaterAdmin.setEmail(systemAdminView.getEmailAgregarAdminField().getText());
            newTheaterAdmin.setUsername(systemAdminView.getUsuarioAgregarAdminField().getText());
            newTheaterAdmin.setPassword(String.valueOf(systemAdminView.getPasswordAgregarAdminField().getPassword()));
            // Validar informacion
            ArrayList<String> errores = TheaterAdminValidator.validarTheaterAdmin(newTheaterAdmin);
            if (errores.size() > 0) {
                systemAdminView.displayMessage(errores.get(0), false);
                return;
            }
            // Encriptar contrasena
            newTheaterAdmin.setPassword(BCrypt.hashpw(newTheaterAdmin.getPassword(), BCrypt.gensalt(4)));
            // Crear administrador en la base de datos
            TheaterAdminsJDBC theaterAdminsJDBC = new TheaterAdminsJDBC();
            theaterAdminsJDBC.setConnection(DatabaseConnection.getConnection());
            theaterAdminsJDBC.createTheaterAdmin(newTheaterAdmin);
            systemAdminView.displayMessage("Administrador de teatro creado!", true);
            // TODO: Limpiar campos
        }
    }

    /**
     * Listener para solo permitir escribir digitos
     */
    private class NumeroEnteroFieldListener extends KeyAdapter {
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

    /**
     * Listener de seleccion para el combo box de teatros
     */
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

    private class cargaDatosListener implements  ActionListener
    {
        @Override
        public void actionPerformed(ActionEvent e) {
            JFileChooser jFileChooser = new JFileChooser();
            jFileChooser.showOpenDialog(jFileChooser);
            File archivoCarga=jFileChooser.getSelectedFile();
            CargaDatos.cargaDatos(archivoCarga);
        }
    }

}
