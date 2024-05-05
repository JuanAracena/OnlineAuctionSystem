<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" import="java.util.ArrayList" import="java.time.format.DateTimeFormatter" import="java.time.LocalDateTime" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile Page</title>

<style>
    .tag-input {
        margin-bottom: 2px; 
    }
</style>

</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	
	<%
	
		// HANDLE TRANSACTION REPORT 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
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
			
			ResultSet rs = statement2.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) where auction_id = " + auction_id + " and (max_bid is null or max_bid >= minprice)");	
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
			statement2.executeUpdate(String.format("INSERT INTO alerts(email, text, redirect, date) VALUES('%s', '%s', '%s', NOW())", maxbidname, "You won the auction!", "itemdetailspage.jsp?id=" + item_ID));

		}
		
		
		// Continue
		String user = (String) session.getAttribute("user"); 
		Statement purchasestatement = con.createStatement();
		Statement soldstatement = con.createStatement();
		
		String profileTo = request.getParameter("profile");
		ResultSet profileInfo = statement.executeQuery("select * from user where email_address = '" + profileTo + "'");
		
		if(profileInfo.next() == false){
			profileTo = user;
			profileInfo = statement.executeQuery("select * from user where email_address = '" + profileTo + "'");
			if(profileInfo.next() == false){
				response.sendRedirect("login.jsp");
				return;
			}
		}
		
		String profileName = profileInfo.getString("name");
		String profilePhone = profileInfo.getString("phone_number");
		int isSeller = profileInfo.getInt("isSeller");
		int isStaff = profileInfo.getInt("isStaff");
		
		ResultSet tagsInfo = statement.executeQuery("select * from search_tags where email = '" + profileTo + "'");
		ResultSet soldInfo = soldstatement.executeQuery(String.format("select * from transaction_report join auction on transaction_report.item_ID = auction.item_id where email_address = '%s'", profileTo));
		ResultSet purchaseInfo = purchasestatement.executeQuery(String.format("select * from transaction_report join auction on transaction_report.item_ID = auction.item_id where email_address = '%s'", profileTo));
		
	%>
	
	<h3><%out.print(profileTo);%>'s Profile</h3>
	
	Name: <%out.print(profileName); %> <br/>
	Phone: <%out.print(profilePhone); %> <br/>
	
	This user is a <%
		if(isSeller == 1){
			%>buyer and a seller!<%
		}else if(isStaff == 1){
			%> staff member! <%
			
		}else{
			%> buyer! <%
		}
	%><br/>
	
	<% if(profileTo.equalsIgnoreCase(user)){ %>
		<h3> Add Interested Item Tags </h3>
		
		<form method = "POST" action = <% out.print("addsearchtag.jsp"); %>>
			Add Tag: <input type="text" name="addtag" class = "tag-input"/><br/>
			<input type="submit" name="tagsubmit" value="Add Tag" id="tagsubmit" class="tag-input"/>
		</form> 
		
		<%
			if(tagsInfo.next()){
				%> <br/>Current Tags: <br/> <%
	
				do{
					
					String tagtext = tagsInfo.getString("tag");
					int tagid = tagsInfo.getInt("tag_id");
					
					%>
		
						<form method = "POST" action =<% out.print("removesearchtag.jsp?id=" + tagid); %>>
							<%out.print(tagtext);%>  
							<input type="submit" name="tagdelete" value="Delete" id="tagsubmit" class="tag-input"/><br/>
						</form>
						
					
					<%
					
				}while((tagsInfo.next()));
			}
		
		%> <br/>
	<% } %>
	
	<% 
		if(isSeller == 1){
			%>	
		
				<h3> Sold Items </h3>
				<%
				
					while(soldInfo.next()){
						
						int iid = soldInfo.getInt("item_ID");
						String iname = soldInfo.getString("item_name");
						String itype = soldInfo.getString("item_Type");
						String buyer = soldInfo.getString("end_user_email");
						float soldprice = soldInfo.getFloat("selling_price");
						
						%>
						
						<b>Item Name: <% out.print(iname); %></b><br/>
						Item Type: <% out.print(itype); %><br/>
						Buyer: <% out.print(buyer); %><br/>
						Sold Price: <% out.print(soldprice); %><br/>
						<a href=<% out.print("itemdetailspage.jsp?id=" + iid);%>>Go to item</a><br/><br/>
					
						<% 
					}
				
				%>
				
			<%
		}
	
		%>
			<h3> Purchased Items </h3>
			<%
				
				while(purchaseInfo.next()){
					
					int iid = purchaseInfo.getInt("item_ID");
					String iname = purchaseInfo.getString("item_name");
					String itype = purchaseInfo.getString("item_Type");
					String seller = purchaseInfo.getString("email_address");
					float soldprice = purchaseInfo.getFloat("selling_price");
					
					%>
					
					<b>Item Name: <% out.print(iname); %></b><br/>
					Item Type: <% out.print(itype); %><br/>
					Seller: <% out.print(seller); %><br/>
					Sold Price: <% out.print(soldprice); %><br/>
					<a href=<% out.print("itemdetailspage.jsp?id=" + iid);%>>Go to item</a><br/><br/>
					
					<% 
				}
			
			%>
		<a href="mainpage.jsp"><button>Home</button></a>
	
</body>
</html>