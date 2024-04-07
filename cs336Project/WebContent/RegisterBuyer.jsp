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
	String user = (String) session.getAttribute("username");
	String pass = (String) session.getAttribute("password");
	String dbname = "cs336project";
	int isSeller = 1;  //Buyer
	int isStaff = 0;
	
	//out.print(dbname);
	// Connect to SQL server
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dbname,"root","Int3LEx$5");
	Statement statement = con.createStatement();
	ResultSet rs;
	
	if(name.equals("") || street.equals("") || phone.equals("")){
		//Move this line to buyer.jsp to display the error message
		out.println("Name, street address, and phone number are required fields");
		
		response.sendRedirect("buyer.jsp");
		return;
	}
	
	//Insert buyer info (Need to add isCustomer/isStaff later):
	String info = String.format("INSERT INTO %s VALUES ('%s', '%s', '%s', '%s', '%s', %d, %d)", table, name, street, phone, user, pass, isSeller, isStaff);
	out.println(info);
	statement.executeUpdate(info);
	response.sendRedirect("login.jsp");
%>