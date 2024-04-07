<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<form method = "POST" action="RegisterBuyer.jsp">
		Enter Name: <input type="text" name="name"/><br/>
		Enter Street Address: <input type="street_address" name="street_address"/><br/>
		Enter Phone Number: <input type=phone_number name="phone_number"/><br/>
		<br>
		<input type="submit" value="Register"/>
	</form>

</body>
</html>