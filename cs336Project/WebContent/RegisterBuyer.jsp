<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<%
	//Variables
	String pname = "name";
	String pstreet = "street_address";
	String pphone = "phone_number";
	String table = "user";
	
	//Find inputs
	String name = request.getParameter("name");
	String street = request.getParameter("street_address");
	String phone = request.getParameter("phone_number");
	String user = (String) session.getAttribute("email");
	String pass = (String) session.getAttribute("password");
	String dbname = "cs336project";
	int isSeller = Integer.parseInt(request.getParameter("isSeller") != null ? request.getParameter("isSeller") : "0");
	int isStaff = Integer.parseInt(request.getParameter("isStaff") != null ? request.getParameter("isStaff") : "0");

	if(name.equals("") || street.equals("") || phone.equals("")){
		//Move this line to buyer.jsp to display the error message
		out.println("Name, street address, and phone number are required fields");
		
		response.sendRedirect("buyer.jsp");
		return;
	}
	
	//Insert buyer info:
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();;
	Statement statement = con.createStatement();
	
	String info = String.format("INSERT INTO %s VALUES ('%s', '%s', '%s', '%s', '%s', %d, %d)", table, name, street, phone, user, pass, isSeller, isStaff);
	out.println(info);
	statement.executeUpdate(info);
	con.close();
	
	// Redirects
	if(isSeller == 1 || isStaff == 1){
		session.setAttribute("name", name);
		session.setAttribute("street_address", street);
		session.setAttribute("phone_number", phone);
		session.setAttribute("isSeller", isSeller);
		session.setAttribute("isStaff", isStaff);
	}
	
	if(isSeller == 1){
		response.sendRedirect("seller.jsp");
		return;
	}
	
	if(isStaff == 1){
		response.sendRedirect("staff.jsp");
		return;
	}
	
	response.sendRedirect("login.jsp");
	
%>