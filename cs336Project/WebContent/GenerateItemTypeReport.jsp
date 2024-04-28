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
	ArrayList<String> itemTypeName = new ArrayList<>(); 
	ArrayList<Integer> itemPrices = new ArrayList<>();
	//item_ID int, item_Type int, item_name varchar(100), end_user_email varchar(100), selling_price int,
	//String itemID = "itemID";
	String itemType = "item_Type";
	//String userEmail = "end_user_email";
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
		String cmd2 = String.format("SELECT %s, SUM(%s) AS total_price FROM %s GROUP BY %s;",itemType, sellingPrice, transactionReport, itemType);
		ResultSet rs2 = statement.executeQuery(cmd2);
		
		while(rs2.next()){
			itemTypeName.add(rs2.getString(itemType));
			itemPrices.add(rs2.getInt("total_price"));
		}
		con.close();
	}

	
%>
	<a href="adminpage.jsp"><button>Back</button> </a>
	<h1>Sales Report</h1>
	Total Earnings: <%= session.getAttribute("response") %>
		<a href="GenerateItemReport.jsp"><button>Item</button></a>
		<a href="GenerateItemTypeReport.jsp"><button>Item Type</button></a>
		<a href="GenerateSellerReport.jsp"><button>Seller</button></a>
		<br>
		<br>
		<h2>Item Types List </h2>
				<%
			for(int i = 0;i < itemTypeName.size();i++){
				out.println("Item Name: "+ itemTypeName.get(i)+" | Total Earnings: "+ itemPrices.get(i)+ "<br>");
			}
		%>
</body>
</html>