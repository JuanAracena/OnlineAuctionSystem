<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Current Bids</title>
</head>
<body>
<%
	String schemaName = "bid";
	String bidId = "bid";
	String auctionId = "auction_id";
	String email = "email_address";
	Integer targetId = Integer.parseInt(request.getParameter("auctionID"));
	ArrayList<String>bider_email = new ArrayList<String>();
	ArrayList<Float>bid_amount = new ArrayList<Float>();
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT * FROM %s WHERE %s='%s'", schemaName,auctionId,targetId);
	rs = statement.executeQuery(cmd);
	while(rs.next()){
		bider_email.add(rs.getString(email));
		bid_amount.add(rs.getFloat(bidId));
	}
%>
	<a href="currentbids.jsp"><button>Back</button> </a>
	<h1>Current Bids</h1>
	<%
		for(int i = 0; i < bider_email.size(); i++){
			out.println("BUYER {"+ bider_email.get(i)+ "} | CURRENT BIDDING AMOUNT {$"+bid_amount.get(i)+"} <a href=DeleteBid.jsp?targetbid="+bid_amount.get(i)+"&auctionID="+targetId+"><button>Delete</button></a>");
		}
	%>
</body>
</html>