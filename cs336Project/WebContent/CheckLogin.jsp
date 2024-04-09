<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
    
<%

	// Variables Depending on Database 
	String dbname = "cs336project";
	String usersdb = "user";
	String dbNameField = "email_address";
	String dbPassField = "password";
	
	// Find inputs
	String user = request.getParameter("username");
	String pass = request.getParameter("password");
	
	// Connect to SQL server
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	//Class.forName("com.mysql.jdbc.Driver");
	//Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,"root","MySQLRoot");
	Statement statement = con.createStatement();
	ResultSet rs;
	
	// Send SQL command
	String cmd = String.format("SELECT * from %s where %s='%s' and %s='%s'", usersdb, dbNameField, user, dbPassField, pass);
	rs = statement.executeQuery(cmd);
		
	// See if password matches
	if (rs.next()){
		session.setAttribute("user", user);
		out.println("Welcome "+user);
		if(rs.getBoolean("isStaff")){
			String staff_info = String.format("SELECT * from %s where %s='%s'", "staff", "email_address", user);
			rs = statement.executeQuery(staff_info);
			if(rs.next() && rs.getBoolean("isadmin")){
				con.close();
				response.sendRedirect("adminpage.jsp");
				return;
			}else{
				con.close();
				response.sendRedirect("reppage.jsp");
				return;
			}
		}
			con.close();
			response.sendRedirect("mainpage.jsp");
			return;
	}
	
	// See if user exists
	cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, user);
	rs = statement.executeQuery(cmd);
	
	if(rs.next()){
		out.println("Invalid Password");//create alert message
		con.close();
		response.sendRedirect("login.jsp");
	}else{
		con.close();
		out.println("Invalid Email");//create alert message
		response.sendRedirect("login.jsp");
	}

%>