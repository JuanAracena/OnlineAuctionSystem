<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Thread</title>
</head>
<body>
	<form method= "POST" action="InsertThread.jsp">
	<p>Title:</p>
		 <input type="text" name="title" required/><br/>
	<p>Comment: </p>
		<textarea rows="5" cols="50" name="description" required></textarea><br/>
	<p></p>
	<input type="submit" value="Submit"/></form>
</body>
</html>