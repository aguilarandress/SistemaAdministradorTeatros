package sistemateatros.daos;

import sistemateatros.models.AgentTheater;
import sistemateatros.models.TheaterAdmin;

import java.sql.Connection;

public interface AgentesDAO {
    public boolean verificarUsername(String username);
    public boolean verificarNombre(String nombre);
    public void AddAgente(AgentTheater agentTheater);
    public void setConnection(Connection connection);
}
