package sistemateatros.controllers;

import org.mindrot.jbcrypt.BCrypt;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Produccion;
import sistemateatros.models.Teatro;
import sistemateatros.validators.AgenteValidator;
import sistemateatros.validators.ProduccionValidator;
import sistemateatros.views.TheaterAdminView;

import javax.xml.crypto.Data;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

public class TheaterAdminController {
    private TheaterAdminView theaterAdminView;
    private int idTeatro;
    private String Admin;
    private Teatro teatro;
    private AgentesJDBC agentesJDBC;
    private ProduccionesJDBC produccionesJDBC;
    private TeatrosJDBC teatrosJDBC;



    public  TheaterAdminController(int IdTeatro,String Admin){


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

        this.teatro = teatrosJDBC.getTeatroByID(idTeatro);
        theaterAdminView.setTextTH(teatro.getNombre());
        this.theaterAdminView.getProdAdd().addActionListener(new addProdListener());
        this.theaterAdminView.getaddButton().addActionListener(new addAgentListener());
        ArrayList<String> tipos = produccionesJDBC.getTipos();

        this.theaterAdminView.setCombo(tipos);


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
            produccionesJDBC.AddProd(produccion);
            theaterAdminView.displayMessage("Añadido con éxito",true);
            theaterAdminView.clearFieldsProd();


        }
    }
    private class addAgentListener implements ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            //Get agent info
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
            char[] pass=agentTheater.getPassword();
            agentTheater.setPassword((BCrypt.hashpw(pass.toString(),BCrypt.gensalt(4))).toCharArray());
            agentTheater.setIdTeatro(idTeatro);
            agentesJDBC.AddAgente(agentTheater);
            theaterAdminView.displayMessage("Añadido con éxito",true);
            theaterAdminView.clearFieldsAgente();
        }
    }
}
