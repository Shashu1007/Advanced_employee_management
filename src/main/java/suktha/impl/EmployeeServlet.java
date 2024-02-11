package suktha.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import suktha.dao.EmployeeDao;
import suktha.model.Employee;

@WebServlet("/")
public class EmployeeServlet extends HttpServlet {
    private EmployeeDao employeedao;
    private final int RECORDS_PER_PAGE = 10;

    @Override
    public void init() {
        employeedao = new EmployeeDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String action = request.getServletPath();

        try {
            switch (action) {
                case "/new":
                    showNewForm(request, response);
                    break;
                
                case "/insert":
                    insertEmployee(request, response);
                    break;
                case "/delete":
                    deleteEmployee(request, response);
                    break;
                case "/edit":
                    showEditForm(request, response);
                    break;
                case "/update":
                    updateEmployee(request, response);
                    break;
                case "/search":
                    searchEmployee(request, response);
                    break;
                case "/list":
                    listEmployee(request, response);
                    break;
                default:
                    listEmployee(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    doGet(request, response);
}

    private void listEmployee(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
    int page = 1;
    int recordsPerPage = 10; // Define the number of records per page
    
    if (request.getParameter("page") != null) {
        page = Integer.parseInt(request.getParameter("page"));
    }
    
    int start = (page - 1) * recordsPerPage;
    
    List<Employee> listEmployees = EmployeeDao.getEmployees(start, recordsPerPage);
    int totalCount = (int) EmployeeDao.getEmployeeCount();
    int totalPages = (int) Math.ceil((double) totalCount / recordsPerPage);
    
    request.setAttribute("listEmployees", listEmployees);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("currentPage", page);
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
    dispatcher.forward(request, response);
}


    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee-form.jsp");
        dispatcher.forward(request, response);
    }
private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String empidParam = request.getParameter("empid");
            if (empidParam != null && !empidParam.isEmpty()) {
                int empid = Integer.parseInt(empidParam);
                Employee existingEmployee = EmployeeDao.getEmployeeById(empid);
                if (existingEmployee != null) {
                    RequestDispatcher dispatcher = request.getRequestDispatcher("employee-form.jsp");
                    request.setAttribute("employee", existingEmployee);
                    dispatcher.forward(request, response);
                } else {
                    response.getWriter().println("No employee found with the provided ID.");
                }
            } else {
                response.getWriter().println("Employee ID parameter is missing or empty.");
            }
        }catch (NumberFormatException e) {
            response.getWriter().println("Invalid employee ID format.");
        }
    }

    private void insertEmployee(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String num = request.getParameter("phn_no");  
      
        
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String place = request.getParameter("place");
        String designation = request.getParameter("designation");
        String salary = request.getParameter("salary");
        
        Employee newEmployee = new Employee(firstName, lastName,num, email,dob, place, designation, salary);
        EmployeeDao.addEmployee(newEmployee);
        response.sendRedirect("list");
}

        
    
private void deleteEmployee(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String empidParam = request.getParameter("empid");
            if (empidParam != null && !empidParam.isEmpty()) {
                int empid = Integer.parseInt(empidParam);
                EmployeeDao.deleteEmployee(empid);
                response.sendRedirect("list"); 
            } else {
                response.getWriter().println("Employee ID parameter is missing or empty.");
            }
        }catch (NumberFormatException e) {
            response.getWriter().println("Invalid employee ID format.");
        }
}

private void updateEmployee(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        try {
            int empid = Integer.parseInt(request.getParameter("empid"));
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
          
            String num = request.getParameter("phn_no"); 
            
            String email = request.getParameter("email");
            String dob = request.getParameter("dob");
            String place = request.getParameter("place");
            String designation = request.getParameter("designation");
            String salary = request.getParameter("salary");
            
            Employee existingEmployee = EmployeeDao.getEmployeeById(empid);
            if (existingEmployee != null) {
                existingEmployee.setFirstName(firstName);
                existingEmployee.setLastName(lastName);
                existingEmployee.setPhn_no(num);
                existingEmployee.setEmail(email);
                existingEmployee.setdob(dob);
                existingEmployee.setPlace(place);
                existingEmployee.setDesignation(designation);
                existingEmployee.setSalary(salary);

                EmployeeDao.updateEmployee(existingEmployee);
                response.sendRedirect("list");
            } else {
                response.getWriter().println("No employee found with the provided ID.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid employee ID format.");
    }
}
   
   private void searchEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String empidParam = request.getParameter("empid");
            if (empidParam != null && !empidParam.isEmpty()) {
                int empid = Integer.parseInt(empidParam);
                Employee searchedEmployee = EmployeeDao.getEmployeeById(empid);
                if (searchedEmployee != null) {
                    List<Employee> searchResult = new ArrayList<>();
                    searchResult.add(searchedEmployee);
                    request.setAttribute("listEmployees", searchResult);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
                    dispatcher.forward(request, response);
                } else {
                    response.getWriter().println("No employee found with the provided ID.");
                }
            } else {
                response.getWriter().println("Employee ID parameter is missing or empty.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid employee ID format.");       
        }
    }
       
}
    

