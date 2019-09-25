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
public class Glasswares {

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getCatNo() {
        return catNo;
    }

    public void setCatNo(int catNo) {
        this.catNo = catNo;
    }

    public String getSubCat() {
        return subCat;
    }

    public void setSubCat(String subCat) {
        this.subCat = subCat;
    }

    public String getDescGoods() {
        return descGoods;
    }

    public void setDescGoods(String descGoods) {
        this.descGoods = descGoods;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public float getGst() {
        return gst;
    }

    public void setGst(float gst) {
        this.gst = gst;
    }
     private int productId;
     private int catNo;
     private String subCat;
     private String descGoods;
     private String make;
     private Double price;
     private float gst;
}
