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
	<h1><% ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	ResultSet rs3;
	ResultSet rs4;
	
	String email = (String) session.getAttribute("user");
	String getTitle = String.format("SELECT title FROM threads JOIN messages USING(thread_id) WHERE email='%s'", email);
	rs3 = stmt.executeQuery(getTitle);
	
	
	
	if(rs3.next()){
		out.print(rs3.getString("title") + " | {" + email + "}");
	}
		
	%>
	
	</h1>
		<%-- Display messages here --%>
		
		<%
			//Getting info:
			Statement statement = con.createStatement();
			ResultSet rs;
			Statement statement2 = con.createStatement();
			ResultSet rs2;
			
			String thread_id = request.getParameter("threadId");
			ArrayList<String> descrList = new ArrayList<>();
			
			
			String getMessageTId = String.format("SELECT DISTINCT thread_id FROM Messages JOIN threads using(thread_id) where email='%s'", email);
			rs = statement.executeQuery(getMessageTId);
			
			//Getting messages with the same thread id:
			while(rs.next()){
				String messageTId = rs.getString("thread_id");
				if(thread_id.equals(messageTId)){
					session.setAttribute("ThId", thread_id);
					String getDescrDate = String.format("SELECT DISTINCT description, post_date, isrep FROM messages WHERE thread_id = %d order by post_date", Integer.valueOf(messageTId));
					rs2 = statement2.executeQuery(getDescrDate);
					while(rs2.next()){
						String descr = rs2.getString("description");
						String post_date = rs2.getString("post_date");
						String isrep = Integer.toString(rs2.getInt("isrep"));
						descrList.add(descr);
						descrList.add(post_date);
						descrList.add(isrep);
					}
				
				}
				
			}
			
			con.close();
			
			%>
			
			
			
			<% //Displaying descrList:
			for(int i = 0; i < descrList.size(); i+=3){%>
				
				<p>&lt;<%out.print(descrList.get(i + 1));
				%>&gt; (<%
						
						if(descrList.get(i+2).equals("1")){
							out.print("Representative");
						}else{
							out.print(email);
						}
						
					%>): <%out.print(descrList.get(i));%> 
				</p><br>
				
				
				
			<%}%>	
		
	</div>
	<div>
		<form method = "POST" action="ReplyController.jsp">
			<textarea name="comment" rows="5" cols= "50" required></textarea><br/>
			<br/><input type="submit" value="Post"/>
		</form>
		<br/><a href="mainpage.jsp"><button>Home</button></a>
	
	</div>	
</body>
</html>