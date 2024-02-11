/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

import suktha.model.Employee;
import suktha.util.HibernateUtil;

/**
 *
 * @author Shashank
 */

    
public class EmployeeDao {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/task";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "1234";
    public static void addEmployee(Employee employee) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {

            transaction = session.beginTransaction();
            session.save(employee);
            transaction.commit();

        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
        }
    }
    public  static Employee getEmployeeById(int empid ) {
		Transaction transaction =null;
		Employee employee=null;
		try(Session session= HibernateUtil.getSessionFactory().openSession()) {
			
			transaction = session.beginTransaction();
			employee=session.get(Employee.class ,empid);
			transaction.commit();
			
		}
		catch(Exception e) {
			if(transaction!=null) {
				transaction.rollback();
			}
		}
		return employee;
	}
    public  static void updateEmployee(Employee employee) {
		Transaction transaction =null;
            
		try(Session session= HibernateUtil.getSessionFactory().openSession()) {
			
			transaction = session.beginTransaction();
			session.update(employee);
			transaction.commit();
			
		}
		catch(Exception e) {
			if(transaction!=null) {
				transaction.rollback();
			}
		}
	}

    @SuppressWarnings("unchecked")
    public static List<Employee> getEmployees() {
		Transaction transaction =null;
		List<Employee> employees=null;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();
        employees = session.createQuery("from Employee").getResultList();
        transaction.commit();
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    }
    return employees;
		

    }
    @SuppressWarnings("unchecked")
    public  static List<Employee> getEmployees(int start, int recordsPerPage) {
    Transaction transaction = null;
    List<Employee> employees = null;
    Session session = null;

    try {
        session = HibernateUtil.getSessionFactory().openSession();
        transaction = session.beginTransaction();
        employees = session.createQuery("from Employee")
                           .setFirstResult(start)
                           .setMaxResults(recordsPerPage)
                           .getResultList();
        transaction.commit();
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    } finally {
        if (session != null) {
            session.close();
        }
    }
    return employees;
}
    public static void deleteEmployee(int empid) {
    Transaction transaction = null;
    @SuppressWarnings("UnusedAssignment")
    Employee employee = null;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();
        employee = session.get(Employee.class, empid);
        if (employee != null) {
            session.delete(employee);
            transaction.commit();
        } else {
            System.out.println("No employee found with the provided ID.");
        }
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    }
}

    public boolean checkPhoneNumberExists(String phoneNumber) {
        String sql = "SELECT COUNT(*) FROM your_table_name WHERE phn_no = ?";
        try (
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            stmt.setString(1, phoneNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                return count > 0; // If count is greater than 0, phone number exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if any exception occurs or phone number doesn't exist
    }
  public String validateEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);
        if (!matcher.matches()) {
            return "Invalid email format";
        }
        return null; // Return null if email format is valid
    }
    public static long getEmployeeCount() {
        Transaction transaction = null;
        long totalcount = 0;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            totalcount = (Long) session.createQuery("select count(*) from Employee").uniqueResult();
            transaction.commit();
        } catch (HibernateException e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
        return totalcount;
    }
}
    

