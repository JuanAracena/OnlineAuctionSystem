<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit User</title>
</head>
<body>
	<a href="editaccounts.jsp"><button>Back</button> </a>
	<h1>Edit User</h1>
	<%
		String customerEmail = request.getParameter("customerNums");
		String schemaName = "user";
		String schemaName2 = "end_users";
		String targetParameter = "email_address";
		String userPhone = "phone_number";
		String userAddress = "street_address";
		String userName = "name";
		String isSeller = "isSeller";
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs;
		String cmd = String.format("SELECT * FROM %s WHERE %s = '%s'", schemaName, targetParameter, customerEmail);
		rs = statement.executeQuery(cmd);
		if(rs.next()&& !rs.getBoolean(isSeller)){
			out.println("NAME: {" +rs.getString(userName)+"} <a href='editnamebuyer.jsp?changeSelection=customerName&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("EMAIL: {"+rs.getString(targetParameter)+"} <a href='editnamebuyer.jsp?changeSelection=customerEmail&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("ADDRESS: {"+rs.getString(userAddress)+"}  <a href='editnamebuyer.jsp?changeSelection=customerAddress&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"}  <a href='editnamebuyer.jsp?changeSelection=customerPhone&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("CHANGE PASSWORD: <a href='editnamebuyer.jsp?changeSelection=customerPassword&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
		}else{
			out.println("NAME: {" +rs.getString(userName)+"} <a href='editnamebuyer.jsp?changeSelection=customerName&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("EMAIL: {"+rs.getString(targetParameter)+"} <a href='editnamebuyer.jsp?changeSelection=customerEmail&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("ADDRESS: {"+rs.getString(userAddress)+"}  <a href='editnamebuyer.jsp?changeSelection=customerAddress&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"}  <a href='editnamebuyer.jsp?changeSelection=customerPhone&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("CHANGE PASSWORD: <a href='editnamebuyer.jsp?changeSelection=customerPassword&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
		}
		rs.close();
		statement.close();
		con.close();
		//out.println(customerEmail);
	%>
</body>
</html>