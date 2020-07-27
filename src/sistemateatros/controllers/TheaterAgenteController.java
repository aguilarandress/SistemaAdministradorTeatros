package sistemateatros.controllers;

import net.proteanit.sql.DbUtils;
import sistemateatros.database.DatabaseConnection;
import sistemateatros.jdbc.AgentesJDBC;
import sistemateatros.jdbc.PresentacionesJDBC;
import sistemateatros.jdbc.ProduccionesJDBC;
import sistemateatros.jdbc.TeatrosJDBC;
import sistemateatros.mapper.*;
import sistemateatros.models.*;
import sistemateatros.validators.ClienteValidator;
import sistemateatros.views.AgentView;
import sistemateatros.views.FormularioCliente;

import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableModel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TheaterAgenteController {
    String agente;
    int IdTeatro;
    AgentView agentView;
    Teatro teatro;
    FormularioCliente formularioCliente;
    private AgentesJDBC agentesJDBC;
    private ProduccionesJDBC produccionesJDBC;
    private TeatrosJDBC teatrosJDBC;
    private PresentacionesJDBC presentacionesJDBC;
    private ArrayList<PresentacionCartelera> presentaciones = new ArrayList<>();
    public  TheaterAgenteController(int IdTeatro,String agente)
    {
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
        //Listener compra
        this.agentView.getTabbedAgente().addChangeListener(new changeTabListener());
        this.agentView.getComboTeatros().addItemListener(new compraTeatroListener());


        this.agentView.getTablaProds().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        ListSelectionModel selectionModel = this.agentView.getTablaProds().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroProdsListener());

        this.agentView.getTablaPresent().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaPresent().getSelectionModel();
        selectionModel.addListSelectionListener(new compraTeatroPresentListener());

        this.agentView.getComboBLQ().addItemListener(new compraTeatroBloqueListener());

        this.agentView.getComboFl().addItemListener(new compraTeatroFilaListener());

        this.agentView.getTablaAsientos().setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        selectionModel = this.agentView.getTablaAsientos().getSelectionModel();

        //Botones
        this.agentView.getBoletosButton().addActionListener(new compraBoletosBtnListener());
        this.agentView.getRealizarCompraButton().addActionListener(new compraDatosBtnListener());

        //Listeners Consulta
        this.agentView.getTeatroComboAsientos().addItemListener(new consultaTeatroListener());

        this.agentView.getTablaProdAsientos().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaProdAsientos().getSelectionModel();
        selectionModel.addListSelectionListener(new consultaTeatroProdsListener());

        this.agentView.getTablaPresAsientos().setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        selectionModel = this.agentView.getTablaPresAsientos().getSelectionModel();
        selectionModel.addListSelectionListener(new consultaTeatroPresentListener());

        this.agentView.getComboBloqueAsientos().addItemListener(new consultaTeatroBloqueListener());

        this.agentView.getComboFilaAsientos().addItemListener(new consultaTeatroFilaListener());

        this.agentView.getTablaAsientos().setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        selectionModel = this.agentView.getTablaAsientos().getSelectionModel();
        //Listener cartelera
        this.agentView.getBuscarCarteleraBtn().addActionListener(new BuscarCarteleraListener());
        this.agentView.getObtenerPreciosCarteleraBtn().addActionListener(new ObtenerPreciosCarteleraListener());

        //Setup tablas
        agentView.getTablaProds().setEnabled(true);
        agentView.getTablaPresent().setEnabled(true);
        agentView.getTablaProdAsientos().setEnabled(true);
        agentView.getTablaPresAsientos().setEnabled(true);
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

                agentView.getComboBLQ().removeAllItems();
                agentView.getComboFl().removeAllItems();


                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
                //Limpieza tab consulta
                model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
                agentView.getTablaProdAsientos().setModel(model);
                model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresAsientos().setModel(model2);
                agentView.getComboBloqueAsientos().removeAllItems();
                agentView.getComboFilaAsientos().removeAllItems();
                model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);
            }
            else if(agentView.getTabbedAgente().getSelectedIndex() == 2)
            {
                agentView.getTeatroComboAsientos().removeAllItems();
                ArrayList<Teatro> teatros = teatrosJDBC.getTeatros();
                agentView.setComboTeatrosAsientos(teatros);
                ModelTablaProd model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
                agentView.getTablaProdAsientos().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresAsientos().setModel(model2);

                agentView.getComboBloqueAsientos().removeAllItems();
                agentView.getComboFl().removeAllItems();


                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);
                //Limpieza tab compra
                model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
                agentView.getTablaProds().setModel(model);
                model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresent().setModel(model2);
                agentView.getComboBLQ().removeAllItems();
                agentView.getComboFl().removeAllItems();
                model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }

            else {
                ModelTablaProd model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
                agentView.getTablaProds().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresent().setModel(model2);
                agentView.getComboBLQ().removeAllItems();
                agentView.getComboFl().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }
    //COMIENZA LISTENERS COMPRA

    private class compraTeatroListener implements ItemListener {
        /**
         * Listener para cargar producciones en base a un teatro
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Teatro teatro = (Teatro) agentView.getComboTeatros().getSelectedItem();
                ArrayList <Produccion> producciones = produccionesJDBC.getProdTIdView(teatro.getId());
                ModelTablaProd model= TablaProdMapper.mapRows(producciones);
                agentView.getTablaProds().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresent().setModel(model2);
                agentView.getComboBLQ().removeAllItems();
                agentView.getComboFl().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
                agentView.getTablaProds().setEnabled(true);
                agentView.getTablaPresent().setEnabled(true);
            }
        }
    }



    private class compraTeatroProdsListener implements ListSelectionListener {
        /**
         * Listener para cargar presentaciones en base a una producción
         * @param e
         */
        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaProds().getRowCount()>0) {
                Produccion produccion = (Produccion) agentView.getTablaProds().getValueAt(agentView.getTablaProds().getSelectedRow(), 0);
                ArrayList<Presentacion> presentacions = presentacionesJDBC.getPresentByProdIdView(produccion);
                ModelTablaProd model = TablaPresenMapper.mapRows(presentacions);
                agentView.getTablaPresent().setModel(model);
                agentView.getComboBLQ().removeAllItems();
                agentView.getComboFl().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);

            }
        }
    }
    private class compraTeatroPresentListener implements  ListSelectionListener{
        /**
         * Listener para cargar bloques en base a una producción-presentación
         * @param e
         */
        @Override
        public void valueChanged(ListSelectionEvent e) {

            if(agentView.getTablaPresent().getRowCount()>0)
            {
                Presentacion presentacion = (Presentacion) agentView.getTablaPresent().getValueAt(agentView.getTablaPresent().getSelectedRow(),0);
                ArrayList<Bloque> bloques = agentesJDBC.getBloquePreciosByProdId(presentacion.getId());
                agentView.getComboBLQ().removeAllItems();
                TablaBloquePreciosMapper.mapRows(bloques,agentView.getComboBLQ());
                agentView.getComboFl().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
            }
        }
    }
    private class compraTeatroBloqueListener implements  ItemListener {
        /**
         * Listener para cargar filas en base a un bloque
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Bloque bloque = (Bloque) agentView.getComboBLQ().getSelectedItem();
                ArrayList<Fila> filas = teatrosJDBC.getFilasByBloque(bloque);
                agentView.getComboFl().removeAllItems();
                TablaFilasMapper.mapRows(filas,agentView.getComboFl());
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientos().setModel(model5);
                agentView.getTablaProds().setEnabled(false);
                agentView.getTablaPresent().setEnabled(false);

            }
        }
    }
    private class compraTeatroFilaListener implements  ItemListener {
        /**
         * Listener para cargar los asientos disponibles en base a la combinación de producción,presentación ,bloque y fila
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {

                Fila fila = (Fila) agentView.getComboFl().getSelectedItem();
                Presentacion presentacion = (Presentacion) agentView.getTablaPresent().getValueAt(agentView.getTablaPresent().getSelectedRow(),0);
                ArrayList<Asiento> asientos = teatrosJDBC.getAsientosByFila(fila,presentacion);
                ModelTablaProd model = TablaAsientosMapper.mapRows(asientos);
                agentView.getTablaAsientos().setModel(model);

            }
        }
    }

    private class compraBoletosBtnListener implements ActionListener
    {
        /**
         * Realiza el proceso de añadir asientos a una reservación
         * @param e
         */
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
                agentView.displayMessage("La cantidad de asientos supera el máximo de 8",false);
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
                Produccion produccion =  (Produccion)(agentView.getTablaProds().getValueAt(agentView.getTablaProds().getSelectedRow(),0));
                Bloque bloque = teatrosJDBC.getBloquePreciosByIDS(asiento.getBloqueId(),produccion.getId());
                agentView.setMontoTotal(agentView.getMontoTotal()+bloque.getPrecio());
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
        /**
         * Encargado de mostrar el formulario de datos del cliente
         * @param e
         */
        @Override
        public void actionPerformed(ActionEvent e) {
            if(!(agentView.getValoresLista().getSize()>0))
            {
                agentView.displayMessage("Debe agregar asientos",false);
                return;
            }
            FormularioCliente view = new FormularioCliente();
            view.setVisible();
            formularioCliente=view;
            formularioCliente.getComprarButton().addActionListener(new comprarFinalBtn());
        }
    }
    private class comprarFinalBtn implements ActionListener
    {
        /**
         * Obtiene todos los datos del cliente y realiza la transacción
         * @param e
         */
        @Override
        public void actionPerformed(ActionEvent e) {

            Reservacion reservacion = new Reservacion();
            reservacion.setNombreCliente(formularioCliente.getNombre().getText());
            reservacion.setCorreo(formularioCliente.getCorreo().getText());
            reservacion.setTelefono(formularioCliente.getTelefono().getText());
            reservacion.setEfectivo(true);
            if(!formularioCliente.esEfectivo())
            {
                reservacion.setNumeroTarjeta(formularioCliente.getTarjeta().getText());
                try
                {
                    reservacion.setCVC(Integer.parseInt(formularioCliente.getCvc().getText()));
                }
                catch (Exception o)
                {
                    reservacion.setCVC(0);
                }
                reservacion.setExpiracion(formularioCliente.getDate().getDate());
                reservacion.setEfectivo(false);
            }
            reservacion.setMonto((Double) agentView.getMontoTotal()) ;
            Produccion produccion = (Produccion) agentView.getTablaProds().getValueAt(agentView.getTablaProds().getSelectedRow(),0);
            Presentacion presentacion = (Presentacion) agentView.getTablaPresent().getValueAt(agentView.getTablaPresent().getSelectedRow(),0);
            ArrayList<String> errores = ClienteValidator.validarCliente(reservacion);
            ArrayList<Asiento> asientos = new ArrayList<Asiento>();
            for (int i = 0 ; i < agentView.getValoresLista().getSize();i++)
            {
                asientos.add((Asiento) agentView.getValoresLista().getElementAt(i));
            }
            if(errores.size()>0)
            {
                formularioCliente.displayMessage(errores.get(0),false);
                return;
            }
            Object[] resultados;
            if(!reservacion.isEfectivo()) {
                resultados = agentesJDBC.procesarCompraTarjeta(reservacion, asientos, produccion.getId(), presentacion.getPresentId());
                if ((Boolean)resultados[0]) {
                    agentView.displayMessage("Compra exitosa, número de orden: "+(Integer)resultados[1],true);
                } else {
                    agentView.displayMessage("Tarjeta rechazada , por favor verifique que cuente con el dinero necesario",false);
                }
            }
            else {
                resultados = agentesJDBC.procesarCompraEfectivo(reservacion,asientos,produccion.getId(),presentacion.getPresentId());
                agentView.displayMessage("Compra exitosa, número de orden: "+(Integer)resultados[1],true);
            }
            //Limpieza tablas
            ModelTablaProd model= TablaProdMapper.mapRows(new ArrayList<Produccion>());
            agentView.getTablaProds().setModel(model);
            ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
            agentView.getTablaPresent().setModel(model2);
            agentView.getComboBLQ().removeAllItems();
            agentView.getComboFl().removeAllItems();
            ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
            agentView.getTablaAsientos().setModel(model5);
            formularioCliente.cerrar();
            agentView.getValoresLista().clear();
            agentView.setMontoTotal(0.0);

            agentView.getTablaProds().setEnabled(true);
            agentView.getTablaPresent().setEnabled(true);
        }
    }

    //FINALIZA LISTENERS COMPRA

    private class consultaTeatroListener implements ItemListener {
        /**
         * Listener para cargar producciones en base a un teatro
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Teatro teatro = (Teatro) agentView.getTeatroComboAsientos().getSelectedItem();
                ArrayList <Produccion> producciones = produccionesJDBC.getProdTIdView(teatro.getId());
                ModelTablaProd model= TablaProdMapper.mapRows(producciones);
                agentView.getTablaProdAsientos().setModel(model);
                ModelTablaProd model2 = TablaPresenMapper.mapRows(new ArrayList<Presentacion>());
                agentView.getTablaPresAsientos().setModel(model2);
                agentView.getComboBloqueAsientos().removeAllItems();
                agentView.getComboFilaAsientos().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);
                agentView.getTablaProdAsientos().setEnabled(true);
                agentView.getTablaPresAsientos().setEnabled(true);
            }
        }
    }



    private class consultaTeatroProdsListener implements ListSelectionListener {
        /**
         * Listener para cargar presentaciones en base a una producción
         * @param e
         */
        @Override
        public void valueChanged(ListSelectionEvent e) {
            if(agentView.getTablaProdAsientos().getRowCount()>0) {
                Produccion produccion = (Produccion) agentView.getTablaProdAsientos().getValueAt(agentView.getTablaProdAsientos().getSelectedRow(), 0);
                ArrayList<Presentacion> presentacions = presentacionesJDBC.getPresentByProdIdView(produccion);
                ModelTablaProd model = TablaPresenMapper.mapRows(presentacions);
                agentView.getTablaPresAsientos().setModel(model);
                agentView.getComboBloqueAsientos().removeAllItems();
                agentView.getComboFilaAsientos().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);

            }
        }
    }
    private class consultaTeatroPresentListener implements  ListSelectionListener{
        /**
         * Listener para cargar bloques en base a una producción-presentación
         * @param e
         */
        @Override
        public void valueChanged(ListSelectionEvent e) {

            if(agentView.getTablaPresAsientos().getRowCount()>0)
            {
                Presentacion presentacion = (Presentacion) agentView.getTablaPresAsientos().getValueAt(agentView.getTablaPresAsientos().getSelectedRow(),0);
                ArrayList<Bloque> bloques = agentesJDBC.getBloquePreciosByProdId(presentacion.getId());
                agentView.getComboBloqueAsientos().removeAllItems();
                TablaBloquePreciosMapper.mapRows(bloques,agentView.getComboBloqueAsientos());
                agentView.getComboFilaAsientos().removeAllItems();
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);
            }
        }
    }
    private class consultaTeatroBloqueListener implements  ItemListener {
        /**
         * Listener para cargar filas en base a un bloque
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {
                Bloque bloque = (Bloque) agentView.getComboBloqueAsientos().getSelectedItem();
                ArrayList<Fila> filas = teatrosJDBC.getFilasByBloque(bloque);
                agentView.getComboFilaAsientos().removeAllItems();
                TablaFilasMapper.mapRows(filas,agentView.getComboFilaAsientos());
                ModelTablaProd model5 = TablaAsientosMapper.mapRows(new ArrayList<Asiento>());
                agentView.getTablaAsientosAsientos().setModel(model5);
                agentView.getTablaProdAsientos().setEnabled(false);
                agentView.getTablaPresAsientos().setEnabled(false);

            }
        }
    }
    private class consultaTeatroFilaListener implements  ItemListener {
        /**
         * Listener para cargar los asientos disponibles en base a la combinación de producción,presentación ,bloque y fila
         * @param e
         */
        @Override
        public void itemStateChanged(ItemEvent e) {
            if (e.getStateChange() == ItemEvent.SELECTED) {

                Fila fila = (Fila) agentView.getComboFilaAsientos().getSelectedItem();
                Presentacion presentacion = (Presentacion) agentView.getTablaPresAsientos().getValueAt(agentView.getTablaPresAsientos().getSelectedRow(),0);
                ArrayList<Asiento> asientos = teatrosJDBC.getAsientosByFila(fila,presentacion);
                ModelTablaProd model = TablaAsientosMapper.mapRows(asientos);
                agentView.getTablaAsientosAsientos().setModel(model);

            }
        }
    }
    /**
     * Event listener para cuando se busca en la cartelera
     */
    private class BuscarCarteleraListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Obtener fechas
            Date fechaInicial = agentView.getFechaInicialChooser().getDate();
            Date fechaFinal = agentView.getFechaFinallChooser().getDate();
            // Validar que las fechas sean validas
            if (fechaInicial == null || fechaFinal == null || fechaInicial.compareTo(fechaFinal) > 0) {
                agentView.displayMessage("Fechas invalidas", false);
                return;
            }
            // Obtener presentaciones de la cartelera

            presentaciones = presentacionesJDBC.getPresentacionesCarteleraByFechas(fechaInicial, fechaFinal);
            if (presentaciones.size() == 0) {
                agentView.displayMessage("No se encontraron presentaciones en estas fechas", false);
                return;
            }
            // Crear tabla
            Object filas[][] = new Object[presentaciones.size()][7];
            for (int i = 0; i < presentaciones.size(); i++) {
                filas[i][0] = presentaciones.get(i).getNombreProduccion();
                filas[i][1] = presentaciones.get(i).getNombreTeatro();
                filas[i][2] = presentaciones.get(i).getTipo();
                filas[i][3] = presentaciones.get(i).getFecha();
                filas[i][4] = presentaciones.get(i).getHora().substring(0, presentaciones.get(i).getHora().indexOf('.'));
                filas[i][5] = presentaciones.get(i).getEstado();
                filas[i][6] = presentaciones.get(i).getDescripcion();
            }
            String columnNames[] = new String[] {"Produccion", "Teatro", "Tipo",
                    "Fecha", "Hora", "Estado", "Descripcion"};
            DefaultTableModel tableModel = new DefaultTableModel(filas, columnNames);
            agentView.getCarteleraTable().setModel(tableModel);
        }
    }

    /**
     * Listener para cuando se bucan los precios de los bloques
     */
    private class ObtenerPreciosCarteleraListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            // Verificar que una fila este seleccionada
            if (agentView.getCarteleraTable().getSelectedRow() != -1) {
                int filaSeleccionada = agentView.getCarteleraTable().getSelectedRow();
                // Obtener id de la produccion
                int produccionId = presentaciones.get(filaSeleccionada).getProduccionId();
                // Obtener los precios de los bloques
                ArrayList<Bloque> bloquePrecios = presentacionesJDBC.getBloquePreciosByProduccionId(produccionId);
                Object filas[][] = new Object[bloquePrecios.size()][2];
                for (int i = 0; i < bloquePrecios.size(); i++) {
                    filas[i][0] = bloquePrecios.get(i).getNombre();
                    filas[i][1] = bloquePrecios.get(i).getPrecio();
                }
                String columnNames[] = new String[] {"Bloque", "Precio"};
                DefaultTableModel tableModel = new DefaultTableModel(filas, columnNames);
                agentView.getBloquePreciosTable().setModel(tableModel);
            }
        }
    }
}
