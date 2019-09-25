/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.control;

import greenInvoice.data.DataMan;
import greenInvoice.data.ChemStock;
import greenInvoice.maps.Chemicals;
import greenInvoice.maps.Glassware;
import greenInvoice.maps.Glasswares;
import greenInvoice.maps.Instrument;
import greenInvoice.maps.Instruments;
import greenInvoice.maps.InvRep;
import greenInvoice.maps.Invoice;
import greenInvoice.maps.Invoices;
import greenInvoice.maps.Login;
import greenInvoice.maps.Parties;
import greenInvoice.maps.Partymaster;
import greenInvoice.maps.Receipts;
import greenInvoice.maps.Stock;
import greenInvoice.maps.StockChem;
import greenInvoice.maps.StockGlass;
import greenInvoice.maps.StockInst;
import greenInvoice.maps.Usermaster;
import greenInvoice.maps.Voucher;
import greenInvoice.maps.Vchr;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
//import javax.sound.midi.Instrument;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.json.JSONObject;

/**
 *
 * @author Vivek
 */
public class Controller {

    private Connection con;
    private Session session;

    public Controller() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/invinv", "root", "root");
            SessionFactory sf = HibernateUtil.getSessionFactory();
            //SessionFactory sf = new Configuration().configure().buildSessionFactory();
            session = sf.openSession();

        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    //Getting Chemicals for Report
    public Chemicals getChemical(int productcode)
    {
        Query qry = session.createQuery("FROM Chemicals where productcode = " + productcode);
        Chemicals chem = (Chemicals) qry.list().iterator().next();
        return chem;
    }
    //getting Glassware for Report
    public Glassware getGlass(int productid)
    {
        Query qry = session.createQuery("FROM Glassware where productId = " + productid);
        Glassware glass = (Glassware) qry.list().iterator().next();
        return glass;
    }
    //getting Instruments for Report
    public Instruments getInst(int productid)
    {
        Query qry = session.createQuery("FROM Instruments where instrumentsId = " + productid);
        Instruments inst = (Instruments) qry.list().iterator().next();
        return inst;
    }
    //getting PartyMaster for Report
    public Partymaster getParty(String partyno)
    {
        Query qry = session.createQuery("FROM Partymaster where partyno = '" + partyno + "'");
        Partymaster pm = (Partymaster) qry.list().iterator().next();
        return pm;
    }
    public void addInvRep(InvRep ir)
    {
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
        */
        try {
            PreparedStatement psmt = con.prepareStatement("insert into invrep values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            psmt.clearParameters();
            psmt.setInt(1, ir.getInvno());
            psmt.setString(2, ir.getPartyName());
            psmt.setString(3, ir.getAddress1());
            psmt.setString(4, ir.getEmail());
            psmt.setString(5, ir.getPhone());
            psmt.setString(6, ir.getProductDesc());
            psmt.setString(7, ir.getSpecs());
            psmt.setDouble(8, ir.getPrice());
            psmt.setInt(9, ir.getUnits());
            psmt.setFloat(10, ir.getGst());
            psmt.setDouble(11, ir.getAmount());
            psmt.setDouble(12, ir.getAmountRecd());
            psmt.setDate(13, new java.sql.Date((ir.getDoi().getYear()+1900), (ir.getDoi().getMonth()+1),ir.getDoi().getDate()));
            psmt.setString(14, ir.getVoucherno());
            psmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public Usermaster getName(String email) {
        try {
            String nm = "";
            Query qry = session.createQuery("FROM Usermaster where email = '" + email + "'");
            List l = qry.list();
            Iterator i = l.iterator();
            Usermaster um = (Usermaster) i.next();
            return um;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public int[] getInvoiceNo() {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select distinct(invno) from invoice order by invno");
            rs.last();
            int invno[] = new int[rs.getRow()];
            rs.beforeFirst();
            int i = 0;
            while (rs.next()) {
                invno[i] = rs.getInt(1);
                i++;
            }
            return invno;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public int getLastProdId() {
        try {
            Query q = session.createQuery("FROM Chemicals order by productcode");
            List l = q.list();
            Iterator i = l.iterator();
            int lst = 0;
            while (i.hasNext()) {
                Chemicals chem = (Chemicals) i.next();
                lst = chem.getProductcode();
            }
            lst++;
            return lst;
        } catch (Exception ex) {
            System.out.println(ex);
            return -1;
        }
    }

    public void delInst(Instrument inst) {
        try {
            Statement stmt = con.createStatement();
            stmt.executeUpdate("delete from instruments where instrumentsid = " + inst.getInstrumentsId());
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delParty(Parties party)
    {
        try
        {
            Statement stmt = con.createStatement();
            stmt.executeUpdate("delete from partymaster where partyno = '" + party.getPartyno() + "'");
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    public void delGlass(Glasswares gls) {
        try {
            Statement stmt = con.createStatement();
            stmt.executeUpdate("delete from glassware where productid = " + gls.getProductId());
            System.out.println("Finally deleted");
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editInst(Instrument inst) {
        Query qry = session.createQuery("FROM Instruments where instrumentsid = " + inst.getInstrumentsId());
        Instruments ins = (Instruments) qry.iterate().next();
        ins.setCatNo(inst.getCatNo());
        ins.setDescGoods(inst.getDescGoods());
        ins.setGst(inst.getGst());
        ins.setInstrumentsId(inst.getInstrumentsId());
        ins.setMoc(inst.getMoc());
        ins.setRate(inst.getRate());
        ins.setTempController(inst.getTempController());
        ins.setWorkingSize(inst.getWorkingSize());
        Transaction t = session.beginTransaction();
        session.update(ins);
        t.commit();
    }
    public void editParty(Parties party)
    {
        Query qry = session.createQuery("FROM Partymaster where partyno = '" + party.getPartyno() + "'");
        Partymaster pm = (Partymaster) qry.iterate().next();
        pm.setAddress1(party.getAddress1());
        pm.setAddress2(party.getAddress2());
        pm.setCity(party.getCity());
        pm.setEmail(party.getEmail());
        pm.setPartyname(party.getPartyname());
        //pm.setPartyno(party.getPartyno());
        pm.setPhone(party.getPhone());
        pm.setPincode(party.getPincode());
        Transaction t = session.beginTransaction();
        session.update(pm);
        t.commit();
        
    }
    public void editGlass(Glasswares gls) {
        Query qry = session.createQuery("FROM Glassware where productid = " + gls.getProductId());
        Glassware glass = (Glassware) qry.iterate().next();
        glass.setCatNo(gls.getCatNo());
        glass.setDescGoods(gls.getDescGoods());
        glass.setGst(gls.getGst());
        glass.setMake(gls.getMake());
        glass.setPrice(gls.getPrice());
        glass.setProductId(gls.getProductId());
        glass.setSubCat(gls.getSubCat());
        Transaction t = session.beginTransaction();
        session.update(glass);
        t.commit();
        System.out.println("Glassware edited");
    }

    public void addInst(Instrument inst) {
        try {
            PreparedStatement psmt = con.prepareStatement("insert into instruments(catno,descgoods,workingsize,moc,tempcontroller,rate,gst) values (?,?,?,?,?,?,?)");
            psmt.clearParameters();
            psmt.setString(1, inst.getCatNo());
            psmt.setString(2, inst.getDescGoods());
            psmt.setString(3, inst.getWorkingSize());
            psmt.setString(4, inst.getMoc());
            psmt.setString(5, inst.getTempController());
            psmt.setDouble(6, inst.getRate());
            psmt.setFloat(7, inst.getGst());
            psmt.execute();
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public int getLastPartyCode()
    {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM partymaster ORDER BY CAST(partyno as SIGNED INTEGER) ASC");
            rs.last();
            return (Integer.parseInt(rs.getString(1))+1);
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
            return 1;
        }
    }
    public void addParty(Parties party)
    {
        try
        {
            PreparedStatement psmt = con.prepareStatement("insert into partymaster values(?,?,?,?,?,?,?,?)");
            psmt.clearParameters();
            psmt.setString(1, String.valueOf(getLastPartyCode()));
            psmt.setString(2, party.getPartyname());
            psmt.setString(3, party.getAddress1());
            psmt.setString(4, party.getAddress2());
            psmt.setString(5, party.getCity());
            psmt.setInt(6, party.getPincode());
            psmt.setString(7, party.getEmail());
            psmt.setString(8, party.getPhone());
            psmt.executeUpdate();
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    public void addGlass(Glasswares gls) {
        try {
            PreparedStatement psmt = con.prepareStatement("insert into glassware(catno,subcat,descgoods,make,price,gst) values (?,?,?,?,?,?)");
            psmt.clearParameters();
            psmt.setInt(1, gls.getCatNo());
            psmt.setString(2, gls.getSubCat());
            psmt.setString(3, gls.getDescGoods());
            psmt.setString(4, gls.getMake());
            psmt.setDouble(5, gls.getPrice());
            psmt.setFloat(6, gls.getGst());
            psmt.execute();
            System.out.println("Glassware added");
        } catch (SQLException ex) {
            Logger.getLogger(Controller.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void delChem(Chemicals chem) {
        Transaction t = session.beginTransaction();
        session.delete(chem);
        t.commit();
    }

    public void editChem(Chemicals chem) {
        try {
            Transaction t = session.beginTransaction();
            session.update(chem);
            t.commit();
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public void addChem(Chemicals chem) {
        try {
            Transaction t = session.beginTransaction();
            session.save(chem);
            t.commit();
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public ArrayList<Partymaster> getParties() {
        try {
            ArrayList<Partymaster> pms = new ArrayList();
            Query qry = session.createQuery("FROM Partymaster");
            List l = qry.list();
            Iterator i = l.iterator();
            while (i.hasNext()) {
                Partymaster pm = (Partymaster) i.next();
                pms.add(pm);
            }
            return pms;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public ArrayList<Login> getCreds() {
        try {
            ArrayList<Login> logins = new ArrayList();
            Query qry = session.createQuery("FROM Login");
            List l = qry.list();
            Iterator i = l.iterator();
            while (i.hasNext()) {
                Login login = (Login) i.next();
                logins.add(login);
            }
            return logins;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public int login(String email, String pwd) {
        try {
            Query qry = session.createQuery("From Login where email = '" + email + "' and pwd = '" + pwd + "'");
            List l = qry.list();
            if (l.size() > 0) {
                return 1;
            } else {
                return 0;
            }
        } catch (Exception ex) {
            System.out.println(ex);
            return -1;
        }
    }

    
    public int chpwd(String email, String o, String n, String cnf)
        {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from login where email = '" + email + "'");
            rs.next();
            String pwd = rs.getString("pwd");
            if (pwd.equals(o))
            {
                System.out.println("Old password confirms");
                Statement stmt1 =  con.createStatement();
                if (!n.equals(cnf))
                {
                    return -1;
                }
                System.out.println("Confirm password matches the new password");
                stmt1.executeUpdate("update login set pwd = '" + n +  "' where email = '" + email + "'");
                System.out.println("Password updated");
                return 1;
            }
            else 
            {
                return -1;
            }
           // if(rs.getString(1).equals(o))
            //{ return -1;}
                
            
        } catch (Exception ex) {
            System.out.println(ex);
            return -1;
            }
      
        } 
          
           
        
    public String[][] getMakeGlass() {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select make,count(make) from glassware group by (make)");
            rs.last();
            String makeGl[][] = new String[rs.getRow()][2];

            rs.beforeFirst();
            int i = 0;
            while (rs.next()) {
                makeGl[i][0] = rs.getString(1);
                makeGl[i][1] = rs.getString(2);
                i++;
            }
            ResultSet rs1 = stmt.executeQuery("select * from glassware where make is null");
            rs1.last();
            makeGl[0][0] = "NA";
            makeGl[0][1] = String.valueOf(rs1.getRow());
            return makeGl;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public String[][] getYrCnt() {
        try {

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT YEAR(STR_TO_DATE(accountopendate, '%Y')) year,count(YEAR(STR_TO_DATE(accountopendate, '%Y'))) cnt from accounts group by YEAR(STR_TO_DATE(accountopendate, '%Y'))");
            rs.last();
            String yrcnt[][] = new String[rs.getRow()][2];
            rs.beforeFirst();
            int i = 0;
            while (rs.next()) {
                yrcnt[i][0] = rs.getString(1);
                yrcnt[i][1] = rs.getString(2);
                i++;
            }
            return yrcnt;
        } catch (SQLException ex) {
            Logger.getLogger(DataMan.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
    }

    public ArrayList<ChemStock> getChemStock() {
        try {
            ArrayList<ChemStock> chem = new ArrayList();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select a.productcode, a.productdesc, b.units from chemicals a, stock b where a.productcode = b.productid and b.tp = 'chemicals'");
            while (rs.next()) {
                ChemStock cs = new ChemStock();
                cs.setProductDesc(rs.getString(2));
                cs.setProductId(rs.getInt(1));
                cs.setUnits(rs.getInt(3));
                chem.add(cs);
            }
            return chem;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public ArrayList<Instruments> getInst() {
        try {
            ArrayList<Instruments> chem = new ArrayList();
            Query qry = session.createQuery("From Instruments");
            List chm = qry.list();
            Iterator i = chm.iterator();
            while (i.hasNext()) {
                Instruments c = (Instruments) i.next();
                chem.add(c);
            }
            return chem;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public String getInvDet(int invno) {
        /*
        select a.*, b.partyname from invoice a, partymaster b,voucher c where a.vchno = c.voucherno and c.partyno = b.partyno;
         */
        try {
            String det = "";
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select a.*, b.partyno from invoice a, partymaster b,voucher c where a.vchno = c.voucherno and c.partyno = b.partyno and a.invno = " + invno);
            rs.next();
            det += rs.getString(8) + "|" + rs.getString(1);
            return det;
        } catch (Exception ex) {
            System.out.println(ex);
            return ex.toString();
        }
    }

    public ArrayList<Glassware> getGlass() {
        try {
            ArrayList<Glassware> chem = new ArrayList();
            Query qry = session.createQuery("From Glassware");
            List chm = qry.list();
            Iterator i = chm.iterator();
            while (i.hasNext()) {
                Glassware c = (Glassware) i.next();
                chem.add(c);
            }
            return chem;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public ArrayList<Chemicals> getChems() {
        try {
            ArrayList<Chemicals> chem = new ArrayList();
            Query qry = session.createQuery("From Chemicals");
            List chm = qry.list();
            Iterator i = chm.iterator();
            while (i.hasNext()) {
                Chemicals c = (Chemicals) i.next();
                chem.add(c);
            }
            return chem;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public double[] getDashData() {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("Select sum(units) from stock where tp = 'chemicals'");
            rs.next();
            double qty[] = new double[4];
            qty[0] = rs.getInt(1);
            rs = stmt.executeQuery("select sum(units) from stock where tp = 'glassware'");
            rs.next();
            qty[1] = rs.getInt(1);
            rs = stmt.executeQuery("select sum(units) from stock where tp = 'instrument'");
            rs.next();
            qty[2] = rs.getInt(1);
            rs = stmt.executeQuery("select sum(cramt) - sum(paid) from invoice");
            rs.next();
            qty[3] = rs.getDouble(1);
            return qty;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getInvStock(int page, int rows, String tp) {
        try {
            JSONObject json = new JSONObject();

            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            if (tp.equals("chem")) {
                ResultSet rs = stmt.executeQuery("select * from stockchem");
                ArrayList<StockChem> stocks = new ArrayList();
                rs.last();
                int total = rs.getRow();
                json.put("total", total);
                rs = stmt.executeQuery("select * from stockchem limit " + rows + " offset " + offset);
                while (rs.next()) {
                    StockChem chem = new StockChem();
                    chem.setProductdesc(rs.getString("productdesc"));
                    chem.setProductid(rs.getInt("productid"));
                    chem.setSpecification(rs.getString("specification"));
                    chem.setUnits(rs.getInt("units"));
                    stocks.add(chem);
                }
                json.put("rows", stocks);
            } else if (tp.equals("glass")) {
                ResultSet rs = stmt.executeQuery("select * from stockglass");
                ArrayList<StockGlass> stocks = new ArrayList();
                rs.last();
                int total = rs.getRow();
                json.put("total", total);
                rs = stmt.executeQuery("select * from stockglass limit " + rows + " offset " + offset);
                while (rs.next()) {
                    StockGlass chem = new StockGlass();
                    chem.setDescgoods(rs.getString("descgoods"));
                    chem.setProductid(rs.getInt("productid"));
                    chem.setMake(rs.getString("make"));
                    chem.setUnits(rs.getInt("units"));
                    stocks.add(chem);
                }
                json.put("rows", stocks);
            } else {
                ResultSet rs = stmt.executeQuery("select * from stockinst");
                ArrayList<StockInst> stocks = new ArrayList();
                rs.last();
                int total = rs.getRow();
                json.put("total", total);
                rs = stmt.executeQuery("select * from stockinst limit " + rows + " offset " + offset);
                while (rs.next()) {
                    StockInst chem = new StockInst();
                    chem.setDescgoods(rs.getString("descgoods"));
                    chem.setProductid(rs.getInt("productid"));
                    chem.setMoc(rs.getString("moc"));
                    chem.setUnits(rs.getInt("units"));
                    stocks.add(chem);
                }
                json.put("rows", stocks);
            }
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public void addReceipt(Receipts r) {
        try {
//            Transaction t = session.beginTransaction();
//            session.update(r);
//            t.commit();
            int invno = r.getInvno();
            double recd = r.getRecd();

            PreparedStatement psmt = con.prepareStatement("insert into receipts(invno, recd, dor, pending) values (?,?,?,?)");
            psmt.clearParameters();
            psmt.setInt(1, invno);
            psmt.setDouble(2, recd);
            psmt.setDate(3, r.getDor());
            psmt.setDouble(4, r.getPending());
            psmt.execute();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select cramt,vchno, paid from invoice where invno = " + invno);
            while (rs.next()) {
                String vchno = rs.getString("vchno");
                double cramt = rs.getDouble("cramt");
                double paid = rs.getDouble("paid");
                double totalRecd = recd + paid;
                System.out.println("CrAmt : " + cramt + ", TotalRecd : " + totalRecd);
                if (rs.getDouble("cramt") > totalRecd) {
                    Statement stmt1 = con.createStatement();
                    stmt1.executeUpdate("update invoice set paid = " + totalRecd + " where invno = " + invno + " and vchno = '" + vchno + "'");
                    System.out.println("Updated invoice");
                    stmt1.executeUpdate("update invrep set amountRecd = " + totalRecd + " where invno = " + invno + " and voucherno = '" + vchno + "'");
                    System.out.println("Updated InvRep");
                    //recd = 0;
                    break;
                } else {
                    System.out.println("Recd : " + recd + ", CrAmt : " + cramt + ", Paid : " + paid);
                    Statement stmt1 = con.createStatement();
                    stmt1.executeUpdate("update invoice set paid = " + cramt + " where invno = " + invno + " and vchno = '" + vchno + "'");
                    System.out.println("Updated invoice");
                    stmt1.executeUpdate("update invrep set amountrecd = " + cramt + " where invno = " + invno + " and voucherno = '" + vchno + "'");
                    System.out.println("Updated InvRep");

                    recd -= (cramt - paid);
                }
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public double getPending(int invno) {
        try {
            double pending = 0;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select (cramt-paid) from invoice where invno = " + invno);
            while (rs.next()) {
                pending += rs.getDouble(1);
            }
            return pending;
        } catch (Exception ex) {
            System.out.println(ex);
            return 0;
        }
    }

    public void purChem(Voucher v) {
        try {
            System.out.println("purChem called with qty : " + v.getQty());

            Transaction t = session.beginTransaction();
            int units = v.getQty();
            int id = v.getId().getProductid();
            String tp = v.getProducttp();
            Query qry = session.createQuery("from Stock where productid = " + id + " and tp = '" + tp + "'");
            Stock stck = (Stock) qry.iterate().next();
            stck.setUnits(stck.getUnits() + units);
            session.save(v);
            session.save(stck);
            t.commit();
            System.out.println("purChem over");
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }

    public ArrayList<Invoices> getInvoice(int invno) {
        try {
            ArrayList<Invoices> invoices = new ArrayList();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from invoice where invno = " + invno);
            while (rs.next()) {
                Invoices invoice = new Invoices();
                invoice.setInvno(rs.getInt("invno"));
                invoice.setCramt(rs.getDouble("cramt"));
                invoice.setDoi(rs.getDate("doi"));
                invoice.setDramt(rs.getDouble("dramt"));
                invoice.setPaid(rs.getDouble("paid"));
                invoice.setParticulars(rs.getString("particulars"));
                invoice.setVchno(rs.getString("vchno"));
                invoices.add(invoice);
            }
            return invoices;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public int[] getPendingInvoice() {
        try {
            int a[];
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select distinct(invno) from invoice where paid < cramt");
            if (rs.next()) {
                rs.last();
                a = new int[rs.getRow()];
                rs.beforeFirst();
                int i = 0;
                while (rs.next()) {
                    a[i] = rs.getInt(1);
                    i++;
                }
                System.out.println("Invoices Found : " + a.length);
                return a;
            }
            return null;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getReceipts(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Receipts> receipts = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from receipts");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from receipts limit " + rows + " offset " + offset);
            while (rs.next()) {
                Receipts receipt = new Receipts();
                receipt.setDor(rs.getDate("dor"));
                receipt.setInvno(rs.getInt("invno"));
                receipt.setPending(rs.getFloat("pending"));
                receipt.setRecd(rs.getFloat("recd"));
                receipt.setRectno(rs.getInt("rectno"));
                receipts.add(receipt);
            }
            json.put("rows", receipts);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getInvoice(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Vchr> vchrs = new ArrayList();
            int offset = (page - 1) * rows;

            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from invoice");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from invoice limit " + rows + " offset " + offset);

            ArrayList<Invoices> arr = new ArrayList();

            while (rs.next()) {
                Invoices invoice = new Invoices();
                invoice.setCramt(rs.getDouble("cramt"));
                invoice.setDoi(rs.getDate("doi"));
                invoice.setDramt(rs.getDouble("dramt"));
                invoice.setInvno(rs.getInt("invno"));
                invoice.setPaid(rs.getDouble("paid"));
                invoice.setParticulars(rs.getString("particulars"));
                invoice.setVchno(rs.getString("vchno"));
                arr.add(invoice);
            }
            json.put("rows", arr);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public String lastVoucherNo() {
        try {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select max(voucherno) from voucher");
            if (rs.next()) {
                String nom = String.valueOf(Integer.parseInt(rs.getString(1)) + 1);
                return nom;
            } else {
                return "1";
            }
        } catch (Exception ex) {
            System.out.println(ex);
            return "1";
        }
    }

    public int addVoucher(Invoice invoice, Voucher voucher) {
        try {
            Query qry = session.createQuery("From Stock where productid = " + voucher.getId().getProductid() + " and tp = '" + voucher.getProducttp() + "'");
            Stock stock = (Stock) qry.iterate().next();
            stock.setUnits(stock.getUnits() - voucher.getQty());
            Transaction t = session.beginTransaction();
            session.save(stock);
            session.save(voucher);
            session.save(invoice);
            t.commit();
            return 1;
        } catch (Exception ex) {
            System.out.println(ex);
            return -1;
        }
    }

    public String getProdDet(String tp, int productid) {
        try {
            Query qry = null;
            int avqty = 0;
            double price = 0;
            qry = session.createQuery("From Stock where tp = '" + tp + "' and productid = " + productid);
            Stock stock = (Stock) qry.iterate().next();
            String dets = stock.getUnits().toString();
            switch (tp) {
                case "chemicals":
                    qry = session.createQuery("From Chemicals where productcode = " + productid);
                    Chemicals chem = (Chemicals) qry.iterate().next();
                    dets += "|" + chem.getPrice() + "|" + chem.getGst();
                    break;
                case "glassware":
                    qry = session.createQuery("From Glassware where productid = " + productid);
                    Glassware gls = (Glassware) qry.iterate().next();
                    dets += "|" + gls.getPrice() + "|" + gls.getGst();
                    break;
                default:
                    qry = session.createQuery("From Instruments where instrumentsid = " + productid);
                    Instruments inst = (Instruments) qry.iterate().next();
                    dets += "|" + inst.getRate() + "|" + inst.getGst();
                    break;
            }
            return dets;
        } catch (Exception ex) {
            System.out.println(ex);
            return ex.toString();
        }
    }

    public String getProdName(String tp, int productid) {
        try {
            Query qry = null;
            String desc = "";
            switch (tp) {
                case "chemicals":
                    qry = session.createQuery("From Chemicals where productcode = " + productid);
                    Chemicals chm = (Chemicals) qry.iterate().next();
                    desc = chm.getProductdesc() + ", " + chm.getSpecification();
                    break;
                case "glassware":
                    qry = session.createQuery("From Glassware where productid = " + productid);
                    Glassware gls = (Glassware) qry.iterate().next();
                    desc = gls.getDescGoods();
                    break;
                default:
                    qry = session.createQuery("From Instruments where instrumentsid = " + productid);
                    Instruments inst = (Instruments) qry.iterate().next();
                    desc = inst.getDescGoods();
                    break;
            }
            return desc;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public ArrayList<Stock> getStock() {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Stock> stocks = new ArrayList();
            Query qry = session.createQuery("From Stock");
            Iterator i = qry.iterate();
            while (i.hasNext()) {
                Stock stock = (Stock) i.next();
                stocks.add(stock);
            }
            return stocks;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getStock(String tp, int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Stock> stock = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from stock where tp = '" + tp + "'");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from stock where tp = '" + tp + "' limit " + rows + " offset " + offset);
            while (rs.next()) {
                Stock s = new Stock();
                s.setStckid(rs.getInt(1));
                s.setProductId(rs.getInt(2));
                s.setTp(rs.getString(3));
                s.setUnits(rs.getInt(4));
                stock.add(s);
            }
            json.put("rows", stock);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getPartys(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Parties> insts = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from partymaster");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from partymaster limit " + rows + " offset " + offset);
            while (rs.next()) {
                Parties instr = new Parties();
                instr.setAddress1(rs.getString("address1"));
                instr.setAddress2(rs.getString("address2"));
                instr.setCity(rs.getString("city"));
                instr.setEmail(rs.getString("email"));
                instr.setPartyname(rs.getString("partyname"));
                instr.setPartyno(rs.getString("partyno"));
                instr.setPhone(rs.getString("phone"));
                instr.setPincode(rs.getInt("pincode"));
                insts.add(instr);
            }
            json.put("rows", insts);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getGlasses(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Glasswares> insts = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from glassware");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from glassware limit " + rows + " offset " + offset);
            while (rs.next()) {
                Glasswares instr = new Glasswares();
                instr.setCatNo(rs.getInt("catno"));
                instr.setDescGoods(rs.getString("descgoods"));
                instr.setGst(rs.getFloat("gst"));
                instr.setMake(rs.getString("make"));
                instr.setPrice(rs.getDouble("price"));
                instr.setSubCat(rs.getString("subcat"));
                instr.setProductId(rs.getInt("productid"));
                insts.add(instr);
            }
            json.put("rows", insts);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getInsts(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Instrument> insts = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from instruments");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from instruments limit " + rows + " offset " + offset);
            while (rs.next()) {
                Instrument instr = new Instrument();
                instr.setCatNo(rs.getString("catno"));
                instr.setDescGoods(rs.getString("descgoods"));
                instr.setGst(rs.getFloat("gst"));
                instr.setInstrumentsId(rs.getInt("instrumentsid"));
                instr.setMoc(rs.getString("moc"));
                instr.setRate(rs.getInt("rate"));
                instr.setTempController(rs.getString("tempcontroller"));
                instr.setWorkingSize(rs.getString("workingsize"));
                insts.add(instr);
            }
            json.put("rows", insts);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getVoucher(int page, int rows, String tp) {
        try {
            JSONObject json = new JSONObject();
            ArrayList<Vchr> vchrs = new ArrayList();
            int offset = (page - 1) * rows;
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from voucher where producttp = '" + tp + "'");
            rs.last();
            int total = rs.getRow();
            json.put("total", total);
            rs = stmt.executeQuery("select * from voucher where producttp = '" + tp + "' limit " + rows + " offset " + offset);
            while (rs.next()) {
                Vchr v = new Vchr();
                v.setDos(rs.getDate("dos"));
                v.setPartyno(rs.getInt("partyno"));
                v.setProductid(rs.getInt("productid"));
                v.setProducttp(rs.getString("producttp"));
                v.setQty(rs.getInt("qty"));
                v.setVoucherno(rs.getInt("voucherno"));
                v.setPrice(rs.getDouble("price"));
                v.setAmt(v.getPrice() * v.getQty());
                vchrs.add(v);
            }
            json.put("rows", vchrs);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getInst(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            Query qry = null;
            int offset = (page - 1) * rows;
            qry = session.createQuery("FROM Instruments");
            //qry.setParameter("enrollmentNumber", enrollmentNumber + "%");
            List std = qry.list();
            qry.setFirstResult(offset);
            qry.setMaxResults(rows);
            List studs = qry.list();
            Iterator i = studs.iterator();
            int total = std.size();
            json.put("total", total);
            ArrayList<Instruments> arr = new ArrayList();
            while (i.hasNext()) {
                Instruments se = (Instruments) i.next();
                arr.add(se);
            }
            json.put("rows", arr);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getGlass(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            Query qry = null;

            int offset = (page - 1) * rows;

            qry = session.createQuery("FROM Glassware");
            //qry.setParameter("enrollmentNumber", enrollmentNumber + "%");

            List std = qry.list();
            qry.setFirstResult(offset);
            qry.setMaxResults(rows);
            List studs = qry.list();
            Iterator i = studs.iterator();
            int total = std.size();
            json.put("total", total);
            ArrayList<Glassware> arr = new ArrayList();

            while (i.hasNext()) {
                Glassware se = (Glassware) i.next();
                arr.add(se);
            }
            json.put("rows", arr);
            System.out.println("Glassware JSON : " + json);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getParty(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            Query qry = null;

            int offset = (page - 1) * rows;

            qry = session.createQuery("FROM Partymaster");
            //qry.setParameter("enrollmentNumber", enrollmentNumber + "%");

            List std = qry.list();

            qry.setFirstResult(offset);
            qry.setMaxResults(rows);
            List studs = qry.list();
            Iterator i = studs.iterator();
            int total = std.size();
            json.put("total", total);
            ArrayList<Partymaster> arr = new ArrayList();

            while (i.hasNext()) {
                Partymaster se = (Partymaster) i.next();
                arr.add(se);
            }
            json.put("rows", arr);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getUser(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            Query qry = null;

            int offset = (page - 1) * rows;

            qry = session.createQuery("FROM Usermaster");
            //qry.setParameter("enrollmentNumber", enrollmentNumber + "%");

            List std = qry.list();

            qry.setFirstResult(offset);
            qry.setMaxResults(rows);
            List studs = qry.list();
            Iterator i = studs.iterator();
            int total = std.size();
            json.put("total", total);
            ArrayList<Usermaster> arr = new ArrayList();

            while (i.hasNext()) {
                Usermaster se = new Usermaster();
                Usermaster um = (Usermaster) i.next();
                se.setDesignation(um.getDesignation());
                se.setEmail(um.getEmail());
                se.setName(um.getName());
                se.setStatus(um.getStatus());
                arr.add(se);
            }
            //System.out.println("All users added");
            json.put("rows", arr);
            System.out.println("User JSON : " + json);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

    public JSONObject getChems(int page, int rows) {
        try {
            JSONObject json = new JSONObject();
            Query qry = null;

            int offset = (page - 1) * rows;

            qry = session.createQuery("FROM Chemicals");
            //qry.setParameter("enrollmentNumber", enrollmentNumber + "%");

            List std = qry.list();

            qry.setFirstResult(offset);
            qry.setMaxResults(rows);
            List studs = qry.list();
            Iterator i = studs.iterator();
            int total = std.size();
            json.put("total", total);
            ArrayList<Chemicals> arr = new ArrayList();

            while (i.hasNext()) {
                Chemicals se = (Chemicals) i.next();
                arr.add(se);
            }
            json.put("rows", arr);
            return json;
        } catch (Exception ex) {
            System.out.println(ex);
            return null;
        }
    }

   
}
