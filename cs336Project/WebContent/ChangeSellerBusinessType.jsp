<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newBType = request.getParameter("newBType");
		String currentBType = request.getParameter("currentBType");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String BType = "business_type";
		String schemaName = "user";
		String schemaName2 = "end_users";
		if(newBType.length()<1){
			newBType = currentBType;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName2, BType, newBType,email, currentUser);
		//String cmd2 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, BName, newBName,email, currentUser);
		statement.executeUpdate(cmd);
		//statement.executeUpdate(cmd2);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
