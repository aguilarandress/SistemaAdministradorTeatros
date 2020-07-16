package sistemateatros.views;

import javax.swing.*;

public class SystemAdminView {

    private JFrame frame;
    private JTabbedPane agregarTeatroTab;
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
    private JPanel agregarAsientosTab;
    private JLabel agregarBloqueTitle;
    private JComboBox teatroAgregarBloqueBox;
    private JTextField nombreBloqueField;
    private JButton agregarBloqueBtn;

    public SystemAdminView() {
        this.frame = new JFrame("Administrador de sistemas");
        this.frame.setContentPane(this.jpanel);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
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

    public JTextField getTeatroCorreoField() {
        return teatroCorreoField;
    }

    public JTextField getTeatroSitioWebField() {
        return teatroSitioWebField;
    }

    public void clearAgregarTeatroFields() {
        teatroNombreField.setText("");
        teatroCorreoField.setText("");
        telefonoAdministracionField.setText("");
        telefonoBoleteriaField.setText("");
        teatroSitioWebField.setText("");
    }
}
