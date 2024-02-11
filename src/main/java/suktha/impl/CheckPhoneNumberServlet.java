/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.impl;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import suktha.dao.EmployeeDao;

/**
 *
 * @author Shashank
 */
@WebServlet("/checkPhoneNumber")
public class CheckPhoneNumberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String phoneNumber = request.getParameter("phonenumber");
        EmployeeDao employeedao = new EmployeeDao();
       
        boolean phoneNumberExists = employeedao.checkPhoneNumberExists(phoneNumber);

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.valueOf(phoneNumberExists));
    }
}


