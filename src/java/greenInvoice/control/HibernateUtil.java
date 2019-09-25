/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package greenInvoice.control;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;

/**
 *
 * @author Vivek
 */
public class HibernateUtil {
    private static SessionFactory sessionFactory;
    static
    {
        try
        {
            sessionFactory = new AnnotationConfiguration().configure().buildSessionFactory();
        }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
    }
    public static SessionFactory getSessionFactory()
    {
        return sessionFactory;
    }
}
