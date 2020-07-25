package sistemateatros.controllers;

import net.proteanit.sql.DbUtils;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.PresentacionesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.mapper.*;
import sistemateatros.models.*;
import sistemateatros.views.AgentView;
import sistemateatros.views.FormularioCliente;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.TableModel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TheaterAgenteController {
    String agente;
    int IdTeatro;
    AgentView agentView;
    Teatro teatro;
    private AgentesJDBC agentesJDBC;
    private ProduccionesJDBC produccionesJDBC;
    private TeatrosJDBC teatrosJDBC;
    private PresentacionesJDBC presentacionesJDBC;
    public  TheaterAgenteController(int IdTeatro,String agente)
    {
        //TODO: SOLUCIONAR PROBLEMA SELECCIÓN FILAS MÚLTIPLES
        this.agente=agente;
        this.IdTeatro=IdTeatro;
        agentView = new AgentView(IdTeatro,agente);
        this.agentView.setVisible();
        agentesJDBC = new AgentesJDBC();
        agentesJDBC.setConnection(DatabaseConnection.getConnection());
        teatrosJDBC = new TeatrosJDBC();
        teatrosJDBC.setConnection(DatabaseConnection.getConnection());
        produccionesJDBC = new ProduccionesJDBC();
        produccionesJDBC.setConnection(DatabaseConnection.getConnection());
        presentacionesJDBC = new PresentacionesJDBC();
        presentacionesJDBC.setConnection(DatabaseConnection.getConnection());
        this.teatro = teatrosJDBC.getTeatroByID(IdTeatro);
        this.agentView.setTheaterInfo(teatro.getNombre());

        this.agentView.getTabbedAgente().addChangeListener(new changeTabListener());
        this.agentView.getComboTeatros().addItemListener(new compraTeatroListener());

        this.agentView.getTablaProds().setColumnSelectionAllowed(false);
        this.agentView.getTablaProds().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        ListSelectionModel selectionModel = this.agentView.getTablaProds().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroProdsListener());

        this.agentView.getTablaPresent().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaPresent().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroPresentListener());

        this.agentView.getTablaBloques().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaBloques().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroBloqueListener());

        this.agentView.getTablaFilas().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaFilas().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroFilaListener());

        this.agentView.getTablaAsientos().setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        selectionModel = this.agentView.getTablaFilas().getSelectionModel();

        this.agentView.getBoletosButton().addActionListener(new compraBoletosBtnListener());

        this.agentView.getRealizarCompraButton().addActionListener(new compraDatosBtnListener());




    }
    private class changeTabListener  implements ChangeListener
    {

        @Override
        public void stateChanged(ChangeEvent e) {
            // Verificar cual tabbed pane se esta cargando
            if(agentView.getTabbedAgente().getSelectedIndex() == 3)
            {
                agentView.getComboTeatros().removeAllItems();
                ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
                agentView.setComboTeatros(teatros);
                ModelTablaProd model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
                agentView.getTablaProds().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresent().setModel(model2);
                ModelTablaProd model3 = TablaBloquePreciosMapper.mapRows(new ArrayList<Bloque>());
                agentView.getTablaBloques().setModel(model3);
                ModelTablaProd model4 = TablaFilasMapper.mapRows(new ArrayList<Fila>());
                agentView.getTablaFilas().setModel(model4);
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }
    private class compraTeatroListener implements ItemListener {

        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Teatro teatro = (Teatro) agentView.getComboTeatros().getSelectedItem();
                ArrayList <Produccion> producciones = produccionesJDBC.getProdTIdView(teatro.getId());
                ModelTablaProd model= TablaProdMapper.mapRows(producciones);
                agentView.getTablaProds().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresent().setModel(model2);
                ModelTablaProd model3 = TablaBloquePreciosMapper.mapRows(new ArrayList<Bloque>());
                agentView.getTablaBloques().setModel(model3);
                ModelTablaProd model4 = TablaFilasMapper.mapRows(new ArrayList<Fila>());
                agentView.getTablaFilas().setModel(model4);
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }



    private class compraTeatroProdsListener implements ListSelectionListener {
        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaProds().getRowCount()>0) {
                Produccion produccion = (Produccion) agentView.getTablaProds().getValueAt(agentView.getTablaProds().getSelectedRow(), 0);
                ArrayList<Presentacion> presentacions = presentacionesJDBC.getPresentByProdIdView(produccion);
                ModelTablaProd model = TablaPresenMapper.mapRows(presentacions);
                agentView.getTablaPresent().setModel(model);
                ModelTablaProd model3 = TablaBloquePreciosMapper.mapRows(new ArrayList<Bloque>());
                agentView.getTablaBloques().setModel(model3);
                ModelTablaProd model4 = TablaFilasMapper.mapRows(new ArrayList<Fila>());
                agentView.getTablaFilas().setModel(model4);
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);

            }
        }
    }
    private class compraTeatroPresentListener implements  ListSelectionListener{

        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaPresent().getRowCount()>0)
            {
                Presentacion presentacion = (Presentacion) agentView.getTablaPresent().getValueAt(agentView.getTablaPresent().getSelectedRow(),0);
                ArrayList<Bloque> bloques = agentesJDBC.getBloquePreciosByProdId(presentacion.getId());
                ModelTablaProd model = TablaBloquePreciosMapper.mapRows(bloques);
                agentView.getTablaBloques().setModel(model);
                ModelTablaProd model4 = TablaFilasMapper.mapRows(new ArrayList<Fila>());
                agentView.getTablaFilas().setModel(model4);
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }
    private class compraTeatroBloqueListener implements  ListSelectionListener {

        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaBloques().getRowCount()>0)
            {
                Bloque bloque = (Bloque) agentView.getTablaBloques().getValueAt(agentView.getTablaBloques().getSelectedRow(),0);
                ArrayList<Fila> filas = teatrosJDBC.getFilasByBloque(bloque);
                ModelTablaProd model = TablaFilasMapper.mapRows(filas);
                agentView.getTablaFilas().setModel(model);
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }
    private class compraTeatroFilaListener implements  ListSelectionListener {

        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaFilas().getRowCount()>0)
            {
                Fila fila = (Fila) agentView.getTablaFilas().getValueAt(agentView.getTablaFilas().getSelectedRow(),0);
                Presentacion presentacion = (Presentacion) agentView.getTablaPresent().getValueAt(agentView.getTablaPresent().getSelectedRow(),0);
                ArrayList<Asiento> asientos = teatrosJDBC.getAsientosByFila(fila,presentacion);
                ModelTablaProd model = TablaAsientosMapper.mapRows(asientos);
                agentView.getTablaAsientos().setModel(model);
            }
        }
    }

    private class compraBoletosBtnListener implements ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            int [] selectedRows = agentView.getTablaAsientos().getSelectedRows();
            if(agentView.getTablaAsientos().getRowCount() < 1)
            {
                agentView.displayMessage("No hay asientos seleccionados",false);
                return;
            }
            else if (selectedRows.length == 0)
            {
                agentView.displayMessage("No hay asientos seleccionados",false);
                return;
            }
            else if  (agentView.getValoresLista().getSize()+selectedRows.length > 8)
            {
                agentView.displayMessage("La cantidad de asientos super el máximo de 8",false);
                return;
            }
            boolean repetido = false;
            for (int i=0 ; i<selectedRows.length ; i++)
            {
                repetido=false;
                Asiento asiento = (Asiento) agentView.getTablaAsientos().getValueAt(selectedRows[i],0);
                for(int o=0 ; o<agentView.getValoresLista().getSize() ;o++ )
                {
                    Asiento asiento2 = (Asiento) agentView.getValoresLista().get(o);
                    if (asiento.getBloqueId() == asiento2.getBloqueId() && asiento.getFilaId().equals(asiento2.getFilaId())
                    && asiento.getAsientoId() == asiento2.getAsientoId())
                    {
                        repetido=true;

                    }
                }
                if (repetido)
                    continue;
                agentView.getValoresLista().addElement(asiento);
            }
            if (repetido)
            {
                agentView.displayMessage("No se agregaron los asientos repetidos",false);

            }

        }
    }
    private class compraDatosBtnListener implements  ActionListener
    {

        @Override
        public void actionPerformed(ActionEvent e) {
            if(!(agentView.getValoresLista().getSize()>0))
            {
                agentView.displayMessage("Debe agregar asientos",false);
                return;
            }
            FormularioCliente formularioCliente = new FormularioCliente();
            formularioCliente.setVisible();

        }
    }
}
