package sistemateatros.mapper;

import sistemateatros.models.Bloque;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;
import sistemateatros.models.Produccion;

import java.util.ArrayList;

public class TablaProdMapper {
    public static ModelTablaProd mapRows(ArrayList<Produccion> producciones)
    {
        Object row[][] = new Object[producciones.size()][5];
        for (int i=0 ; i<producciones.size();i++)
        {
            row[i][0]=producciones.get(i) ;
            row[i][1]=producciones.get(i).getDescripcion();
            row[i][2]=producciones.get(i).getTipo();
            row[i][3]=producciones.get(i).getFechaI();
            row[i][4]=producciones.get(i).getFechaF();
        }
        String[] columnNames = {"Nombre", "Descripcción", "Tipo" , "Fecha Inicial" , "Fecha Final"};
        ModelTablaProd model = new ModelTablaProd(row,columnNames);
        return  model;
    }
}
