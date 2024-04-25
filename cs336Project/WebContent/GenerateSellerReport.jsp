<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
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
	//item_ID int, item_Type int, item_name varchar(100), end_user_email varchar(100), selling_price int,
	//String itemID = "itemID";
	//String itemType = "item_Type";
	//String userEmail = "end_user_email";
	//String sellingPrice = "selling_price";
	
	//alert("Button Clicked");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT sum(%s.selling_price)total_sum from %s ", transactionReport,transactionReport);
	rs = statement.executeQuery(cmd);
	if(rs.next()){
		session.setAttribute("response", rs.getInt("total_sum"));
		con.close();
	}

	
%>
	<a href="adminpage.jsp"><button>Back</button> </a>
	<h1>Report Page</h1>
	Total Earnings: <%= session.getAttribute("response") %>
		<a href="GenerateItemReport.jsp"><button>Item</button></a>
		<a href="GenerateItemTypeReport.jsp"><button>Item Type</button></a>
		<a href="GenerateSellerReport.jsp"><button>Seller</button></a>
		<br>
		<br>
		<h2>Seller List Here</h2>
</body>
</html>