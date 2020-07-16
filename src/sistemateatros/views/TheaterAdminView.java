package sistemateatros.views;

import javax.swing.*;

public class TheaterAdminView {
    private JFrame frame;
    private JTabbedPane homeTAdm;
    private JPanel panel1;


    public TheaterAdminView() {
        this.frame = new JFrame("Aplicación de administración de teatros");
        this.frame.setContentPane(this.homeTAdm);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(700, 500);
    }
    public void setVisible() {
        this.frame.setVisible(true);
    }
}
