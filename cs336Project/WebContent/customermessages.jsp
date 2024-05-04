<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Messages</title>
</head>
<body>
<%
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
		threadIDs.add(rs.getInt(threadID));
		threadTitles.add(rs.getString(threadTitle));
		threadEmails.add(rs.getString(threadEmail));
	}
	
%>
	<a href="reppage.jsp"><button>Back</button></a>
	<h1>Messages</h1>
	<!-- Display all threads -->
	<%
		for(int i = 0; i < threadIDs.size(); i++){
			out.println(threadTitles.get(i) + ":{"+threadEmails.get(i)+"}  <a href='represpond.jsp?threadID="+threadIDs.get(i)+"&threadTitle="+threadTitles.get(i)+"&threadEmail="+threadEmails.get(i)+"'><button>Respond</button></a><br><br>");
		}
	%>
	
</body>
</html>