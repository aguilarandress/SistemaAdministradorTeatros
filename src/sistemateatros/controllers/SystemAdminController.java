package sistemateatros.controllers;

import sistemateatros.views.SystemAdminView;

public class SystemAdminController {

    private SystemAdminView systemAdminView;

    public SystemAdminController() {
        this.systemAdminView = new SystemAdminView();
        this.systemAdminView.setVisible();
    }

}
