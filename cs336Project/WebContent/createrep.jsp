<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Representative Account</title>
</head>
<body>
	<h1>Create Representative Account</h1>
		<a href="adminpage.jsp"><button>Back</button> </a>
	<form method = "POST" action="RegisterRepAccount.jsp">
		Enter Name: <input type="text" name="name"/>
		<br/>
		Enter Email: <input type="text" name="email"/>
		<br/>
		Enter Street Address: <input type="street_address" name="street_address"/>
		<br/>
		Enter Phone Number: <input type=phone_number name="phone_number"/>
		<br>
		Enter Password: <input type="password" name="password"/>
		<br/>
		Verify Password: <input type=password name="verifiedpassword"/>
		<br/>
		<input type="submit" value="Register"/>
	</form>
</body>
</html>