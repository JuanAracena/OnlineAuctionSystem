<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.util.ArrayList" import="java.time.format.DateTimeFormatter" import="java.time.LocalDateTime" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Auction</title>

<style>
    .tag-input {
        margin-bottom: 2px; 
    }
</style>

</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<a href="mainpage.jsp"><button>Home</button></a>
	<form method = "POST" action = "RegisterAuction.jsp"> 
		
		<%
			String user = (String) session.getAttribute("user"); 
	
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();;
			Statement statement = con.createStatement();
		%>
		
		
		<%-- SELECT ITEM --%>
		<div id="items"> 
			<h3>Select Item</h3>
			<%
				String info = String.format("SELECT * FROM item WHERE email_address = '%s' and item_id not in (SELECT item_id FROM auction)", user);
				ResultSet rs = statement.executeQuery(info);
				
				int amount = 0;
				while(rs.next()){
					amount++;
					String item_name = rs.getString("item_name");
					String item_type = rs.getString("item_type");
					 
					int item_id = rs.getInt("item_id");
					
					%>
						
						<input type ="radio" name="item" id=<%out.print(item_id);%> value=<%out.print(item_id);%> class="tag-input" required/> <%out.print(item_type + ": " +item_name);%> <br/>
						
					<%
					
				}
				
				if(amount == 0){
					%> 
						You have no items registered! Go register an item to list it on auction! <br/>
					<%
					
				}
				%> <a href="registeritempage.jsp" >Click here to register an item.</a> <br/> <%
				
			%>
		
		</div>
		
		<%-- OTHER DETAILS --%>
		<div id = "Other Details">
			
			<h3>Auction Details</h3>
			Initial Price <br/>
			<input type ="number" name="initprice" id="initprice" required/> <br/>
			
			<br/>Bid Increment<br/>
			<input type ="number" name="bidinc" id="bidinc" required/> <br/>
			
			<br/>Minimum Sell Price<br/>
			<input type ="number" name="minprice" id="minprice" required/> <br/>
			 
			<%
			 	LocalDateTime now = LocalDateTime.now();
			 	LocalDateTime nowPlus7 = now.plusDays(7);
			 	LocalDateTime nowPlus21 = now.plusDays(21);
			 	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
		        String formattedDateTime = now.format(formatter);  
		        String formattedPlus7 = nowPlus7.format(formatter);
		        String formattedPlus21 = nowPlus21.format(formatter);
			%>
			 
			<br/>End Date<br/> 
			<input type="datetime-local" name="endauction" id="endauction" min="<%out.print(formattedDateTime);%>" 
				value="<%out.print(formattedPlus7);%>" max="<%out.print(formattedPlus21);%>" required/> <br/>

			
		</div> <br/> <br/> 
		 
		<input type="submit" name="submitauction" value = "Post Auction"/><br/>
 		
	
	</form>

</body>
</html>