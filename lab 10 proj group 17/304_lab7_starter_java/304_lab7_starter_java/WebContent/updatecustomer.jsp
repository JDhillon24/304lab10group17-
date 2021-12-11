<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Update Customer</title>
<link rel="stylesheet" href="updateproduct.css">
</head>
<body>
<%@ include file="header.jsp" %>

<br />
<h1><center>Update Customer</center></h1>
<br />
<div align="center">
<form name="MyForm1" method=post action="#">
    <table style="display:inline">
        <tr class="spacerows">
        <td><p>Customer ID:</p></td>
        <td><input type="text" name="customerId" size=10 maxlength=16 required></td>
        </tr>
        <tr class="spacerows">
        <td><p>Username:</p></td>
        <td><input type="text" name="username" size=25 maxlength=16></td>
        </tr>
        <tr class="spacerows">
        <td><p>Password:</p></td>
        <td><input type="password" name="password" size=25 maxlength=16 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>First Name:</p></td> 
        <td><input type="text" name="fname" size=25 maxlength=16 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>Last Name:</p></td>
        <td><input type="text" name="lname" size=25 maxlength=16 ></td> 
        </tr>
        <tr class="spacerows">
        <td><p>Email:</p></td>
        <td><input type="email" name="email" size=25 maxlength=64 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>Phone #:</p></td>
        <td><input type="tel" name="phone" size=25 pattern="[0-9]{3}[0-9]{3}[0-9]{4}" ></td>
        </tr>
        <tr class="spacerows">
        <td><p>Address:</p></td>
        <td><input type="text" name="address" size=25 maxlength=40 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>City:</p></td>
        <td><input type ="text" name="city" size=25 maxlength=20 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>State:</p></td>
        <td><input type="text" name="state" size=25 maxlength=20 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>Postal Code:</p></td>
        <td><input type="text" name="postalcode" size=25 maxlength=6 ></td>
        </tr>
        <tr class="spacerows">
        <td><p>Country:</p></td>
        <td><input type="text" name="country" size=25 maxlength=20 ></td>
        </tr>
        
        <tr><td><input id="submit-button" type="submit" name="submit" value="Update Account" class="submit-button"></td></tr>
        </table>
</form>
</div>
<%

