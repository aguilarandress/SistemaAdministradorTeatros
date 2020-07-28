package sistemateatros.mapper;


import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.PresentacionesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.models.*;

import java.io.DataOutput;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;

public class CargaDatos {

    public static void cargaDatos(File file)
    {
        AgentesJDBC agentesJDBC = new AgentesJDBC();
        agentesJDBC.setConnection(DatabaseConnection.getConnection());
        TeatrosJDBC teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        ProduccionesJDBC produccionesJDBC = new ProduccionesJDBC();
        produccionesJDBC.setConnection(DatabaseConnection.getConnection());
        PresentacionesJDBC presentacionesJDBC = new PresentacionesJDBC();
        presentacionesJDBC.setConnection(DatabaseConnection.getConnection());
        try {
            XSSFWorkbook documento = new XSSFWorkbook(file);
            XSSFSheet teatros = documento.getSheetAt(8);
            XSSFSheet bloques = documento.getSheetAt(3);
            XSSFSheet filas = documento.getSheetAt(1);
            XSSFSheet producciones = documento.getSheetAt(5);
            XSSFSheet precioBloques = documento.getSheetAt(2);
            XSSFSheet presentaciones = documento.getSheetAt(4);
            //carga teatro
            Row filaTeatro =teatros.getRow(3);
            Teatro teatro = new Teatro();
            teatro.setNombre(filaTeatro.getCell(0).getStringCellValue());
            teatro.setTelefonoAdministracion((filaTeatro.getCell(1).getStringCellValue()));
            teatro.setTelefonoBoleteria(filaTeatro.getCell(5).getStringCellValue());
            Double capacidad = filaTeatro.getCell(4).getNumericCellValue();
            teatro.setCapacidad(capacidad.intValue());
            teatro.setSitioWeb(filaTeatro.getCell(3).getStringCellValue());
            teatro.setCorreo(filaTeatro.getCell(2).getStringCellValue());
            teatrosJDBC.crearTeatro(teatro);
            //Inicio carga bloques
            int cantidadbloques = bloques.getLastRowNum();
            Row filabloque;
            for (int i = 1; i<=cantidadbloques ;i++)
            {
                filabloque= bloques.getRow(i);
                Double teatroId= filabloque.getCell(0).getNumericCellValue();
                if(teatroId.intValue()==3)
                {
                    Bloque bloque = new Bloque();
                    bloque.setIdTeatro(teatroId.intValue());
                    bloque.setNombre(filabloque.getCell(1).getStringCellValue());
                    teatrosJDBC.crearBloque(bloque);
                }
            }
            //Inicio carga Filas
            int cantidadFilas = filas.getLastRowNum();
            Row filafila;
            for(int i = 1 ; i<=cantidadFilas ; i++)
            {
                filafila = filas.getRow(i);
                Double teatroId = filafila.getCell(0).getNumericCellValue();
                    if (teatroId.intValue() == 3)
                {
                    Fila fila = new Fila();
                    Double idBloque = filafila.getCell(1).getNumericCellValue();
                    fila.setBloqueId(idBloque.intValue());
                    fila.setLetra(filafila.getCell(2).getStringCellValue());
                    Double cantidadAsientos = filafila.getCell(3).getNumericCellValue();
                    fila.setNumeroAsientos(cantidadAsientos.intValue());
                    teatrosJDBC.crearFila(fila);
                }
            }
            //Carga producciones
            int cantidadProducciones = producciones.getLastRowNum();
            Row filaProd;
            for (int i = 1 ; i<= cantidadProducciones ; i++)
            {
                filaProd = producciones.getRow(i);
                Double idTeatro = filaProd.getCell(0).getNumericCellValue();
                int idTeat = idTeatro.intValue();
                if (idTeat == 3)
                {
                    Produccion produccion = new Produccion();
                    produccion.setIdTeatro(((Double)filaProd.getCell(0).getNumericCellValue()).intValue());
                    produccion.setNombre(filaProd.getCell(1).getStringCellValue());
                    produccion.setIdTipo(((Double)filaProd.getCell(2).getNumericCellValue()).intValue());
                    produccion.setFechaI((filaProd.getCell(3).getDateCellValue()));
                    produccion.setFechaF((filaProd.getCell(4).getDateCellValue()));
                    produccion.setDescripcion(filaProd.getCell(5).getStringCellValue());
                    produccion.setIdEstado(((Double)filaProd.getCell(6).getNumericCellValue()).intValue());
                    produccionesJDBC.AddProd(produccion);
                }
            }
            //Carga bloquePrecios
            int cantidadPrecios=precioBloques.getLastRowNum();
            Row bloqueprecio;
            for(int i = 1 ; i<= cantidadPrecios; i++)
            {
                bloqueprecio = precioBloques.getRow(i);
                Double idTeatro = bloqueprecio.getCell(0).getNumericCellValue();
                if(idTeatro.intValue() == 3)
                {

                    Bloque bloque = new Bloque();
                    bloque.setIdTeatro(idTeatro.intValue());
                    bloque.setIdProd(((Double)bloqueprecio.getCell(1).getNumericCellValue()).intValue());
                    bloque.setId(((Double)bloqueprecio.getCell(2).getNumericCellValue()).intValue());
                    bloque.setPrecio(((Double)bloqueprecio.getCell(3).getNumericCellValue()).floatValue());
                    ArrayList<Bloque> bloques1 = new ArrayList<Bloque>();
                    bloques1.add(bloque);
                    produccionesJDBC.AddBloquePrecio(bloques1,bloque.getIdProd());
                }
            }
            //Carga presentaciones
            int cantidadPresentaciones = presentaciones.getLastRowNum();
            Row presentacion;
            for (int i =  1; i< cantidadPresentaciones;i++)
            {
                presentacion=presentaciones.getRow(i);
                Double idTeatro = presentacion.getCell(0).getNumericCellValue();

                if(idTeatro == null)
                {
                    continue;
                }
                if(idTeatro.intValue() == 3)
                {
                    Presentacion presentacion1 = new Presentacion();
                    presentacion1.setId(((Double)presentacion.getCell(1).getNumericCellValue()).intValue());
                    presentacion1.setFecha((presentacion.getCell(2).getDateCellValue()));
                    presentacion1.setHora((presentacion.getCell(3).toString()));
                    presentacion1.setPresentId(((Double)presentacion.getCell(4).getNumericCellValue()).intValue());
                    presentacionesJDBC.addPresentacion(presentacion1);

                }



            }

        }
        catch (IOException | InvalidFormatException ex)
        {
            ex.printStackTrace();
        }
    }
}
