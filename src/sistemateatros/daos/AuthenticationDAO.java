package sistemateatros.daos;

import sistemateatros.models.SystemAdmin;
import sistemateatros.models.TheaterAdmin;

import java.sql.Connection;

public interface AuthenticationDAO {
    public void setConnection(Connection connection);
    public SystemAdmin getSystemAdminByUsername(String username);
    public TheaterAdmin getTheaterAdminByUsername(String username);
}
