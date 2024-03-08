/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.dao;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import suktha.model.Employee;
import suktha.model.Employee.EmployeeStatus;
import suktha.util.ConnectionFactory;
import suktha.util.HibernateUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Shashank
 */


public class EmployeeDao {
    


public static List<Employee> getEmployees(int start, int recordsPerPage) {
    Transaction transaction = null;
    List<Employee> employees = null;
    Session session = HibernateUtil.getSessionFactory().openSession();
    try {
        transaction = session.beginTransaction();
        
        Query<Employee> query = session.createQuery("FROM Employee WHERE empStatus != :status", Employee.class);
        query.setParameter("status", EmployeeStatus.DELETED); // Set the parameter value for the status
        query.setFirstResult(start);
        query.setMaxResults(recordsPerPage);
        employees = query.getResultList();
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

    public static List<Employee> getAllEmployees() {
        Transaction transaction = null;
        List<Employee> employees = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();

            Query<Employee> query = session.createQuery("FROM Employee WHERE empStatus != :status", Employee.class);
            query.setParameter("status", EmployeeStatus.DELETED); // Set the parameter value for the status
            employees = query.getResultList(); // Fetch all employees without pagination
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

    public static List<Employee> getFilteredEmployees(String[] jobFilters) throws SQLException, ParseException {
        List<Employee> employees = new ArrayList<>();

        // Obtain a connection from your connection factory or DriverManager
        try (Connection connection = ConnectionFactory.getConnection()) {
            StringBuilder queryStringBuilder = new StringBuilder("SELECT * FROM Employee WHERE 1=1");

            // Check if jobFilters exist and append to the query
            if (jobFilters != null && jobFilters.length > 0) {
                queryStringBuilder.append(" AND job IN (");
                for (int i = 0; i < jobFilters.length; i++) {
                    queryStringBuilder.append("?");
                    if (i < jobFilters.length - 1) {
                        queryStringBuilder.append(",");
                    }
                }
                queryStringBuilder.append(")");
            }

            // Exclude records where empStatus is 'DELETED'
            queryStringBuilder.append(" AND empStatus != 'DELETED'");

            // Create the PreparedStatement
            try (PreparedStatement preparedStatement = connection.prepareStatement(queryStringBuilder.toString())) {
                // Set parameters if jobFilters exist
                if (jobFilters != null && jobFilters.length > 0) {
                    for (int i = 0; i < jobFilters.length; i++) {
                        preparedStatement.setString(i + 1, jobFilters[i]);
                    }
                }

                // Execute the query
                try (ResultSet rs = preparedStatement.executeQuery()) {
                    // Process the result set
                    while (rs.next()) {
                        Employee employee = new Employee();
                        // Populate employee fields from the result set
                        employee.setId(rs.getInt("id"));
                        employee.setEmployeeId(rs.getString("employeeId"));
                        employee.setFirstName(rs.getString("first_name"));
                        employee.setLastName(rs.getString("last_name"));
                        employee.setEmail(rs.getString("e_mail"));
                        String dobString = rs.getString("dob");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                        Date dob = dateFormat.parse(dobString);
                        employee.setDob(dob);
                        employee.setLocation(rs.getString("location"));
                        employee.setPhoneNo(rs.getString("Phone_no"));
                        employee.setGender(rs.getString("gender"));
                        employee.setManager(rs.getString("manager"));
                        employee.setProject(rs.getString("project"));
                        employee.setJob(rs.getString("job"));
                        employee.setSalary(rs.getString("salary"));
                        String empStatusString = rs.getString("empStatus");
                        EmployeeStatus empStatus = EmployeeStatus.valueOf(empStatusString);
                        employee.setEmpStatus(empStatus);

                        employees.add(employee);
                    }
                }
            }
        }

        return employees;
    }

  public static List<Employee> searchEmployees(String searchKeyword) throws SQLException, ParseException {
    List<Employee> employees = new ArrayList<>();
   
    String sql = "SELECT * FROM Employee " +
            "WHERE (employeeId LIKE ? OR " +
                 "first_name LIKE ? OR " +
                 "last_name LIKE ? OR " +
                 "e_mail LIKE ? OR " +
            "Phone_no LIKE ? OR " +
            "location LIKE ?) " + // Closing parentheses for the OR conditions
            "AND empStatus != 'DELETED'"; // Filter for empStatus
    
    try (Connection conn = ConnectionFactory.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
        String keyword = "%" + searchKeyword + "%";
        stmt.setString(1, keyword); // employee_id
        stmt.setString(2, keyword); // first_name
        stmt.setString(3, keyword); // last_name
        stmt.setString(4, keyword); // email
        stmt.setString(5, keyword); // phone_no
        stmt.setString(6, keyword); // location
        
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Employee employee = new Employee();

                String idParam = rs.getString("id");
                int id = Integer.parseInt(idParam);
                employee.setId(id);
                employee.setEmployeeId(rs.getString("employeeId"));
                employee.setFirstName(rs.getString("first_name"));
                employee.setLastName(rs.getString("last_name"));
                employee.setEmail(rs.getString("e_mail"));
                String dobString = rs.getString("dob");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date dob = dateFormat.parse(dobString);
                employee.setDob(dob);
                employee.setLocation(rs.getString("location"));
                employee.setPhoneNo(rs.getString("Phone_no"));
                employee.setGender(rs.getString("gender"));
                employee.setManager(rs.getString("manager"));
                employee.setProject(rs.getString("project"));
                employee.setJob(rs.getString("job"));
                employee.setSalary(rs.getString("salary"));
                String empStatusString = rs.getString("empStatus");
                EmployeeStatus empStatus = EmployeeStatus.valueOf(empStatusString);
                employee.setEmpStatus(empStatus);

                employees.add(employee);
            }
        }
    } catch (SQLException | ParseException e) {
        e.printStackTrace();
    }
    
    return employees;
}


    public static void addEmployee(Employee employee) {
        Transaction transaction = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();
            session.save(employee);
            transaction.commit();
        } catch (Exception ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
  public static Employee getEmployeeById(int id) {
    Transaction transaction = null;
    Employee employee = null;
    Session session = HibernateUtil.getSessionFactory().openSession();
    try  {
        transaction = session.beginTransaction();
        employee = (Employee) session.createQuery("from Employee e where e.id = :id")
                                    .setParameter("id", id)
                                    .uniqueResult();
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
    return employee;
}


    public static List<Employee> getEmployeesByIds(List<String> ids) {
        Transaction transaction = null;
        List<Employee> employees = null;
        Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            transaction = session.beginTransaction();
            employees = session.createQuery("from Employee e where e.employeeId IN (:ids)")
                    .setParameterList("ids", ids)
                    .list();
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


  public static void updateEmployee(Employee employee) {
    Transaction transaction = null;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();
        session.update(employee);
        transaction.commit();
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    }
}
	
@SuppressWarnings("unchecked")
public static List<Employee> getExcelEmployees() {
    Transaction transaction = null;
    List<Employee> employees = null;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();
        
       
        employees = session.createQuery(
                        "select e.employeeId, e.firstName, e.lastName, e.email, e.dob, e.location, " +
                        "e.phoneNo, e.gender, e.job, e.salary, e.manager, e.project, e.empStatus " +
                        "from Employee e")
                .getResultList();
        
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
public static List<Employee> getEmployees() {
    int start = 0; // Default starting index
    int recordsPerPage = 5; // Default records per page
    return getEmployees(start, recordsPerPage);
}


    @SuppressWarnings({"unchecked", "CallToPrintStackTrace"})
    private void listEmployees(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int page = 1;
    int recordsPerPage = 5;

    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }

    int start = (page - 1) * recordsPerPage;

    List<Employee> listEmployees = EmployeeDao.getEmployees(start, recordsPerPage);
    long totalCount = EmployeeDao.getEmployeeCount(); // Assuming you have a method to get total count
    int totalPages = (int) Math.ceil((double) totalCount / recordsPerPage);

    request.setAttribute("listEmployees", listEmployees);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("currentPage", page);

    RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
    dispatcher.forward(request, response);
}


  public static void deleteEmployee(int id) {
    Transaction transaction = null;
    Session session = HibernateUtil.getSessionFactory().openSession();
    
    try  {
        transaction = session.beginTransaction();
        
        Employee employee = session.get(Employee.class, id);
        
        if (employee != null) {
            // Update the status to DELETED
            employee.setEmpStatus(EmployeeStatus.DELETED);
            // No need to delete, just update and commit
            transaction.commit();
            System.out.println("Employee  DELETED successfully!");
        } else {
            System.out.println("No employee found with the provided ID.");
        }
    } catch (Exception ex) {
        if (transaction != null) {
            transaction.rollback();
        }
        ex.printStackTrace();
    } finally {
        if (session != null) {
            session.close();
        }
    }
}

     public static String deleteEmployees(List<Integer> ids) {
        Transaction transaction = null;
        String message = "";
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            for (Integer id : ids) {
                Employee employee = session.get(Employee.class, id);
                if (employee != null) {
                    employee.setEmpStatus(EmployeeStatus.DELETED);
                    message += "Employees deleted successfully.";
                    
                } else {
                    message += "Employee with ID " + id + " not found.";
                }
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            message += "Error while deleting the employees";
        }
        return message;
    }
     
     public static void deleteAllEmployees(List<Integer> ids, EmployeeStatus status) {
    Transaction transaction = null;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();
        for (Integer id : ids) {
            Employee employee = session.get(Employee.class, id);
            if (employee != null) {
                 employee.setEmpStatus(EmployeeStatus.DELETED);
            } else {
                System.out.println("Employee with ID " + id + " not found.");
            }
        }
        transaction.commit();
    } catch (Exception e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    }
}
     
   public static long getEmployeeCount() {
       Session session = HibernateUtil.getSessionFactory().openSession();
        try {
            
            return (Long) session.createQuery("select count(*) from Employee where empStatus not like 'DELETED'").uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }finally{
        if(session!=null)
            session.close();
        }
    }


    public static long getEmployeeCounts() {
    Transaction transaction = null;
    long count = 0;
    try (Session session = HibernateUtil.getSessionFactory().openSession()) {
        transaction = session.beginTransaction();

        // Execute query to count total number of employees
        count = (long) session.createQuery("SELECT COUNT(*) FROM Employee WHERE empStatus NOT LIKE 'DELETED'").uniqueResult();

        transaction.commit();
    } catch (HibernateException e) {
        if (transaction != null) {
            transaction.rollback();
        }
        e.printStackTrace();
    }
    return count;
}



    public static List<String> getAllGenders() {
        List<String> genders = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<String> query = session.createQuery("SELECT DISTINCT gender FROM Employee WHERE empStatus NOT LIKE 'DELETED'", String.class);
            genders = query.getResultList();
        }catch (HibernateException ex){
            ex.printStackTrace();
        }
        return genders;
    }
    

    public static List<String> getAllManagers() {
        List<String> managers = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<String> query = session.createQuery("SELECT DISTINCT manager FROM Employee WHERE empStatus NOT LIKE 'DELETED'", String.class);
            managers = query.getResultList();
        }catch(HibernateException ex){
            ex.printStackTrace();
        }
        return managers;
    }

    public static List<String> getAllProjects() {
        List<String> projects = new ArrayList<>();
        
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<String> query = session.createQuery("SELECT DISTINCT project FROM Employee WHERE empStatus NOT LIKE 'DELETED'", String.class);
            projects = query.getResultList();
            
        } catch(HibernateException ex ){
            ex.printStackTrace();
        }
        return projects;
        
    }

    public static List<String> getAllJobs() {
        List<String> jobs = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<String> query = session.createQuery("SELECT DISTINCT job FROM Employee WHERE empStatus NOT LIKE 'DELETED'", String.class);
            jobs = query.getResultList();
      
       
    }catch(HibernateException ex){
    ex.printStackTrace();
}
    return jobs;
}
}
    

