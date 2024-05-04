<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newPhone = request.getParameter("newPhone");
		String currentPhone = request.getParameter("currentPhone");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String phone = "phone_number";
		String schemaName = "user";
		if(newPhone.length()<1){
			newPhone = currentPhone;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, phone, newPhone,email, currentUser);
		statement.executeUpdate(cmd);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
