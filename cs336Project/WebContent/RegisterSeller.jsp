<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<%
	
	//Variables
	String table = "seller";
	String dbname = "cs336project";
	
	//Find inputs
	String bname = request.getParameter("bname");
	String baddress = request.getParameter("baddress");
	String btype = request.getParameter("btype");
	String user = (String) session.getAttribute("email");
	
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
	
	
	// Redirects
	int isStaff = (int) session.getAttribute("isStaff");
	
	if(isStaff == 1){
		response.sendRedirect("staff.jsp");
		return;
	}
	
	response.sendRedirect("login.jsp");
	
%>