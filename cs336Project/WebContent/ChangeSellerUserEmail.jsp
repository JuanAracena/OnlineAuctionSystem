<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newEmail = request.getParameter("newEmail");
		String currentEmail = request.getParameter("currentEmail");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		//String name = "name";
		String schemaName = "user";
		String schemaName2 = "end_users";
		String schemaName3 = "transaction_report";
		if(newEmail.length()<1){
			newEmail = currentEmail;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd3 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName3, "end_user_email", newEmail,"end_user_email", currentUser);
		String cmd2 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName2, email, newEmail,email, currentUser);
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, email, newEmail,email, currentUser);
		statement.executeUpdate(cmd);
		statement.executeUpdate(cmd2);
		statement.executeUpdate(cmd3);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+newEmail);
	%>
