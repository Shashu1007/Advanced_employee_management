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

        reader.onload = function (e) {
            $('#pic-preview').attr('src', e.target.result);
        };

        reader.readAsDataURL(input.files[0]);
    }
}

$("#pic").change(function () {
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
    var checkboxes = document.querySelectorAll('tbody input[type="checkbox"]:not(#selectAll)');

    checkboxes.forEach(function (checkbox) {

        var id = checkbox.value;
        ids.push(id);

    });

    if (ids.length > 0) {
        var form = document.getElementById("myForm");
        var idsInput = document.createElement("input");
        idsInput.type = "hidden";
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

    // Submit the form
    document.getElementById('recordsPerPageForm').submit();

}


function handleDeleteEmployee(id) {
    $('#deleteId').val(id);
}

