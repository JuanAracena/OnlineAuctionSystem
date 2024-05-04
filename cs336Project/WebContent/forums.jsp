<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Threads</title>
</head>
<body>
	<h1>Threads</h1>
	<div>
		<%-- Display open threads here --%>
		<%
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			ArrayList<String> titleList = new ArrayList<>();
			ArrayList<String> threadIdList = new ArrayList<>();
			ResultSet rs;
			
			
			//Get info:
			String email = (String) session.getAttribute("user");
			String getInfo = String.format("SELECT thread_id, title, email FROM threads WHERE email='%s'", email);
			rs = statement.executeQuery(getInfo);
			String threadId = "";
			
			
			while(rs.next()){
				String threadTitle = rs.getString("title");
				threadId = rs.getString("thread_id");
				titleList.add(threadTitle);
				threadIdList.add(threadId);
				
			}
			
			
			con.close();
		%>
		<%
            //Displaying all the threads
            for(int i = 0; i < titleList.size(); i++){
                 %>
                <a href="viewThread.jsp?threadId=<%= threadIdList.get(i) %>"><%out.print(titleList.get(i));%></a><br/>
            <% }%>
		
	</div>
	<div>
		<p>Create a new thread to talk to a customer representative</p>
		<a href="createThread.jsp"><button>New Thread</button></a>
		<a href="LogOut.jsp"><button>Log out</button></a>
	</div>
	
</body>
</html>