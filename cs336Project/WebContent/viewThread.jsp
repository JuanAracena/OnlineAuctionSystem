<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Messages</title>
</head>
<body>
	<div>
	<h1>Messages</h1>
		<%-- Display messages here --%>
		
		<%
			//Getting info:
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			ResultSet rs;
			Statement statement2 = con.createStatement();
			ResultSet rs2;
			
			String email = (String) session.getAttribute("user");
			String thread_id = request.getParameter("threadId");
			ArrayList<String> descrList = new ArrayList<>();
			
			
			String getMessageTId = String.format("SELECT DISTINCT thread_id FROM Messages JOIN threads using(thread_id) where email='%s'", email);
			rs = statement.executeQuery(getMessageTId);
			
			//Getting messages with the same thread id:
			while(rs.next()){
				String messageTId = rs.getString("thread_id");
				if(thread_id.equals(messageTId)){
					session.setAttribute("ThId", thread_id);
					String getDescrDate = String.format("SELECT DISTINCT description, post_date FROM messages WHERE thread_id = %d order by post_date", Integer.valueOf(messageTId));
					rs2 = statement2.executeQuery(getDescrDate);
					while(rs2.next()){
						String descr = rs2.getString("description");
						String post_date = rs2.getString("post_date");
						descrList.add(descr);
						descrList.add(post_date);
					}
				
				}
				
			}
			
			con.close();
			%>
			
			
			
			<% //Displaying descrList:
			for(int i = 0; i < descrList.size(); i+=2){%>
				<p><%out.print(descrList.get(i));%></p>
				<p><%out.print(descrList.get(i + 1));
				%></p><br>
				
				
			<%}%>	
		
	</div>
	<div>
		<form method = "POST" action="ReplyController.jsp">
			Comment: <input type="text" size = 50 name="comment"/><br/>
			<input type="submit" value="Reply"/>
		</form>
	
	</div>	
</body>
</html>