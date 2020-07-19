package sistemateatros.mapper;

import sistemateatros.models.Bloque;
import sistemateatros.models.ModelTablaBloques;

import java.sql.ResultSet;
import java.util.ArrayList;

public class TableBloquesMapper {
    public static ModelTablaBloques mapRows(ArrayList<Bloque> bloques)
    {
        Object row[][] = new Object[bloques.size()][2];
        for (int i=0 ; i<bloques.size();i++)
        {
            row[i][0]=bloques.get(i) ;
            row[i][1]= 0 ;
        }
        String[] columnNames = {"Bloque", "Precio"};
        ModelTablaBloques model = new ModelTablaBloques(row,columnNames);
        return  model;
    }
}
