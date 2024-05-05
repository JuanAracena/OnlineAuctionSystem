<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<%

	//Variables Depending on Database 
	String dbname = "cs336project";
	String usersdb = "user";
	
	String user = (String) session.getAttribute("user");

	// Find inputs
	String itemname = request.getParameter("ItemName");
	String itemtype = request.getParameter("itemtype");
	String itemdescription = request.getParameter("Description");
	
	String specname1 = "", specname2 = "", specname3 = "";
	String spec1 = "", spec2 = "", spec3 = "";
	
	switch(itemtype){
		case "PSU":
			specname1 = "Watts";
			specname2 = "Efficiency";
			specname3 = "Size";
			break;
		case "Motherboard":
			specname1 = "RAM Slots";
			specname2 = "Chipset";
			specname3 = "Amount Storage Connectors";
			break;
		case "CPU":
			specname1 = "Number of Cores";
			specname2 = "Socket";
			specname3 = "Product Line";
			break;
		case "GPU":
			specname1 = "Video Memory";
			break;
		case "Hard Drive":
			specname1 = "Storage Capacity";
			break;
		case "RAM":
			specname1 = "Storage Capacity";
			specname2 = "Clock Frequency";
			specname3 = "Stick Type";
			break;
		case "Monitor":
			specname1 = "Resolution";
			specname2 = "Refresh Rate";
			specname3 = "Size";
			break;
	
	}

	if(!specname1.isEmpty()) spec1 = request.getParameter(specname1);
	if(!specname2.isEmpty()) spec2 = request.getParameter(specname2);
	if(!specname3.isEmpty()) spec3 = request.getParameter(specname3);
	
	String[] tags = request.getParameterValues("Tag");
	
	// Insert Into DB 
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	
	String info = "";
	if(!specname3.isEmpty()){
		info = String.format("INSERT INTO item(item_name, email_address, description, item_type,`%s`,`%s`,`%s`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s');", 
			itemtype+"_"+specname1, itemtype+"_"+specname2, itemtype+"_"+specname3, 
			itemname, user, itemdescription, itemtype, spec1, spec2, spec3
		);
	}else if(!specname2.isEmpty()){
		info = String.format("INSERT INTO item(item_name, email_address, description, item_type,`%s`,`%s`) VALUES ('%s', '%s', '%s', '%s', '%s', '%s');", 
			itemtype+"_"+specname1, itemtype+"_"+specname2,
			itemname, user, itemdescription, itemtype, spec1, spec2
		);
	}else{
		info = String.format("INSERT INTO item(item_name, email_address, description, item_type,`%s`) VALUES ('%s', '%s', '%s', '%s', '%s');", 
			itemtype+"_"+specname1,
			itemname, user, itemdescription, itemtype, spec1
		);
	}
	
	statement.executeUpdate(info);
	
	ResultSet rs = statement.executeQuery("SELECT LAST_INSERT_ID();");
	int lastid = -1;
	if (rs.next()) { // Ensure the cursor is moved to the first row
	    lastid = rs.getInt(1);
	}
	
	if(lastid != -1){
		for(int i = 0; i < tags.length; i++){
			info = String.format("INSERT INTO item_tags(item_id, tag) VALUES(%d, '%s');", lastid, tags[i]);
			statement.executeUpdate(info);
		}
	}
		
	response.sendRedirect("registerauctionpage.jsp");

%>