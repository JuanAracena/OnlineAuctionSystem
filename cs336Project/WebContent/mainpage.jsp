<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Main Page</title>
</head>
<body>
	<% 
	if(session.getAttribute("user") != null){
		out.println("You are logged in as " + session.getAttribute("user"));
	}else{
		out.println("You currently are not logged in.");
	}
	
	%>
</body>
</html>