package sistemateatros.mapper;

import sistemateatros.models.Bloque;
import sistemateatros.models.ModelTablaBloquePrecios;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;

import java.util.ArrayList;

public class TablaBloquePreciosMapper {
    public static ModelTablaProd mapRows(ArrayList<Bloque> bloques)
    {
        Object row[][] = new Object[bloques.size()][2];
        for (int i=0 ; i<bloques.size();i++)
        {
            row[i][0]=bloques.get(i) ;
            row[i][1]= bloques.get(i).getPrecio();
        }
        String[] columnNames = {"Bloque", "Precio"};
        ModelTablaProd model = new ModelTablaProd(row,columnNames);
        return  model;
    }
}
