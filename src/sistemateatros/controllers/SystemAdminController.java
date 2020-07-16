package sistemateatros.controllers;

import sistemateatros.views.SystemAdminView;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class SystemAdminController {

    private SystemAdminView systemAdminView;

    public SystemAdminController() {
        this.systemAdminView = new SystemAdminView();
        this.systemAdminView.setVisible();
        // Set event listeners
        this.systemAdminView.getAgregarTeatroBtn().addActionListener(new AgregarTeatroListener());
    }

    private class AgregarTeatroListener implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {

        }
    }

}
