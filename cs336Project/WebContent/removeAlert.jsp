<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>

<%
	String getAlertId = (String) request.getParameter("alert_id");
	
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	
	String deleteAlert = String.format("DELETE FROM alerts WHERE alert_id = '%s'", getAlertId);
	stmt.executeUpdate(deleteAlert);
	
	response.sendRedirect("mainpage.jsp");
	con.close();

%>