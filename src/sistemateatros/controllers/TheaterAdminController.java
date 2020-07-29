package sistemateatros.controllers;

import net.proteanit.sql.DbUtils;
import org.mindrot.jbcrypt.BCrypt;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.PresentacionesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.mapper.TableBloquesMapper;
import sistemateatros.models.*;
import sistemateatros.validators.AgenteValidator;
import sistemateatros.validators.BloquePrecioValidator;
import sistemateatros.validators.ProduccionValidator;
import sistemateatros.views.AuthenticationView;
import sistemateatros.views.TheaterAdminView;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.plaf.basic.BasicTreeUI;
import javax.swing.table.TableModel;
import javax.xml.crypto.Data;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.sql.ResultSet;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class TheaterAdminController {
    private TheaterAdminView theaterAdminView;
    private int idTeatro;
    private String Admin;
    private Teatro teatro;
    private AgentesJDBC agentesJDBC;
    private ProduccionesJDBC produccionesJDBC;
    private TeatrosJDBC teatrosJDBC;
    private PresentacionesJDBC presentacionesJDBC;



    public  TheaterAdminController(int IdTeatro, String Admin, AuthenticationView authenticationView){


        this.setAdmin(Admin);
        theaterAdminView = new TheaterAdminView(this.Admin);
        this.setIdTeatro(IdTeatro);
        theaterAdminView.setVisible();
        agentesJDBC = new AgentesJDBC();
        agentesJDBC.setConnection(DatabaseConnection.getConnection());
        teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        produccionesJDBC = new ProduccionesJDBC();
        produccionesJDBC.setConnection(DatabaseConnection.getConnection());
        presentacionesJDBC = new PresentacionesJDBC();
        presentacionesJDBC.setConnection(DatabaseConnection.getConnection());

        this.teatro = teatrosJDBC.getTeatroByID(idTeatro);
        theaterAdminView.setTextTH(teatro.getNombre());
        this.theaterAdminView.getProdAdd().addActionListener(new addProdListener());
        this.theaterAdminView.getaddButton().addActionListener(new addAgentListener());
        this.theaterAdminView.getHomeTAdm().addChangeListener(new cambiarPaneListener());
        this.theaterAdminView.getProdPresen().addItemListener(new cargarPresentacionesListener());
        this.theaterAdminView.getAddPresentacion().addActionListener(new addPresentacionListener());
        this.theaterAdminView.getProduccionesEstados().addItemListener(new refresEstadoListener());
        this.theaterAdminView.getCambiarEstadoButton().addActionListener(new changeEstadoListener());
        ArrayList<String> tipos = produccionesJDBC.getTipos();
        this.theaterAdminView.setCombo(tipos);

        this.theaterAdminView.getLogoutBtn().addActionListener(new logoutBtnListener());

        this.theaterAdminView.setAuthenticationView(authenticationView);

    }

    public int getIdTeatro() {
        return idTeatro;
    }

    public void setIdTeatro(int idTeatro) {
        this.idTeatro = idTeatro;
    }

    public String getAdmin() {
        return Admin;
    }

    public void setAdmin(String admin) {
        Admin = admin;
    }

    private class addProdListener implements  ActionListener
    {
        public void actionPerformed(ActionEvent e) {
            Produccion produccion = new Produccion();
            produccion.setNombre(theaterAdminView.getProduccion());
            produccion.setDescripcion(theaterAdminView.getDescripcion());
            produccion.setFechaI(theaterAdminView.getProdInicio());
            produccion.setFechaF(theaterAdminView.getProdFinal());
            produccion.setIdTeatro(idTeatro);
            produccion.setIdTipo(theaterAdminView.getTipoProd());
            produccion.setIdEstado(1);
            ArrayList<String> errores = ProduccionValidator.validarAgente(produccion);
            if (errores.size()>0)
            {
                theaterAdminView.displayMessage(errores.get(0),false);
                return;
            }
            ArrayList<Bloque> bloques = new ArrayList<Bloque>();
            int filas = theaterAdminView.getTablaBloques().getRowCount();
            if(filas==0)
            {
                theaterAdminView.displayMessage("Dado que el teatro no tiene bloques no se puede continuar",false);
                return;
            }
            for(int i = 0 ; i<filas ; i++)
            {
                Bloque bloque=(Bloque)theaterAdminView.getTablaBloques().getValueAt(i,0);
                bloque.setPrecio((Integer) theaterAdminView.getTablaBloques().getValueAt(i,1));
                bloques.add(bloque);
                System.out.println(i);
            }
            errores = BloquePrecioValidator.validateBloques(bloques);
            if (errores.size()>0)
            {
                theaterAdminView.displayMessage(errores.get(0),false);
                return;
            }
            produccionesJDBC.AddProd(produccion);
            produccion = produccionesJDBC.getProdByName(produccion.getNombre());
            produccionesJDBC.AddBloquePrecio(bloques,produccion.getId());
            theaterAdminView.displayMessage("Añadido con éxito",true);
            theaterAdminView.clearFieldsProd();



        }
    }
    private class addAgentListener implements ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            //Get agent info
            if (theaterAdminView.getCedula().isEmpty()) {
                theaterAdminView.displayMessage("Cedula invalida", false);
                return;
            }
            AgentTheater agentTheater = new AgentTheater();
            agentTheater.setNombre(theaterAdminView.getNombreField());
            agentTheater.setDireccion(theaterAdminView.getDireccionField());
            agentTheater.setFechaNacimiento(theaterAdminView.getDate());
            agentTheater.setSexo(theaterAdminView.getGenero());
            agentTheater.setEmail(theaterAdminView.getEmail());
            theaterAdminView.setTelefonos(agentTheater);
            agentTheater.setUsername(theaterAdminView.getUsuario());
            agentTheater.setPassword(theaterAdminView.getPassword());
            agentTheater.setCedula(Integer.parseInt(theaterAdminView.getCedula()));
            ArrayList<String> errores = AgenteValidator.validarAgente(agentTheater);
            if (errores.size()>0)
            {
                theaterAdminView.displayMessage(errores.get(0),false);
                return;
            }
            String pass=agentTheater.getPassword();
            agentTheater.setPassword((BCrypt.hashpw(pass.toString(),BCrypt.gensalt(4))));
            agentTheater.setIdTeatro(idTeatro);
            agentesJDBC.AddAgente(agentTheater);
            theaterAdminView.displayMessage("Añadido con éxito",true);
            theaterAdminView.clearFieldsAgente();
        }
    }
    private class cambiarPaneListener implements ChangeListener {
        @Override
        public void stateChanged(ChangeEvent e) {
                // Verificar cual tabbed pane se esta cargando
            if (theaterAdminView.getHomeTAdm().getSelectedIndex() == 1)
            {

                //query bloques
                ArrayList<Bloque> bloques = teatrosJDBC.getBloquesByIdTeatro(idTeatro);
                ModelTablaBloques model =  TableBloquesMapper.mapRows(bloques);
                theaterAdminView.getTablaBloques().setModel(model);




            }
            else if (theaterAdminView.getHomeTAdm().getSelectedIndex() == 2)
            {
                theaterAdminView.getProduccionesEstados().removeAllItems();
                ArrayList<Produccion> produccions = produccionesJDBC.getProducciones();
                theaterAdminView.setComboProdsEs(produccions);
                theaterAdminView.getComboEstados().removeAllItems();
                ArrayList<String> estados = produccionesJDBC.getEstados();
                theaterAdminView.setComboEstados(estados);
            }
            else if (theaterAdminView.getHomeTAdm().getSelectedIndex() == 3) {
                theaterAdminView.getProdPresen().removeAllItems();
                ArrayList<Produccion> produccions = produccionesJDBC.getProducciones();
                theaterAdminView.setComboProds(produccions);


            }
        }
    }
    private  class cargarPresentacionesListener implements ItemListener
    {

        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Produccion produccion = produccionesJDBC.getProdByName((String)theaterAdminView.getProdPresen().getSelectedItem());
                ResultSet presentacions = presentacionesJDBC.getRawPresentByProdId(produccion.getId());
                TableModel model= DbUtils.resultSetToTableModel(presentacions);
                theaterAdminView.getPresentacionesProduc().setModel(model);
                theaterAdminView.getPresentacionFecha().setMaxSelectableDate(produccion.getFechaF());
                theaterAdminView.getPresentacionFecha().setMinSelectableDate(produccion.getFechaI());
            }

        }
    }
    private class refresEstadoListener implements  ItemListener
    {

        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Produccion produccion = produccionesJDBC.getProdByName((String)theaterAdminView.getProduccionesEstados().getSelectedItem());
                String estado = produccionesJDBC.getEstadoById(produccion.getIdEstado());
                theaterAdminView.getLabelEstado().setText("La produccion se encuentra : "+estado);

            }
        }
    }
    private class changeEstadoListener implements  ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            Produccion produccion = produccionesJDBC.getProdByName((String)theaterAdminView.getProduccionesEstados().getSelectedItem());
            produccion.setIdEstado(theaterAdminView.getComboEstados().getSelectedIndex()+1);
            produccionesJDBC.updateEstado(produccion);
            theaterAdminView.getLabelEstado().setText("La produccion se encuentra : "+(String)theaterAdminView.getComboEstados().getSelectedItem());
            theaterAdminView.displayMessage("Actualizado con éxito",true);


        }
    }
    private class addPresentacionListener implements  ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            Presentacion presentacion = new Presentacion();
            Object valorHora=theaterAdminView.getHoraSpinner().getValue();
            Date date = (Date)valorHora;
            SimpleDateFormat format = new SimpleDateFormat("HH:mm");
            String time = format.format(date);
            Produccion produccion = produccionesJDBC.getProdByName((String)theaterAdminView.getProdPresen().getSelectedItem());
            presentacion.setHora(time);
            presentacion.setFecha(theaterAdminView.getPresentacionFecha().getDate());
            presentacion.setId(produccion.getId());
            ArrayList<Presentacion>presentacions = presentacionesJDBC.getPresentByProdId(produccion.getId());
            presentacion.setPresentId(presentacions.size()+1);
            //TODO: PUEDEN HABER PRESENTACIONES A LA MISMA HORA DE DIFERENTES PRODUCCIONES

            presentacionesJDBC.addPresentacion(presentacion);
            theaterAdminView.displayMessage("Añadido con éxito",true);
            ResultSet presentacionsRaw = presentacionesJDBC.getRawPresentByProdId(produccion.getId());
            TableModel model= DbUtils.resultSetToTableModel(presentacionsRaw);
            theaterAdminView.getPresentacionesProduc().setModel(model);




        }
    }
    /**
     * Listener que realiza la acción de logout
     */
    private class logoutBtnListener implements  ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            theaterAdminView.getAuthenticationView().setVisible();
            theaterAdminView.close();

        }
    }
}
