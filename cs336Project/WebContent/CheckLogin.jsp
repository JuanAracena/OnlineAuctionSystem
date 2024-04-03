<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
    
<%

	// Variables Depending on Database 
	String dbname = "Ebay";
	String usersdb = "users";
	String dbNameField = "username";
	String dbPassField = "password";
	
	// Find inputs
	String user = request.getParameter("username");
	String pass = request.getParameter("password");
	
	// Connect to SQL server
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,"root","MySQLRoot");
	Statement statement = con.createStatement();
	ResultSet rs;
	
	// Send SQL command
	String cmd = String.format("SELECT * from %s where %s='%s' and %s='%s'", usersdb, dbNameField, user, dbPassField, pass);
	rs = statement.executeQuery(cmd);
	
	// See if password matches
	if (rs.next()){
		session.setAttribute("user", user);
		out.println("Welcome "+user);
		response.sendRedirect("mainpage.jsp");
		return;
	}
	
	// See if user exists
	cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, user);
	rs = statement.executeQuery(cmd);
	
	if(rs.next()){
		out.println("Invalid Password");
		response.sendRedirect("login.jsp");
	}else{
		response.sendRedirect("register.jsp");
	}

%>