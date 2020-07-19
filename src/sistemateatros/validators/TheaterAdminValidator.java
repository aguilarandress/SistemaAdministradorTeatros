package sistemateatros.validators;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.TheaterAdminsJDBC;
import sistemateatros.models.TheaterAdmin;

import java.util.ArrayList;
import java.util.regex.Pattern;

public class TheaterAdminValidator {

    public static ArrayList<String> validarTheaterAdmin(TheaterAdmin theaterAdmin) {
        ArrayList<String> errores = new ArrayList<String>();
        // Validar campos
        if (theaterAdmin.getId() < 100000000 || theaterAdmin.getId() > 999999999) {
            errores.add("Cedula invalida");
        }
        if (theaterAdmin.getNombre().isEmpty() || theaterAdmin.getNombre().length() > 30) {
            errores.add("Nombre invalido");
        }
        // TODO: Ver como se valida la fecha si esta vacia
        if (theaterAdmin.getDireccion().isEmpty() || theaterAdmin.getDireccion().length() > 40) {
            errores.add("Direccion invalida");
        }
        if (theaterAdmin.getEmail().isEmpty() || !validarCorreo(theaterAdmin.getEmail())
                || theaterAdmin.getEmail().length() > 20) {
            errores.add("Email invalido");
        }
        if (theaterAdmin.getUsername().isEmpty() || theaterAdmin.getUsername().length() > 20) {
           errores.add("Username invalido");
        }
        if (theaterAdmin.getFechaNacimiento() == null) {
            errores.add("Fecha nacimiento invalida");
        }
        if (theaterAdmin.getPassword().isEmpty() || !(validarPassword(theaterAdmin.getPassword())) ||
            theaterAdmin.getPassword().length() > 20) {
            errores.add("Password invalido");
        }
        if (theaterAdmin.getTelefonoCasa() != null && !validarTelefono(theaterAdmin.getTelefonoCasa())) {
            errores.add("Telefono Casa invalido");
        }
        if (theaterAdmin.getTelefonoCelular() != null && !validarTelefono(theaterAdmin.getTelefonoCelular())) {
            errores.add("Telefono celular invalido");
        }
        if (theaterAdmin.getTelefonoOtro() != null && !validarTelefono(theaterAdmin.getTelefonoOtro())) {
            errores.add("Telefono otro invalido");
        }
        if (errores.size() > 0) {
            return errores;
        }

        TheaterAdminsJDBC theaterAdminsJDBC = new TheaterAdminsJDBC();
        theaterAdminsJDBC.setConnection(DatabaseConnection.getConnection());
        // Validar cedula repetida
        if(theaterAdminsJDBC.getTheaterAdminById(theaterAdmin.getId()) != null) {
            errores.add("Cedula ya existe");
        }
        // Validar nombre repetido
        if (theaterAdminsJDBC.getTheaterAdminByNombre(theaterAdmin.getNombre()) != null) {
            errores.add("Nombre ya existe");
        }
        // Validar nombre de usuario repetido
        if (theaterAdminsJDBC.getTheaterAdminByUsername(theaterAdmin.getUsername()) != null) {
            errores.add("Usuario ya existe");
        }
        return errores;
    }

    /**
     * Valida los telefonos
     * @param telefono El telefono para validar
     * @return Si el telefono es valido o no
     */
    public static boolean validarTelefono(String telefono) {
        String patternStr = "\\d{4}(-?)\\d{4}";
        Pattern pattern = Pattern.compile(patternStr);
        return pattern.matcher(telefono).matches();
    }

    public static boolean validarPassword(String password) {
        String patternStr = "(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}";
        Pattern pattern = Pattern.compile(patternStr);
        return pattern.matcher(password).matches();
    }

    /**
     * Valida los correos
     * @param correo El correo para validar
     * @return Si el correo es valido o no
     */
    public static boolean validarCorreo(String correo) {
        String patternStr = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
        Pattern pattern = Pattern.compile(patternStr);
        return pattern.matcher(correo).matches();
    }
}
