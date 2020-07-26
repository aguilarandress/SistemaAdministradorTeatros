package sistemateatros.mapper;

import sistemateatros.models.Fila;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;

import javax.swing.*;
import java.util.ArrayList;

public class TablaFilasMapper {
    public static void mapRows(ArrayList<Fila> Filas, JComboBox combo) {
        Object row[][] = new Object[Filas.size()][2];
        for (int i = 0; i < Filas.size(); i++) {

           combo.addItem(Filas.get(i));

        }
        return ;
    }
}
