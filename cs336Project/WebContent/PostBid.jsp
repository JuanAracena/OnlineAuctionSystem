<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" import="java.time.format.DateTimeFormatter" import="java.time.*" import="java.time.format.*" 
import="java.util.HashMap" import= "java.util.Iterator" import= "java.util.Map"
%>


<%

	//Variables Depending on Database 
	String dbname = "cs336project";
	String usersdb = "user";
	
	String user = (String) session.getAttribute("user");

	// Find inputs
	int auctionid = Integer.parseInt(request.getParameter("aid"));
	int itemid = Integer.parseInt(request.getParameter("id"));
	float bid = Float.parseFloat(request.getParameter("bidbox"));
	boolean autobidcheckbox = request.getParameter("enableautobid") != null;
	float autobidmax = 0;
	if(autobidcheckbox){
		autobidmax = Float.parseFloat(request.getParameter("autobidamt"));
	}

	
	// DB 
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	
	String info = String.format("INSERT INTO bid(auction_id, bid, bid_email_address) VALUES (%d, '%.2f', '%s')", auctionid, bid, user);
	statement.executeUpdate(info);
	
	if(autobidcheckbox){
		statement.executeUpdate("DELETE FROM autobid WHERE auction_id = '" + auctionid + "' and autobid_email = '" + user + "'");
		statement.executeUpdate(String.format("INSERT INTO autobid VALUES (%d, '%s', %.2f)", auctionid, user, autobidmax));
	}
	
	// Find current max
	ResultSet rs = statement.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction.item_id = " + itemid);	
	String maxbidname = null;
	if(rs.next()){
		float maxbid = -1;
		if(rs.getObject("max_bid") != null){
			maxbid = rs.getFloat("max_bid");
			
			ResultSet maxbiduserrs = statement.executeQuery("select bid_email_address from bid where auction_id="+auctionid+" and bid=" + maxbid);
			if(maxbiduserrs.next()){
				maxbidname = maxbiduserrs.getString("bid_email_address");
			}
			
		}
	}
	
	// HANDLE AUTOBIDS 
	
	// Get auction info
	rs = statement.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction.item_id = " + itemid);	
	rs.next();
	float bidinc = rs.getFloat("bidinc");
	float currentbid = bid;

	ResultSet autobidders = statement.executeQuery("SELECT * FROM autobid WHERE auction_id = " + auctionid + " and autobid_cap > " + bid);
	HashMap<String, Float> dictionary = new HashMap<>();
	
	// Get autobidders enabled
	while(autobidders.next()){
		String email = autobidders.getString("autobid_email");
		float max = autobidders.getFloat("autobid_cap"); 
		dictionary.put(email, max);
	}
	
	// Autobidding	
	String lastbid = user;
	
	while(dictionary.size() >= 2){
		Iterator<Map.Entry<String, Float>> iterator = dictionary.entrySet().iterator();
		while (iterator.hasNext()) {
		    Map.Entry<String, Float> entry = iterator.next();
		    String email = entry.getKey();
		    if (!email.equalsIgnoreCase(lastbid)) {
		        float maxautobid = entry.getValue();
		        if (maxautobid >= bid + bidinc) {
		            bid = bid + bidinc;
		            info = String.format("INSERT INTO bid(auction_id, bid, bid_email_address) VALUES (%d, '%.2f', '%s')", auctionid, bid, email);
		            statement.executeUpdate(info);
		            lastbid = email;
		        } else {
		            iterator.remove(); 
		            String redirect = "itemdetailspage.jsp?id=" + itemid;
		            String text = "Your maximum bid for an item has been surpassed.";
		            info = String.format("INSERT INTO alerts(email, text, redirect, date) VALUES ('%s', '%s', '%s', NOW())", email, text, redirect);
		            statement.executeUpdate(info);
		        }
		    }
		}
	}
	
	if(dictionary.size() == 1){
		for (String email : dictionary.keySet()) {
			if(!email.equalsIgnoreCase(lastbid)){
				// Bid
				float maxautobid = dictionary.get(email);
				if(maxautobid >= bid + bidinc){
					bid = bid+bidinc;
					info = String.format("INSERT INTO bid(auction_id, bid, bid_email_address) VALUES (%d, '%.2f', '%s')", auctionid, bid, email);
					statement.executeUpdate(info);
					lastbid = email;
				}
			}
		}
	}
	
	if(!lastbid.equals(maxbidname)){
		String redirect = "itemdetailspage.jsp?id=" + itemid;
	    String text = "You have been outbid.";
	    info = String.format("INSERT INTO alerts(email, text, redirect, date) VALUES ('%s', '%s', '%s', NOW())", maxbidname, text, redirect);
	    statement.executeUpdate(info);
	}
	
	
	response.sendRedirect("itemdetailspage.jsp?id=" + itemid);
	
%>