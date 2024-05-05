<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forum</title>
</head>
<body>
<%
	String keyword = request.getParameter("keyword");
	//Initialize name of Schema
	String schemaName = "threads";

	//Initialize attribute names
	String threadID = "thread_id";
	String threadTitle = "title";
	String threadEmail = "email";
	
	//Initialize Storage of values
	ArrayList<Integer>threadIDs = new ArrayList<Integer>();
	ArrayList<String>threadTitles = new ArrayList<String>();
	ArrayList<String>threadEmails = new ArrayList<String>();
	
	//Open connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	
	//Get all Threads
	String cmd = String.format("SELECT * FROM %s",schemaName);
	rs = statement.executeQuery(cmd);
	
	//Iterate through all threads and store all attributes.
	while(rs.next()){
		if(rs.getString(threadTitle).toLowerCase().contains(keyword.toLowerCase())){
			threadIDs.add(rs.getInt(threadID));
			threadTitles.add(rs.getString(threadTitle));
			threadEmails.add(rs.getString(threadEmail));
		}
	}
	
%>
	<a href="mainpage.jsp"><button>Back</button></a>
	<h1>Forum</h1>
	<form method = "POST" action="filterthread.jsp">
		<input type="text" name="keyword"/>
		<input type="submit" value="Search"/>
	</form><br><br>
	<!-- Display all threads -->
	<%
		if(threadIDs.size()>0){
			for(int i = 0; i < threadIDs.size(); i++){
				out.println(threadTitles.get(i) + ":{"+threadEmails.get(i)+"}  <a href='viewchat.jsp?threadID="+threadIDs.get(i)+"&threadTitle="+threadTitles.get(i)+"&threadEmail="+threadEmails.get(i)+"'><button>View</button></a><br><br>");
			}
		}else{
			out.println("No messages found with keyword: " + keyword);
		}
	
		
	%>
</body>
</html>