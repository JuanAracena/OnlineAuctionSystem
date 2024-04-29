<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	String targetEmail = request.getParameter("customerNums");
	String schemaName = "user";
	String schemaName2 = "end_users";
	String targetParameter = "email_address";
	String isSeller = "isSeller";
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT * FROM %s WHERE %s = '%s'", schemaName, targetParameter, targetEmail);
	rs = statement.executeQuery(cmd);
	if(rs.next()&& !rs.getBoolean(isSeller)){
		out.println(rs.getString(targetParameter));
		String cmd2 = String.format("DELETE FROM %s WHERE %s = '%s'",schemaName,targetParameter, targetEmail );
		statement.executeUpdate(cmd2);
	}else{
		out.println(rs.getString(targetParameter));
		String cmd2 = String.format("DELETE FROM %s WHERE %s = '%s'",schemaName2,targetParameter, targetEmail );
		statement.executeUpdate(cmd2);
		String cmd3 = String.format("DELETE FROM %s WHERE %s = '%s'",schemaName,targetParameter, targetEmail );
		statement.executeUpdate(cmd3);
	}
	rs.close();
	statement.close();
	con.close();
	response.sendRedirect("editaccounts.jsp");
	return;
%>