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
	String auctions = "auction";
	String auctionId = "auction_id"; 
	String item = "item";
	String sellerEmail = "email_address";
	String itemID = "item_id";
	String itemType = "item_type";
	String itemName = "item_name";
	Integer currentID;
	ArrayList<String> auctionItemName = new ArrayList<>(); 
	ArrayList<String> auctionItemType = new ArrayList<>();
	ArrayList<Integer> auctionItemId = new ArrayList<>();
	ArrayList<String> sellerEmails = new ArrayList<>();
	ArrayList<Integer> auctionIds  = new ArrayList<>();
	
	
	
	//alert("Button Clicked");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT * from %s ", auctions);
	rs = statement.executeQuery(cmd);
	while(rs.next()){
		//out.println(rs.getString(sellerEmail));
		//if current time is < expire time
		// Store seller email in sellerEmails Arraylist
		sellerEmails.add(rs.getString(sellerEmail));
		auctionItemId.add(rs.getInt(itemID));
		auctionIds.add(rs.getInt(auctionId));
	// Fore each Item ID make get request to grab that item name and store in the auctionItemName
	}
	for(int i = 0; i < auctionItemId.size(); i++){
		String cmd2 = String.format("SELECT * from %s WHERE %s = '%s'",item, itemID, auctionItemId.get(i));
		ResultSet rs2 = statement.executeQuery(cmd2);
		if(rs2.next()){
			auctionItemName.add(rs2.getString(itemName));
			auctionItemType.add(rs2.getString(itemType));
		}else{
			out.println("item not found for item id: " + auctionItemId.get(i));
		}	
	}


%>
<a href="reppage.jsp"><button>Back</button> </a>
	<h1>Current Auctions</h1>

		<%
		for(int i = 0; i < sellerEmails.size(); i++){
			out.println("SELLER: {"+ sellerEmails.get(i)+"} | ITEM TYPE:{" + auctionItemType.get(i)+"} | ITEM NAME: {" + auctionItemName.get(i)+ "} <a href=showbids.jsp?auctionID="+auctionIds.get(i)+"><button>SELECT</button></a><br><br>");
		}
		
		%>
</body>
</html>