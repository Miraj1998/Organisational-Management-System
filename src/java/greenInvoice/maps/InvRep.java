/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.maps;

import java.util.Date;

/**
 *
 * @author shree
 */
/*
| invno       | int(11)       | NO   |     | NULL    |       |
| partyname   | varchar(100)  | YES  |     | NULL    |       |
| address1    | varchar(100)  | YES  |     | NULL    |       |
| email       | varchar(100)  | YES  |     | NULL    |       |
| phone       | varchar(45)   | YES  |     | NULL    |       |
| productDesc | varchar(300)  | YES  |     | NULL    |       |
| specs       | varchar(1000) | YES  |     | NULL    |       |
| price       | double        | YES  |     | NULL    |       |
| units       | int(11)       | YES  |     | NULL    |       |
| gst         | float         | YES  |     | NULL    |       |
| amount      | double        | YES  |     | NULL    |       |
| amountRecd  | double        | YES  |     | NULL    |       |
| doi         | date          | YES  |     | NULL    |       |
*/
public class InvRep {
    private int invno, units;
    private float gst;
    private double price, amount, amountRecd;
    private String partyName, address1, email, phone, productDesc, specs, voucherno;

    public String getVoucherno() {
        return voucherno;
    }

    public void setVoucherno(String voucherno) {
        this.voucherno = voucherno;
    }
    private Date doi;

    public Date getDoi() {
        return doi;
    }

    public void setDoi(Date doi) {
        this.doi = doi;
    }
    public int getInvno() {
        return invno;
    }

    public void setInvno(int invno) {
        this.invno = invno;
    }

    public int getUnits() {
        return units;
    }

    public void setUnits(int units) {
        this.units = units;
    }

    public float getGst() {
        return gst;
    }

    public void setGst(float gst) {
        this.gst = gst;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getAmountRecd() {
        return amountRecd;
    }

    public void setAmountRecd(double amountRecd) {
        this.amountRecd = amountRecd;
    }

    public String getPartyName() {
        return partyName;
    }

    public void setPartyName(String partyName) {
        this.partyName = partyName;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProductDesc() {
        return productDesc;
    }

    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    public String getSpecs() {
        return specs;
    }

    public void setSpecs(String specs) {
        this.specs = specs;
    }
}
