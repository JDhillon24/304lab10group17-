<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>



<!DOCTYPE html>
<html>
<head>
<title>ClickForKicks Register</title>
</head>
<body>
<%@ include file="header.jsp" %>
<br>
<h1 align="center">Create an Account</h3>
<br>
<div align="center">
<form action = "#" method = "POST">
    <table style="display:inline"><tr class="spacerows">
    <td><p>Username:</p></td>
    <td><input type="text" name="username" size=25 maxlength=16></td>
    </tr>
    <tr class="spacerows">
    <td><p>Password:</p></td>
    <td><input type="password" name="password" size=25 maxlength=16></td>
    </tr>
    <tr class="spacerows">
    <td><p>First Name:</p></td> 
    <td><input type="text" name="fname" size=25 maxlength=16></td>
    </tr>
    <tr class="spacerows">
    <td><p>Last Name:</p></td>
    <td><input type="text" name="lname" size=25 maxlength=16></td> 
    </tr>
    <tr class="spacerows">
    <td><p>Email:</p></td>
    <td><input type="email" name="email" size=25 maxlength=64></td>
    </tr>
    <tr class="spacerows">
    <td><p>Phone #:</p></td>
    <td><input type="tel" name="phone" size=25 pattern="[0-9]{3}[0-9]{3}[0-9]{4}" required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Address:</p></td>
    <td><input type="text" name="address" size=25 maxlength=40></td>
    </tr>


</form>
</div>
<%
//Note: Forces loading of SQL Server driver

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";




try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();
	  Statement stmt2 = con.createStatement();) 
{		
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}

%>

</body>
</html>
