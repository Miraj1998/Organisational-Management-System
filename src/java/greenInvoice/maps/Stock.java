package greenInvoice.maps;
// Generated 19 Feb, 2019 9:57:44 PM by Hibernate Tools 4.3.1



/**
 * Stock generated by hbm2java
 */
public class Stock  implements java.io.Serializable {


     private Integer stckid;
     private Integer productId;
     private String tp;
     private Integer units;

    public Stock() {
    }

    public Stock(Integer productId, String tp, Integer units) {
       this.productId = productId;
       this.tp = tp;
       this.units = units;
    }
   
    public Integer getStckid() {
        return this.stckid;
    }
    
    public void setStckid(Integer stckid) {
        this.stckid = stckid;
    }
    public Integer getProductId() {
        return this.productId;
    }
    
    public void setProductId(Integer productId) {
        this.productId = productId;
    }
    public String getTp() {
        return this.tp;
    }
    
    public void setTp(String tp) {
        this.tp = tp;
    }
    public Integer getUnits() {
        return this.units;
    }
    
    public void setUnits(Integer units) {
        this.units = units;
    }




}

