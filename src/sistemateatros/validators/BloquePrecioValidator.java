package sistemateatros.validators;

import sistemateatros.models.Bloque;

import java.util.ArrayList;

public class BloquePrecioValidator {
    public static ArrayList<String> validateBloques(ArrayList<Bloque> bloques)
    {
        ArrayList<String> errores= new ArrayList<String>();
        for (Bloque bloque:bloques
             ) {
            if (bloque.getPrecio() <= 0 || bloque.getPrecio() > 99999999.99f)
            {
                errores.add("Precio inválido");
            }
        }
        return errores;
    }
}
