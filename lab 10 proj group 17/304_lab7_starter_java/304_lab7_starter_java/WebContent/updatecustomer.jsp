<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
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
String sql = "UPDATE product SET firstName = ? WHERE productId = ?";
String sql2 = "UPDATE product SET lastName = ? WHERE productId = ?";
String sql3= "UPDATE product SET email = ? WHERE productId = ?";
String sql4 = "UPDATE product SET phonenum = ? WHERE productId = ?";
String sql5 = "UPDATE product SET address = ? WHERE productId = ?";
String sql6 = "UPDATE product SET city = ? WHERE productId = ?";
String sql7= "UPDATE product SET state = ? WHERE productId = ?";
String sql8 = "UPDATE product SET postalCode = ? WHERE productId = ?";
String sql9 = "UPDATE product SET country = ? WHERE productId = ?";
String sql10 = "UPDATE product SET userid = ? WHERE productId = ?";
String sql11= "UPDATE product SET password = ? WHERE productId = ?";
String sql12 = "SELECT productName, categoryId, productDesc, productPrice FROM product WHERE productId = ?";

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
    
    /*
    stmt5.setString(1, customerId);
    ResultSet rst = stmt5.executeQuery();
    rst.next();
    
    if(productId == null) {

    }else {
        if(productName != null && productName != ""){
            stmt.setString(1, productName);
            stmt.setInt(2, StringtoInt(productId, 0));
            stmt.executeUpdate();
        }else{
            stmt.setString(1, rst.getString(1));
            stmt.setInt(2, StringtoInt(productId, 0));
            stmt.executeUpdate();
         
        }
        if(categoryId != null && categoryId != ""){
            stmt2.setInt(1, StringtoInt(categoryId, rst.getInt(2)));
            stmt2.setInt(2, StringtoInt(productId, 0));
            stmt2.executeUpdate();
        }else{
         
        }
        if(productDesc != null && productDesc != ""){
            stmt3.setString(1, productDesc);
            stmt3.setInt(2, StringtoInt(productId, 0));
            stmt3.executeUpdate();
        }else{
            stmt3.setString(1, rst.getString(3));
            stmt3.setInt(2, StringtoInt(productId, 0));
            stmt3.executeUpdate();
         
        }
        if(productPrice != null && productPrice != ""){
            stmt4.setDouble(1, StringtoDouble(productPrice, rst.getDouble(4)));
            stmt4.setInt(2, StringtoInt(productId, 0));
            stmt4.executeUpdate();
        }else{
         
        }
        
   
    }
    */





 
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