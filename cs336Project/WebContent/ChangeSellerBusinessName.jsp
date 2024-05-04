<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newBName = request.getParameter("newBName");
		String currentBName = request.getParameter("currentBName");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String BName = "business_name";
		String schemaName = "user";
		String schemaName2 = "end_users";
		if(newBName.length()<1){
			newBName = currentBName;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName2, BName, newBName,email, currentUser);
		//String cmd2 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, BName, newBName,email, currentUser);
		statement.executeUpdate(cmd);
		//statement.executeUpdate(cmd2);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
