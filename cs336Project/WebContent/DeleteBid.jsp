<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%		
		//out.println(request.getParameter("auctionID"));
		Float targetBid = Float.parseFloat(request.getParameter("targetbid"));
		String auctionId = request.getParameter("auctionID");
		String auction = "auction_id";
		String schemaName = "bid";
		String bidAmount = "bid";
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		String cmd = String.format("DELETE FROM %s WHERE %s = '%s' AND %s = '%s'",schemaName,bidAmount, targetBid, auction, auctionId );
		statement.executeUpdate(cmd);
		statement.close();
		con.close();
		response.sendRedirect("showbids.jsp?auctionID="+auctionId);
		return;
	%>