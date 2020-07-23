package sistemateatros.controllers;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.PresentacionesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.Teatro;
import sistemateatros.views.AgentView;

public class TheaterAgenteController {
    String agente;
    int IdTeatro;
    AgentView agentView;
    Teatro teatro;
    private AgentesJDBC agentesJDBC;
    private ProduccionesJDBC produccionesJDBC;
    private TeatrosJDBC teatrosJDBC;
    private PresentacionesJDBC presentacionesJDBC;
    public  TheaterAgenteController(int IdTeatro,String agente)
    {
        this.agente=agente;
        this.IdTeatro=IdTeatro;
        agentView = new AgentView(IdTeatro,agente);
        this.agentView.setVisible();
        agentesJDBC = new AgentesJDBC();
        agentesJDBC.setConnection(DatabaseConnection.getConnection());
        teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        produccionesJDBC = new ProduccionesJDBC();
        produccionesJDBC.setConnection(DatabaseConnection.getConnection());
        presentacionesJDBC = new PresentacionesJDBC();
        presentacionesJDBC.setConnection(DatabaseConnection.getConnection());
        this.teatro = teatrosJDBC.getTeatroByID(IdTeatro);
        this.agentView.setTheaterInfo(teatro.getNombre());

    }
}
