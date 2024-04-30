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
		String businessname = "business_name";
		String businesstype = "business_type";
		String businessaddress = "business_address";
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		ResultSet rs;
		ResultSet rs2;
		String cmd = String.format("SELECT * FROM %s WHERE %s = '%s'", schemaName, targetParameter, customerEmail);
		rs = statement.executeQuery(cmd);
		if(rs.next()&& !rs.getBoolean(isSeller)){
			out.println("NAME: {" +rs.getString(userName)+"} <a href='editnamebuyer.jsp?changeSelection=customerName&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("EMAIL: {"+rs.getString(targetParameter)+"} <a href='editnamebuyer.jsp?changeSelection=customerEmail&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("ADDRESS: {"+rs.getString(userAddress)+"}  <a href='editnamebuyer.jsp?changeSelection=customerAddress&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"}  <a href='editnamebuyer.jsp?changeSelection=customerPhone&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
			out.println("CHANGE PASSWORD: <a href='editnamebuyer.jsp?changeSelection=customerPassword&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
		}else{
			String cmd2 = String.format("SELECT * FROM %s WHERE %s = '%s'", schemaName2, targetParameter, customerEmail);
			rs2 = statement.executeQuery(cmd2);
			if(rs2.next()){
				out.println("NAME: {" +rs2.getString(userName)+"} <a href='editnameseller.jsp?changeSelection=customerName&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("EMAIL: {"+rs2.getString(targetParameter)+"} <a href='editnameseller.jsp?changeSelection=customerEmail&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("ADDRESS: {"+rs2.getString(userAddress)+"}  <a href='editnameseller.jsp?changeSelection=customerAddress&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("PHONE NUMBER: {"+rs2.getString(userPhone)+"}  <a href='editnameseller.jsp?changeSelection=customerPhone&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("BUSINESS NAME: {"+rs2.getString(businessname)+"}  <a href='editnameseller.jsp?changeSelection=customerBName&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("BUSINESS TYPE: {"+rs2.getString(businesstype)+"}  <a href='editnameseller.jsp?changeSelection=customerBType&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("BUSINESS ADDRESS: {"+rs2.getString(businessaddress)+"}  <a href='editnameseller.jsp?changeSelection=customerBAddr&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");
				out.println("CHANGE PASSWORD: <a href='editnameseller.jsp?changeSelection=customerPassword&customerEmail="+customerEmail +"'><button>change</button></a><br><br>");	
			}

		}
		rs.close();
		statement.close();
		con.close();
		//out.println(customerEmail);
	%>
</body>
</html>