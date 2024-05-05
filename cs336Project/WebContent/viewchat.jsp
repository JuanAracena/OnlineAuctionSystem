<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	
	//Grab query information
	Integer threadID = Integer.parseInt(request.getParameter("threadID"));
	String threadTitle = request.getParameter("threadTitle");
	String threadEmail = request.getParameter("threadEmail");
	
	out.println("<a href='searchforum.jsp'><button>Back</button></a>");
	//Initialize Schema name
	String schemaName = "messages";
	
	//Initialize Attribute names
	String messageId = "message_id";
	String threadId = "thread_id";
	String description = "description";
	String postDate = "post_date";
	
	//Display title information
	out.println("<h1>"+threadTitle+ " | {"+threadEmail+"}</h1>");
	
	//Set up connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	
	//Grab messages of given thread
	String cmd = String.format("SELECT * FROM %s WHERE %s = '%s' ORDER BY post_date ASC;", schemaName, threadId, threadID);
	rs = statement.executeQuery(cmd);
	
	//Go through all messages
	while(rs.next()){
		if(rs.getBoolean("isrep")){
			out.println("<"+ rs.getString(postDate) + "> (Representative): "+rs.getString(description) + "  <br><br>	");
		}else{
			out.println("<"+ rs.getString(postDate) + "> ("+threadEmail+"): "+rs.getString(description) + "  <br><br>	");
		}
	}
%>
	

</body>
</html>