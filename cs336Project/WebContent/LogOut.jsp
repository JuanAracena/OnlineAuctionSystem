<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
    
<%
	session.removeAttribute("user");
	response.sendRedirect("login.jsp");
	return;
%>