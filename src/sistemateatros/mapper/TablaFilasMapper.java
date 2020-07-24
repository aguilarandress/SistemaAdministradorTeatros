package sistemateatros.mapper;

import sistemateatros.models.Fila;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;

import java.util.ArrayList;

public class TablaFilasMapper {
    public static ModelTablaProd mapRows(ArrayList<Fila> Filas) {
        Object row[][] = new Object[Filas.size()][2];
        for (int i = 0; i < Filas.size(); i++) {
            row[i][0] = Filas.get(i);
            row[i][1] = Filas.get(i).getNumeroAsientos();

        }
        String[] columnNames = {"Letra", "Cantidad de asientos"};
        ModelTablaProd model = new ModelTablaProd(row, columnNames);
        return model;
    }
}
