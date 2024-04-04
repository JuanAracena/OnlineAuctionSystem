<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%
	String dbname = "cs336project";
	String usersdb = "user";
	String dbNameField = "email_address";
	String dbPassField = "password";
	String usertype = request.getParameter("usertype");
	String user = request.getParameter("email");
	String password = request.getParameter("password");
	String verifyPassword = request.getParameter("verifiedpassword");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	//Create a SQL statement
	Statement stmt = con.createStatement();
	ResultSet rs;
	
	// Send SQL command
	String cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, user);
	rs = stmt.executeQuery(cmd);
	
	// See if user exists
	cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, user);
	rs = stmt.executeQuery(cmd);
	if(rs.next()){
		con.close();
		response.sendRedirect("register.jsp");
		return;
	}
	con.close();
	if(password.equals(verifyPassword)){
		session.setAttribute("email", user);
		session.setAttribute("password", password);
		if(usertype.equals("staff")){
			response.sendRedirect("staffregister.jsp");
			return;
		}
		response.sendRedirect("consumerregister.jsp");
	}else{
		out.println("Invalid Email");
		response.sendRedirect("register.jsp");
	}
%>