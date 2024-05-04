<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Main Page</title>
</head>
<body>
	<h1>Welcome, <%ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	ResultSet rs;
	String getName = String.format("SELECT name FROM user WHERE email_address='%s'", session.getAttribute("user"));
	rs = stmt.executeQuery(getName);	
	
	if(rs.next()){
		out.print(rs.getString("name"));

	}
	%>
	</h1>
	<a href="forums.jsp"><button>Profile</button></a><br><br>
	<a href="forums.jsp"><button>Buy</button></a>
	<a href="forums.jsp"><button>Sell</button></a>
	<a href="forums.jsp"><button>Get Help</button></a>
	<a href="LogOut.jsp"><button>Log out</button></a>
	<br><br>
	<% 	
	if(session.getAttribute("user") != null){
		out.println("You are logged in as " + session.getAttribute("user"));
	}else{
		out.println("You currently are not logged in.");
	}
	
	%>
</body>
</html>