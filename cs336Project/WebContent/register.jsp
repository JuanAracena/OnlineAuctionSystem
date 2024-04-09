<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<form method = "POST" action="RegisterVerify.jsp">
		Enter Email: <input type="text" name="email"/><br/>
		Enter Password: <input type="password" name="password"/><br/>
		Verify Password: <input type=password name="verifiedpassword"/><br/>

		<br>
		<input type="submit" value="Create Account"/>
	</form>

</body>
</html>