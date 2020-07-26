package sistemateatros.models;

import javax.swing.JTable;
import javax.swing.ListSelectionModel;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.event.TableModelListener;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.TableModel;




    public class CheckBoxSelectionTableModel implements TableModel, ListSelectionListener {

        protected final AbstractTableModel delegate;
        protected int selectedRow = -1;
        protected final ListSelectionModel selectionModel;

        public CheckBoxSelectionTableModel(AbstractTableModel delegate, ListSelectionModel selectionModel) {
            this.delegate = delegate;
            this.selectionModel = selectionModel;
            selectionModel.addListSelectionListener(this);
        }

        public static void register(JTable table) {
            table.setModel(new CheckBoxSelectionTableModel((AbstractTableModel)table.getModel(), table.getSelectionModel()));
        }

        protected boolean isCheckBoxCloumn(int columnIndex) {
            return columnIndex == getCheckBoxColumnIndex();
        }

        protected int getCheckBoxColumnIndex() {
            return delegate.getColumnCount();
        }

        // --------------------- delegate methods --------------------- \\

        public int getRowCount() {
            return delegate.getRowCount();
        }

        public int getColumnCount() {
            return getCheckBoxColumnIndex()+1;
        }

        public String getColumnName(int columnIndex) {
            return isCheckBoxCloumn(columnIndex) ? "" : delegate.getColumnName(columnIndex);
        }


        public Class<?> getColumnClass(int columnIndex) {
            return isCheckBoxCloumn(columnIndex) ? Boolean.class : delegate.getColumnClass(columnIndex);
        }

        public boolean isCellEditable(int rowIndex, int columnIndex) {
            return isCheckBoxCloumn(columnIndex) ? true : delegate.isCellEditable(rowIndex, columnIndex);
        }

        public Object getValueAt(int rowIndex, int columnIndex) {
            return  isCheckBoxCloumn(columnIndex) ?  rowIndex == selectedRow : delegate.getValueAt(rowIndex, columnIndex);
        }

        public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
            if(isCheckBoxCloumn(columnIndex)) {
                int lastSelected = selectedRow;
                if((Boolean) aValue){
                    selectedRow = rowIndex;
                } else {
                    selectionModel.clearSelection();
                    selectedRow = -1;
                }
                if(lastSelected > -1) {
                    delegate.fireTableRowsUpdated(lastSelected, lastSelected);
                }
                delegate.fireTableRowsUpdated(rowIndex, rowIndex);
            } else {
                delegate.setValueAt(aValue, rowIndex, columnIndex);
            }
        }

        public void addTableModelListener(TableModelListener l) {
            delegate.addTableModelListener(l);
        }

        public void removeTableModelListener(TableModelListener l) {
            delegate.removeTableModelListener(l);
        }

        // --------------------- ListSelectionListener methods --------------------- \\

        @Override
        public void valueChanged(final ListSelectionEvent e) {
            if(e.getValueIsAdjusting()){
                return;
            }
            int index = selectionModel.getLeadSelectionIndex();
            boolean isSelected = selectionModel.isSelectedIndex(index);
            setValueAt(isSelected ,index , getCheckBoxColumnIndex());
        }


    }

