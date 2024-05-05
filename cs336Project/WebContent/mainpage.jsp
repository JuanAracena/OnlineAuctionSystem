<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Main Page</title>
</head>
<body>

	<%
	
	// HANDLE TRANSACTION REPORT 
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();;
	Statement statement = con.createStatement();
	Statement statement2 = con.createStatement();
	Statement statement3 = con.createStatement();
	ResultSet transactionsToAdd = statement.executeQuery("select * from auction join item on auction.item_id=item.item_ID where endauction < NOW() and auction.item_id not in (select transaction_report.item_ID from transaction_report)");
	
	while(transactionsToAdd.next()){
		int auction_id = transactionsToAdd.getInt("auction_id");
		int item_ID = transactionsToAdd.getInt("item_id");
		String item_type = transactionsToAdd.getString("item_type");
		String item_name = transactionsToAdd.getString("item_name");
		float maxbid = -1;
		String maxbidname = "";
		
		ResultSet rs = statement2.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction_id = " + auction_id + " and max_bid >= minprice");	
		if(rs.next() && rs.getObject("max_bid") != null){
			maxbid = rs.getFloat("max_bid");
			
			ResultSet maxbiduserrs = statement3.executeQuery("select bid_email_address from bid where auction_id="+auction_id+" and bid=" + maxbid);
			if(maxbiduserrs.next()){
				maxbidname = maxbiduserrs.getString("bid_email_address");
			}
			
		}else{
			continue;
		}
		
		statement2.executeUpdate(String.format("INSERT INTO transaction_report VALUES(%d, '%s', '%s', '%s', %.02f)", item_ID, item_type, item_name, maxbidname, maxbid));
	}
	
	%>
	

	<h1>Welcome, <%
	Statement stmt = con.createStatement();
	ResultSet rs;
	String getName = String.format("SELECT name FROM user WHERE email_address='%s'", session.getAttribute("user"));
	rs = stmt.executeQuery(getName);	
	String loggedin = (String) session.getAttribute("user");
	
	if(rs.next()){
		out.print(rs.getString("name"));

	}
	%>
	</h1>
	<a href=<% out.print("profilepage.jsp?profile=" + loggedin);%>><button>Profile</button></a><br><br>
	<a href="listedauctionpage.jsp"><button>Buy</button></a>
	
	<%
		Statement stmt3 = con.createStatement();
		ResultSet rs3;
		String getIsSeller = String.format("SELECT isSeller FROM user WHERE email_address='%s'", session.getAttribute("user"));
	
		rs3 = stmt3.executeQuery(getIsSeller);
		
		if(rs3.next()){
			int isSeller = rs3.getInt("isSeller");
			if(isSeller == 1){%>
			<a href="registerauctionpage.jsp"><button>Sell</button></a>
				
			<% }
		}
	%>
		
	<a href="forums.jsp"><button>Get Help</button></a>
	<a href="LogOut.jsp"><button>Log out</button></a>
	<br><br>
	<div>
	<%--Display alerts here --%>
		<p>Alerts:</p>
		<%
			Statement stmt2 = con.createStatement();
			ResultSet rs2;
			String getAlerts = String.format("SELECT text, redirect, date FROM alerts WHERE email='%s' order by date desc", session.getAttribute("user"));
			rs2 = stmt2.executeQuery(getAlerts);
			while(rs2.next()){%>
				<p>&lt;<%out.print(rs2.getString("date"));%>&gt;:<%out.print(rs2.getString("text"));%><br><a href="<%= rs2.getString("redirect") %>">Check it out!</a>
			<% }
		%>
	</div><br>
	<% 	
	if(session.getAttribute("user") != null){
		out.println("You are logged in as " + session.getAttribute("user"));
	}else{
		out.println("You currently are not logged in.");
	}
	
	%>
</body>
</html>