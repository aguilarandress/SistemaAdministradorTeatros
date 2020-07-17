package sistemateatros.views;

import javax.swing.*;

public class TheaterAdminView {
    private JFrame frame;
    private JTabbedPane homeTAdm;
    private JPanel panel1;
    private JLabel welcome_message;
    private JLabel TheaterInfo;
    private String Admin;

    public TheaterAdminView(String Admin) {
        this.frame = new JFrame("Aplicación de administración de teatros");
        this.frame.setContentPane(this.homeTAdm);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(700, 500);
        this.setAdmin(Admin);
        this.welcome_message.setText(welcome_message.getText() + getAdmin());


    }
    public void setVisible() {
        this.frame.setVisible(true);
    }


    public String getAdmin() {
        return Admin;
    }

    public void setAdmin(String admin) {
        Admin = admin;
    }
}

