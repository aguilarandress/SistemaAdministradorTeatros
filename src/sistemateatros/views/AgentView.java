package sistemateatros.views;

import sistemateatros.models.AgentTheater;

import javax.swing.*;

public class AgentView {
    private JFrame frame;
    private JPanel panel1;
    private JTabbedPane tabbedPane1;
    private JLabel welcome_message;
    private JLabel TheaterInfo;
    private String Agente;
    private int TeatroId;

    public String getAgente() { return Agente; }

    public void setAgente(String agente) { Agente = agente; }

    public int getTeatroId() { return TeatroId; }

    public void setTeatroId(int teatroId) { TeatroId = teatroId; }

    public void setWelcome_message(String nombre) {
        this.welcome_message.setText("Bienvenido : " + nombre );
    }

    public void setTheaterInfo(String Nombre) {
        TheaterInfo.setText("Teatro designado: "+ Nombre);
    }
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
}
