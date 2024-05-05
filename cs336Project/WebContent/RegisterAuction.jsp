<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" import="java.time.format.DateTimeFormatter" import="java.time.*" import="java.time.format.*" %>

<%!

	public boolean isFloat( String input ) {
	    try {
	        Float.parseFloat( input );
	        return true;
	    }
	    catch( Exception e ) {
	        return false;
	    }
	}
%>

<%

	//Variables Depending on Database 
	String dbname = "cs336project";
	String usersdb = "user";
	
	String user = (String) session.getAttribute("user");

	// Find inputs
	String sitemnum = request.getParameter("item");
	String sinitprice = request.getParameter("initprice");
	String sbidinc = request.getParameter("bidinc");
	String sminprice = request.getParameter("minprice");
	String sendauctiontime = request.getParameter("endauction");
	
	// Verifying inputs 
	if(!isFloat(sinitprice) || !isFloat(sbidinc) || !isFloat(sminprice)){
		response.sendRedirect("registerauctionpage.jsp");
		return; // inputs invalid 
	}
	
	// Parsing
	int itemnum = Integer.parseInt(sitemnum);
	float initprice = Float.parseFloat(sinitprice);
	float bidinc = Float.parseFloat(sbidinc);
	float minprice = Float.parseFloat(sminprice);
	
	DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
	LocalDateTime localDateTime = LocalDateTime.parse(sendauctiontime, inputFormatter);
	DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	String sqltime = localDateTime.format(outputFormatter);
	out.print(sqltime);

	
	// DB 
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	
	String info = String.format("INSERT INTO auction(item_id, email_address, initprice, bidinc, minprice, endauction) VALUES (%d, '%s', %.2f, %.2f, %.2f, '%s')", itemnum, user, initprice, bidinc, minprice, sqltime);
	statement.executeUpdate(info);
	
	response.sendRedirect("itemdetailspage.jsp?id=" + itemnum);
	
%>