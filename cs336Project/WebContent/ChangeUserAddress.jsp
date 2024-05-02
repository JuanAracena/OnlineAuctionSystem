<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newAddress = request.getParameter("newAddress");
		String currentAddress = request.getParameter("currentAddress");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String address = "street_address";
		String schemaName = "user";
		if(newAddress.length()<1){
			newAddress = currentAddress;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, address, newAddress,email, currentUser);
		statement.executeUpdate(cmd);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
