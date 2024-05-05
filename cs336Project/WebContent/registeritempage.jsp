<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Item</title>

<style>
    .tag-input {
        margin-bottom: 2px; 
    }
</style>

</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<form method = "POST" action = "RegisterItem.jsp"> 
		
		<%-- GENERAL INFORMATION --%>
		<h3> Enter Item Information </h3>
		Item Name: <br/> 
		<input type="text" name="ItemName" class="tag-input" required> <br/> <br/>
		
		Item Type: <br/>
		<input type ="radio" name="itemtype" id="PSU" value="PSU" class="tag-input" required/>Power Supply Unit (PSU) <br/>
		<input type ="radio" name="itemtype" id="MB" value="Motherboard" class="tag-input"/>Motherboard <br/>
		<input type ="radio" name="itemtype" id="CPU" value="CPU" class="tag-input"/>Central Processing Unit (CPU) <br/>
		<input type ="radio" name="itemtype" id="GPU" value="GPU" class="tag-input"/>Graphics Processing Unit (GPU) <br/>
		<input type ="radio" name="itemtype" id="HD" value="Hard Drive" class="tag-input"/>Hard Drive <br/>
		<input type ="radio" name="itemtype" id="RAM" value="RAM" class="tag-input"/>Random Access Memory (RAM) <br/>
		<input type ="radio" name="itemtype" id="MON" value="Monitor" class="tag-input"/>Monitor <br/> <br/>
		
		Item Description: <br/> <textarea name="Description" rows="4" cols="50"> </textarea>
				
				
		<%-- SPECIFIC INFORMATION --%>
		<div id = "ItemInfo">
		
		
		</div>
		
		<script type = "text/javascript">
		
			$(document).ready(function(){
				
				function update(){
					var html = '<br/><h3> Enter Specs </h3>'
					if( $('#PSU').is(':checked') ){
					    html += 'Watts: <input type="text" name="Watts" class="tag-input" required><br/>';
					    html += 'Efficiency: <input type="Efficiency" name="Efficiency" class="tag-input" required><br/>';
					    html += 'Size: <input type="text" name="Size" class="tag-input" required><br/>';
					}else if( $('#MB').is(':checked') ) {
						html += 'RAM Slots: <input type="text" name="RAM Slots" class="tag-input" required><br/>';
					    html += 'Chipset: <input type="Efficiency" name="Chipset" class="tag-input" required><br/>';
					    html += 'Amount Storage Connectors: <input type="text" name="Amount Storage Connectors" class="tag-input" required><br/>';
					}else if( $('#CPU').is(':checked') ) {
						html += 'Number of Cores: <input type="text" name="Number of Cores" class="tag-input" required><br/>';
					    html += 'Socket: <input type="Efficiency" name="Socket" class="tag-input" required><br/>';
					    html += 'Product Line: <input type="text" name="Product Line" class="tag-input" required><br/>';
					}else if( $('#GPU').is(':checked') ) {
						html += 'Video Memory (VRAM): <input type="text" name="Video Memory" class="tag-input" required><br/>';
					}else if( $('#HD').is(':checked') ) {
						html += 'Storage Capacity: <input type="text" name="Storage Capacity" class="tag-input" required><br/>';
					}else if( $('#RAM').is(':checked') ) {
						html += 'Storage Capacity: <input type="text" name="Storage Capacity" class="tag-input" required><br/>';
					    html += 'Clock Frequency: <input type="Efficiency" name="Clock Frequency" class="tag-input" required><br/>';
					    html += 'Stick Type: <input type="text" name="Stick Type" class="tag-input" required><br/>';
					}else if( $('#MON').is(':checked') ) {
						html += 'Resolution: <input type="text" name="Resolution" class="tag-input" required><br/>';
					    html += 'Refresh Rate: <input type="Efficiency" name="Refresh Rate" class="tag-input" required><br/>';
					    html += 'Size: <input type="text" name="Size" class="tag-input" required><br/>';
					}else{
						html += "Select a computer part from above to reveal spec information!"
					}
					
					$("#ItemInfo").html(html)
				}
				
				$("input:radio[name=itemtype]").click(update)
				update()
			})
		
		</script>
		
				
		<%-- TAGS --%>
		<br/>
		<h3> Enter Tags </h3>
		<div id = "Tags">
		
			Enter Tags:<br/>
			<input type="text" name="Tag" class = "tag-input"/><br/>
			
		</div>
		<input type="button" id = "AddTagButton" name="AddTagButton" value = "Add Tag"/><br/>
		
		<script type = "text/javascript">
		
			$(document).ready(function(){
				$('#AddTagButton').click(function(){	
					$('#Tags').append('<input type="text" name="Tag" class = "tag-input"/><br/>')						
				})	
			})
		
		</script>
		
		<br/><br/>
		<input type="submit" name="submit" value = "Submit"/><br/>
	
	</form>
	

</body>
</html>