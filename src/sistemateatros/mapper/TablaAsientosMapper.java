package sistemateatros.mapper;

import sistemateatros.models.Asiento;
import sistemateatros.models.Fila;
import sistemateatros.models.ModelTablaBloques;
import sistemateatros.models.ModelTablaProd;

import java.util.ArrayList;

public class TablaAsientosMapper {
    public static ModelTablaProd mapRows(ArrayList<Asiento> asientos) {
        Object row[][] = new Object[asientos.size()][1];
        for (int i = 0; i < asientos.size(); i++) {
            row[i][0] = asientos.get(i);


        }
        String[] columnNames = {"Asientos disponibles"};
        ModelTablaProd model = new ModelTablaProd(row, columnNames);
        return model;
    }


}
