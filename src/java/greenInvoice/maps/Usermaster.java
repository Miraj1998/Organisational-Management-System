package greenInvoice.maps;
// Generated 19 Feb, 2019 9:57:44 PM by Hibernate Tools 4.3.1



/**
 * Usermaster generated by hbm2java
 */
public class Usermaster  implements java.io.Serializable {


     private String email;
     private String name;
     private String designation;
     private String status;
     private Login login;

    public Usermaster() {
    }

	
    public Usermaster(String email) {
        this.email = email;
    }
    public Usermaster(String email, String name, String designation, String status, Login login) {
       this.email = email;
       this.name = name;
       this.designation = designation;
       this.status = status;
       this.login = login;
    }
   
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    public String getDesignation() {
        return this.designation;
    }
    
    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Login getLogin() {
        return this.login;
    }
    
    public void setLogin(Login login) {
        this.login = login;
    }




}


