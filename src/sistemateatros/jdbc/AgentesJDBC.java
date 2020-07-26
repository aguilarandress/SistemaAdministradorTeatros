package sistemateatros.jdbc;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import com.microsoft.sqlserver.jdbc.SQLServerCallableStatement;
import com.microsoft.sqlserver.jdbc.SQLServerDataTable;
import sistemateatros.daos.AgentesDAO;
import sistemateatros.models.*;

public class AgentesJDBC implements AgentesDAO {
    private Connection connection;
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    @Override
    public boolean existeCedula(int cedula) {
        try {


            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateIdTeatroAgentes ?");
            preparedStatement.setInt(1, cedula);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return false;
            }
            return true;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public ArrayList<Bloque> getBloquePreciosByProdId(int ProdId) {
        try
        {

        ArrayList<Bloque> bloques = new ArrayList<Bloque>() ;
        PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByProdIdBloquePrecios ?");
        preparedStatement.setInt(1,ProdId);
        ResultSet resultSet = preparedStatement.executeQuery();
        while(resultSet.next())
        {
            Bloque bloque = new Bloque();
            bloque.setNombre(resultSet.getString("BloqueNombre"));
            bloque.setPrecio(resultSet.getBigDecimal("Monto").floatValue());
            bloque.setId(resultSet.getInt("BloqueId"));
            bloque.setIdProd(resultSet.getInt("IdProduccion"));
            bloques.add(bloque);
        }
        return bloques;
    }
        catch (SQLException e)
    {
        e.printStackTrace();
    }
        return null;
    }

    @Override
    public Object[] procesarCompraTarjeta(Reservacion reservacion,ArrayList<Asiento> asientos,int ProdId, int PresId) {

        try
        {
            SQLServerCallableStatement callableStatement = (SQLServerCallableStatement)connection.prepareCall("EXEC RealizarCompraTarjeta ?,?,?,?,?,?,?,?,?,? ");
            callableStatement.setString(1,reservacion.getNombreCliente());
            callableStatement.setString(2,reservacion.getTelefono());
            callableStatement.setInt(3,reservacion.getCVC());
            BigDecimal bd = new BigDecimal(reservacion.getMonto()).setScale(2, RoundingMode.HALF_UP);
            callableStatement.setBigDecimal(4,bd);
            SQLServerDataTable sourceDataTable = new SQLServerDataTable();
            sourceDataTable.addColumnMetadata("BloqueId", Types.INTEGER);
            sourceDataTable.addColumnMetadata("FilaId",Types.CHAR);
            sourceDataTable.addColumnMetadata("AsientoId",Types.INTEGER);
            for (Asiento asiento:asientos
                 ) {
                sourceDataTable.addRow(asiento.getBloqueId(),asiento.getFilaId(),asiento.getAsientoId());

            }
            callableStatement.setStructured(5,"dbo.TablaAsientos",sourceDataTable);
            callableStatement.setInt(6,ProdId);
            callableStatement.setInt(7,PresId);
            callableStatement.registerOutParameter(8,Types.INTEGER);
            callableStatement.registerOutParameter(9,Types.DECIMAL);
            callableStatement.registerOutParameter(10,Types.DATE);
            callableStatement.execute();
            Boolean success=callableStatement.getBoolean(8);
            int comprobacion=callableStatement.getBigDecimal(9).intValue();
            Date fecha = callableStatement.getDate(10);
            Object[] resultados= new Object[]{success,comprobacion,fecha};
            return resultados;

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return new Object[0];
    }

    @Override
    public Object[] procesarCompraEfectivo(Reservacion reservacion, ArrayList<Asiento> asientos, int ProdId, int PresId) {
        try
         {
            SQLServerCallableStatement callableStatement = (SQLServerCallableStatement)connection.prepareCall("EXEC RealizarCompraEfectivo ?,?,?,?,?,?,?,?,? ");
            callableStatement.setString(1,reservacion.getNombreCliente());
            callableStatement.setString(2,reservacion.getTelefono());
            BigDecimal bd = new BigDecimal(reservacion.getMonto()).setScale(2, RoundingMode.HALF_UP);
            callableStatement.setBigDecimal(3,bd);
            SQLServerDataTable sourceDataTable = new SQLServerDataTable();
            sourceDataTable.addColumnMetadata("BloqueId", Types.INTEGER);
            sourceDataTable.addColumnMetadata("FilaId",Types.CHAR);
            sourceDataTable.addColumnMetadata("AsientoId",Types.INTEGER);
            for (Asiento asiento:asientos
            ) {
                sourceDataTable.addRow(asiento.getBloqueId(),asiento.getFilaId(),asiento.getAsientoId());

            }
            callableStatement.setStructured(4,"dbo.TablaAsientos",sourceDataTable);
            callableStatement.setInt(5,ProdId);
            callableStatement.setInt(6,PresId);
            callableStatement.registerOutParameter(7,Types.INTEGER);
            callableStatement.registerOutParameter(8,Types.DECIMAL);
            callableStatement.registerOutParameter(9,Types.DATE);
            callableStatement.execute();
            Boolean success=callableStatement.getBoolean(7);
            int comprobacion=callableStatement.getBigDecimal(8).intValue();
            Date fecha = callableStatement.getDate(9);
            Object[] resultados= new Object[]{success,comprobacion,fecha};
            return resultados;

        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return new Object[0];
}

    @Override
    public boolean verificarUsername(String username) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateUsername ?");
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return  false;
            }
            return true;
        }


        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return true;
    }

    @Override
    public boolean verificarNombre(String nombre) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC ValidateNameTeatroAgentes ?");
            preparedStatement.setString(1, nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean agenteFound = resultSet.next();
            if (!agenteFound) {

                return false;
            }
            return true;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return  true ;
    }

    @Override
    public void AddAgente(AgentTheater agentTheater) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateTeatroAgentes ?,?,?,?,?,?,?,?,?,?,?,?");
            preparedStatement.setInt(1,agentTheater.getCedula());
            preparedStatement.setString(2, agentTheater.getNombre());
            preparedStatement.setInt(3,agentTheater.getIdTeatro());

            java.sql.Date date = new java.sql.Date(agentTheater.getFechaNacimiento().getTime());
            preparedStatement.setDate(4,date);


            preparedStatement.setString(5,String.valueOf(agentTheater.getSexo()));
            preparedStatement.setString(6,agentTheater.getDireccion());
            preparedStatement.setString(7,agentTheater.getEmail());
            preparedStatement.setString(8,agentTheater.getUsername());
            preparedStatement.setString(9,String.valueOf(agentTheater.getPassword()));
            if (!(agentTheater.getTelefonoCasa()==null))
            {
                preparedStatement.setString(10,agentTheater.getTelefonoCasa());
            }
            else
            {
                preparedStatement.setNull(10, Types.VARCHAR);
            }
            if (!(agentTheater.getTelefonoCelular()==null))
            {
                preparedStatement.setString(11,agentTheater.getTelefonoCelular());
            }
            else
            {
                preparedStatement.setNull(

                        11, Types.VARCHAR);
            }
            if (!(agentTheater.getTelefonoOtro()==null))
            {
                preparedStatement.setString(12,agentTheater.getTelefonoOtro());
            }
            else
            {
                preparedStatement.setNull(12, Types.VARCHAR);
            }
            preparedStatement.execute();

        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }

    }
}
