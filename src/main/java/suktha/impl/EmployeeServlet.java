package suktha.impl;

import com.google.gson.Gson;
import org.hibernate.HibernateException;
import suktha.dao.EmployeeDao;
import suktha.model.Employee;
import suktha.model.Employee.EmployeeStatus;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, //2MB
        maxFileSize = 1024 * 1024 * 10, //10MB
        maxRequestSize = 1024 * 1024 * 50) //50 MB
@WebServlet("/")

public class EmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final long defaultRecords = 5;

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

                case "/records":
                    recordsPerPage(request, response);
                    break;
                    
                case "/deleteAllEmployee":
                      deleteAllEmployees(request,response);
                      break;
                case "/filter":
                    filterEmployees(request, response);
                    break;
                    
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

    private void recordsPerPage(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int recordsPerPage;
        // Default values
        String pageParam = request.getParameter("page");
        int page = Integer.parseInt(pageParam);
        String recordsPerPageParam = request.getParameter("recordsPerPage");
        if (recordsPerPageParam.isEmpty()) {
            recordsPerPage = (int) defaultRecords;
        }
        // Check if the recordsPerPage parameter is provided and not empty in the request
        if (recordsPerPageParam != null && !recordsPerPageParam.isEmpty()) {
            try {
                recordsPerPage = Integer.parseInt(recordsPerPageParam);
            } catch (NumberFormatException e) {
                // Handle the case where the parameter cannot be parsed as an integer
                response.getWriter().write("Records per page selected not valid");
                return; // Exit the method as we cannot proceed with an invalid parameter
            }
        } else {
            recordsPerPage = (int) defaultRecords;
        }


        // Check if the page parameter is provided and not empty in the request

        // Calculate the starting index for fetching records based on the current page and recordsPerPage
        int start = (page - 1) * recordsPerPage;

        // Fetch the list of employees based on the calculated start index and recordsPerPage
        List<Employee> listEmployees = EmployeeDao.getEmployees(start, recordsPerPage);

        // Get the total count of employees for pagination
        long totalCount = EmployeeDao.getEmployeeCounts();

        // Calculate the total number of pages based on the total count and records per page
        int totalPages = (int) Math.ceil((double) totalCount / recordsPerPage);

        // Set attributes for JSP rendering
        request.setAttribute("listEmployees", listEmployees);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("count", totalCount);
        request.setAttribute("recordsPerPage", recordsPerPage); // Add recordsPerPage to attributes

        // Forward the request to the JSP page for rendering
        RequestDispatcher dispatcher = request.getRequestDispatcher("employee-list.jsp");
        dispatcher.forward(request, response);
    }

    private void searchEmployee(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        String searchKeyword = request.getParameter("searchKeyword");

        try {
            // Check if the search keyword is empty
            if (searchKeyword == null || searchKeyword.trim().isEmpty()) {
                // Set an attribute to indicate empty search
                request.setAttribute("emptySearchMessage", "Please enter a search keyword.");
            } else {
                // Perform the search and retrieve the search results
                List<Employee> searchResult = EmployeeDao.searchEmployees(searchKeyword);

                // Set the search results as a request attribute
                request.setAttribute("listEmployees", searchResult);
            }

            // Forward to the employee-list.jsp page
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


        Part file = request.getPart("pic");

        String imageFileName = file.getSubmittedFileName();  // get selected image file name
        System.out.println("Selected Image File Name : " + imageFileName);

        String uploadPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\images\\" + imageFileName;  // upload path where we have to upload our actual image
        System.out.println("Upload Path : " + uploadPath);

        // Uploading our selected image into the images folder

        try {

            FileOutputStream fos = new FileOutputStream(uploadPath);
            InputStream is = file.getInputStream();

            byte[] data = new byte[is.available()];
            is.read(data);
            fos.write(data);
            fos.close();


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
            EmployeeStatus empStatus = EmployeeStatus.valueOf(empStatusStr);
        Date createdBy = new Date();


            Employee employee = new Employee(imageFileName, employeeId, firstName, lastName, email, dob, location, phoneNo, gender,
                manager, project, job, salary, empStatus, createdBy);
        EmployeeDao.addEmployee(employee);
        System.out.println("successfully inserted");
        } catch (IOException e) {
            
            e.printStackTrace();
            
        }


        response.sendRedirect("list");
    }


    @SuppressWarnings("null")
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

                    Part file = request.getPart("pic");
                    if (file != null && file.getSize() != 0) {
                    String imageFileName = file.getSubmittedFileName();  // get selected image file name
                    System.out.println("Selected Image File Name : " + imageFileName);

                    String uploadPath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 8.5\\webapps\\images\\" + imageFileName;  // upload path where we have to upload our actual image
                    System.out.println("Upload Path : " + uploadPath);

                    // Uploading our selected image into the images folder


                    FileOutputStream fos = new FileOutputStream(uploadPath);
                    InputStream is = file.getInputStream();

                    byte[] data = new byte[is.available()];
                    is.read(data);
                    fos.write(data);
                    fos.close();


                    existingEmployee.setImageName(imageFileName);

                    } else {
                        existingEmployee.setImageName(existingEmployee.getImageName());
                    }
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

        String idParam = request.getParameter("id");


        int id = Integer.parseInt(idParam);
                EmployeeDao.deleteEmployee(id);
                response.sendRedirect("list");

    }

    private void deleteEmployees(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String idsParam = request.getParameter("ids");

        String[] idsArray = idsParam.split(",");
        List<Integer> ids = new ArrayList<>();
        for (String id : idsArray) {
            // Trim the ID string and remove leading and trailing whitespace
            id = id.trim();
            if (id.equals("on")) {
                continue;
            }
            ids.add(Integer.valueOf(id));
        }
        String deleteMessage = EmployeeDao.deleteEmployees(ids);

        // Set the message as an attribute in the request
        request.setAttribute("deleteMessage", deleteMessage);

        // Forward the request to the JSP page
        response.sendRedirect("list");
    }


    private void deleteAllEmployees(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, ParseException {
    String idsParam = request.getParameter("ids");
    String statusParam = request.getParameter("status");

    List<Integer> ids = new ArrayList<>();

     String[] idArray = idsParam.split(",");
        for (String idStr : idArray) {
            ids.add(Integer.valueOf(idStr));

        }

    EmployeeStatus status = EmployeeStatus.valueOf(statusParam);

    EmployeeDao.deleteAllEmployees(ids, status);

    RequestDispatcher dispatcher = request.getRequestDispatcher("/employees");
    dispatcher.forward(request, response);
 }

    private void login(HttpServletRequest request, HttpServletResponse response)
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


    private void filterEmployees(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException, ParseException {

        String[] jobFilters = request.getParameterValues("jobFilters");


        List<Employee> filteredEmployees = EmployeeDao.getFilteredEmployees(jobFilters);

        // Assuming you have a method to convert the list of employees to JSON format
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(new Gson().toJson(filteredEmployees));
    }

}
    
