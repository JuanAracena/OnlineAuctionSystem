<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report Page</title>
</head>
<body>
<% 
	String dbname = "cs336project";
	String transactionReport = "transaction_report";
	String auction = "auction";
	String endauction = "endauction";
	String auctionId = "auction_id";
	String itemId = "item_id";
	String email = "email_address";
	String itemType = "item_type";
	String itemName = "item_name";
	ArrayList<String>itemIDs = new ArrayList<>();
	ArrayList<String>itemTypes = new ArrayList<>();
	ArrayList<String>itemNames = new ArrayList<>();
	ArrayList<String>auctionIDs = new ArrayList<>();
	ArrayList<String>end_user_emails = new ArrayList<>();
	ArrayList<Float>sellingPrices = new ArrayList<>();
	//alert("Button Clicked");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	//update transaction report
	String cmd2 = String.format(" SELECT * FROM auction JOIN item using(item_id) WHERE endauction < NOW() AND auction_id NOT IN (SELECT auction_id FROM transaction_report);");//all auctions that have ended and not in transaction_report
	rs = statement.executeQuery(cmd2);
	//inserting all relevant information from auction schema into arraylist
	while(rs.next()){
		auctionIDs.add(rs.getString(auctionId));
		itemIDs.add(rs.getString(itemId));
		itemTypes.add(rs.getString(itemType));
		itemNames.add(rs.getString(itemName));
		end_user_emails.add(rs.getString(email));
	}
	//all 
	for(int i = 0; i < auctionIDs.size(); i++){
		String cmd3 = String.format("SELECT MAX(bid) maxBid FROM bid WHERE auction_id = %s;",auctionIDs.get(i));
		rs = statement.executeQuery(cmd3);
		if(rs.next()){
			sellingPrices.add(rs.getFloat("maxBid"));
		}
		
		out.println(auctionIDs.get(i) + itemNames.get(i) + sellingPrices.get(i));
	}
	for(int i = 0; i < auctionIDs.size(); i++){
		String cmd4 = String.format("INSERT INTO transaction_report VALUES('%s', '%s', '%s', '%s', '%s', %s)",
			    itemIDs.get(i),
			    itemTypes.get(i), // Escaping single quotes within the string
			    itemNames.get(i), // Escaping single quotes within the string
			    auctionIDs.get(i),
			    end_user_emails.get(i), // Escaping single quotes within the string
			    sellingPrices.get(i)); // Assuming sellingPrices is a numeric field and does not require quotes

		statement.executeUpdate(cmd4);
	}
	String cmd = String.format("SELECT sum(%s.selling_price)total_sum from %s ", transactionReport,transactionReport);
	rs = statement.executeQuery(cmd);
	if(rs.next()){
		session.setAttribute("response", rs.getInt("total_sum"));
		con.close();
	}

	
%>
	<a href="adminpage.jsp"><button>Back</button> </a>
	<h1>Sales Report</h1>
	TOTAL EARNINGS: {$<%= session.getAttribute("response") %>}
	<%out.println("OPTIONS:"); %>
		<a href="GenerateItemReport.jsp"><button>Item</button></a>
		<a href="GenerateItemTypeReport.jsp"><button>Item Type</button></a>
		<a href="GenerateSellerReport.jsp"><button>Seller</button></a>
		
	
</body>
</html>