<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<%

String user = (String) session.getAttribute("user"); 

ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();;
Statement statement = con.createStatement();

String gettagid = request.getParameter("id");

statement.executeUpdate(String.format("DELETE FROM search_tags WHERE tag_id=" + gettagid));

response.sendRedirect("profilepage.jsp?profile=" + user);

%>
