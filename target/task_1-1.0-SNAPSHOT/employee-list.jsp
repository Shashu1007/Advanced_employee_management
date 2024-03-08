
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="suktha.dao.EmployeeDao" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Employee Profile Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

    
<style>
     .filter {
        margin-left: 70%;
        
    }

    #sorting,
    #res {
        font-size: 12px;
        margin-top: 2%
    }
.container-xl {
    min-width: 100%;
    margin-right: auto; 
    margin-left: auto;
   
}

body {
	color: #2196F3;
	background: #f5f5f5;
	font-family: 'Varela Round', sans-serif;
	font-size: 15px;
}
.table-responsive {
    min-width: 100%;
    margin-right: auto;
    margin-left: auto;
    
    
    
    
}
.table-wrapper {
	background: #fff;
	padding: 10px ;
	border-radius: 3px;
    min-width: 100%;
    margin-right: auto;
    margin-left: auto;
	
	box-shadow: 0 1px 1px rgba(0,0,0,.05);

}
.table-title {        

	background: #2196F3;
	color: #fff;
	padding: 10px 10px;
    min-width: 100%;
    
	
	border-radius: 3px 3px 0 0;
}
.table-title h2 {
	margin: 10px;
	font-size: 24px;
    min-width: 100%;
    
}
.table-title .btn-group {
	float: right;
        margin: 15px;

}
.table-title .btn {
	color: #fff;
	float: right;
	font-size: 13px;
	border: none;
	min-width: 50px;
	border-radius: 15%;

	outline: none !important;
    margin-right: 10px;
	
}
.table-title .btn i {
	float: left;
	font-size: 15px;
	
}
.table-title .btn span {
	float: left;
	
}
table.table tr th, table.table tr td {
	border-color: #e9e9e9;
	padding: 5px 5px;
	vertical-align: middle;
    min-width: 100%;
    
}
table.table tr th:first-child {

	width: 30px;
}
table.table tr th:last-child {
	width: 100px;
}
table.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fcfcfc;
        width: inherit;
    min-width: 100%;
    margin-right: auto;
    margin-left: auto;}
table.table-striped.table-hover tbody tr:hover {
    width: inherit;
	background: #f5f5f5;
    min-width: 100%;
    margin-right: auto;
    margin-left: auto;}
table.table th i {
	font-size: 20px;
	margin: auto; 
	cursor: pointer;
}	
table.table td:last-child i {
	opacity: 0.9;
	font-size: 20px;
	margin: 0 10px;
}
table.table td a {
	font-weight: bold;
	color: #566787;
	display: inline-block;
	text-decoration: none;
	outline: none !important;
}
table.table td a:hover {
	color: #2196F3;
}
table.table td a.edit {
	color: #FFC107;
}
table.table td a.delete {
	color: #F44336;
}
table.table td i {
	font-size: 20px;
}
table.table .avatar {
	border-radius: 50%;
	vertical-align: middle;
	margin-right: 05px;
    min-width: 100%;
    margin-right: auto;
    margin-left: auto;
}
    
    
.form-exp{
    
    margin:15px;
}

.pagination {
	float: right;
	margin: 0 0 5px;
        text-decoration: #000;
}.pagination li a {
    border: #000;
    font-size: 13px;
    min-width: 20px;
    min-height: 20px;
    margin: 0 2px;
    line-height: 20px;
    border-radius: 90px !important;
    text-align: center;
    padding: 0 6px;
    color: darkcyan;
    text-decoration: none;
}
.pagination li a:hover {
	color: #666;
}	
.pagination li.active a, .pagination li a:hover {
    background-color: #2196F3;
    color:  #fff;
}

.pagination li.active a:hover {        
	background: #0397d6;
        color:  #fff;
        
}
.pagination li.disabled i {
    color: #666;
}
.pagination li i {
    background: #0397d6;
    font-size: 13px;
    padding-top: 6px;
    color: #000;
}
.hint-text {
	float: left;
	margin-top: 10px;
	font-size: 13px;
}    

