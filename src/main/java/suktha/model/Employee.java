/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.model;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;




@Entity
@Table(name = "employee")
public class Employee implements Serializable {
    private static int employeeCounter = 1;

    @Column(name = "image")
    private String imagePath ;  
    
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "employeeId", unique = true, length = 150)
    private String employeeId;

    @Column(name = "first_name", nullable = false, length = 225)
    private String firstName;

    @Column(name = "last_name", length = 225)
    private String lastName;

    @Column(name = "e_mail", nullable = false, length = 225)
    private String email;

    @Column(name = "dob")
    @Temporal(TemporalType.DATE)
    private Date dob;

    @Column(name = "location", nullable = false, length = 500)
    private String location;

    @Column(name = "Phone_no", nullable = false, length = 10)
    private String phoneNo;

    @Column(name = "gender")
    private String gender;
    
    
 

    @Column(name = "manager", length = 225)
    private String manager;

    @Column(name = "project", length = 225)
    private String project;

    @Column(name = "job", length = 200)
    private String job;

    @Column(name = "salary")
    private String salary;

    @Enumerated(EnumType.STRING)
    @Column(name = "empStatus" )
    private EmployeeStatus empStatus = EmployeeStatus.ACTIVE;

    @Column(name = "created_on", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdBy;

    @Column(name = "updated_on")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedBy;
    
    //getters and setters

    public static int getEmployeeCounter() {
        return employeeCounter;
    }

    public static void setEmployeeCounter(int employeeCounter) {
        Employee.employeeCounter = employeeCounter;
    }

    public String  getImagePath() {
        return imagePath;
    }

    public void setImagepath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    
    
    public int getId() {
        return id;
    }



    public String getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }



    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getManager() {
        return manager;
    }

    public void setManager(String manager) {
        this.manager = manager;
    }

    public String getProject() {
        return project;
    }

    public void setProject(String project) {
        this.project = project;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
    }

    public EmployeeStatus getEmpStatus() {
        return empStatus;
    }

    public void setEmpStatus(EmployeeStatus empStatus) {
        this.empStatus = empStatus;
    }

    public Date getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(Date createdBy) {
        this.createdBy = createdBy;
    }

    public Date getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(Date updatedBy) {
        this.updatedBy = updatedBy;
    }


    public Employee() {
        this.employeeId = generateEmployeeId();
        this.createdBy = new Date();
    }

    public Employee(String imagePath,String employeeId, String firstName, String lastName, String email, Date dob, String location,
                    String phoneNo, String gender, String manager, String project, String job, String salary,
                    EmployeeStatus empStatus, Date createdBy) {
        super();
        this.imagePath = imagePath;
        this.employeeId = employeeId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.dob = dob;
        this.location = location;
        this.phoneNo = phoneNo;
        this.gender = gender;
        this.manager = manager;
        this.project = project;
        this.job = job;
        this.salary = salary;
        this.empStatus = empStatus;
        this.createdBy = createdBy;

    }


    @PreUpdate
    protected void onUpdate() {
        this.updatedBy = new Date();
    }


    public static String generateEmployeeId() {
        String prefix = "SUKTH";
        String paddedCounter = String.format("%04d", employeeCounter++);
        return prefix + paddedCounter;
    }


    public enum EmployeeStatus {
        ACTIVE,
        DEPARTED,
        DELETED,
        RETIRED,
        AWOL
    }
   public interface ApplicationCanstant {
	String FILE_LOCATION = "C:\\Program Files\\Java\\server\\Tomcat_9v";
	String TEMP_FILE_LOCATION = "C:\\Program Files\\Java\\server\\Tomcat_9v\\images";
	

    
}
}

