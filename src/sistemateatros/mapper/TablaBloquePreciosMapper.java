package sistemateatros.mapper;

import sistemateatros.models.Bloque;
import sistemateatros.models.ModelTablaBloquePrecios;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;

import javax.swing.*;
import java.util.ArrayList;

public class TablaBloquePreciosMapper {
    public static void mapRows(ArrayList<Bloque> bloques, JComboBox combo)
    {

        for (int i=0 ; i<bloques.size();i++)
        {
            combo.addItem(bloques.get(i));

        }
        return ;
    }
}
