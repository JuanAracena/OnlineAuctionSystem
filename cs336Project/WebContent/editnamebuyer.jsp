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
		String selection = request.getParameter("changeSelection");	
		String customerEmail = request.getParameter("customerEmail");
		String schemaName = "user";
		String schemaName2 = "end_users";
		String targetParameter = "email_address";
		String userPassword = "password";
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
			if(selection.equals("customerName")){
				out.println("NAME: {" +rs.getString(userName)+"}<br><br>");
				out.println("<form method = 'POST' action='ChangeUserName.jsp?userEmail="+customerEmail+"&currentName="+rs.getString(userName)+"'>New Name: <input type='text' name='newName'/><input type='submit' value='Submit Change'/></form><br><br>");
				out.println("EMAIL: {"+rs.getString(targetParameter)+"}<br><br>");
				out.println("ADDRESS: {"+rs.getString(userAddress)+"} <br><br>");
				out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"} <br><br>");
				out.println("CHANGE PASSWORD:<br><br>");
			}else if(selection.equals("customerEmail")){
				out.println("NAME: {" +rs.getString(userName)+"}<br><br>");
				out.println("EMAIL: {"+rs.getString(targetParameter)+"}<br><br>");
				out.println("<form method = 'POST' action='ChangeUserEmail.jsp?userEmail="+customerEmail+"&currentEmail="+rs.getString(targetParameter)+"'>New Email: <input type='text' name='newEmail'/><input type='submit' value='Submit Change'/></form><br><br>");
				out.println("ADDRESS: {"+rs.getString(userAddress)+"} <br><br>");
				out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"} <br><br>");
				out.println("CHANGE PASSWORD:<br><br>");	
			}else if(selection.equals("customerAddress")){
				out.println("NAME: {" +rs.getString(userName)+"}<br><br>");
				out.println("EMAIL: {"+rs.getString(targetParameter)+"}<br><br>");
				out.println("ADDRESS: {"+rs.getString(userAddress)+"}<br><br>");
				out.println("<form method = 'POST' action='ChangeUserAddress.jsp?userEmail="+customerEmail+"&currentAddress="+rs.getString(userAddress)+"'>New Address: <input type='text' name='newAddress'/><input type='submit' value='Submit Change'/></form><br><br>");
				out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"} <br><br>");
				out.println("CHANGE PASSWORD<br><br>");	
			}else if(selection.equals("customerPhone")){
				out.println("NAME: {" +rs.getString(userName)+"}<br><br>");
				out.println("EMAIL: {"+rs.getString(targetParameter)+"}<br><br>");
				out.println("ADDRESS: {"+rs.getString(userAddress)+"}<br><br>");
				out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"} <br><br>");
				out.println("<form method = 'POST' action='ChangeUserPhone.jsp?userEmail="+customerEmail+"&currentPhone="+rs.getString(userPhone)+"'>New Phone: <input type='text' name='newPhone'/><input type='submit' value='Submit Change'/></form><br><br>");
				out.println("CHANGE PASSWORD<br><br>");	
			}else if(selection.equals("customerPassword")){
				out.println("NAME: {" +rs.getString(userName)+"}<br><br>");
				out.println("EMAIL: {"+rs.getString(targetParameter)+"}<br><br>");
				out.println("ADDRESS: {"+rs.getString(userAddress)+"}<br><br>");
				out.println("PHONE NUMBER: {"+rs.getString(userPhone)+"} <br><br>");
				out.println("CHANGE PASSWORD<br><br>");	
				out.println("<form method = 'POST' action='ChangeUserPassword.jsp?userEmail="+customerEmail+"&currentPassword="+rs.getString(userPassword)+"'>New Password: <input type='text' name='newPassword'/><input type='submit' value='Submit Change'/></form><br><br>");
			}else{
				
			}

		}
		rs.close();
		statement.close();
		con.close();
		//out.println(customerEmail);
	%>
</body>
</html>