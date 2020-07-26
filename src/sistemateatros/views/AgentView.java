package sistemateatros.views;

import sistemateatros.models.CheckBoxSelectionTableModel;
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
    private JButton BoletosButton;
    private JTable tablaAsientos;
    private JList listaAsientos;
    private JButton realizarCompraButton;
    private JLabel totalL;
    private JLabel montoTotal;
    private JComboBox comboBLQ;
    private JComboBox comboFl;
    private JPanel ConsultaAsientos;
    private JComboBox teatroComboAsientos;
    private JScrollPane HolderProdAsientos;
    private JTable tablaProdAsientos;
    private JTable tablaPresAsientos;
    private JTable tablaAsientosAsientos;
    private JComboBox comboBloqueAsientos;
    private JComboBox comboFilaAsientos;
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
        CheckBoxSelectionTableModel.register(tablaProds);
        CheckBoxSelectionTableModel.register(tablaPresent);

    }

    public JComboBox getTeatroComboAsientos() {
        return teatroComboAsientos;
    }

    public JTable getTablaProdAsientos() {
        return tablaProdAsientos;
    }

    public JTable getTablaPresAsientos() {
        return tablaPresAsientos;
    }

    public JTable getTablaAsientosAsientos() {
        return tablaAsientosAsientos;
    }

    public JComboBox getComboBloqueAsientos() {
        return comboBloqueAsientos;
    }

    public JComboBox getComboFilaAsientos() {
        return comboFilaAsientos;
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


    public JButton getBoletosButton() { return BoletosButton; }



    public JTable getTablaAsientos() { return tablaAsientos; }

    public JButton getRealizarCompraButton() { return realizarCompraButton; }

    public JList getListaAsientos() { return listaAsientos; }

    public DefaultListModel getValoresLista() { return valoresLista; }


    public JComboBox getComboBLQ() {
        return comboBLQ;
    }

    public JComboBox getComboFl() {
        return comboFl;
    }

    public void setComboTeatros(ArrayList<Teatro> teatros)
    {
        for (Teatro t:teatros
             ) {
            this.comboTeatros.addItem(t);
        }
    }
    public void setComboTeatrosAsientos(ArrayList<Teatro> teatros)
    {
        for (Teatro t:teatros
        ) {
            this.teatroComboAsientos.addItem(t);
        }
    }

    public void displayMessage(String message, boolean success) {
        JOptionPane.showMessageDialog(this.frame, message, success ? "EXITO" : "ERROR",
                success ? JOptionPane.INFORMATION_MESSAGE : JOptionPane.ERROR_MESSAGE);
    }

    public Double getMontoTotal() {
        return Double.parseDouble(montoTotal.getText());
    }

    public void setMontoTotal(Double montoTotal) {
        this.montoTotal.setText(montoTotal.toString());
    }

    public void setTheaterInfo(String Nombre) {
        TheaterInfo.setText("Teatro designado: "+ Nombre);
    }



}
