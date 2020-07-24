package sistemateatros.mapper;

import sistemateatros.models.Bloque;
import sistemateatros.models.ModelTablaBloquePrecios;
import sistemateatros.models.ModelTablaBloques;

import java.util.ArrayList;

public class TablaBloquePreciosMapper {
    public static ModelTablaBloquePrecios mapRows(ArrayList<Bloque> bloques)
    {
        Object row[][] = new Object[bloques.size()][2];
        for (int i=0 ; i<bloques.size();i++)
        {
            row[i][0]=bloques.get(i) ;
            row[i][1]= bloques.get(i).getPrecio();
        }
        String[] columnNames = {"Bloque", "Precio"};
        ModelTablaBloquePrecios model = new ModelTablaBloquePrecios(row,columnNames);
        return  model;
    }
}