.custom-checkbox {
	position: relative;
}
.custom-checkbox input[type="checkbox"] {    
	opacity: 0;
	position: absolute;
	margin: 5px 0 0 3px;
	z-index: 9;
}
.custom-checkbox label:before{
	width: 18px;
	height: 18px;
}
.custom-checkbox label:before {
	content: '';
	margin-right: 10px;
	display: inline-block;
	vertical-align: text-top;
	background: white;
	border: 1px solid #bbb;
	border-radius: 2px;
	box-sizing: border-box;
	z-index: 2;
}
.custom-checkbox input[type="checkbox"]:checked + label:after {
	content: '';
	position: absolute;
	left: 6px;
	top: 3px;
	width: 6px;
	height: 11px;
	border: solid #000;
	border-width: 0 3px 3px 0;
	transform: rotateZ(45deg);
	z-index: 3;
	transform: rotateZ(45deg);
}
.custom-checkbox input[type="checkbox"]:checked + label:before {
	border-color: #03A9F4;
	background: #03A9F4;
}
.custom-checkbox input[type="checkbox"]:checked + label:after {
	border-color: #fff;
}
.custom-checkbox input[type="checkbox"]:disabled + label:before {
	color: #b8b8b8;
	cursor: auto;
	box-shadow: none;
	background: #ddd;
}



.modal-header{
        background-color:  #2196F3;
        color: #fcfcfc;     
}
.close{
    color: #fff;
}

.modal .modal-content {
	border-radius: 3px;
	font-size: 14px;
        color: #000;
}
.modal .modal-footer {
	background:  #2196F3;
	border-radius: 0 0 3px 3px;
        
}
.modal .modal-title {
	display: inline-block;
        
}
.modal .form-control {
	border-radius: 2px;
	box-shadow:none ;
	border-color: #dddddd;
}

	
	
        
.modal form label {
	font-weight: normal;
        .table-scrollable {
    display: block;
    
    
    width: 100%;
  }
  
}	
.slider {
  -webkit-appearance: none;
  width: 100%;
  height: 15px;
  border-radius: 5px;  
  background: #d3d3d3;
  outline: none;
  opacity: 0.7;
  -webkit-transition: .2s;
  transition: opacity .2s;
}

.slider::-webkit-slider-thumb {
  -webkit-appearance: none;
  appearance: none;
  width: 25px;
  height: 25px;
  border-radius: 50%; 
  background: #04AA6D;
  cursor: pointer;
}
.btn-primary{
    margin: 2px;
}

.filter-tabler{
    border: none;
}

.slider::-moz-range-thumb {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  background: #04AA6D;
  cursor: pointer;
}
.col-sm-6{

}
.selects{
    margin-right: 60px;
}
#job-filter {
    display: none;
         }


.avatar {
    border-radius: 50%;
    vertical-align: middle;
    margin-right: 10px;
   
}
.avatar:hover{
 transform: scale(2.5);
 border-radius: 50%; 
 
}
#preview {
         width: 100px;
         height: 100px;
         border-radius: 50%;
}
#preview2 {
         width: 100px;
         height: 100px;
         border-radius: 50%;
}

</style>
<script>
  function previewImage(event) {
  var input = event.target;
  var image = document.getElementById('preview');
  if (input.files && input.files[0]) {
    image.src = URL.createObjectURL(input.files[0]);
  }
}
 function previewImage2(event) {
  var input = event.target;
  var image = document.getElementById('preview2');
  if (input.files && input.files[0]) {
    image.src = URL.createObjectURL(input.files[0]);
  }
}

    $(document).ready(function () {

        $('[data-toggle="tooltip"]').tooltip();


        var checkbox = $('table tbody input[type="checkbox"]');
        $("#selectAll").click(function () {
            if (this.checked) {
                checkbox.each(function () {
                    this.checked = true;
                });
            } else {
                checkbox.each(function () {
                    this.checked = false;
                });
            }
        });
        checkbox.click(function () {
            if (!this.checked) {
                $("#selectAll").prop("checked", false);
            }
        });
    });
    $(document).ready(function () {
        $('#deleteForm').submit(function (e) {
            e.preventDefault();
            var ids = [];
            $('input[type=checkbox]:checked').each(function () {
                ids.push($(this).val());
            });
            $('#deleteIds').val(ids.join(','));
            $(this).unbind('submit').submit();
        });
    });



    $(document).ready(function () {
        $('.delete').on('click', function () {
            var id = $(this).data('id');
            $('#deleteId').val(id);
        });
    });

//    //$(document).ready(function(){
//    //    $('.pagin')
//    //}
//

