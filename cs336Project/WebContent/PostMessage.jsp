<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	Integer threadId = Integer.parseInt(request.getParameter("threadID"));
	String threadTitle = request.getParameter("threadTitle");
	String threadEmail = request.getParameter("threadEmail");
	String description = request.getParameter("message");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	ResultSet rs;
	Statement statement = con.createStatement();
	String cmd2 = String.format("SELECT MAX(message_id)maxId FROM messages");
	rs = statement.executeQuery(cmd2);
	if(rs.next()){
		Integer newMessageId = rs.getInt("maxId")+1;
		String cmd = String.format("INSERT INTO messages VALUES(%s, %s, '%s',NOW(), true);", threadId,newMessageId, description);
		statement.executeUpdate(cmd);
	}else{
		String cmd = String.format("INSERT INTO messages VALUES(%s,'%s', '%s',NOW(), true);", threadId,1, description);
		statement.executeUpdate(cmd);
	}
	rs.close();
	statement.close();
	con.close();
	response.sendRedirect("represpond.jsp?threadID="+threadId+"&threadTitle="+threadTitle+"&threadEmail="+threadEmail);
	
%>

