/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.maps;

/**
 *
 * @author Vivek
 */
public class StockInst {
    private int productid, units;
    private String descgoods, moc;

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public int getUnits() {
        return units;
    }

    public void setUnits(int units) {
        this.units = units;
    }

    public String getDescgoods() {
        return descgoods;
    }

    public void setDescgoods(String descgoods) {
        this.descgoods = descgoods;
    }

    public String getMoc() {
        return moc;
    }

    public void setMoc(String moc) {
        this.moc = moc;
    }
}