// JavaScript function to handle updating employee details
function handleUpdateEmployee(employeeId) {
    // Fetch existing employee details and fill the update modal
    fillOldEmployeeDetails(employeeId);
    
    // Open the update modal
    $('#updateEmployeeModal').modal('show');
}

    // sorting function😒
    function sortTable(n) {
        var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
        table = document.getElementById("table");
        switching = true;
        // Set the sorting direction to ascending:
        dir = "asc";
        /* Make a loop that will continue until
        no switching has been done: */
        while (switching) {
            // Start by saying: no switching is done:
            switching = false;
            rows = table.rows;
            /* Loop through all table rows (except the
            first, which contains table headers): */
            for (i = 1; i < (rows.length - 1); i++) {
                // Start by saying there should be no switching:
                shouldSwitch = false;
                /* Get the two elements you want to compare,
                one from current row and one from the next: */
                x = rows[i].getElementsByTagName("td")[n];
                y = rows[i + 1].getElementsByTagName("td")[n];
                /* Check if the two rows should switch place,
                based on the direction, asc or desc: */
                if (dir === "asc") {
                    if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                        // If so, mark as a switch and break the loop:
                        shouldSwitch = true;
                        break;
                    }
                } else if (dir === "desc") {
                    if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                        // If so, mark as a switch and break the loop:
                        shouldSwitch = true;
                        break;
                    }
                }
            }
            if (shouldSwitch) {
                /* If a switch has been marked, make the switch
                and mark that a switch has been done: */
                rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                switching = true;
                // Each time a switch is done, increase this count by 1:
                switchcount++;
            } else {
                /* If no switching has been done AND the direction is "asc",
                set the direction to "desc" and run the while loop again. */
                if (switchcount === 0 && dir === "asc") {
                    dir = "desc";
                    switching = true;
                }
            }
        }
    }

    $(document).ready(function () {
        $('th[data-sortable="true"]').click(function () {
            var table = $(this).parents('table').eq(0);
            var rows = table.find('tr:gt(0)').toArray().sort(compare($(this).index()));

            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        function compare(index) {
            return function (a, b) {
                var valA = getCellValue(a, index);
                var valB = getCellValue(b, index);
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            };
        }

        function getCellValue(row, index) {
            return $(row).children('td').eq(index).text();
        }
    });

    $(document).ready(function () {
        $('.toggle-button').click(function () {
            var select = $(this).siblings('select');
            select.toggle();
        });
    });
    
    
    
        // JavaScript function to handle updating employee data
    // JavaScript function to handle updating employee data
        function fillOldEmployeeDetails(employeeId) {
            // Set the employee ID in the hidden input field of the update modal
            document.getElementById('updateEmployeeId').value = employeeId;

            // Fetch existing employee details and populate the form fields
            fetchEmployeeDetails(employeeId);
        }

        // JavaScript function to fetch existing employee details and populate the update modal
        function fetchEmployeeDetails(employeeId) {
            // AJAX request to fetch employee details
            fetch('getEmployeeDetails?id=' + employeeId)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Network response was not ok');
                    }
                    return response.json();
                })
                .then(data => {
                    // Populate form fields in the update modal with the retrieved employee details
//                    document.getElementById('pic').value = data.filePath;
                    document.getElementById('firstName').value = data.firstName;
                    document.getElementById('lastName').value = data.lastName;
                    document.getElementById('email').value = data.email;
                    // Parse the date string received from the server
                    const date = new Date(data.dob);
                    // Format the date in the desired format (YYYY-MM-DD)
                    const formattedDate = date.toISOString().split('T')[0];
                    // Set the formatted date as the value of the "dob" input field
                    document.getElementById('dob').value = formattedDate;
                    document.getElementById('location').value = data.location;
                    document.getElementById('phoneNo').value = data.phoneNo;
                    // Assuming data.gender contains the gender value from JSON (e.g., "Male" or "Female")
                    document.getElementById('manager').value = data.manager;
                    document.getElementById('job').value = data.job;
                    document.getElementById('salary').value = data.salary;
                    document.getElementById('project').value = data.project;
                    var gender = data.gender;
// Check the appropriate radio button based on the gender value
                    if (gender === "Male") {
                    document.getElementById("male").checked = true;
                    } else if (gender === "Female") {
                    document.getElementById("female").checked = true;
                    }
                     console.log(data.empStatus);
                     
                    var empStatus = data.empStatus;
                    var empStatusSelect = document.getElementById('empStatus');

// Loop through each option in the select element

                    for (var i = 0; i < empStatusSelect.options.length; i++) {
                    var option = empStatusSelect.options[i];
    
    // Check if the option value matches the employee status
                    if (option.value === empStatus) {
        // Set the selected attribute for the matching option
                    option.selected = true;
        // Exit the loop since we found the matching option
                    break;
    }
}
   
                })
                .catch(error => console.error('Error fetching employee details:', error));
        }

   function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();

    reader.onload = function(e) {
      $('#pic-preview').attr('src', e.target.result);
    };

    reader.readAsDataURL(input.files[0]);
  }
}

