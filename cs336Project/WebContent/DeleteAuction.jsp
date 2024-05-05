<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

	<%
		out.println(request.getParameter("auctionID"));
		Integer targetId = Integer.parseInt(request.getParameter("auctionID"));
		String schemaName = "bid";
		String schemaName2 = "auction";
		String auctionID = "auction_id";
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		statement.executeUpdate("DELETE FROM autobid WHERE auction_id=" + targetId);
		String cmd = String.format("DELETE FROM %s WHERE %s = '%s'",schemaName,auctionID, targetId );
		statement.executeUpdate(cmd);
		String cmd2 = String.format("DELETE FROM %s WHERE %s = '%s'",schemaName2,auctionID, targetId );
		statement.executeUpdate(cmd2);
		
		response.sendRedirect("currentauctions.jsp");
	%>