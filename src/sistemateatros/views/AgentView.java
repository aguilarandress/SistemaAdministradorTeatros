package sistemateatros.views;

import sistemateatros.models.Teatro;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.util.ArrayList;

public class AgentView {
    private JFrame frame;
    private JPanel panel1;
    private JTabbedPane tabbedAgente;
    private JLabel welcome_message;
    private JLabel TheaterInfo;
    private JComboBox comboTeatros;
    private JTable tablaProds;
    private JTable tablaPresent;
    private JTable tablaBloques;
    private JButton BoletosButton;
    private JTable tablaFilas;
    private JTable tablaAsientos;
    private JList listaAsientos;
    private JButton realizarCompraButton;
    private String Agente;
    private int TeatroId;
    private DefaultListModel valoresLista;

    public AgentView (int TeatroId,String Agente)
    {
        this.frame = new JFrame("Agente de teatro");
        this.frame.setContentPane(this.panel1);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(800, 700);

        this.setAgente(Agente);
        this.setTeatroId(TeatroId);
        setWelcome_message(Agente);
        DefaultListModel model =new DefaultListModel();
        this.listaAsientos.setModel(model);
        this.valoresLista= model;

    }

    public void setVisible()
    {
        this.frame.setVisible(true);
    }
    
    public String getAgente() { return Agente; }

    public void setAgente(String agente) { Agente = agente; }

    public int getTeatroId() { return TeatroId; }

    public void setTeatroId(int teatroId) { TeatroId = teatroId; }

    public void setWelcome_message(String nombre) { this.welcome_message.setText("Bienvenido : " + nombre ); }

    public JTabbedPane getTabbedAgente() { return tabbedAgente; }

    public JComboBox getComboTeatros() {
        return comboTeatros;
    }

    public JTable getTablaProds() { return tablaProds; }

    public JTable getTablaPresent() { return tablaPresent; }

    public JTable getTablaBloques() { return tablaBloques; }

    public JButton getBoletosButton() { return BoletosButton; }

    public JTable getTablaFilas() { return tablaFilas; }

    public JTable getTablaAsientos() { return tablaAsientos; }

    public JButton getRealizarCompraButton() { return realizarCompraButton; }

    public JList getListaAsientos() { return listaAsientos; }

    public DefaultListModel getValoresLista() { return valoresLista; }

    public void setComboTeatros(ArrayList<Teatro> teatros)
    {
        for (Teatro t:teatros
             ) {
            this.comboTeatros.addItem(t);
        }
    }

    public void displayMessage(String message, boolean success) {
        JOptionPane.showMessageDialog(this.frame, message, success ? "EXITO" : "ERROR",
                success ? JOptionPane.INFORMATION_MESSAGE : JOptionPane.ERROR_MESSAGE);
    }

    public void setTheaterInfo(String Nombre) {
        TheaterInfo.setText("Teatro designado: "+ Nombre);
    }



}