$("#pic").change(function() {
  readURL(this);
});


document.addEventListener('DOMContentLoaded', function() {
    var jobFilter = document.getElementById('job-filter');

    // Check if the jobFilter element exists
    if (jobFilter) {
        // Add change event listener to jobFilter
        jobFilter.addEventListener('change', sendFilterValues);
    }
    
    // Ajax Function to send filter values to the servlet
    function sendFilterValues() {
        var selectedValues = getSelectedValues(jobFilter);
        
        if (selectedValues.length > 0) {
            var xhr = new XMLHttpRequest();
            var url = 'filter?jobFilters=' + encodeURIComponent(selectedValues.join(','));
            
            xhr.open('GET', url, true);
            
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 200) {
                        // Handle successful response from servlet
                        var responseData = JSON.parse(xhr.responseText);
                        

                        
                        // Populate table with received data
                        populateTable(responseData);
                    } else {
                        // Handle error response from servlet
                        console.error('Error fetching data:', xhr.statusText);
                    }
                }
            };
            xhr.send();
        }
    }
    
    // Function to get selected values from a select element
    function getSelectedValues(selectElement) {
        var selectedValues = [];
        if (selectElement) {
            for (var i = 0; i < selectElement.options.length; i++) {
                if (selectElement.options[i].selected) {
                    selectedValues.push(selectElement.options[i].value);
                }
            }
        }
        return selectedValues;
    }

    // Function to populate the table with data
   function populateTable(data) {
    // Get a reference to the table body
    var tableBody = document.querySelector('table tbody');
    
    // Clear existing table rows
    tableBody.innerHTML = '';
    
    // Iterate over the received data and create table rows dynamically
    data.forEach(function (employee) {
       
        var row = document.createElement('tr');
        var dob = new Date(employee.dob);
        var formattedDob = dob.toISOString().split('T')[0];
        console.log(employee.id);

        row.innerHTML = `
            <td>
                <span class="custom-checkbox">
                    <input type="checkbox" id="checkbox1" name="options[]" value=" ` + employee.id + `">
                    <label for="checkbox1"></label>
                </span>
            </td>
            <td><img class="avatar" style="height: 50px; width: 50px;" src="data:image/png;base64,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" alt="img"></td>
            <td>` + employee.employeeId + `</td>
            <td>` + employee.firstName +`</td>
            <td>` + employee.lastName +`</td>
            <td>` + employee.email + `</td>
            <td>` + formattedDob + `</td>
            <td>` + employee.location +`</td>
            <td>` + employee.phoneNo + `</td>
            <td>` + employee.gender + `</td>
            <td>` + employee.manager + `</td>
            <td>` + employee.project + `</td>
            <td>` + employee.job + `</td>
            <td>` + employee.salary + `</td>
            <td>` + employee.empStatus + `</td>
            <td>
                <a href="#update" class="edit" data-toggle="modal" onclick="handleUpdateEmployee(` + employee.id + `)">
                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                </a>
                <a href="#delete2" class="delete" data-toggle="modal" data-id="` + employee.id + `">
                    <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                </a>
            </td>
        `;
        // Append the row to the table body
        tableBody.appendChild(row);
    });
}


});



document.addEventListener('DOMContentLoaded', function() {
    var deleteBtn = document.getElementById('deleteBtn');

    deleteBtn.addEventListener('click', function(event) {

        // Prevent the default action of the link
        event.preventDefault();
        
        // Check if any checkboxes are checked
        var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');

        if (checkboxes.length === 0) {
            $('#delete1').modal('hide');
        
            // No checkboxes are checked, show the modal with the message
            document.getElementById('deleteMessageText').innerText = "Please select employees to delete first";
            $('#deleteMessage').modal('show');
        }
            
        else {
             $('#delete1').modal('show');
        }
    });
});

