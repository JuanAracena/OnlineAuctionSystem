<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Profile Search</title>
</head>
<body>
<%	
	ArrayList<String> user_names = new ArrayList<String>();
	ArrayList<String> user_emails = new ArrayList<String>();
	String keyword_search = request.getParameter("keywordSearch");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	String cmd = String.format("SELECT * FROM user");
	
	ResultSet rs  = statement.executeQuery(cmd);
	while(rs.next()){
		if(rs.getString("name").toLowerCase().contains(keyword_search) && !rs.getBoolean("isStaff") ){
			user_names.add(rs.getString("name"));
			user_emails.add(rs.getString("email_address"));
		}else if(rs.getString("email_address").toLowerCase().contains(keyword_search)&& !rs.getBoolean("isStaff") ){
			user_names.add(rs.getString("name"));
			user_emails.add(rs.getString("email_address"));
		}
	}

%>
	<a href='mainpage.jsp'><button>Back</button></a>
	<h1>Results for keyword:"<%= request.getParameter("keywordSearch") %>	"</h1>
		<%
			for(int i = 0; i < user_names.size();i++){
				out.println("Name: {"+user_names.get(i) + "} Email: {" +user_emails.get(i)+"} <a href = 'profilepage.jsp?profile="+user_emails.get(i)+"'><button>view</button></a>" );
			}
			if(user_names.size() == 0){
				out.println("No profiles found with given keyword");
			}
		%>
	
</body>
</html>