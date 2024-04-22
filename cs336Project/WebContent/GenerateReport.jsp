<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
    
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
	String cmd = String.format("SELECT * from %s", transactionReport);
	rs = statement.executeQuery(cmd);
	if(rs.next()){
		session.setAttribute("response", rs.getInt("item_ID"));
		con.close();
		response.sendRedirect("reportpage.jsp");
		return;
	}
	
	
%>