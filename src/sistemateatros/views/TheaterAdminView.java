package sistemateatros.views;
import com.toedter.calendar.JDateChooser;
import sistemateatros.models.AgentTheater;
import sun.security.krb5.internal.crypto.Des;

import javax.swing.*;
import java.awt.event.ComponentAdapter;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
    private JTextField produccion;
    private JTextField Descripcion;
    private JComboBox tipoProd;
    private JButton prodAdd;
    private JPanel holderI;
    private JPanel holderF;
    private String Admin;
    JDateChooser date = new JDateChooser();
    JDateChooser prodInicio = new JDateChooser();
    JDateChooser prodFinal = new JDateChooser();

    public JButton getProdAdd() {
        return prodAdd;
    }

    public TheaterAdminView(String Admin) {
        prodInicio.setDateFormatString("yyyy-MM-dd");
        prodFinal.setDateFormatString("yyyy-MM-dd");
        date.setDateFormatString("yyyy-MM-dd");
        this.frame = new JFrame("Aplicación de administración de teatros");
        this.frame.setContentPane(this.homeTAdm);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(700, 500);
        this.setAdmin(Admin);
        this.welcome_message.setText(welcome_message.getText() + getAdmin());
        CalendarHolder.add(date);
        holderI.add(prodInicio);
        holderF.add(prodFinal);
        //Configurar el field de cédula para que solo acepte números
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
        panel1.addComponentListener(new ComponentAdapter() {
        });
    }
    public void setVisible() {
        this.frame.setVisible(true);
    }


    public String getAdmin() {
        return Admin;
    }
    public void setCombo(ArrayList<String> tipos)
    {
        for (String tipo:
                tipos
             ) {
            this.tipoProd.addItem(tipo);
        }

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

    public String getProduccion() {
        return produccion.getText();
    }

    public String getDescripcion() {
        return Descripcion.getText();
    }

    public int getTipoProd() {

        return tipoProd.getSelectedIndex()+1;
    }

    public Date getProdInicio() {
        return prodInicio.getDate();
    }

    public Date getProdFinal() {
        return prodFinal.getDate();
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
    public void clearFieldsAgente()
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
        try
        {
            date.setDate(new SimpleDateFormat("dd/MM/yyyy").parse("00/00/0000"));
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }



    }
    public void clearFieldsProd()
    {
        produccion.setText("");
        Descripcion.setText("");
        try
        {
            prodInicio.setDate(new SimpleDateFormat("dd/MM/yyyy").parse("00/00/0000"));
            prodFinal.setDate(new SimpleDateFormat("dd/MM/yyyy").parse("00/00/0000"));
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

    }
    private void createUIComponents() {
        // TODO: place custom component creation code here
    }
}

