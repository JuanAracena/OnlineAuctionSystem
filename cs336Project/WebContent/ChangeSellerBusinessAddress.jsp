<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("userEmail"));
		String newBAddr = request.getParameter("newBAddr");
		String currentBAddr = request.getParameter("currentBAddr");
		String currentUser = request.getParameter("userEmail");
		String email = "email_address";
		String BAddr = "business_address";
		String schemaName = "user";
		String schemaName2 = "end_users";
		if(newBAddr.length()<1){
			newBAddr = currentBAddr;
		}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName2, BAddr, newBAddr,email, currentUser);
		//String cmd2 = String.format("UPDATE %s SET %s = '%s' WHERE %s = '%s'", schemaName, BName, newBName,email, currentUser);
		statement.executeUpdate(cmd);
		//statement.executeUpdate(cmd2);
		statement.close();
		con.close();
		response.sendRedirect("edituser.jsp?customerNums="+currentUser);
	%>
