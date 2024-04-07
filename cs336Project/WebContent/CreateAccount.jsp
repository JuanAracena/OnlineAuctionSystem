<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<% 

	//Variables Depending on Database 
	String dbname = "cs336project";
	String usersdb = "user";
	String dbNameField = "email_address";
	String dbPassField = "password";
	
	// Find inputs
	String user = request.getParameter("email");
	String pass = request.getParameter("password");
	String verifiedpass = request.getParameter("verifiedpassword");
	String getConsumer = request.getParameter("usertype");
	

	//See if user typed an email or password
		if(user.equals("") || pass.equals("")){
			out.println("Email and password are required fields.");
			response.sendRedirect("register.jsp");
			return;
		}
		
	
	
	
	if(pass.equals(verifiedpass) == false){
		out.println("Passwords don't match!");
		response.sendRedirect("register.jsp");
		return;
	}
	
	// Connect to SQL server
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,"root","Int3LEx$5");
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
	
	
	//If the user doesn't select the type of account
	if(getConsumer == null){
		//Move this line to register.jsp to display the error message
		out.println("Select \"Register as Staff\" or \"Register as Consumer\" before proceeding.");
		
		response.sendRedirect("register.jsp");
		return;
	}
	
	//If the user doesn't exist and you are registering as a consumer
	if(!rs.next() && getConsumer.equals("consumer")){
		
		//Pass email and password to buyer.jsp
		session.setAttribute("username", user);
		session.setAttribute("password", pass);
		
		response.sendRedirect("buyer.jsp");
		return;
	}
	
	// Create account
	//cmd = String.format("INSERT INTO %s VALUES ('%s', '%s')", usersdb, user, pass);
	//statement.executeUpdate(cmd);
	
	//session.setAttribute("user", user);
	//response.sendRedirect("mainpage.jsp");
	

%>