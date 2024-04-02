<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body>
	<form method = "POST" action="CreateAccount.jsp">
		Enter Username: <input type="text" name="username"/><br/>
		Enter Password: <input type="password" name="password"/><br/>
		Verify Password: <input type=password name="verifiedpassword"/><br/>
		<input type="submit" value="Create Account"/>
	</form>

</body>
</html>