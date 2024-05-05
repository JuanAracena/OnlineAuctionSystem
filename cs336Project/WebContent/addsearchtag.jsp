<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<%

String user = (String) session.getAttribute("user"); 

ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();;
Statement statement = con.createStatement();

String gettag = request.getParameter("addtag");

statement.executeUpdate(String.format("INSERT INTO search_tags(email,tag) VALUES('%s', '%s')", user, gettag));

response.sendRedirect("profilepage.jsp?profile=" + user);

%>
