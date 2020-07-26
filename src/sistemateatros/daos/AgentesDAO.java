package sistemateatros.daos;

import sistemateatros.models.*;

import java.sql.Connection;
import java.util.ArrayList;

public interface AgentesDAO {
    public boolean verificarUsername(String username);
    public boolean verificarNombre(String nombre);
    public void AddAgente(AgentTheater agentTheater);
    public void setConnection(Connection connection);
    public boolean existeCedula(int cedula);
    public ArrayList<Bloque> getBloquePreciosByProdId(int ProdId);
    public Object[] procesarCompraTarjeta(Reservacion reservacion, ArrayList<Asiento> asientos,int ProdId, int PresId);
    public Object[] procesarCompraEfectivo(Reservacion reservacion,ArrayList<Asiento> asientos,int ProdId, int PresId);
}
