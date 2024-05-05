<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Report Page</title>
</head>
<body>
<% 
	String dbname = "cs336project";
	String transactionReport = "transaction_report";
	ArrayList<String> userEmails = new ArrayList<>(); 
	ArrayList<Integer> itemPrices = new ArrayList<>();
	//item_ID int, item_Type int, item_name varchar(100), end_user_email varchar(100), selling_price int,
	//String itemID = "itemID";
	String itemType = "item_Type";
	String userEmail = "end_user_email";
	String itemName = "item_name";
	String sellingPrice = "selling_price";
	
	//alert("Button Clicked");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT sum(%s.selling_price)total_sum from %s ", transactionReport,transactionReport);
	rs = statement.executeQuery(cmd);
	if(rs.next()){
		session.setAttribute("response", rs.getInt("total_sum"));
		String cmd3 = String.format(" SELECT end_user_email, sum(selling_price)as total_buy FROM transaction_report GROUP BY end_user_email ORDER BY total_buy DESC LIMIT 1;");
		String cmd4 = String.format("  SELECT item_name, count(*)as total_count FROM transaction_report GROUP BY item_name ORDER BY total_count DESC LIMIT 1;");
		rs = statement.executeQuery(cmd3);
		
		if(rs.next()){
			session.setAttribute("bestBuyer", rs.getString("end_user_email"));
		}
		rs = statement.executeQuery(cmd4);
		if(rs.next()){
			session.setAttribute("best_selling_Item", rs.getString("item_name"));
		}
		String cmd2 = String.format("SELECT %s, SUM(%s) AS total_price FROM %s GROUP BY %s;",userEmail, sellingPrice, transactionReport, userEmail);
		ResultSet rs2 = statement.executeQuery(cmd2);
		
		while(rs2.next()){
			userEmails.add(rs2.getString(userEmail));
			itemPrices.add(rs2.getInt("total_price"));
		}
		con.close();
	}

	
%>
	<a href="adminpage.jsp"><button>Back</button> </a>
	<h1>Sales Report</h1>
	TOTAL EARNINGS: {$<%= session.getAttribute("response") %>}<br>
	BEST-SELLING ITEMS: {<%= session.getAttribute("best_selling_Item") %>}<br>
	BEST BUYER: {<%= session.getAttribute("bestBuyer") %>}<br><br>
	<%out.println("OPTIONS:"); %>
		<a href="GenerateItemReport.jsp"><button>Item</button></a>
		<a href="GenerateItemTypeReport.jsp"><button>Item Type</button></a>
		<a href="GenerateSellerReport.jsp"><button>Seller</button></a>
		<br>
		<br>
		<h2>Sellers List</h2>
		<%
			for(int i = 0;i < userEmails.size();i++){
				out.println("End Users: {"+ userEmails.get(i)+"} | Total Earning: {"+ itemPrices.get(i)+ "}<br>");
			}
		%>
</body>
</html>