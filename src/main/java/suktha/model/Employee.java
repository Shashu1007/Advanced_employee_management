/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package suktha.model;

/**
 *
 * @author Shashank
 */
import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="employee")
public class Employee implements Serializable{
     
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="employee_id" )
	private int empid;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
        
        @Column(name="contact_number")
        private String phn_no;
	
	@Column(name="email")
	private String email;
	
	@Column(name="dob")
	private String dob;
	
	@Column(name="place")
	private String place;
	
	@Column(name="designation")
	private String designation;
	
	@Column(name="salary")
	private String salary;

    public Employee() {
    }


public Employee(String firstName, String lastName, String phn_no,String email,String dob,  String place,
        String designation, String salary) {
    super();
    	this.firstName = firstName;
        this.lastName = lastName;
        this.phn_no=phn_no;
        this.email = email;
	this.dob=dob;
        this.place = place;
	this.designation=designation;
	this.salary=salary;
}
    
    public int getEmpid() {
            return empid;
    }
    
    public void setEmpid(int empid) {
            this.empid = empid;
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

    public String getPhn_no() {
        return phn_no;
    }

    public void setPhn_no(String phn_no) {
        this.phn_no = phn_no;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }
        
        

    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getdob() {
        return dob;
    }

    public void setdob(String dob) {
        this.dob = dob;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
	this.place = place;
    }

	
    public String getDesignation() {
	return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
        
    public String getSalary() {
	return salary;
    }

    public void setSalary(String salary) {		
        this.salary = salary;
    }
 
}
