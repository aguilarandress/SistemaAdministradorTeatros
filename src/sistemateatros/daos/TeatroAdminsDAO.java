package sistemateatros.daos;

import sistemateatros.models.TheaterAdmin;

import java.sql.Connection;

public interface TeatroAdminsDAO {
    public void setConnection(Connection connection);

    public TheaterAdmin getTheaterAdminById(int id);
    public TheaterAdmin getTheaterAdminByNombre(String nombre);
    public TheaterAdmin getTheaterAdminByUsername(String username);
    public void createTheaterAdmin(TheaterAdmin theaterAdmin);
}
