package sistemateatros.daos;

import sistemateatros.models.SystemAdmin;

import java.sql.Connection;

public interface AuthenticationDAO {
    public void setConnection(Connection connection);
    public SystemAdmin getSystemAdminByUsername(String username);
}
