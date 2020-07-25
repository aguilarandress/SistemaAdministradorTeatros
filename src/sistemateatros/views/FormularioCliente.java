package sistemateatros.views;

import com.toedter.calendar.JDateChooser;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormularioCliente {
    private JFrame frame;
    private JPanel panel1;
    private JTextField nombre;
    private JTextField telefono;
    private JRadioButton efectivoRadioButton;
    private JRadioButton tarjetaDeCréditoRadioButton;
    private JTextField correo;
    private JTextField tarjeta;
    private JTextField cvc;
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

        this.cvc.addKeyListener(new KeyAdapter() {
            public void keyPressed(KeyEvent ke) {
                String value = cvc.getText();
                int l = value.length();
                if (((ke.getKeyChar() >= '0' && ke.getKeyChar() <= '9') || ke.getKeyCode() == KeyEvent.VK_BACK_SPACE ) && ((value.length()<3)|| ke.getKeyCode() == KeyEvent.VK_BACK_SPACE )) {
                    cvc.setEditable(true);

                } else {
                    cvc.setEditable(false);
                }
            }
        });
        this.efectivoRadioButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(efectivoRadioButton.isSelected())
                {
                    tarjeta.setEnabled(false);
                    cvc.setEnabled(false);
                    date.setEnabled(false);
                }
            }
        });
        this.tarjetaDeCréditoRadioButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(tarjetaDeCréditoRadioButton.isSelected())
                {
                    tarjeta.setEnabled(true);
                    cvc.setEnabled(true);
                    date.setEnabled(true);
                }
            }
        });
        this.efectivoRadioButton.setSelected(true);
        tarjeta.setEnabled(false);
        cvc.setEnabled(false);
        date.setEnabled(false);
    }
    public void setVisible()
    {
        this.frame.setVisible(true);
    }

    public JTextField getNombre() {
        return nombre;
    }

    public JTextField getTelefono() {
        return telefono;
    }

    public JTextField getCorreo() {
        return correo;
    }

    public JTextField getTarjeta() {
        return tarjeta;
    }

    public JTextField getCvc() {
        return cvc;
    }

    public JButton getComprarButton() {
        return comprarButton;
    }

    public JDateChooser getDate() {
        return date;
    }
    public boolean esEfectivo ()
    {
        if(this.efectivoRadioButton.isSelected())
        {
            return false;
        }
        else
        {
            return  true;
        }
    }
}
