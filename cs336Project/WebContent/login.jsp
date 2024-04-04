<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<form method = "POST" action="CheckLogin.jsp">
		Email: <input type="text" name="username"/><br/>
		Password: <input type="password" name="password"/><br/>
		<input type="submit" value="Login"/>
	</form>
	
	<a href="register.jsp">Register Here</a>

</body>
</html>