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
	Statement statement4 = con.createStatement();
	ResultSet rs;
	//update transaction report
	String cmd2 = String.format(" SELECT * FROM auction JOIN item using(item_id) WHERE endauction < NOW() AND auction_id NOT IN (SELECT auction_id FROM transaction_report);");//all auctions that have ended and not in transaction_report
	rs = statement4.executeQuery(cmd2);
	//inserting all relevant information from auction schema into arraylist
	while(rs.next()){
		auctionIDs.add(rs.getString(auctionId));
		itemIDs.add(rs.getString(itemId));
		itemTypes.add(rs.getString(itemType));
		itemNames.add(rs.getString(itemName));
		end_user_emails.add(rs.getString(email));
	}
	//all 
		
	// HANDLE TRANSACTION REPORT 
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
		
		 rs = statement2.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction_id = " + auction_id + " and (max_bid is null or max_bid >= minprice)");
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
	
	String cmd = String.format("SELECT sum(%s.selling_price)total_sum from %s ", transactionReport,transactionReport);
	rs = statement.executeQuery(cmd);
	if(rs.next()){
		session.setAttribute("response", rs.getInt("total_sum"));

	}
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
	con.close();
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
	
	
</body>
</html>