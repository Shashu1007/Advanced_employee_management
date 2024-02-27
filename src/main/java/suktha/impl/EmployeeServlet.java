package suktha.impl;

import com.google.gson.Gson;
import java.awt.Image;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;
import org.hibernate.HibernateException;
import suktha.dao.EmployeeDao;
import suktha.model.Employee;



import javax.servlet.annotation.WebServlet;
import javax.servlet.*;
import java.sql.SQLException;
import java.text.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;


import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.*;
import suktha.model.Employee.EmployeeStatus;
@MultipartConfig
@WebServlet("/")

public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    public void init() {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, HibernateException {

        String action = request.getServletPath();

        try {
            switch (action) {
                
                
                case "/insert":
                    insertEmployee(request, response);
                    break;
                case "/delete":
                    deleteEmployee(request, response);
                    break;
                case "/update":
                    updateEmployee(request, response);
                    break;
                case "/getEmployeeDetails":
                    getEmployeeDetails(request, response);
                    break;
                case "/search":
                    searchEmployee(request, response);
                    break;
                case "/list":
                    listEmployee(request, response);
                    break;
                    
                case "/deleteEmployees":
                    deleteEmployees(request, response);
                    break;
                
                case "/deleteAllEmployee":
                      deleteAllEmployees(request,response);
                      break;
 //               case "/filter":
//
//                    filterEmployees(request, response);
//                    break;
                    
                case   "/login":
                      login(request,response);
                      break;
                
                
                default:
                   response.sendRedirect("login.jsp");
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        } catch (ParseException ex) {
            Logger.getLogger(EmployeeServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, HibernateException {
        doGet(request, response);
    }

    private void listEmployee(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {

        int page = 1;
        int recordsPerPage = 5;

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        int start = (page - 1) * recordsPerPage;

        List<Employee> listEmployees = EmployeeDao.getEmployees(start, recordsPerPage);
        long totalCount = EmployeeDao.getEmployeeCounts(); // Use long instead of int
        int totalPages = (int) Math.ceil((double) totalCount / recordsPerPage);

        request.setAttribute("listEmployees", listEmployees);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("count", totalCount);

        RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
        dispatcher.forward(request, response);
    }

    private void searchEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        String searchKeyword = request.getParameter("searchKeyword");
        try {
            List<Employee> searchResult = EmployeeDao.searchEmployees(searchKeyword);
            request.setAttribute("listEmployees", searchResult);
            RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            // Handle database error
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred while searching employees.");
        }
    }

   
    private void insertEmployee(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ParseException, ServletException {


        try {
         Part filePart = request.getPart("pic");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        
        // Get the temporary directory path from the servlet context
        String tempDirPath = getServletContext().getAttribute("javax.servlet.context.tempdir").toString();
        
        // Construct the file path in the temporary directory
        String filePath = tempDirPath + File.separator + fileName;
        
        // Save the uploaded file to the temporary directory
        try (InputStream fileContent = filePart.getInputStream(); 
                OutputStream outputStream = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }
        String employeeId = Employee.generateEmployeeId();
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String dobStr = request.getParameter("dob");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date dob = sdf.parse(dobStr);
        String location = request.getParameter("location");
        String phoneNo = request.getParameter("phoneNo");
        String genderStr = request.getParameter("gender");
        String gender = genderStr.equals("male") ? "Male" : "Female";
        String manager = request.getParameter("manager");
        String project = request.getParameter("project");
        String job = request.getParameter("job");
        String salary = request.getParameter("salary");
        String empStatusStr = request.getParameter("empStatus");
        EmployeeStatus empStatus = EmployeeStatus.ACTIVE;
        Date createdBy = new Date();

        
        Employee employee = new Employee(filePath,employeeId, firstName, lastName, email, dob, location, phoneNo, gender,
                manager, project, job, salary, empStatus, createdBy);
        EmployeeDao.addEmployee(employee);
        System.out.println("successfully inserted");
        }
        catch (IOException | ServletException e){
            
            e.printStackTrace();
            
        }
        
        response.sendRedirect("list");
    }

    private void updateEmployee(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Fetch employee ID from the request parameter
        String idParam = request.getParameter("id");

        // Check if ID parameter is provided
        if (idParam != null && !idParam.isEmpty()) {
            try {
                // Parse the ID parameter to an integer
                int id = Integer.parseInt(idParam);

                // Retrieve employee details by ID
                Employee existingEmployee = EmployeeDao.getEmployeeById(id);

                // Check if the employee with the given ID exists
                if (existingEmployee != null) {
                    // Update employee data with the new values from the request parameters
             
                    Part filePart = request.getPart("pic");
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    String uploadDirectory = "C:/Users/Shashank/Documents/NetBeansProjects/task_1/src/main/webapp/images/";
                    File file = new File(uploadDirectory + fileName);
                    String imagepath = uploadDirectory + fileName;

                    InputStream fileContent = filePart.getInputStream(); 
                    OutputStream outputStream = new FileOutputStream(file); 
                    byte[] buffer = new byte[4096];
                    int bytesRead;
                    while ((bytesRead = fileContent.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                    
                    existingEmployee.setImagepath(imagepath);
                    existingEmployee.setFirstName(request.getParameter("firstName"));
                    existingEmployee.setLastName(request.getParameter("lastName"));
                    existingEmployee.setEmail(request.getParameter("email"));

                    // Parse and set the date of birth
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        existingEmployee.setDob(sdf.parse(request.getParameter("dob")));
                    } catch (ParseException e) {
                        e.printStackTrace(); // Handle parsing exception accordingly
                    }

                    existingEmployee.setLocation(request.getParameter("location"));
                    existingEmployee.setPhoneNo(request.getParameter("phoneNo"));
                    existingEmployee.setGender(request.getParameter("gender"));
                    existingEmployee.setManager(request.getParameter("manager"));
                    existingEmployee.setProject(request.getParameter("project"));
                    existingEmployee.setJob(request.getParameter("job"));
                    existingEmployee.setSalary(request.getParameter("salary"));

                    // Parse and set employee status
                    String statusStr = request.getParameter("empStatus");
                    existingEmployee.setEmpStatus(EmployeeStatus.valueOf(statusStr));

                    // Set the updated timestamp
                    Date updatedBy = new Date();
                    existingEmployee.setUpdatedBy(updatedBy);

                    // Update employee in the database
                    EmployeeDao.updateEmployee(existingEmployee);
                    System.out.println("successfully updated");

                    // Redirect to the employee list page
                    response.sendRedirect("list");
                } else {
                    System.out.println("failed 1");
                    // If the employee with the given ID does not exist, handle accordingly
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    response.getWriter().write("Employee not found for ID: " + id);
                }
            } catch (NumberFormatException e) {
                // Handle the case where the ID parameter is not a valid integer
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid employee ID format.");
            }
        } else {
             System.out.println("failed 2");
            // If the ID parameter is missing or empty, return a bad request response
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Employee ID parameter is missing or empty");
        }
    }


    protected void getEmployeeDetails(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Fetch employee ID from request parameter
        String idParam = request.getParameter("id");

        // Check if ID parameter is provided
        if (idParam != null && !idParam.isEmpty()) {
            try {
                // Parse ID parameter to an integer
                int id = Integer.parseInt(idParam);

                // Retrieve employee details by ID
                Employee employee = EmployeeDao.getEmployeeById(id);

                // Convert employee object to JSON and write it to the response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(new Gson().toJson(employee));
            } catch (NumberFormatException e) {
                // Handle invalid ID format
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("Invalid employee ID format.");
            }
        } else {
            // Handle missing or empty ID parameter
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Employee ID parameter is missing or empty.");
        }
    }


    private void deleteEmployee(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                int id = Integer.parseInt(idParam);
                EmployeeDao.deleteEmployee(id);
                response.sendRedirect("list");
            } else {
                response.getWriter().println("Employee ID parameter is missing or empty.");
            }
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid employee ID format.");
        }
    }
    private void deleteEmployees(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
    try {
        String idsParam = request.getParameter("ids");
        if ( idsParam != null && !idsParam.isEmpty() ) {
            String[] idsArray = idsParam.split(",");
            List<Integer> ids = new ArrayList<>();
            for (String id : idsArray) {
                if(id.equals("on")){
                continue;
                }
                ids.add(Integer.valueOf(id));
            }
//            EmployeeDao.deleteEmployees(ids);
            String deleteMessage = EmployeeDao.deleteEmployees(ids);

            // Set the message as an attribute in the request
            request.setAttribute("deleteMessage", deleteMessage);

            // Forward the request to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("employee.jsp");
            dispatcher.forward(request, response);
            response.sendRedirect("list");
        } else {
            response.getWriter().println("Employee IDs parameter is missing or empty.");
        }
    } catch (NumberFormatException e) {
        response.getWriter().println("Invalid employee ID format.");
    }
    }
 private void deleteAllEmployees(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, ParseException {
    String idsParam = request.getParameter("ids");
    String statusParam = request.getParameter("status");

    List<Integer> ids = new ArrayList<>();
    if (idsParam != null) {
        String[] idArray = idsParam.split(",");
        for (String idStr : idArray) {
            ids.add(Integer.valueOf(idStr));
        }
    }

    EmployeeStatus status = EmployeeStatus.valueOf(statusParam);

    EmployeeDao.deleteAllEmployees(ids, status);

    RequestDispatcher dispatcher = request.getRequestDispatcher("/employees");
    dispatcher.forward(request, response);
}private void login(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        try{
    String username = request.getParameter("username");
    System.out.println(request.getParameter("username"));
    String password = request.getParameter("password");
    System.out.println(request.getParameter("password"));

    // Check if username and password match
    if (!username.equals("Admin") || !password.equals("Admin@123")) {
        // Failed login
        request.setAttribute("error", "Invalid username or password. Please try again.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    // Successful login
    response.sendRedirect("list");
        }
    catch (IOException e){
            e.printStackTrace();
            }
}
}
