<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<% 

	//Variables Depending on Database 
	String dbname = "ebay";
	String usersdb = "users";
	String dbNameField = "username";
	String dbPassField = "password";
	
	// Find inputs
	String user = request.getParameter("username");
	String pass = request.getParameter("password");
	String verifiedpass = request.getParameter("verifiedpassword");
	
	if(pass.equals(verifiedpass) == false){
		out.println("Passwords don't match!");
		response.sendRedirect("register.jsp");
		return;
	}
	
	// Connect to SQL server
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,"root","MySQLRoot");
	Statement statement = con.createStatement();
	ResultSet rs;
	
	// See if user already exists
	String cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, user);
	rs = statement.executeQuery(cmd);
	
	if(rs.next()){
		out.println("Username taken.");
		response.sendRedirect("register.jsp");
		return;
	}
	
	// Create account
	cmd = String.format("INSERT INTO %s VALUES ('%s', '%s')", usersdb, user, pass);
	statement.executeUpdate(cmd);
	
	session.setAttribute("user", user);
	response.sendRedirect("mainpage.jsp");
	

%>