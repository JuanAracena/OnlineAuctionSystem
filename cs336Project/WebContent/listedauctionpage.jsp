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
		Connection con = db.getConnection();;
		Statement statement = con.createStatement();
		Statement statement2 = con.createStatement();
		
		String search = request.getParameter("search");
		String sortanddir = request.getParameter("sortanddir");
		String sortby = request.getParameter("sort");
		String sortdir = request.getParameter("dir");
		
		if(search == null){
			search = "";
		}
		
		if(sortanddir != null){
			String[] params = sortanddir.split("-");
			sortby = params[0];
			sortdir = params[1];
		}
		
		if(sortby == null){
			sortby = "endauction";
		}
		
		if(sortdir == null){
			sortdir = "ASC";
		}
	%>
	
	<%-- JQUERY IMPLEMENTATIONS --%>
	
	
	<%-- Search Feature --%>
	<h3>Search</h3>
	<%
		if(!search.isEmpty()){
			%> Currently searching by <% out.print(search); %><br/><%
		}
	%>
	
	<form method = "POST" action = <%out.print("listedauctionpage.jsp?sort=" +sortby+"&dir=" + sortdir);%>>
		<input type="text" name="search" class = "tag-input"/><br/>
		<input type="submit" name="searchbutton" value="Search" id="search" class="tag-input"/><br/>
	</form> 
	
	<h3>Sort By</h3>
	Currently sorting by <% out.print(sortby + " " + sortdir); %> <br/> <br/>
	<form method = "POST" action = <%out.print("listedauctionpage.jsp?search=" + search);%>>
		Item Name (ASC): <input type="radio" name="sortanddir" value="item_name-asc"/> 
		Item Name (DESC): <input type="radio" name="sortanddir" value="item_name-desc"/> <br/>
		
		Item Type (ASC): <input type="radio" name="sortanddir" value="item_type-asc"/> 
		Item Type (DESC): <input type="radio" name="sortanddir" value="item_type-desc"/> <br/>
		
		Current Bid (ASC): <input type="radio" name="sortanddir" value="max_bid-asc"/> 
		Current Bid (DESC): <input type="radio" name="sortanddir" value="max_bid-desc"/> <br/>
		
		<input type="submit" name="sortbutton" value="Sort" id="sort" class="tag-input"/><br/> <br/>
	</form> 
	
	
	<%-- ITEMS --%>
	<div id=items>
		<h3>Items:</h3>
		<%
			ResultSet rs = statement.executeQuery("select * from auction JOIN item using(item_id) LEFT JOIN (select auction_id, max(bid) as max_bid from bid group by auction_id) as max_bids using(auction_id) order by " + sortby + " " + sortdir);	

			while(rs.next()){
				int auctionid = rs.getInt("auction_id");
				String itemtype = rs.getString("item_type");
				int itemid = rs.getInt("item_id");
				String itemname = rs.getString("item_name");
				String description = rs.getString("description");
				Timestamp endauction = rs.getTimestamp("endauction");
				
				// Create keyword search
				
				
				float maxbid = rs.getFloat("initprice");
				
				if(rs.getObject("max_bid") != null){
					maxbid = rs.getFloat("max_bid");
				}
				
				if(search.isEmpty())
				
				%>
					
					<div id="item">
						<b>Item: <% out.print(itemname); %></b> <br/>
						Item Type: <% out.print(itemtype); %><br/>
						
						Item Description:
							<% out.print(description); %> <br/>
						Current Bid: <% out.print(maxbid); %> <br/>
						
						End Auction Date: <% out.print(endauction); %><br/>
						<a href="itemdetailspage.jsp?id=<%out.print(itemid);%>"><button>Item Details</button></a>
						<br/><br/><br/>
					</div>
					
				<% 
				
			}
	
		%>
	</div>
	
	
</body>
</html>