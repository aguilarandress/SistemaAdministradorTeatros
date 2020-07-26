package sistemateatros.views;
import com.toedter.calendar.JDateChooser;
import com.toedter.components.JSpinField;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Bloque;
import sistemateatros.models.Produccion;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import javax.swing.text.DateFormatter;
import java.awt.event.ComponentAdapter;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
    private JComboBox ProdPresen;
    private JButton addPresentacion;
    private JTable PresentacionesProduc;
    private JPanel fechaHolderPrese;
    private JPanel horaHolder;
    private JPanel FechaPresen;
    private JComboBox ProduccionesEstados;
    private JComboBox comboEstados;
    private JButton cambiarEstadoButton;
    private JLabel labelEstado;
    private JTable tablaBloques;
    private JPanel horaHolderPresen;
    private String Admin;
    private JSpinner horaSpinner;
    JDateChooser date = new JDateChooser();
    JDateChooser prodInicio = new JDateChooser();
    JDateChooser prodFinal = new JDateChooser();
    JDateChooser presentacionFecha = new JDateChooser();



    public JButton getProdAdd() {
        return prodAdd;
    }

    public TheaterAdminView(String Admin) {
        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        Date date2 = new Date(System.currentTimeMillis());

        prodInicio.setDateFormatString("yyyy-MM-dd");
        prodFinal.setDateFormatString("yyyy-MM-dd");
        date.setDateFormatString("yyyy-MM-dd");
        presentacionFecha.setDateFormatString("yyyy-MM-dd");
        date.setDate(date2);

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
        FechaPresen.add(presentacionFecha);

        PresentacionesProduc.setModel(new DefaultTableModel(2,2));

        setSpinner();

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

    public void setSpinner()
    {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.HOUR_OF_DAY, 24); // 24 == 12 PM == 00:00:00
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.SECOND, 0);

        SpinnerDateModel model = new SpinnerDateModel();
        model.setValue(calendar.getTime());

        JSpinner spinner = new JSpinner(model);

        JSpinner.DateEditor editor = new JSpinner.DateEditor(spinner, "HH:mm");
        DateFormatter formatter = (DateFormatter)editor.getTextField().getFormatter();
        formatter.setAllowsInvalid(false); // this makes what you want
        formatter.setOverwriteMode(true);

        spinner.setEditor(editor);
        this.horaSpinner=spinner;
        horaHolder.add(spinner);
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
    public void setComboProds(ArrayList<Produccion> produccions)
    {
        for (Produccion p:produccions
             ) {
            this.ProdPresen.addItem(p.getNombre());
        }
    }
    public void setComboProdsEs(ArrayList<Produccion> produccions)
    {
        for (Produccion p:produccions
        ) {
            this.ProduccionesEstados.addItem(p.getNombre());
        }
    }

    public void setComboEstados(ArrayList<String> estados)
    {
        for (String s:estados
        ) {
            this.comboEstados.addItem(s);
        }
    }



    public void setAdmin(String admin) {
        Admin = admin;
    }

    public void setTextTH(String Teatro)
     {
         this.TheaterInfo.setText(TheaterInfo.getText()+" "+Teatro);
     }

    public JTabbedPane getHomeTAdm() {
        return homeTAdm;
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

    public String getPassword() {
        return String.valueOf(password.getPassword());
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

    public JPanel getFechaHolderPrese() { return fechaHolderPrese; }

    public JPanel getHoraHolderPresen() { return horaHolderPresen; }

    public JSpinner getHoraSpinner() { return horaSpinner; }

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

    public JComboBox getProdPresen() { return ProdPresen; }

    public JTable getPresentacionesProduc() { return PresentacionesProduc; }

    public JDateChooser getPresentacionFecha() { return presentacionFecha; }

    public JButton getAddPresentacion() { return addPresentacion; }

    public JComboBox getProduccionesEstados() { return ProduccionesEstados; }

    public JComboBox getComboEstados() { return comboEstados; }

    public JButton getCambiarEstadoButton() { return cambiarEstadoButton; }

    public JLabel getLabelEstado() { return labelEstado; }

    public JTable getTablaBloques() { return tablaBloques; }

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
        try {
            prodInicio.setDate(new SimpleDateFormat("dd/MM/yyyy").parse("00/00/0000"));
            prodFinal.setDate(new SimpleDateFormat("dd/MM/yyyy").parse("00/00/0000"));

            int filas = getTablaBloques().getRowCount();
            for(int i = 0 ; i<filas ; i++)
            {
                getTablaBloques().setValueAt(0,1,1);
                getTablaBloques().setValueAt(0,0,1);
            }

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

