<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register User</title>
</head>
<body>
	<form method = "POST" action="RegisterBuyer.jsp">
		Enter Name: <input type="text" name="name"/><br/>
		Enter Street Address: <input type="street_address" name="street_address"/><br/>
		Enter Phone Number: <input type=phone_number name="phone_number"/><br/><br/>
		Are you going to sell products? <input type="checkbox" name="isSeller" value="1"/><br/>
		<br>
		<input type="submit" value="Continue"/>
	</form>

</body>
</html>