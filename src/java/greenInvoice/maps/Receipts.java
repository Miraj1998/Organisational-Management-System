/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.maps;

import java.sql.Date;

/**
 *
 * @author Vivek
 */
public class Receipts {
    /*
        | invno   | int(11) | YES  |     | NULL    |       |
        | recd    | double   | YES  |     | NULL    |       |
        | dor     | date    | YES  |     | NULL    |       |
        | pending | double   | YES  |     | NULL    |       |
    */
    private int invno, rectno;

    public int getRectno() {
        return rectno;
    }

    public void setRectno(int rectno) {
        this.rectno = rectno;
    }
    private double recd, pending;
    private java.sql.Date dor;

    public int getInvno() {
        return invno;
    }

    public void setInvno(int invno) {
        this.invno = invno;
    }

    public double getRecd() {
        return recd;
    }

    public void setRecd(double recd) {
        this.recd = recd;
    }

    public double getPending() {
        return pending;
    }

    public void setPending(double pending) {
        this.pending = pending;
    }

    public Date getDor() {
        return dor;
    }

    public void setDor(Date dor) {
        this.dor = dor;
    }
}
