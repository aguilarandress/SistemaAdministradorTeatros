package sistemateatros.validators;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Produccion;

import java.util.ArrayList;

public class ProduccionValidator {
    public static ArrayList<String> validarAgente (Produccion prod) {
        ArrayList<String> errores = new ArrayList<String>();



        if(prod.getNombre().isEmpty() || prod.getNombre().length()>30)
        {
            errores.add("Nombre inválido");
        }
        if(prod.getDescripcion().isEmpty())
        {
            errores.add("Descripción inválida");
        }
        //TODO: Producciones en misma fecha
        if((prod.getFechaF().toString().isEmpty() || prod.getFechaI().toString().isEmpty()) ||(prod.getFechaI().compareTo(prod.getFechaF())>0))
        {
            errores.add("Fechas inválidas");
        }


        return errores;
    }
}
