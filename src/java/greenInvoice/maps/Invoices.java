/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.maps;

import java.util.Date;

/**
 *
 * @author Vivek
 */
public class Invoices {
    /*
    doi         | date         | YES  |     | NULL    |       |
| particulars | varchar(300) | YES  |     | NULL    |       |
| vchno       | varchar(100) | YES  |     | NULL    |       |
| dramt       | double(10,2) | YES  |     | NULL    |       |
| cramt       | double(10,2) | YES  |     | NULL    |       |
| invNo       | int(11)      | NO   | PRI | NULL    |       |
| paid        | double(10,2) | YES  |     | NULL    |
    */
    private Date doi;
    private String particulars, vchno;
    private double dramt, cramt, paid;
    private int invno;

    public Date getDoi() {
        return doi;
    }

    public void setDoi(Date doi) {
        this.doi = doi;
    }

    public String getParticulars() {
        return particulars;
    }

    public void setParticulars(String particulars) {
        this.particulars = particulars;
    }

    public String getVchno() {
        return vchno;
    }

    public void setVchno(String vchno) {
        this.vchno = vchno;
    }

    public double getDramt() {
        return dramt;
    }

    public void setDramt(double dramt) {
        this.dramt = dramt;
    }

    public double getCramt() {
        return cramt;
    }

    public void setCramt(double cramt) {
        this.cramt = cramt;
    }

    public double getPaid() {
        return paid;
    }

    public void setPaid(double paid) {
        this.paid = paid;
    }

    public int getInvno() {
        return invno;
    }

    public void setInvno(int invno) {
        this.invno = invno;
    }
}
