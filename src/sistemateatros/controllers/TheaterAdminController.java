package sistemateatros.controllers;

import sistemateatros.views.TheaterAdminView;

public class TheaterAdminController {
    private TheaterAdminView theaterAdminView;
    private int idTeatro;
    private String Admin;


    public  TheaterAdminController(){
    theaterAdminView = new TheaterAdminView(this.Admin);
    theaterAdminView.setVisible();
    }

    public int getIdTeatro() {
        return idTeatro;
    }

    public void setIdTeatro(int idTeatro) {
        this.idTeatro = idTeatro;
    }

    public String getAdmin() {
        return Admin;
    }

    public void setAdmin(String admin) {
        Admin = admin;
    }
}
