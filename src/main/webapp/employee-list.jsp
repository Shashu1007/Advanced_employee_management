
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

     .records-per-page {
         padding: 5px;
     }

     .records-per-page label {
         font-size: 13px;
         margin-right: 10px;
         margin-left: 10px;

     }

     .records-per-page select {
         padding: 5px 10px;
         font-size: 13px;
         border: 1px solid #ccc;
         border-radius: 4px;
         background-color: #fff;
         color: #333;
         cursor: pointer;
     }
</style>

<script>
    //   document.addEventListener('DOMContentLoaded', function () {
    //    // Define variables for pagination
    //    var currentPage = 1;
    //    var recordsPerPage = 5; // Default records per page
    //    var totalRecords = 53; // Total number of records
    //
    //    // Function to display records for the current page
    //    function displayRecords() {
    //        var start = (currentPage - 1) * recordsPerPage;
    //        var end = Math.min(start + recordsPerPage, totalRecords);
    //
    //        // Loop through table rows and show/hide based on current page
    //        var tableRows = document.querySelectorAll('#mytable tbody tr');
    //        for (var i = 0; i < tableRows.length; i++) {
    //            if (i >= start && i < end) {
    //                tableRows[i].style.display = 'table-row';
    //            } else {
    //                tableRows[i].style.display = 'none';
    //            }
    //        }
    //    }
    //
    //    // Function to update pagination UI
    //    function updatePaginationUI() {
    //        // Calculate total pages
    //        var totalPages = Math.ceil(totalRecords / recordsPerPage);
    //
    //        // Update pagination info
    //        var paginationInfo = document.querySelector('.hint-text');
    //        paginationInfo.innerHTML = `Showing <b>`+Math.min(totalRecords, (currentPage - 1) * recordsPerPage + 1)+`</b> to <b>`+ Math.min(totalRecords, currentPage * recordsPerPage)+`</b> of <b>`totalRecords`</b> entries`;
    //
    //        // Update pagination links
    //        var pagination = document.querySelector('.pagination');
    //        var paginationHTML = '';
    //        for (var i = 1; i <= totalPages; i++) {
    //          paginationHTML += '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">';
    //            paginationHTML += '<a class="page-link" href="#" onclick="changePage(' + i + ')">' + i + '</a>';
    //            paginationHTML += '</li>';
    //
    //        }
    //        pagination.innerHTML = paginationHTML;
    //    }
    //
    //    // Function to change page
    //    window.changePage = function(page) {
    //        currentPage = page;
    //        displayRecords();
    //        updatePaginationUI();
    //    };
    //
    //    // Initial display and pagination UI update
    //    displayRecords();
    //    updatePaginationUI();
    //});


    document.addEventListener('DOMContentLoaded', function () {
        // Add event listener to the table body to handle delete button clicks
        document.querySelector('table tbody').addEventListener('click', function (event) {
            // Check if the clicked element is a delete button
            if (event.target.classList.contains('delete')) {
                // Get the ID of the employee associated with the delete button
                var employeeId = event.target.getAttribute('data-id');
                // Call the handleDeleteEmployee function with the employee ID
                handleDeleteEmployee(employeeId);
            }
        });

        // Other code...
    });

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


    // JavaScript function to handle updating employee details
    function handleUpdateEmployee(employeeId) {
        // Fetch existing employee details and fill the update modal
        fillOldEmployeeDetails(employeeId);

        // Open the update modal
        $('#updateEmployeeModal').modal('show');
    }

    // sorting function
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
                    var imageNamee = data.imageName;
                    var image = document.getElementById('preview2');
                    console.log(imageNamee);

                    image.src = `/images/` + imageNamee;
                    
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


    //FILTER OPTION

    document.addEventListener('DOMContentLoaded', function () {
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

                xhr.onreadystatechange = function () {
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
            var selectAllCheckbox = document.getElementById('selectAll');
            if (selectAllCheckbox) {
                selectAllCheckbox.addEventListener('change', function () {
                    var checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
                    checkboxes.forEach(function (checkbox) {
                        checkbox.checked = selectAllCheckbox.checked;
                    });
                });
            }

            // Clear existing table rows
            tableBody.innerHTML = '';

            // Iterate over the received data and create table rows dynamically
            data.forEach(function (employee) {

                var row = document.createElement('tr');
                var dob = new Date(employee.dob);
                var formattedDob = dob.toISOString().split('T')[0];

                var imagename = employee.imageName;
                var id = employee.id;
                console.log(id);
                row.innerHTML = `
            <td>
                <span class="custom-checkbox">
                    <input type="checkbox" id="checkbox1" name="options[]" value=" ` + id + `">
                    <label for="checkbox1"></label>
                </span>
            </td>

            <td><img class="avatar" style="height: 50px; width: 50px;" src="/images/` + imagename + `" alt="img" </td>
            <td>` + employee.employeeId + `</td>
            <td>` + employee.firstName + `</td>
            <td>` + employee.lastName + `</td>
            <td>` + employee.email + `</td>
            <td>` + formattedDob + `</td>
            <td>` + employee.location + `</td>
            <td>` + employee.phoneNo + `</td>
            <td>` + employee.gender + `</td>
            <td>` + employee.manager + `</td>
            <td>` + employee.project + `</td>
            <td>` + employee.job + `</td>
            <td>` + employee.salary + `</td>
            <td>` + employee.empStatus + `</td>
            <td>
                <a href="#update" class="edit" data-toggle="modal" onclick="handleUpdateEmployee(` + id + `)">
                    <i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i>
                </a>
                <a href="#delete2" class="delete" data-toggle="modal" data-id="` + id + `" onclick="handleDeleteEmployee(` + id + `)">
                    <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                </a>
            </td>
        `;
                // Append the row to the table body
                tableBody.appendChild(row);
                hidePaginationAndRecordsPerPage()
    });
        }


    });


    document.addEventListener('DOMContentLoaded', function () {
        var deleteBtn = document.getElementById('deleteBtn');

        deleteBtn.addEventListener('click', function (event) {

            // Prevent the default action of the link
            event.preventDefault();

            // Check if any checkboxes are checked
            var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');

            if (checkboxes.length === 0) {
                $('#delete1').modal('hide');

                // No checkboxes are checked, show the modal with the message
                document.getElementById('deleteMessageText').innerText = "Please select employees to delete first";
                $('#deleteMessage').modal('show');
            } else {
                $('#delete1').modal('show');
            }
        });
    });

    function sendEmployeeIds() {
        var ids = [];
        var checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');

        checkboxes.forEach(function (checkbox) {
            var id = checkbox.value;
            ids.push(id);
        });

        if (ids.length > 0) {
            var form = document.getElementById("myForm");

            // Remove existing hidden input if any
            var existingInput = document.getElementById("idsInput");
            if (existingInput) {
                existingInput.remove();
            }

            // Create new hidden input
            var idsInput = document.createElement("input");
            idsInput.type = "hidden";
            idsInput.id = "idsInput";
            idsInput.name = "ids";
            idsInput.value = JSON.stringify(ids); // Convert array to JSON string
            form.appendChild(idsInput);
            form.submit();
        } else {
            // No checkboxes are checked
            alert("Please select at least one employee.");
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        var exportBtn = document.getElementById('exportBtn');

        exportBtn.addEventListener('click', function (event) {

            // Prevent the default action of the link
            event.preventDefault();

            // Check if any checkboxes are checked
            var rows = document.querySelectorAll('tbody tr');


            if (rows.length <= 1) {
                $('#downloadMessage').modal('hide');

                // No checkboxes are checked, show the modal with the message
            } else {
                document.getElementById('downloadMessageText').innerText = "Are you sure to download these records now?";
                $('#downloadMessage').modal('show');
            }
        });
    });
    // Add event listener to the "Yes" button
    document.addEventListener('DOMContentLoaded', function () {
        
    document.getElementById("exportyes").addEventListener("click", function () {
        sendEmployeeIds(); // Call sendEmployeeIds() to gather checkbox IDs before sending the request
        
        // Send HTTP request to servlet when button is clicked
        fetch('/export', {method: 'GET'})
            .then(response => {
                if (response.ok) {
                    // Display success message or perform any other actions
                    document.getElementById("downloadMessageText").innerText = "Data exported successfully.";
                } 
            })
            .catch(error => {
                console.error('Error:', error);
                // Display error message or perform any other actions
                document.getElementById("downloadMessageText").innerText = "Error occurred while exporting data.";
            });
    });
    });


    // Function to handle pagination and update records per page
    function changeRecordsPerPage() {
        var select = document.getElementById('recordsPerPageSelect');
        var selectedValue = select.value;
        console.log('Selected value:', selectedValue); // Debugging statement

        // Set the selected attribute for the appropriate option
        var options = select.options;
        for (var i = 0; i < options.length; i++) {
            if (options[i].value === selectedValue) {
                options[i].selected = true;
            } else {
                options[i].selected = false;
            }
        }

        // Update the hidden input field value
        document.getElementById('recordsPerPageInput').value = selectedValue;

        // Get the current page number from the URL
        var urlParams = new URLSearchParams(window.location.search);
        var currentPage = urlParams.get('page');

        // Update the URL parameters for next and previous page links
        var nextPageLink = document.querySelector('.pagination li.page-item:not(.disabled) a');
        var prevPageLink = document.querySelector('.pagination li.page-item.disabled a');

        if (nextPageLink !== null) {
            var nextUrl = nextPageLink.getAttribute('href');
            nextUrl = updateUrlParameter(nextUrl, 'recordsPerPage', selectedValue);
            nextPageLink.setAttribute('href', nextUrl);
        }

        if (prevPageLink !== null) {
            var prevUrl = prevPageLink.getAttribute('href');
            prevUrl = updateUrlParameter(prevUrl, 'recordsPerPage', selectedValue);
            prevPageLink.setAttribute('href', prevUrl);
        }

        // Submit the form
        document.getElementById('recordsPerPageForm').submit();
    }

    // Function to update URL parameter
    function updateUrlParameter(url, key, value) {
        var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
        var separator = url.indexOf('?') !== -1 ? "&" : "?";
        if (url.match(re)) {
            return url.replace(re, '$1' + key + "=" + value + '$2');
        } else {
            return url + separator + key + "=" + value;
        }
    }


    function handleDeleteEmployee(id) {
        $('#deleteId').val(id);
    }

    function hidePaginationAndRecordsPerPage() {
        var paginationDiv = document.querySelector('.clearfix');
        if (paginationDiv) {
            paginationDiv.style.display = 'none';
        }
    }

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
                                <button class="btn btn-danger" id="deleteBtn" data-toggle="modal"><i
                                        class="material-icons">&#xE15C;</i>
                                    <span>Delete</span></button>
                                <button type="submit" id="exportBtn" class="btn btn-success"><i class="material-icons">&#xE2C4;</i>Export
                                </button>

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
                                                    <select id="job-filter" name="job-filter" multiple>
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

            <table id="mytable" class="table table-striped table-responsive table-hover ">
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

                                    <td>
                                        <form action="display" method="post" enctype="multipart/form-data">
                                            <input type="hidden" value="${employee.id}" name="imagedisplayid">
                                            <img class="avatar" style="height: 50px; width: 50px;"
                                                 src="/images/${employee.imageName}" alt="img">
                                        </form>
                                    </td>

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


                                        <a href="#delete2" class="delete" data-toggle="modal" data-id="${employee.id}"
                                           onclick="handleDeleteEmployee(${employee.id})">
                                            <i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i>
                                        </a>

                                    </td>
                                </tr>
                            </c:forEach>
			</tbody>
			</table>
                    
     <div class="clearfix">
         <form id="recordsPerPageForm" method="get" action="records">
             <input type="hidden" name="recordsPerPage" id="recordsPerPageInput" value="${recordsPerPage}"/>
             <input type="hidden" name="page" id="recordsPerPageInput" value="${currentPage}"/>

             <div class="hint-text">
                 Showing <b>${listEmployees.size() + ((currentPage - 1) * (recordsPerPage))}</b> out of <b>${count}</b>
                 entries
    </div>
             <div class="records-per-page">
                 <label for="recordsPerPage">Records per page:</label>
                 <select id="recordsPerPageSelect" name="recordsPerPage" onchange="changeRecordsPerPage()">
                     <option id="5" value="5" ${recordsPerPage == 5 ? 'selected' : ''}>5</option>
                     <option id="25" value="25" ${recordsPerPage == 25 ? 'selected' : ''}>25</option>
                     <option id="50" value="50" ${recordsPerPage == 50 ? 'selected' : ''}>50</option>
                     <option id="100" value="100" ${recordsPerPage == 100 ? 'selected' : ''}>100</option>
                     <option id="all" value="${count}" ${recordsPerPage == count ? 'selected' : ''}>All</option>
                 </select>

             </div>
         </form>
         <ul class="pagination">
        <c:if test="${currentPage > 1}">
            <li class="page-item disabled"><a href="records?page=${currentPage - 1}&recordsPerPage=${recordsPerPage}">&laquo;
                Prev</a></li>
        </c:if>
             <c:forEach var="pageNumber" begin="1" end="${totalPages}">
                 <li class="page-item ${pageNumber == currentPage ? 'active' : ''}">
                     <a href="records?page=${pageNumber}&recordsPerPage=${recordsPerPage}">${pageNumber}</a>
                 </li>
             </c:forEach>
             <c:if test="${currentPage < totalPages}">
                 <li class="page-item">
                     <a href="records?page=${currentPage + 1}&recordsPerPage=${recordsPerPage}">Next &raquo;</a>
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
                                <input type="file" id="pic" name="pic" accept="image/*" onchange="previewImage(event)"
                                       class="form-control">
                                <img id="preview" alt="Preview Image">
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

    <div id="update" class="modal fade">
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
                                  <input type="file" id="pic" src="" name="pic" accept="image/*"
                                         onchange="previewImage2(event)"
                                         class="form-control">
                                  <img id="preview2"
                                       src=""
                                       alt="Preview Image">
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
                    <h4 class="modal-title">Delete Employees</h4>
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