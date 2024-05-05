<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>

    <%
    
    	ApplicationDB db = new ApplicationDB();
    	Connection con =  db.getConnection();
    	Statement statement = con.createStatement();
    	ResultSet rs;
    	String email = (String) session.getAttribute("user");

    	
    	//Getting info:
    	String thId = (String) session.getAttribute("ThId");
    	int realThId = Integer.valueOf(thId);
    	String descr = request.getParameter("comment");
    	
    	String getMessageId = String.format("SELECT IFNULL( (SELECT MAX(%s) FROM %s LIMIT 1), -1) as max_id", "message_id", "messages");
    	rs = statement.executeQuery(getMessageId);
    	
    	int message_id = -99;
    	if(rs.next()){
    		message_id = rs.getInt("max_id");
    	}
    	
    	
    	if(message_id == -1){
    		message_id = 1;
    	}
    	else{
    		message_id += 1;
    	}
    	
    	rs = statement.executeQuery("SELECT * FROM customer_representative where email_address = '" + email+"'");
    	int isrep = 0;
    	if(rs.next()) isrep = 1;
    	
    	String info = String.format("INSERT INTO messages VALUES(%d, %d, '%s', NOW(), %d)", realThId, message_id, descr, isrep);
    	statement.executeUpdate(info);
    	
    	con.close();
    	response.sendRedirect("viewThread.jsp?threadId=" + thId);
    
    %>