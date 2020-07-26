package sistemateatros.models;

import javax.swing.table.DefaultTableModel;

public class ModelTablaBloquePrecios extends DefaultTableModel
{
    public ModelTablaBloquePrecios(Object rowData[][], Object columnNames[]) {
        super(rowData, columnNames);
    }

    @Override
    public Class getColumnClass(int col) {
        if (col == 1)       //second column accepts only Integer values
            return Double.class;
        else return String.class;  //other columns accept String values
    }

    @Override
    public boolean isCellEditable(int row, int col) {
        if (col == 0)       //first column will be uneditable
            return false;
        else return false;
    }
}