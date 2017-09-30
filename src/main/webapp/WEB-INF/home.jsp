<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function() {
		var editProductId = ''
		$('#productForm').submit(function(result) {
			var myForm = $('#productForm')
			var data = {}
			//prevent's form from submitting
			result.preventDefault();
			
			for(let val of $(this).serializeArray()) {
				data[val.name] = val.value
			}
			$.ajax({
				contentType: 'application/json; charset=utf-8',
				type: myForm.attr('method'),
				url: myForm.attr('action'),
				dataType : 'json',
	            data : JSON.stringify(data),
	            success : function(newProduct){
	            		var content = '<tr id="' + newProduct.id +  '"><td>' + newProduct.name + '</td>' + '<td>' + newProduct.description  + '</td>'
	            						+ '<td>' + newProduct.price + '</td>' + '<td>' + newProduct.id + '</td>' + '<td><a href="#" id="' + newProduct.id +  '">Delete</a></td>' + '</tr>'
	            		$('#table').append(content)
	            		$('#productForm').trigger('reset')
	            },
	            error : function(){
	            	console.log('^^^^^')
	            }
			})	
		})
	
	$("table").on("click", "a", function(element) {
		var productId =  element.target.id
		$('#' + element.target.id).remove()	
		$.get('delete?id=' + productId, function(data, status){
	        console.log(status)
	    });
	
		})
		
	$('button').click(function() {
		$.get('find?id=' + $('#edit').val(), function(data, status) {
			$('#editName').val(data.name)
			$('#editDescription').val(data.description)
			$('#editPrice').val(data.price)
			editProductId = data.id
		})
	})	

	$('#productForm2').submit(function(element) {
		var myForm = $('#productForm2')
		var data = {}
		element.preventDefault();
		for(let val of $(this).serializeArray()) {
			data[val.name] = val.value
		}
		data["id"] = editProductId
		
		$.ajax({
				contentType: 'application/json; charset=utf-8',
				type: myForm.attr('method'),
				url: myForm.attr('action'),
				dataType : 'json',
	            data : JSON.stringify(data),
	            success : function(changedProduct){
		            	var content = '<tr id="' + editProductId +  '"><td>' + data.name + '</td>' + '<td>' + data.description  + '</td>'
		        		+ '<td>' + data.price + '</td>' + '<td>' + data.id + '</td>' + '<td><a href="#" id="' + editProductId +  '">Delete</a></td>' + '</tr>'
		        		$('table #' + editProductId).replaceWith(content)
		        		$('#productForm2').trigger('reset')
	            },
	            error : function(){
	            	console.log('^^^^^')
	            }
			})
		
	})
	
	})

</script>
<style>
	table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
	
</style>
</head>
<body>
	<table id="table">
		<tr>
			<td>Name</td>
			<td>Description</td>
			<td> Price</td>
			<td> Id</td>
			<td> Action </td>
		<tr>
	</table>
	New Product <form action="new" method="post" id="productForm">
		Name: <input type="text" name="name"/>
		Description: <input type="text" name="description"/>
		Price: <input type="text" name="price"/>
		<input type="submit" value="Submit"/>
	</form>
	
	<div>
		Enter Product id: <input type="text" name="id" id="edit"/>
		<button>Find Product</button>
	</div>
	
	Edit <form action="update" method="post" id="productForm2">
		Name: <input type="text" name="name" id="editName"/>
		Description: <input type="text" name="description" id="editDescription"/>
		Price: <input type="text" name="price" id="editPrice"/>
		<input type="submit" value="Submit"/>
	</form>

</body>
</html>