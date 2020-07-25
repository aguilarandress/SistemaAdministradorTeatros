package sistemateatros.views;

import com.toedter.calendar.JDateChooser;

import javax.swing.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormularioCliente {
    private JFrame frame;
    private JPanel panel1;
    private JTextField textField1;
    private JTextField textField2;
    private JRadioButton efectivoRadioButton;
    private JRadioButton tarjetaDeCréditoRadioButton;
    private JTextField textField3;
    private JTextField textField4;
    private JTextField textField5;
    private JPanel HolderFechaCompra;
    private JButton comprarButton;
    JDateChooser date = new JDateChooser();

    public FormularioCliente()
    {
        this.frame = new JFrame("Datos de compra");
        this.frame.setContentPane(this.panel1);
        this.frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.frame.pack();
        this.frame.setSize(800, 700);

        SimpleDateFormat formatter= new SimpleDateFormat("yyyy-MM-dd");
        Date date2 = new Date(System.currentTimeMillis());

        date.setDate(date2);
        HolderFechaCompra.add(date);
    }
    public void setVisible()
    {
        this.frame.setVisible(true);
    }
}
