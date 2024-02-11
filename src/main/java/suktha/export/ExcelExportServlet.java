package suktha.export;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import suktha.dao.EmployeeDao;
import suktha.model.Employee;

@WebServlet("/export")
public class ExcelExportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=employees.xlsx");

        List<Employee> employees = EmployeeDao.getEmployees();

        try ( 
                XSSFWorkbook workbook = new XSSFWorkbook()) {
            org.apache.poi.ss.usermodel.Sheet sheet = workbook.createSheet("Employees");
            
  
            Row headerRow = sheet.createRow(0);
            String[] headers = {"Employee ID", "First Name", "Last Name", "E-mail", "Date of Birth", "Place", "Designation", "Salary"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }
            
          
            int rowNum = 1;
            for (Employee employee : employees) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(employee.getEmpid());
                row.createCell(1).setCellValue(employee.getFirstName());
                row.createCell(2).setCellValue(employee.getLastName());
                row.createCell(3).setCellValue(employee.getEmail());
                row.createCell(4).setCellValue(employee.getdob());
                row.createCell(5).setCellValue(employee.getPlace());
                row.createCell(6).setCellValue(employee.getDesignation());
                row.createCell(7).setCellValue(employee.getSalary());
            }
          workbook.write(response.getOutputStream());
        }
    }
}
