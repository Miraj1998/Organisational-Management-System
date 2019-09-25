package greenInvoice.maps;
// Generated 19 Feb, 2019 9:57:44 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Glassware generated by hbm2java
 */
public class Glassware  implements java.io.Serializable {


     private int productId;
     private int catNo;
     private String subCat;
     private String descGoods;
     private String make;
     private Double price;
     private Set vouchers = new HashSet(0);
     private float gst;

    public float getGst() {
        return gst;
    }

    public void setGst(float gst) {
        this.gst = gst;
    }
    public Glassware() {
    }

	
    public Glassware(int productId, int catNo) {
        this.productId = productId;
        this.catNo = catNo;
    }
    public Glassware(int productId, int catNo, String subCat, String descGoods, String make, Double price, Set vouchers, float gst) {
       this.productId = productId;
       this.catNo = catNo;
       this.subCat = subCat;
       this.descGoods = descGoods;
       this.make = make;
       this.price = price;
       this.vouchers = vouchers;
       this.gst = gst;
    }
   
    public int getProductId() {
        return this.productId;
    }
    
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public int getCatNo() {
        return this.catNo;
    }
    
    public void setCatNo(int catNo) {
        this.catNo = catNo;
    }
    public String getSubCat() {
        return this.subCat;
    }
    
    public void setSubCat(String subCat) {
        this.subCat = subCat;
    }
    public String getDescGoods() {
        return this.descGoods;
    }
    
    public void setDescGoods(String descGoods) {
        this.descGoods = descGoods;
    }
    public String getMake() {
        return this.make;
    }
    
    public void setMake(String make) {
        this.make = make;
    }
    public Double getPrice() {
        return this.price;
    }
    
    public void setPrice(Double price) {
        this.price = price;
    }
    public Set getVouchers() {
        return this.vouchers;
    }
    
    public void setVouchers(Set vouchers) {
        this.vouchers = vouchers;
    }




}