document.addEventListener('DOMContentLoaded', function() {
    var exportBtn = document.getElementById('exportBtn');

    exportBtn.addEventListener('click', function(event) {

        // Prevent the default action of the link
        event.preventDefault();
        
        // Check if any checkboxes are checked
        var rows = document.querySelectorAll('tbody tr');
        

        if (rows.length <= 1) {
            $('#downloadMessage').modal('hide');
        
            // No checkboxes are checked, show the modal with the message
        }
            
        else {
            document.getElementById('downloadMessageText').innerText = "Are you sure to download these records now?";
            $('#downloadMessage').modal('show');
        }
    });
});
//
//
//function sendEmployeeIds() {
//    var ids = [];
//    var rows = document.querySelectorAll('table tbody tr');
//
//    rows.forEach(function(row) {
//        var idCell = row.cells[2]; // Assuming the ID is in the third column (index 2)
//        var id = idCell.textContent.trim();
//        ids.push(id);
//    });
//
//    document.getElementById("ids").value = ids.join(",");
//    document.getElementById("myForm").submit();
//}
//

//   document.getElementById('searchForm').addEventListener('submit', function(event) {
//        var searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();
//        if (!searchKeyword) {
//            event.preventDefault(); // Prevent form submission
//            document.getElementById('deleteMessageText').innerText = "Please enter a search keyword.";
//            $('#deleteMessage').modal('show');
//        }
//    });


