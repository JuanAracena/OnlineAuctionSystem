<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
    
<%
	String dbname = "cs336project";
	String usersdb = "user";
	String repdb = "customer_representative";
	String staffdb = "staff";
	String dbNameField = "email_address";
	String dbPassField = "password";
	String rep_name = request.getParameter("name");
	String rep_user = request.getParameter("email");
	String rep_password = request.getParameter("password");
	String rep_address = request.getParameter("street_address");
	String rep_phone = request.getParameter("phone_number");
	String rep_verify_password = request.getParameter("verifiedpassword");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT * from %s where %s='%s'", usersdb, dbNameField, rep_user);
	rs = statement.executeQuery(cmd);
	
	//if user exists
	if(rs.next()){
		//set alert message: Email already exists
		response.sendRedirect("createrep.jsp");
		con.close();
		return;
	}else{
		String insert_user = String.format("INSERT INTO %s VALUES('%s','%s', '%s', '%s', '%s', '%d','%d')",usersdb, rep_name, rep_address, rep_phone, rep_user, rep_password,0,1);
		String insert_staff =  String.format("INSERT INTO %s VALUES('%s','%s', '%s', '%s', '%s', '%d','%d')",staffdb, rep_name, rep_address, rep_phone, rep_user, rep_password, 0, 1 );
		String insert_rep = String.format("INSERT INTO %s VALUES('%s','%s', '%s', '%s', '%s')",repdb, rep_name, rep_address, rep_phone, rep_user, rep_password );
		statement.executeUpdate(insert_user);
		statement.executeUpdate(insert_staff);
		statement.executeUpdate(insert_rep);
		con.close();
		//set alert message: Representative account created
		response.sendRedirect("adminpage.jsp");
		return;
	}
	
%>