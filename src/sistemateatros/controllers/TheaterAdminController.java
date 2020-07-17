package sistemateatros.controllers;

import com.toedter.calendar.JDateChooser;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Teatro;
import sistemateatros.views.TheaterAdminView;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class TheaterAdminController {
    private TheaterAdminView theaterAdminView;
    private int idTeatro;
    private String Admin;
    private Teatro teatro;



    public  TheaterAdminController(int IdTeatro,String Admin){
        this.theaterAdminView.getAñadirButton().addActionListener(new addAgentListener());
        this.setAdmin(Admin);
        theaterAdminView = new TheaterAdminView(this.Admin);
        this.setIdTeatro(IdTeatro);
        theaterAdminView.setVisible();
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        this.teatro = teatrosJDBC.getTeatroByID(idTeatro);
        theaterAdminView.setTextTH(teatro.getNombre());

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


        }
    }
}
