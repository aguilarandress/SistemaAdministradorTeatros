package sistemateatros.validators;

import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.models.AgentTheater;
import sistemateatros.models.Teatro;

import java.util.ArrayList;

import static sistemateatros.validators.TheaterAdminValidator.*;

public class AgenteValidator {
    public static ArrayList<String> validarAgente (AgentTheater agente) {
        ArrayList<String> errores = new ArrayList<String>();
        AgentesJDBC agentesJDBC = new AgentesJDBC();
        agentesJDBC.setConnection(DatabaseConnection.getConnection());
        if(agente.getNombre().isEmpty() || agente.getNombre().length()>30)
        {
            errores.add("Nombre inválido");
        }

        if(agentesJDBC.verificarNombre(agente.getNombre()))
        {
            errores.add("Esta persona ya se encuentra registrada");
        }
        if(agente.getCedula() < 99999999 || agente.getCedula() > 1000000000
                || agentesJDBC.existeCedula(agente.getCedula())) {
            {
                errores.add("Cédula inválida");
            }
        }
        if(agente.getFechaNacimiento().toString().isEmpty())
        {
            errores.add("Fecha de nacimiento Inválida");

        }
        if(agente.getDireccion().isEmpty() || agente.getDireccion().length()>40)
        {
            errores.add("Dirección inválida");
        }
        if(agente.getEmail().isEmpty()||agente.getEmail().length()>40 ||!validarCorreo(agente.getEmail()))
        {
            errores.add("Correo electrónico inválido");
        }
        if (agente.getTelefonoCasa() != null && !validarTelefono(agente.getTelefonoCasa())) {
            errores.add("Telefono Casa invalido");
        }
        if (agente.getTelefonoCelular() != null && !validarTelefono(agente.getTelefonoCelular())) {
            errores.add("Telefono celular invalido");
        }
        if (agente.getTelefonoOtro() != null && !validarTelefono(agente.getTelefonoOtro())) {
            errores.add("Telefono otro invalido");
        }
        if(agente.getUsername().isEmpty() || agente.getUsername().length()>20 )
        {
            errores.add("Usuario inválido");
        }
        if(agentesJDBC.verificarUsername(agente.getUsername()))
        {
            errores.add("Este usuario ya existe");
        }
        String password = String.valueOf(agente.getPassword());
        if(password.isEmpty() || !(validarPassword(password)) ||
               password.length() > 20)
        {
            errores.add("Contraseña inválida");
        }
        return errores;
    }
}
