package sistemateatros.jdbc;

import sistemateatros.daos.TeatrosDAO;
import sistemateatros.models.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Clase para teatros en la BD
 */
public class TeatrosJDBC implements TeatrosDAO {

    private Connection connection;

    /**
     * Configura la conexion que debe usar
     * @param connection La conexion de la base de datos
     */
    @Override
    public void setConnection(Connection connection) {
        this.connection = connection;
    }

    /**
     * Obtiene todos los teatros
     * @return Todos los teatros de la base de datos
     */
    @Override
    public ArrayList<Teatro> getTeatros() {
        ArrayList<Teatro> teatros = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetTeatros");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Teatro teatro = new Teatro();
                teatro.setId(resultSet.getInt("Id"));
                teatro.setNombre(resultSet.getString("Nombre"));
                teatro.setSitioWeb(resultSet.getString("SitioWeb"));
                teatro.setCorreo(resultSet.getString("Correo"));
                teatro.setCapacidad(resultSet.getInt("Capacidad"));
                teatro.setTelefonoAdministracion(resultSet.getString("TelefonoAdministracion"));
                teatro.setTelefonoBoleteria(resultSet.getString("TelefonoBoleteria"));
                teatros.add(teatro);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return teatros;
    }

    /**
     * Obtiene el teatro por el nombre
     * @param nombre El nombre del teatro
     * @return Un teatro
     */
    @Override
    public Teatro getTeatroByNombre(String nombre) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByNombreTeatros ?");
            preparedStatement.setString(1, nombre);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean teatroFound = resultSet.next();
            if (!teatroFound) {
                return null;
            }
            Teatro teatro = new Teatro();
            teatro.setNombre(resultSet.getString("Nombre"));
            return teatro;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Teatro getTeatroByID(int Id) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByIdTeatros ?");
            preparedStatement.setInt(1, Id);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean teatroFound = resultSet.next();
            if (!teatroFound) {
                return null;
            }
            Teatro teatro = new Teatro();
            teatro.setNombre(resultSet.getString("Nombre"));
            return teatro   ;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return  null;
    }
  
    /**
     * Crea un teatro nuevo
     * @param teatro El teatro nuevo
     */
    @Override
    public void crearTeatro(Teatro teatro) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateTeatros ?, ?, ?, ?, ?, ?");
            preparedStatement.setString(1, teatro.getNombre());
            preparedStatement.setInt(2, 0);
            preparedStatement.setString(3, teatro.getCorreo());
            preparedStatement.setString(4, teatro.getSitioWeb());
            preparedStatement.setString(5, teatro.getTelefonoAdministracion());
            preparedStatement.setString(6, teatro.getTelefonoBoleteria());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public ArrayList<Fila> getFilasByBloque(Bloque bloque) {
        ArrayList<Fila> filas = new ArrayList<Fila>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByBloqueIdFilas ?");
            preparedStatement.setInt(1, bloque.getId());
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Fila fila = new Fila();
                fila.setLetra(resultSet.getString("FilaId"));
                fila.setNumeroAsientos(resultSet.getInt("NumeroAsientos"));
                fila.setBloqueId(resultSet.getInt("BloqueId"));
                filas.add(fila);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return filas;
    }

    @Override
    public ArrayList<Asiento> getAsientosByFila(Fila fila, Presentacion presentacion ) {
        ArrayList<Asiento> asientos = new ArrayList<Asiento>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByFilaId_BloqueId_ProdId_PresentacionIdAsientos ?,?,?,?");
            preparedStatement.setString(2,fila.getLetra());
            preparedStatement.setInt(1,fila.getBloqueId());
            preparedStatement.setInt(3,presentacion.getId());
            preparedStatement.setInt(4,presentacion.getPresentId());
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Asiento asiento = new Asiento();
                asiento.setFilaId(fila.getLetra());
                asiento.setBloqueId(fila.getBloqueId());
                asiento.setAsientoId(resultSet.getInt("AsientoId"));
                asientos.add(asiento);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return asientos;
    }

    /**
     *
     * @param IdBloque El id de un bloque
     * @param IdProd El id de una producicón
     * @return bloque con el precio
     */
    @Override
    public Bloque getBloquePreciosByIDS(int IdBloque,int IdProd) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByIdBloque ?,?");
            preparedStatement.setInt(1,IdBloque);
            preparedStatement.setInt(2,IdProd);
            ResultSet resultSet = preparedStatement.executeQuery();
            Boolean found = resultSet.next();
            if (!found) {
                return null;
            }
            Bloque bloque = new Bloque();
            bloque.setPrecio(resultSet.getBigDecimal("Monto").floatValue());
            return bloque;
        }
        catch (SQLException e)
        {

        }

        return null;
    }

    /**
     * Obtiene un bloque por nombre
     * @param idTeatro El id del teatro de ese bloque
     * @param nombre El nombre de ese bloque
     * @return El bloque con el nombre deseado
     */
    @Override
    public Bloque getBloqueByNombre(int idTeatro, String nombre) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByNombreBloques ?, ?");
            preparedStatement.setString(1, nombre);
            preparedStatement.setInt(2, idTeatro);
            ResultSet resultSet = preparedStatement.executeQuery();
            boolean bloqueFound = resultSet.next();
            if (!bloqueFound) {
                return null;
            }
            Bloque bloque = new Bloque();
            bloque.setNombre(resultSet.getString("Nombre"));
            return bloque;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Obtiene los bloques de un teatro
     * @param idTeatro El id de ese teatro
     * @return Los bloques de ese teatro
     */
    @Override
    public ArrayList<Bloque> getBloquesByIdTeatro(int idTeatro) {
        ArrayList<Bloque> bloques = new ArrayList<>();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByTeatroIdBloques ?");
            preparedStatement.setInt(1, idTeatro);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Bloque bloque = new Bloque();
                bloque.setId(resultSet.getInt("Id"));
                bloque.setNombre(resultSet.getString("Nombre"));
                bloque.setIdTeatro(resultSet.getInt("IdTeatro"));
                bloques.add(bloque);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return bloques;
    }

    /**
     * Crea un bloque nuevo
     * @param bloque Los datos del bloque nuevo
     */
    @Override
    public void crearBloque(Bloque bloque) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateBloques ?, ?");
            preparedStatement.setString(1, bloque.getNombre());
            preparedStatement.setInt(2, bloque.getIdTeatro());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Obtiene la fila de un bloque por su letra
     * @param letra La letra de la fila
     * @param idBloque El id del bloque donde pertenece la fia
     * @return La fila que coincide con la letra
     */
    public Fila getFilaByLetra(String letra, int idBloque) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC GetByLetraFilas ?, ?");
            preparedStatement.setString(1, letra);
            preparedStatement.setInt(2, idBloque);
            ResultSet resultSet = preparedStatement.executeQuery();
            // Verificar si existe la fila
            boolean filaFound = resultSet.next();
            if (!filaFound) {
                return null;
            }
            Fila fila = new Fila();
            fila.setLetra(resultSet.getString("FilaId"));
            return fila;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void crearFila(Fila fila) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("EXEC CreateFilas ?, ?, ?");
            preparedStatement.setString(1, fila.getLetra());
            preparedStatement.setInt(2, fila.getBloqueId());
            preparedStatement.setInt(3, fila.getNumeroAsientos());
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
