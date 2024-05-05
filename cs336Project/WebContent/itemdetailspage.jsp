<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.util.ArrayList" import="java.time.format.DateTimeFormatter" import="java.time.LocalDateTime" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Auction</title>

<style>
    .tag-input {
        margin-bottom: 2px; 
    }
</style>

</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<% 
		String user = (String) session.getAttribute("user"); 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		int itemId = Integer.parseInt(request.getParameter("id"));
		
		ResultSet rs = statement.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction.item_id = " + itemId);	
		
		if(rs.next() == false){
			response.sendRedirect("listedauctionpage.jsp");
		}
		
		int auctionid = rs.getInt("auction_id");
		String itemowner = rs.getString("email_address");
		String itemtype = rs.getString("item_type");
		String itemname = rs.getString("item_name");
		String description = rs.getString("description");
		Timestamp endauction = rs.getTimestamp("endauction");
		float initprice = rs.getFloat("initprice");
		float bidinc = rs.getFloat("bidinc");
		float secretminprice = rs.getFloat("minprice");
		float maxbid = -1;
		String maxbidname = "";
		if(rs.getObject("max_bid") != null){
			maxbid = rs.getFloat("max_bid");
			
			ResultSet maxbiduserrs = statement.executeQuery("select bid_email_address from bid where auction_id="+auctionid+" and bid=" + maxbid);
			if(maxbiduserrs.next()){
				maxbidname = maxbiduserrs.getString("bid_email_address");
			}
			
		}
		float nextbid = maxbid == -1 ? initprice: (maxbid + bidinc);
		
		ResultSet tagsrs = statement.executeQuery("select * from item_tags where item_id = " + itemId);
		ArrayList<String> tags = new ArrayList<>();
		while(tagsrs.next()){
			tags.add(tagsrs.getString("tag"));
		}
		
		ResultSet rspastdue = statement.executeQuery("select * from auction where auction_id = " + auctionid + " and NOW() > endauction");	
		boolean pastdue = rspastdue.next();
		
	%>
	
	<a href="mainpage.jsp"><button>Home</button></a>
	
	<div id=itemdetails>
		<h3>Item Details</h3>
		Item Name: <% out.print(itemname); %><br/>
		Item Type: <% out.print(itemtype); %><br/>
		Item Description: <% out.print(description); %> <br/>
		Item Tags: <% out.print(String.join(", ", tags)); %> <br/>
		Current Owner: <% out.print(itemowner); %><br/><br/>
		
		Initial Bid: <% out.print(initprice); %> <br/>
		Current Bid: <% 
			if(maxbid == -1){
				out.print("None");
			}else{
				out.print(maxbid);
			}
		%> <br/>
		Bid Increment: <% out.print(bidinc); %> <br/> <br/>
		
		End Auction Date: <% out.print(endauction); %><br/>
	
	</div> <br/> 
	
	<% if(!pastdue){ %>
		<form method = "POST" action = <%out.print("PostBid.jsp?aid=" + auctionid+"&id=" + itemId);%>> 
			<div id=placebid>
				<h3>Place Bid</h3>
				Minimum Bid: <% out.print(nextbid); %> <br/>
				<input type ="number" name="bidbox" id="bidbox" min = <%out.print(nextbid);%> class=tag-input value = <%out.print(nextbid);%> /> <br/> 
				<input type ="checkbox" name ="enableautobid" id="enableautobid" /> Enable Auto-Bid
			
			</div><br/>
			
			<div id="autobid">
			
			</div><br/>
			
			<input type ="submit" name="placebidbutton" id="placebidbutton" value="Place Bid" class=tag-input />
		</form>
		
		<script type = "text/javascript">
		
			$(document).ready(function(){
				
				function update(){
					var html = ''
					if(document.getElementById('enableautobid').checked){
						html = 'Max Bid:<br/> <input type ="number" name="autobidamt" id="autobidamt" class=tag-input /> <br/>'
					}
					
					$("#autobid").html(html)
				}
				
				$("input:checkbox[name=enableautobid]").click(update)
				update()
			})
		
		</script>
	<%
	
	}else{
		
		if(maxbid > secretminprice){
			// Auction Sold
			%> Item sold to <% out.println(maxbidname); %> for <% out.println(maxbid);
			
		}else{
			// Auction Did Not Sell
			%> Auction did not meet the seller's secret minimum sell price! <%
		}
	
	}%>
	
	
	<div id=bidding>
		<h3>History of Bids</h3>
		
		<%
			ResultSet bidsrs = statement.executeQuery("select * from bid where auction_id = " + auctionid + " order by bid desc");
			while(bidsrs.next()){
				
				float bid = bidsrs.getFloat("bid");
				String email = bidsrs.getString("bid_email_address");
				
				out.print(email + " - " + bid); %> <br/> <%
				
			}
		%>
	
	</div>
	

</body>
</html>