package sistemateatros.views;
import com.toedter.calendar.JDateChooser;
import sistemateatros.models.AgentTheater;

import javax.swing.*;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.util.Date;

public class TheaterAdminView {
    private JFrame frame;
    private JTabbedPane homeTAdm;
    private JPanel panel1;
    private JLabel welcome_message;
    private JLabel TheaterInfo;
    private JTextField NombreField;
    private JTextField direccionField;
    private JTextField tHome;
    private JTextField tMobile;
    private JTextField email;
    private JTextField tOther;
    private JRadioButton masculinoRadioButton;
    private JRadioButton femeninoRadioButton;
    private JPanel CalendarHolder;
    private JButton verificarDisponibilidadButton;
    private JButton addButton;
    private JPasswordField password;
    private JTextField usuario;
    private JTextField cedula;
    private String Admin;
    JDateChooser date = new JDateChooser();



    public TheaterAdminView(String Admin) {
        date.setDateFormatString("yyyy-MM-dd");
        this.frame = new JFrame("Aplicación de administración de teatros");
        this.frame.setContentPane(this.homeTAdm);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(700, 500);
        this.setAdmin(Admin);
        this.welcome_message.setText(welcome_message.getText() + getAdmin());
        CalendarHolder.add(date);
        cedula.addKeyListener(new KeyAdapter() {
            public void keyPressed(KeyEvent ke) {
                String value = cedula.getText();
                int l = value.length();
                if ((ke.getKeyChar() >= '0' && ke.getKeyChar() <= '9' )|| ke.getKeyCode() == KeyEvent.VK_BACK_SPACE) {
                    cedula.setEditable(true);

                } else {
                    cedula.setEditable(false);

                }
            }



    });
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
     public void setTextTH(String Teatro)
     {
         this.TheaterInfo.setText(TheaterInfo.getText()+" "+Teatro);
     }

    public String getNombreField() {
        return NombreField.getText();
    }

    public String getDireccionField() {
        return direccionField.getText();
    }

    public String gettHome() {
        return tHome.getText();
    }

    public String gettMobile() {
        return tMobile.getText();
    }

    public String getEmail() {
        return email.getText();
    }

    public Date getDate() {
        return date.getDate();
    }

    public String gettOther() {
        return tOther.getText();
    }

    public char[] getPassword() {
        return password.getPassword();
    }

    public String getUsuario() {
        return usuario.getText();
    }

    public String getCedula() {
        return cedula.getText();
    }

    public char getGenero()
    {
        if(masculinoRadioButton.isSelected())
        {
            return 'M';
        }
        else
        {
            return 'F';
        }
    }
    public void setTelefonos(AgentTheater agente)
    {
        if(!tHome.getText().isEmpty())
        {
            agente.setTelefonoCasa(tHome.getText());
        }
        if(!tMobile.getText().isEmpty())
        {
            agente.setTelefonoCelular(tMobile.getText());
        }
        if(!tOther.getText().isEmpty())
        {
            agente.setTelefonoOtro(tOther.getText());
        }
    }
    public JButton getaddButton() {
        return addButton;
    }
    public void displayMessage(String message, boolean success) {
        JOptionPane.showMessageDialog(this.frame, message, success ? "EXITO" : "ERROR",
                success ? JOptionPane.INFORMATION_MESSAGE : JOptionPane.ERROR_MESSAGE);
    }
    public void clearFields()
    {
        NombreField.setText("");
        direccionField.setText("");
        tHome.setText("");
        tMobile.setText("");
        tOther.setText("");
        email.setText("");
        password.setText("");
        usuario.setText("");
        cedula.setText("");

    }
    private void createUIComponents() {
        // TODO: place custom component creation code here
    }
}

