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
public class Vchr {
    /*
    | voucherno | partyno | dos        | productid | qty  | price | producttp |
+-----------+---------+------------+-----------+------+-------+-----------+
| 10        | 1       | 2019-02-15 |         1 |   10 |   100 | chemicals |
    */
    private int voucherno, partyno, productid, qty;
    private java.util.Date dos;
    private String producttp;
    private double price;
    private double amt;

    public double getAmt() {
        return amt;
    }

    public void setAmt(double amt) {
        this.amt = amt;
    }
    
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    public int getVoucherno() {
        return voucherno;
    }

    public void setVoucherno(int voucherno) {
        this.voucherno = voucherno;
    }

    public int getPartyno() {
        return partyno;
    }

    public void setPartyno(int partyno) {
        this.partyno = partyno;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public Date getDos() {
        return dos;
    }

    public void setDos(Date dos) {
        this.dos = dos;
    }

    public String getProducttp() {
        return producttp;
    }

    public void setProducttp(String producttp) {
        this.producttp = producttp;
    }
}
