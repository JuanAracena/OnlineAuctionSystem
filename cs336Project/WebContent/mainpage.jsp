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
	<h1>Welcome, <%ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	ResultSet rs;
	String getName = String.format("SELECT name FROM user WHERE email_address='%s'", session.getAttribute("user"));
	rs = stmt.executeQuery(getName);	
	
	if(rs.next()){
		out.print(rs.getString("name"));

	}
	%>
	</h1>
	<a href="forums.jsp"><button>Profile</button></a><br><br>
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