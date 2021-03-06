package greenInvoice.maps;
// Generated 19 Feb, 2019 9:57:44 PM by Hibernate Tools 4.3.1



/**
 * InvoiceId generated by hbm2java
 */
public class InvoiceId  implements java.io.Serializable {


     private int invNo;
     private String vchno;

    public InvoiceId() {
    }

    public InvoiceId(int invNo, String vchno) {
       this.invNo = invNo;
       this.vchno = vchno;
    }
   
    public int getInvNo() {
        return this.invNo;
    }
    
    public void setInvNo(int invNo) {
        this.invNo = invNo;
    }
    public String getVchno() {
        return this.vchno;
    }
    
    public void setVchno(String vchno) {
        this.vchno = vchno;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof InvoiceId) ) return false;
		 InvoiceId castOther = ( InvoiceId ) other; 
         
		 return (this.getInvNo()==castOther.getInvNo())
 && ( (this.getVchno()==castOther.getVchno()) || ( this.getVchno()!=null && castOther.getVchno()!=null && this.getVchno().equals(castOther.getVchno()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + this.getInvNo();
         result = 37 * result + ( getVchno() == null ? 0 : this.getVchno().hashCode() );
         return result;
   }   


}


