<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import ="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Customer Accounts</title>
</head>
<body>
<%

	String schemaName = "user";
	String userEmail = "email_address";
	String isStaff = "isStaff";
	String userName = "name";
	
	ArrayList<String> customerEmails = new ArrayList<String>();
	ArrayList<String> customerNames = new ArrayList<String>();
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement statement = con.createStatement();
	ResultSet rs;
	String cmd = String.format("SELECT * from %s ",schemaName);
	rs = statement.executeQuery(cmd);
		while(rs.next()){
			if(!rs.getBoolean(isStaff)){
				customerEmails.add(rs.getString(userEmail));
				customerNames.add(rs.getString(userName));
			}

		}
		
	rs.close();
	statement.close();
	con.close();
%>
	<a href="reppage.jsp"><button>Back</button> </a>
	<h1>Edit Accounts</h1>
	<%
		for(int i = 0; i < customerEmails.size(); i++){
			out.println("NAME: {" + customerNames.get(i) + "} EMAIL: {" + customerEmails.get(i) + "}  <br>OPTIONS: <a href='edituser.jsp?custNums="+customerEmails.get(i)+"'><button>Edit</button></a> <a href='DeleteUser.jsp?customerNums="+customerEmails.get(i)+"'><button>Delete</button></a><br><br>");		
		}
	
	%>

</body>
</html>