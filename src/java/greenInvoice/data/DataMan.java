/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.data;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Vivek
 */
public class DataMan {

    private Connection con;

    public DataMan() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/invinv", "root", "root");
        } catch (Exception ex) {
            System.out.println(ex);
        }

    }
    public String[][] getMakeGlass()
    {
        try
        {
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select make,count(make) from glassware group by (make)");
            rs.last();
            String makeGl[][] = new String[rs.getRow()][2];
            rs.beforeFirst();
            int i = 0;
            while (rs.next())
            {
                makeGl[i][0] = rs.getString(1);
                makeGl[i][1] = rs.getString(2);
                i++;
            }
            return makeGl;
        }
        catch(Exception ex)
        {
            System.out.println(ex);
            return null;
        }
    }
    private void enterStock()
    {
        try
        {
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("select * from chemicals");
            
            while (rs.next())
            {
                Statement stmt1 = con.createStatement();
                double d = Math.round(Math.random()*1000);
                int pi = rs.getInt(1);
                String tp = "chemicals";
                stmt1.executeUpdate("insert into stock values("+pi + ",'" + tp +"', "+ d + ")");
            }
            rs = stmt.executeQuery("select * from glassware");
            while (rs.next())
            {
                Statement stmt1 = con.createStatement();
                double d = Math.round(Math.random()*1000);
                int pi = rs.getInt(1);
                String tp = "glassware";
                stmt1.executeUpdate("insert into stock values("+pi + ",'" + tp +"', "+ d + ")");
            }
            rs = stmt.executeQuery("select * from instruments");
            while (rs.next())
            {
                Statement stmt1 = con.createStatement();
                double d = Math.round(Math.random()*1000);
                int pi = rs.getInt(1);
                String tp = "instruments";
                stmt1.executeUpdate("insert into stock values("+pi + ",'" + tp +"', "+ d + ")");
            }
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    public String[][] getYrCnt()
    {
        try
        {
            
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT YEAR(STR_TO_DATE(accountopendate, '%Y')) year,count(YEAR(STR_TO_DATE(accountopendate, '%Y'))) cnt from accounts group by YEAR(STR_TO_DATE(accountopendate, '%Y'))");
            rs.last();
            String yrcnt [][] = new String[rs.getRow()][2];
            rs.beforeFirst();
            int i=0;
            while (rs.next())
            {
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
    public static void main(String args[])
    {
        DataMan dm = new DataMan();
        System.out.println("Connection done");
        dm.enterStock();
    }
}
