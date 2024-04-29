<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<%
	
	//Variables
	String table = "user";
	String dbname = "cs336project";
	
	//Find inputs
	String bname = request.getParameter("bname");
	String baddress = request.getParameter("baddress");
	String btype = request.getParameter("btype");
	String user = (String) session.getAttribute("email");
	
	// Get session info
	String email = (String) session.getAttribute("email");
	String password =(String) session.getAttribute("password");
	String name =(String) session.getAttribute("name");
	String street =(String) session.getAttribute("street_address");
	String phone =(String) session.getAttribute("phone_number");
	int isSeller = 1;
	int isStaff = 0;
	
	if(bname.equals("") || baddress.equals("") || btype.equals("")){
		//Move this line to buyer.jsp to display the error message
		out.println("Name, street address, and phone number are required fields");
		
		response.sendRedirect("seller.jsp");
		return;
	}
	
	//Insert buyer info:
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();;
	Statement statement = con.createStatement();
	
	//TODO =====INSERTING===== \\ 
	String info = String.format("INSERT INTO %s VALUES ('%s', '%s', '%s', '%s', '%s', %d, %d)", table, name, street, phone, user, password, isSeller, isStaff);
	out.println(info);
	statement.executeUpdate(info);
	
	info = String.format("INSERT INTO %s VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')", "end_users", name, street, phone, user, password, bname, baddress, btype, name, null, null, null);
	out.println(info);
	statement.executeUpdate(info);
			
	con.close();
	response.sendRedirect("login.jsp");
	
%>