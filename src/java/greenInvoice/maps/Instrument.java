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
public class Instrument {
    private Integer instrumentsId;
     private String catNo;
     private String descGoods;
     private String workingSize;
     private String moc;
     private String tempController;
     private double rate;
     private float gst;

    public Integer getInstrumentsId() {
        return instrumentsId;
    }

    public void setInstrumentsId(Integer instrumentsId) {
        this.instrumentsId = instrumentsId;
    }

    public String getCatNo() {
        return catNo;
    }

    public void setCatNo(String catNo) {
        this.catNo = catNo;
    }

    public String getDescGoods() {
        return descGoods;
    }

    public void setDescGoods(String descGoods) {
        this.descGoods = descGoods;
    }

    public String getWorkingSize() {
        return workingSize;
    }

    public void setWorkingSize(String workingSize) {
        this.workingSize = workingSize;
    }

    public String getMoc() {
        return moc;
    }

    public void setMoc(String moc) {
        this.moc = moc;
    }

    public String getTempController() {
        return tempController;
    }

    public void setTempController(String tempController) {
        this.tempController = tempController;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public float getGst() {
        return gst;
    }

    public void setGst(float gst) {
        this.gst = gst;
    }
}
