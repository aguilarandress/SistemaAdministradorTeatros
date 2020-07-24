package sistemateatros.views;

import sistemateatros.models.Teatro;

import javax.swing.*;
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
    private JButton comprarButton;
    private JTable tablaFilas;
    private JTable tablaAsientos;
    private String Agente;
    private int TeatroId;

    public AgentView (int TeatroId,String Agente)
    {
        this.frame = new JFrame("Administrador de sistemas");
        this.frame.setContentPane(this.panel1);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(800, 600);

        this.setAgente(Agente);
        this.setTeatroId(TeatroId);
        setWelcome_message(Agente);

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

    public JButton getComprarButton() { return comprarButton; }

    public JTable getTablaFilas() { return tablaFilas; }

    public JTable getTablaAsientos() { return tablaAsientos; }

    public void setComboTeatros(ArrayList<Teatro> teatros)
    {
        for (Teatro t:teatros
             ) {
            this.comboTeatros.addItem(t);
        }
    }

    public void setTheaterInfo(String Nombre) {
        TheaterInfo.setText("Teatro designado: "+ Nombre);
    }



}
