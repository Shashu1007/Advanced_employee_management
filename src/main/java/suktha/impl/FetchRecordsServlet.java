/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.impl;

/**
 *
 * @author Shashank
 */
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import suktha.dao.EmployeeDao;
import suktha.model.Employee;

@WebServlet("/FetchRecordsServlet")
public class FetchRecordsServlet extends HttpServlet {
    @Override
    @SuppressWarnings("null")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get selected filter values from request parameters
        String[] locations = request.getParameterValues("location-filter");
        String[] genders = request.getParameterValues("gender-filter");
        String[] managers = request.getParameterValues("manager-filter");
        String[] projects = request.getParameterValues("project-filter");
        String[] jobs = request.getParameterValues("job-filter");

        // Call method to fetch filtered records
        List<Employee> filteredEmployees = null;
        try {
            filteredEmployees = EmployeeDao.fetchRecords(locations, genders, managers, projects, jobs);
        } catch (SQLException | ParseException ex) {
            Logger.getLogger(FetchRecordsServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Set response content type
        response.setContentType("text/html");

        // Write filtered records as HTML table rows
        PrintWriter out = response.getWriter();
        for (Employee employee : filteredEmployees) {
            out.println("<tr>");
            // Output table cell values for each employee attribute
            out.println("<td>" + employee.getEmployeeId() + "</td>");
            out.println("<td>" + employee.getFirstName() + "</td>");
            // Repeat for other attributes as needed
            out.println("</tr>");
        }
        out.close();
    }
}
