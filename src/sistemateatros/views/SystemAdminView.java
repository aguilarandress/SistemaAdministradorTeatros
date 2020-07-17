package sistemateatros.views;

import sistemateatros.models.Bloque;
import sistemateatros.models.Teatro;

import javax.swing.*;

public class SystemAdminView {

    private JFrame frame;
    private JTabbedPane tabbedPane;
    private JPanel jpanel;
    private JPanel agregarTeatroPanel;
    private JLabel agregarTeatroTitle;
    private JTextField teatroNombreField;
    private JLabel teatroNombreLabel;
    private JTextField telefonoAdministracionField;
    private JLabel telefonoAdministracionLabel;
    private JLabel telefonoBoleteriaLabel;
    private JTextField telefonoBoleteriaField;
    private JTextField teatroCorreoField;
    private JLabel teatroCorreoLabel;
    private JLabel teatroSitioWebLabel;
    private JTextField teatroSitioWebField;
    private JButton agregarTeatroBtn;
    private JPanel agregarBloquesTab;
    private JLabel agregarBloqueTitle;
    private JComboBox<Teatro> teatroAgregarBloqueBox;
    private DefaultComboBoxModel<Teatro> teatroComboBoxModel;

    private JTextField nombreBloqueField;
    private JButton agregarBloqueBtn;
    private JPanel agregarFilasTab;

    private DefaultComboBoxModel<Teatro> seleccionarTeatroAgregarFilaComboBoxModel;
    private JComboBox seleccionarTeatroAgregarFilaBox;

    private DefaultComboBoxModel<Bloque> seleccionarBloqueAgregarFilaComboBoxModel;
    private JComboBox seleccionarBloqueAgregarFilaBox;

    private JTextField letraFilaField;
    private JTextField capacidadFilaField;
    private JButton agregarFilaBtn;
    private JLabel agregarFilaTitle;
    private JLabel letraFilaLabel;
    private JLabel capacidadFilaLabel;
    private JLabel nombreAgregarBloqueLabel;
    private JLabel teatroAgregarBloqueField;

    public SystemAdminView() {
        this.frame = new JFrame("Administrador de sistemas");
        this.frame.setContentPane(this.jpanel);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        // Set models
        this.teatroComboBoxModel = new DefaultComboBoxModel<>();
        this.teatroAgregarBloqueBox.setModel(teatroComboBoxModel);

        this.seleccionarTeatroAgregarFilaComboBoxModel = new DefaultComboBoxModel<>();
        this.seleccionarTeatroAgregarFilaBox.setModel(seleccionarTeatroAgregarFilaComboBoxModel);

        this.seleccionarBloqueAgregarFilaComboBoxModel = new DefaultComboBoxModel<>();
        this.seleccionarBloqueAgregarFilaBox.setModel(seleccionarBloqueAgregarFilaComboBoxModel);

        this.frame.setSize(800, 600);
    }

    public void setVisible() {
        this.frame.setVisible(true);
    }

    public void displayMessage(String message, boolean success) {
        JOptionPane.showMessageDialog(this.frame, message, success ? "EXITO" : "ERROR",
                success ? JOptionPane.INFORMATION_MESSAGE : JOptionPane.ERROR_MESSAGE);
    }

    public void close() {
        this.frame.dispose();
    }

    public JButton getAgregarTeatroBtn() {
        return agregarTeatroBtn;
    }

    public JTextField getTeatroNombreField() {
        return teatroNombreField;
    }

    public JTextField getTelefonoAdministracionField() {
        return telefonoAdministracionField;
    }

    public JTextField getTelefonoBoleteriaField() {
        return telefonoBoleteriaField;
    }

    public JTabbedPane getTabbedPane() {
        return tabbedPane;
    }

    public JComboBox<Teatro> getTeatroAgregarBloqueBox() {
        return teatroAgregarBloqueBox;
    }

    public JComboBox getSeleccionarBloqueAgregarFilaBox() {
        return seleccionarBloqueAgregarFilaBox;
    }

    public JComboBox getSeleccionarTeatroAgregarFilaBox() {
        return seleccionarTeatroAgregarFilaBox;
    }

    public JTextField getTeatroCorreoField() {
        return teatroCorreoField;
    }

    public JTextField getTeatroSitioWebField() {
        return teatroSitioWebField;
    }

    public JTextField getNombreBloqueField() {
        return nombreBloqueField;
    }

    public void clearAgregarTeatroFields() {
        teatroNombreField.setText("");
        teatroCorreoField.setText("");
        telefonoAdministracionField.setText("");
        telefonoBoleteriaField.setText("");
        teatroSitioWebField.setText("");
    }

    public void clearAgregarBloqueFields() {
        nombreBloqueField.setText("");
    }

    public JButton getAgregarBloqueBtn() {
        return agregarBloqueBtn;
    }

    public JTextField getLetraFilaField() {
        return letraFilaField;
    }

    public JTextField getCapacidadFilaField() {
        return capacidadFilaField;
    }

    public JButton getAgregarFilaBtn() {
        return agregarFilaBtn;
    }
}
