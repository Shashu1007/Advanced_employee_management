  function resetForm() {
        document.getElementById("employeeForm").reset();
    }

    function saveOrUpdateEmployee() {
        document.getElementById("employeeForm").submit();
    }
$(document).ready(function(){
	
	$('[data-toggle="tooltip"]').tooltip();
	
	
	var checkbox = $('table tbody input[type="checkbox"]');
	$("#selectAll").click(function(){
		if(this.checked){
			checkbox.each(function(){
				this.checked = true;                        
			});
		} else{
			checkbox.each(function(){
				this.checked = false;                        
			});
		} 
	});
	checkbox.click(function(){
		if(!this.checked){
			$("#selectAll").prop("checked", false);
		}
	});
});

$(document).ready(function(){
    $('.delete').on('click', function(){
        var id = $(this).data('id');
        $('#deleteId').val(id);
    });
});
$(document).ready(function(){
    $('.update').on('click', function(){
        var id = $(this).data('id');
        $('#updateId').val(id);
    });
});
//$(document).ready(function(){
//    $('.pagin')
//}
$(document).ready(function(){
    $('.edit').on('click', function(){
        var id = $(this).data('id');
        $('#updateId').val(id);
    });
});
