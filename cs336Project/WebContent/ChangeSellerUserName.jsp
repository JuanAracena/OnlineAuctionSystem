<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newName = request.getParameter("newName");
		String currentName = request.getParameter("currentName");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String name = "name";
		String schemaName = "user";
		String schemaName2 = "end_users";
		if(newName.length()<1){
			newName = currentName;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName2, name, newName,email, currentUser);
		String cmd2 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, name, newName,email, currentUser);
		statement.executeUpdate(cmd);
		statement.executeUpdate(cmd2);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
