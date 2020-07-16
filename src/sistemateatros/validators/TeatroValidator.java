package sistemateatros.validators;

import sistemateatros.models.Teatro;
import java.util.regex.Pattern;
import java.util.ArrayList;

public class TeatroValidator {

    public static ArrayList<String> validarTeatro (Teatro teatro) {
        ArrayList<String> errores = new ArrayList<String>();
        if (teatro.getNombre().isEmpty() || teatro.getCorreo().length() > 30) {
            errores.add("Nombre invalido");
        }
        if (!validarCorreo(teatro.getCorreo()) || teatro.getCorreo().length() > 30) {
            errores.add("Correo invalido");
        }
        if (!validarTelefono(teatro.getTelefonoAdministracion()) || teatro.getTelefonoAdministracion().length() > 9) {
            errores.add("Telefono administracion invalido");
        }
        if (!validarTelefono(teatro.getTelefonoBoleteria()) || teatro.getTelefonoBoleteria().length() > 9) {
            errores.add("Telefono boleteria invalido");
        }
        if (teatro.getSitioWeb().isEmpty() || teatro.getSitioWeb().length() > 9) {
            errores.add("Sitio web invalido");
        }
        if (errores.size() > 0) {
            return  errores;
        }
        return errores;
    }

    public static boolean validarTelefono(String telefono) {
        String patternStr = "\\d{4}(-?)\\d{4}";
        Pattern pattern = Pattern.compile(patternStr);
        return pattern.matcher(telefono).matches();
    }

    public static boolean validarCorreo(String correo) {
        String patternStr = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
        Pattern pattern = Pattern.compile(patternStr);
        return pattern.matcher(correo).matches();
    }

}
