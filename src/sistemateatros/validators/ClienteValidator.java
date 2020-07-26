package sistemateatros.validators;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.models.Reservacion;
import sistemateatros.models.TheaterAdmin;

import java.util.ArrayList;

public class ClienteValidator {
    public static ArrayList<String> validarCliente(Reservacion reservacion) {
        ArrayList<String> errores = new ArrayList<String>();

        if (reservacion.getNombreCliente().isEmpty() || reservacion.getNombreCliente().length() > 30) {
            errores.add("Nombre inválido");
        }
        if (reservacion.getTelefono().isEmpty() || !TheaterAdminValidator.validarTelefono(reservacion.getTelefono())) {
            errores.add("Teléfono inválida");
        }
        if (reservacion.getCorreo().isEmpty() || !TheaterAdminValidator.validarCorreo(reservacion.getCorreo())) {
            errores.add("Correo inválido");
        }


        if(!reservacion.isEfectivo())
        {
            System.out.println("es compra tarjeta");
            if(reservacion.getNumeroTarjeta()!=null)
            {
                if(reservacion.getNumeroTarjeta().length()!=16) {
                    errores.add("Número de tarjeta inválido");
                }
            }
            if (reservacion.getExpiracion() == null) {
                errores.add("Fecha de expiración inválida");
            }
            if(reservacion.getCVC()<100 || reservacion.getCVC()>999)
            {
                errores.add("CVC inválido");
            }
        }
        return  errores;
    }
}