// Add event listener to the "Yes" button
        document.getElementById("exportyes").addEventListener("click", function() {
            // Send HTTP request to servlet when button is clicked
            fetch('/TableDataExport', { method: 'GET' })
                .then(response => {
                    if (response.ok) {
                        // Display success message or perform any other actions
                        document.getElementById("downloadMessageText").innerText = "Data exported successfully.";
                    } else {
                        // Display error message or perform any other actions
                        document.getElementById("downloadMessageText").innerText = "Failed to export data.";
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    // Display error message or perform any other actions
                    document.getElementById("downloadMessageText").innerText = "Error occurred while exporting data.";
                });
        });

</script>



</head>
<body>
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-6">
                        <h2><b><a href="list" style="color: #fff">Manage Employees</a></b></h2>
                    </div>
                    <div class="col-sm-6">
                        <div align="right">
                            
                            <div class="btn-group">
                                <a href="#new" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i>
                                    <span>Add</span></a>
                                <button  class="btn btn-danger"  id="deleteBtn" data-toggle="modal"><i class="material-icons">&#xE15C;</i>
                                    <span>Delete</span></button>
                                    <button type="submit" id="exportBtn" class="btn btn-success"><i class="material-icons">&#xE2C4;</i>Export</button>
                                                     
                            </div>
                        </div>
                        <div class="form-exp">
         <form action="search" method="get" class="form-inline" id="searchForm">
    <input type="text" name="searchKeyword" data-toggle="tooltip"
           title=" Search by Name,ID,email,phone_no,location" class="form-control"
           placeholder="Search by Name,ID,email,phone_no">
    <button type="submit" class="btn btn-success" id="searchButton">
        <i class="material-icons">&#xE8B6;</i>Search
    </button>
</form>
                        </div>

                    </div>
				</div>
                            
                            <div class="row">
                                <div class="col-sm-6"> 

                                    <table class="filter-table">
                                        <thead>
                                            <tr class="filters">

                                                    
                                                    <div class="selects">
                                                        <button class="toggle-button">Job&#9660;</button>
                                                    <select id="job-filter"  name="job-filter" multiple>
                                                        <c:forEach var="job" items="${EmployeeDao.getAllJobs()}">
                                                            <option value="${job}">${job}</option>
                                                        </c:forEach>
                                                    </select>
                                                                    
                                                    </div>
                                                </th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>

                    <table id="mytable" class="table table-striped table-responsive table-hover " >
                        <thead>
                            <tr>
                               <th>
    <span class="custom-checkbox">
        <input type="checkbox" class="select-checkbox" id="selectAll">
        <label for="selectAll"></label>
    </span>
                                <th>Pic</th>
                                <th data-sortable="true" >#ID</th>
                                <th data-sortable="true" >First Name</th>
                                <th data-sortable="true" >Last Name</th>
                                <th data-sortable="true" >Email</th>
                                <th data-sortable="true" >DoB</th>
                                <th data-sortable="true" >City</th>
                                <th data-sortable="true" >Phone</th>
                                <th data-sortable="true" >Gender</th>    
                                <th data-sortable="true" >Manager</th>
                                <th data-sortable="true" >Project</th>
                                <th data-sortable="true" >Job</th>
                                <th data-sortable="true" >Salary</th>
                                <th data-sortable="true" >Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody >
                            
                            <c:forEach var="employee" items="${listEmployees}">
                                <tr>
                                    <td>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="checkbox1" name="options[]" value="${employee.id}">
                                            <label for="checkbox1"></label>
                                        </span>
                                    </td>
                                    <td><img class="avatar" style="height: 50px; width: 50px;" src="data:image/jpeg;base64,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ZfGNX3h2XfMdfdVo4MpdWcv9NQx+StRmxe0zXwz7cXP2mtb+Z9JV83EVNbISykjyT34IGfftOK7eHbFJNV/SanOrOWtP1s/ePh5DuV9QWSnoHZZGAfvHtO+Z6KxXO/IrETGOO/eZ7u2Lh2taLZpj07RHaHKiXG3RXOAMlZqaHBwGSMOHQ5CloqjSV0dkpo7e+AQt5bzlzSM6jt2iTuTsN/IeCQ2SmhoXwiJvLeSXtPa1Hbck7k7DfyCsUQVsNkpoKR0QiAY5wc4EklzhjBLicnGB8gu+W3QzGXVG081oZJncOaM4BHufmpaIKyrsNLWCPXFnlt0MwXN0t27OxG2w+S4rLDS1rWCSIO0N0NyXZ0fcJz2m+RyrREFbW2Klr5Q6SFriAG+GWg5DSBs5o8DkKTXUMVwpyyVgc3IOD4joQeoI8QpKIK9tlpm24wcppiOSWHcE5zqJO5Od89VxT2WmpqOSJsQDJARINyXgjSdTjudttyrFEFZTWKlpqaSNsQ0SDD2kue1w32w4nxXbbbXBa2OEUYbqOXHJLiQMDLjuVORBDNshNA6DQOW/XqZ3HmEuf8ySfdddys9PdC3mxhxbnSd2uAPUagQcHwVgiCILfC1kQEbQIjmIAYDDpLNgP2SR7rqfZqZ9PIwxN0yP5jxjYv27fk7YbjvCsEQRaC3xW6DREwNbkk9SST1cSdyfMrhS0QEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERB//9k=" alt="img"></td>
                                    <td>${employee.employeeId}</td>
                                    <td>${employee.firstName}</td>
                                    <td>${employee.lastName}</td>
                                    <td>${employee.email}</td>
                                    <td>${employee.dob}</td>
                                    <td>${employee.location}</td>
                                    <td>${employee.phoneNo}</td>
                                    <td>${employee.gender}</td>
                                    <td>${employee.manager}</td>
                                    <td>${employee.project}</td>
                                    <td>${employee.job}</td>
                                    <td>${employee.salary}</td>
                                    <td>${employee.empStatus}</td>
                                    <td>

                                            <a href="#update" class="edit" data-toggle="modal" onclick="handleUpdateEmployee(${employee.id})">
                                                <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                                            </a>


                                        <a href="#delete2" class="delete" data-toggle="modal" data-id="${employee.id}"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                    </td>
                                </tr>
                            </c:forEach>
			</tbody>
			</table>
                    
     <div class="clearfix">
    <div class="hint-text">
        Showing <b>${listEmployees.size()+((currentPage -1)*5)}</b> out of <b>${count}</b> entries
    </div>
    <ul class="pagination">
        <c:if test="${currentPage > 1}">
            <li class="page-item disabled"><a href="list?page=${currentPage - 1}">&laquo; Prev</a></li>
        </c:if>
        <c:forEach var="pageNumber" begin="1" end="${totalPages}">
            <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                <a href="list?page=${pageNumber}">${pageNumber}</a>
            </li>
        </c:forEach>
        <c:if test="${currentPage < totalPages}">
            <li class="page-item">  
                <a href="list?page=${currentPage + 1}">Next &raquo;</a>
            </li>
        </c:if>
    </ul>
     </div>
        </div>
	</div>        
<div id="new" class="modal fade">
    <div class="modal-dialog modal-lg"> 
        <div class="modal-content">
            <form action="insert" method="post" enctype="multipart/form-data" >
                <div class="modal-header">						
                    <h4 class="modal-title">Add Employee</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                        <!--Left column -->

                        <div class="form-group">
                            <label>Employee Pic*</label>
                            <input type="file" id="pic" name="pic"  onchange="previewImage(event)" class="form-control" >
                            <img id="preview" alt="Preview Image"  >
                        </div>  
                            <div class="form-group">
                                <label>First Name *</label>
                                <input type="text" name="firstName" class="form-control"  required>

                            </div>
                            <div class="form-group">
                                <label>Last Name *</label>
                                <input type="text" name="lastName" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>E-mail *</label>
                                <input type="email" name="email" class="form-control" pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" required>
                            </div>
                            <div class="form-group">
                                <label>Date Of Birth *</label>
                                <input type="date" name="dob" max="2006-02-12" min="1964-02-12" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>City *</label>
                                <input type="text" class="form-control" name="location" required>
                            </div>
                            
                        </div>
                        <div class="col-md-6"><!--
                            <-- Right column -->
                             <div class="form-group">
                                <label>Phone No. *</label>
                                <input type="tel" pattern="[5-9]{1}[0-9]{9}" name="phoneNo" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Gender *</label>
                                <br>
                                <input type="radio" id="gender" name="gender" value="male">
                                <label for="male">Male</label>
                                &nbsp;&nbsp;
                                <input type="radio" id="gender" name="gender" value="female">
                                <label for="female">Female</label>
                            </div>
                            <div class="form-group">
                                <label>Manager</label>
                                <input type="text" name="manager" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>Project</label>
                                <input type="text" name="project" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>Job *</label>
                                <input type="text" class="form-control" name="job" required>
                            </div>
                            <div class="form-group">
                                <label>Salary *</label>
                                <input type="text" class="form-control" name="salary" required>
                            </div>
                            <div class="form-group">
                                <label for="empStatus">Employee Status:</label><br>
                                <select id="empStatus" name="empStatus" class="form-control">
                                    <option value="ACTIVE">Active</option>
                                    <option value="DEPARTED">Departed</option>
                                    <option value="RETIRED">Retired</option>
                                    <option value="AWOL">AWOL</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                       <button type="reset" class="btn btn-danger" data-dismiss="modal">Clear</button>
                    <button type="submit" class="btn btn-success">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
    
<div id="update" class="modal fade" >     
    <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <form id="updateEmployeeForm" action="update" method="post" enctype="multipart/form-data">
                    <div class="modal-header">
                        <h4 class="modal-title">Update Employee</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="updateEmployeeId" name="id" >

                        <div class="row">
                            <div class="col-md-6">
                              <div class="form-group">
                                <label>Employee Pic *</label>
                                 <input type="file" id="pic" name="pic"   onchange="previewImage2(event)" class="form-control" >
                                 <img id="preview2" src="data:image/jpeg;base64,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ZfGNX3h2XfMdfdVo4MpdWcv9NQx+StRmxe0zXwz7cXP2mtb+Z9JV83EVNbISykjyT34IGfftOK7eHbFJNV/SanOrOWtP1s/ePh5DuV9QWSnoHZZGAfvHtO+Z6KxXO/IrETGOO/eZ7u2Lh2taLZpj07RHaHKiXG3RXOAMlZqaHBwGSMOHQ5CloqjSV0dkpo7e+AQt5bzlzSM6jt2iTuTsN/IeCQ2SmhoXwiJvLeSXtPa1Hbck7k7DfyCsUQVsNkpoKR0QiAY5wc4EklzhjBLicnGB8gu+W3QzGXVG081oZJncOaM4BHufmpaIKyrsNLWCPXFnlt0MwXN0t27OxG2w+S4rLDS1rWCSIO0N0NyXZ0fcJz2m+RyrREFbW2Klr5Q6SFriAG+GWg5DSBs5o8DkKTXUMVwpyyVgc3IOD4joQeoI8QpKIK9tlpm24wcppiOSWHcE5zqJO5Od89VxT2WmpqOSJsQDJARINyXgjSdTjudttyrFEFZTWKlpqaSNsQ0SDD2kue1w32w4nxXbbbXBa2OEUYbqOXHJLiQMDLjuVORBDNshNA6DQOW/XqZ3HmEuf8ySfdddys9PdC3mxhxbnSd2uAPUagQcHwVgiCILfC1kQEbQIjmIAYDDpLNgP2SR7rqfZqZ9PIwxN0yP5jxjYv27fk7YbjvCsEQRaC3xW6DREwNbkk9SST1cSdyfMrhS0QEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERB//9k=" alt="Preview Image"  >
                              </div>
                                <div class="form-group">
                        <label>First Name</label>
                        <input type="text" name="firstName" id="firstName" class="form-control"  required><br>
                                </div>
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" name="lastName" id="lastName" class="form-control"><br>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" id="email"  class="form-control"><br>
                    </div>
                    <div class="form-group">
                        <label>Date of Birth</label>
                        <input type="date" name="dob" id="dob" class="form-control"><br>
                    </div>
                    <div class="form-group">
                        <label>City</label>
                        <input type="text" name="location" id="location" class="form-control"><br>
                    </div>
                   
                            </div>
                    <div class="col-md-6">
                        <div class="form-group">
                             
                        <label>Phone No.</label>
                        <input type="tel" pattern="[5-9]{1}[0-9]{9}" id="phoneNo"  name="phoneNo" class="form-control"><br>
                    </div>
                        <div class="form-group">
                            <label>Gender</label><br>
                            <input type="radio" id="male" name="gender" value="Male">
                            <label for="male">Male</label>
                            &nbsp;              &nbsp;
                            <input type="radio" id="female" name="gender" value="Female">
                            <label for="female">Female</label><br>
                        </div>
                    <div class="form-group">
                        <label>Manager</label>
                        <input type="text" name="manager" id="manager" class="form-control"><br>
                    </div>
                    <div class="form-group">
                        <label>Project</label>
                        <input type="text" name="project" id="project" class="form-control"><br>
                    </div>
                    <div class="form-group">
                        <label>Job</label>
                        <input type="text" name="job" id="job" class="form-control" required><br>
                    </div>
                    <div class="form-group">
                        <label>Salary</label>
                        <input type="text" name="salary" id="salary" class="form-control" required><br>
                    </div>
                    <div class="form-group">
                        <label>Employee Status</label><br>
                <select id="empStatus" name="empStatus" class="form-control">
                    <option value="ACTIVE">Active</option>
                    <option value="DEPARTED">Departed</option>
                    <option value="RETIRED">Retired</option>
                    <option value="AWOL">AWOL</option>
                </select><br>

                    </div>
                        </div>
                        </div>
                    </div>
                        <div class="modal-footer">
                            <button type="reset" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-success">Update</button>
                        </div>
            </form>
        </div>
    </div>
    </div>

<div id="delete1" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="deleteForm" action="deleteEmployees" method="post">
                <input type="hidden" id="deleteIds" name="ids">
                <div class="modal-header">						
                    <h4 class="modal-title">Delete Employee</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p>Are you sure you want to delete the selected records?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="delete2" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="delete" action="delete" method="post">
                <input type="hidden" id="deleteId" name="id">
                <div class="modal-header">						
                    <h4 class="modal-title">Delete Employee</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p>Are you sure you want to delete this record?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-danger">Delete</button>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
    
    <div id="downloadMessage" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
                        <form class="export" id="myForm" action="export" method="get" enctype="multipart/form-data">

                <div class="modal-header">						
                    <h4 class="modal-title">Export Employees</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">					
                    <p id="downloadMessageText"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" data-dismiss="modal">No</button>
                    <button id="exportyes" type="submit" class="btn btn-success">Yes</button>
                 
                </div>
                        </form>
        </div>
    </div>
</div>


<div id="deleteMessage" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">						
                <h4 class="modal-title">Message</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">					
                <p id="deleteMessageText"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
     
    
    <% if (request.getAttribute("emptySearchMessage") != null) { %>
    <script>
        // Set the text of the deleteMessageText element inside the modal
        document.getElementById('deleteMessageText').innerText = '<%= request.getAttribute("emptySearchMessage") %>';
        
        // Display the modal
        $('#deleteMessage').modal('show');
    </script>
<% } %>


</body>
</html>