String customerId = request.getParameter("customerId");
String firstName = request.getParameter("fname");
String lastName = request.getParameter("lname");
String email = request.getParameter("email");
String phonenum = request.getParameter("phone");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalCode = request.getParameter("postalcode");
String country = request.getParameter("country");
String userid = request.getParameter("username");
String password = request.getParameter("password");


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
String sql = "UPDATE customer SET firstName = ? WHERE customerId = ?";
String sql2 = "UPDATE customer SET lastName = ? WHERE customerId = ?";
String sql3= "UPDATE customer SET email = ? WHERE customerId = ?";
String sql4 = "UPDATE customer SET phonenum = ? WHERE customerId = ?";
String sql5 = "UPDATE customer SET address = ? WHERE customerId = ?";
String sql6 = "UPDATE customer SET city = ? WHERE customerId = ?";
String sql7= "UPDATE customer SET state = ? WHERE customerId = ?";
String sql8 = "UPDATE customer SET postalCode = ? WHERE customerId = ?";
String sql9 = "UPDATE customer SET country = ? WHERE customerId = ?";
String sql10 = "UPDATE customer SET userid = ? WHERE customerId = ?";
String sql11= "UPDATE customer SET password = ? WHERE customerId = ?";
String sql12 = "SELECT firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM customer WHERE customerId = ?";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql);
      PreparedStatement stmt2 = con.prepareStatement(sql2);
      PreparedStatement stmt3 = con.prepareStatement(sql3);
      PreparedStatement stmt4 = con.prepareStatement(sql4);
      PreparedStatement stmt5 = con.prepareStatement(sql5);
      PreparedStatement stmt6 = con.prepareStatement(sql6);
      PreparedStatement stmt7 = con.prepareStatement(sql7);
      PreparedStatement stmt8 = con.prepareStatement(sql8);
      PreparedStatement stmt9 = con.prepareStatement(sql9);
      PreparedStatement stmt10 = con.prepareStatement(sql10); 
      PreparedStatement stmt11 = con.prepareStatement(sql11);
      PreparedStatement stmt12 = con.prepareStatement(sql12); )
{   
    
    
    stmt12.setString(1, customerId);
    ResultSet rst = stmt12.executeQuery();
    rst.next();
    
    if(customerId == null) {

    }else {
        if(firstName != null && firstName != ""){
            stmt.setString(1, firstName);
            stmt.setInt(2, StringtoInt(customerId, 0));
            stmt.executeUpdate();
        }else{
            stmt.setString(1, rst.getString(1));
            stmt.setInt(2, StringtoInt(customerId, 0));
            stmt.executeUpdate();
         
        }
        if(lastName != null && lastName != ""){
            stmt2.setString(1, lastName);
            stmt2.setInt(2, StringtoInt(customerId, 0));
            stmt2.executeUpdate();
        }else{
            stmt2.setString(1, rst.getString(2));
            stmt2.setInt(2, StringtoInt(customerId, 0));
            stmt2.executeUpdate();
         
        }
        if(email != null && email != ""){
            stmt3.setString(1, email);
            stmt3.setInt(2, StringtoInt(customerId, 0));
            stmt3.executeUpdate();
        }else{
            stmt3.setString(1, rst.getString(3));
            stmt3.setInt(2, StringtoInt(customerId, 0));
            stmt3.executeUpdate();
         
        }
        if(phonenum != null && phonenum != ""){
            stmt4.setString(1, phonenum);
            stmt4.setInt(2, StringtoInt(customerId, 0));
            stmt4.executeUpdate();
        }else{
            stmt4.setString(1, rst.getString(4));
            stmt4.setInt(2, StringtoInt(customerId, 0));
            stmt4.executeUpdate();
         
        }
        if(address != null && address != "") {
            stmt5.setString(1, address);
            stmt5.setInt(2, StringtoInt(customerId, 0));
            stmt5.executeUpdate();
        }else {
            stmt5.setString(1, rst.getString(5));
            stmt5.setInt(2, StringtoInt(customerId, 0));
            stmt5.executeUpdate();
        }
        if(city != null && city != "") {
            stmt6.setString(1, city);
            stmt6.setInt(2, StringtoInt(customerId, 0));
            stmt6.executeUpdate();
        }else {
            stmt6.setString(1, rst.getString(6));
            stmt6.setInt(2, StringtoInt(customerId, 0));
            stmt6.executeUpdate();
        }
        if(state != null && state != "") {
            stmt7.setString(1, state);
            stmt7.setInt(2, StringtoInt(customerId, 0));
            stmt7.executeUpdate();
        }else {
            stmt7.setString(1, rst.getString(7));
            stmt7.setInt(2, StringtoInt(customerId, 0));
            stmt7.executeUpdate();
        }
        if(postalCode != null && postalCode != "") {
            stmt8.setString(1, postalCode);
            stmt8.setInt(2, StringtoInt(customerId, 0));
            stmt8.executeUpdate();
        }else {
            stmt8.setString(1, rst.getString(8));
            stmt8.setInt(2, StringtoInt(customerId, 0));
            stmt8.executeUpdate();
        }
        if(country != null && country != "") {
            stmt9.setString(1, country);
            stmt9.setInt(2, StringtoInt(customerId, 0));
            stmt9.executeUpdate();
        }else {
            stmt9.setString(1, rst.getString(9));
            stmt9.setInt(2, StringtoInt(customerId, 0));
            stmt9.executeUpdate();
        }
        if(userid != null && userid != "") {
            stmt10.setString(1, userid);
            stmt10.setInt(2, StringtoInt(customerId, 0));
            stmt10.executeUpdate();
        }else {
            stmt10.setString(1, rst.getString(10));
            stmt10.setInt(2, StringtoInt(customerId, 0));
            stmt10.executeUpdate();
        }
        if(password != null && password != "") {
            stmt11.setString(1, address);
            stmt11.setInt(2, StringtoInt(customerId, 0));
            stmt11.executeUpdate();
        }else {
            stmt11.setString(1, rst.getString(11));
            stmt11.setInt(2, StringtoInt(customerId, 0));
            stmt11.executeUpdate();
        }
        
        
   
    }
    





 
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
//response.sendRedirect("admin.jsp");
// Close connection
%>


<%!
    int StringtoInt(String x, int y) {

        try {
            return Integer.parseInt(x);
        }
        catch (NumberFormatException e) {
            return y;
        }
    }

    double StringtoDouble(String x, double y) {

        try {
            return Double.parseDouble(x);
        }
        catch (NumberFormatException e) {
            return y;
        }
    }






%>

</body>
</html>