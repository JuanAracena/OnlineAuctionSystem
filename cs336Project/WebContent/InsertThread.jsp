<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%
	
	//Find inputs:
	String title = request.getParameter("title");
	String descr = request.getParameter("description");
	
	//Get session info:
	String email = (String) session.getAttribute("user");
	
	
	
	//Insert thread info:
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	ResultSet rs2;
	
	String info = String.format("INSERT INTO threads(title, email) VALUES ('%s', '%s')", title, email);
	out.println(info);
	statement.executeUpdate(info);
	
	
	//Insert message info:
	String getThreadId = String.format("SELECT MAX(%s) as max_id FROM %s LIMIT 1", "thread_id", "threads");
	rs = statement.executeQuery(getThreadId);
	int thread_id = 0;
	if(rs.next()){
		thread_id = rs.getInt("max_id");
	}
	
	String getMessageId = String.format("SELECT IFNULL( (SELECT MAX(%s) FROM %s LIMIT 1), -1) as max_id", "message_id", "messages");
	rs2 = statement.executeQuery(getMessageId);
	
	int message_id = -1;
	if(rs2.next()){
		message_id = rs2.getInt("max_id");
	}
	
	rs = statement.executeQuery("SELECT * FROM customer_representative where email_address = '" + email+"'");
	int isrep = 0;
	if(rs.next()) isrep = 1;
	
	
	if(message_id == -1){
		message_id = 1;
	}
	else{
		message_id += 1;
	}
	
	
	info = String.format("INSERT INTO %s VALUES ('%d', '%d', '%s', NOW(), %d)", "messages", thread_id, message_id, descr, isrep);
	statement.executeUpdate(info);
	
	con.close();
	response.sendRedirect("forums.jsp");
	

%>

