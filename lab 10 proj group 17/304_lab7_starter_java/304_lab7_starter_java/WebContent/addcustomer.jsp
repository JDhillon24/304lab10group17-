<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>



<!DOCTYPE html>
<html>
<head>
<title>ClickForKicks Register</title>
<link rel="stylesheet" href="createaccount.css">
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
    <td><input type="text" name="username" size=25 maxlength=16 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Password:</p></td>
    <td><input type="password" name="password" size=25 maxlength=16 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>First Name:</p></td> 
    <td><input type="text" name="fname" size=25 maxlength=16 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Last Name:</p></td>
    <td><input type="text" name="lname" size=25 maxlength=16 required></td> 
    </tr>
    <tr class="spacerows">
    <td><p>Email:</p></td>
    <td><input type="email" name="email" size=25 maxlength=64 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Phone #:</p></td>
    <td><input type="tel" name="phone" size=25 pattern="[0-9]{3}[0-9]{3}[0-9]{4}" required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Address:</p></td>
    <td><input type="text" name="address" size=25 maxlength=40 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>City:</p></td>
    <td><input type ="text" name="city" size=25 maxlength=20 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>State:</p></td>
    <td><input type="text" name="state" size=25 maxlength=20 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Postal Code:</p></td>
    <td><input type="text" name="postalcode" size=25 maxlength=6 required></td>
    </tr>
    <tr class="spacerows">
    <td><p>Country:</p></td>
    <td><input type="text" name="country" size=25 maxlength=20 required></td>
    </tr>
    <tr><td><input id="button" type="submit" name="submit" value="Create Account" class="createbutton"></td></tr>
    </table>
    



</form>
</div>
<%
//Note: Forces loading of SQL Server driver



String firstname = request.getParameter("fname");
String lastname = request.getParameter("lname");
String email = request.getParameter("email");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalcode = request.getParameter("postalcode");
String country = request.getParameter("country");
String username = request.getParameter("username");
String password = request.getParameter("password");




try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String sql = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?,?,?,?,?,?,?,?,?,?,?)";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql);) 
{		
    if(firstname != null && lastname != null && email != null && phone != null && address != null && city != null && state != null && postalcode != null && country != null && username != null && password != null) {
        stmt.setString(1, firstname);
        stmt.setString(2, lastname);
        stmt.setString(3, email);
        stmt.setString(4, phone);
        stmt.setString(5, address);
        stmt.setString(6, city);
        stmt.setString(7, state);
        stmt.setString(8, postalcode);
        stmt.setString(9, country);
        stmt.setString(10, username);
        stmt.setString(11, password);
        stmt.executeUpdate();
        response.sendRedirect("login.jsp");
    }
    
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}

%>

</body>
</html>
