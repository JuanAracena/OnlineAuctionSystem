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
			Statement statement2 = con.createStatement();
			Statement statement3 = con.createStatement();
			ArrayList<String> threadsList = new ArrayList<>();
			ArrayList<String> titleList = new ArrayList<>();
			ArrayList<String> threadIdList = new ArrayList<>();
			ResultSet rs;
			
			
			//Get info:
			String email = (String) session.getAttribute("user");
			
			System.out.println(email);
			
			//Getting email from threads:
			String getThreadEmail = String.format("SELECT email FROM threads");
			String getThreadTitle = String.format("SELECT title FROM threads WHERE email='%s'", email);
			String getThreadId = String.format("SELECT thread_id FROM threads WHERE email='%s'", email);
			rs = statement.executeQuery(getThreadEmail);
			ResultSet rs2 = statement2.executeQuery(getThreadTitle);
			ResultSet rs3 = statement3.executeQuery(getThreadId);
			String threadId = "";
			while(rs.next()){
				String threadEmail = rs.getString("email");
				if (rs3.next()){
					threadId = rs3.getString("thread_id");
				}
				
				if(email.equals(threadEmail)){
					threadsList.add(threadEmail);
					threadIdList.add(threadId);
					while(rs2.next()){
						String threadTitle = rs2.getString("title");
						titleList.add(threadTitle);
					}
				}
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
	</div>
</body>
</html>