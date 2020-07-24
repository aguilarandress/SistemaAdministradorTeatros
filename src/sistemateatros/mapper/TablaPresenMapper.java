package sistemateatros.mapper;

import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;
import sistemateatros.models.Presentacion;
import sistemateatros.models.Produccion;

import java.util.ArrayList;

public class TablaPresenMapper {
    public static ModelTablaProd mapRows(ArrayList<Presentacion> presentaciones)
    {
        Object row[][] = new Object[presentaciones.size()][3];
        for (int i=0 ; i<presentaciones.size();i++)
        {
            row[i][0]=presentaciones.get(i) ;
            row[i][1]=presentaciones.get(i).getFecha();
            row[i][2]=presentaciones.get(i).getHora();

        }
        String[] columnNames = {"Número de función", "Fecha", "Hora"};
        ModelTablaProd model = new ModelTablaProd(row,columnNames);
        return  model;
    }
}


