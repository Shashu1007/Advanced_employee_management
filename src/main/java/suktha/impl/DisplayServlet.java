/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package suktha.impl;

import suktha.dao.EmployeeDao;
import suktha.model.Employee;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Shashank
 */
@WebServlet(name = "DisplayServlet", urlPatterns = {"/display"})
public class DisplayServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {

            // Parse the ID parameter to an integer
            int id = Integer.parseInt(idParam);

            // Retrieve employee details by ID
            Employee existingEmployee = EmployeeDao.getEmployeeById(id);
            String imageName = existingEmployee.getImageName();


            RequestDispatcher rd;
            request.setAttribute("imageName", imageName);
            rd = request.getRequestDispatcher("employee-list.jsp");
            rd.forward(request, response);


        }

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
