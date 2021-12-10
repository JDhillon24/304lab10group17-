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
<h1><center>Update Product</center></h1>
<br />
<div align="center">
<form name="MyForm1" method=post action="#">
    <table style="display:inline">
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product ID: </div></td>
        <td><input type="text" name="productId"  id = "productId-field"  class = "Product-form" size=2 maxlength=2 required></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product Name: </div></td>
        <td><input type="text" name="productName"  id = "productName-field"  class = "Product-form" size=10 maxlength=10 ></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Category Id: </div></td>
        <td><input type="text" name="categoryId"  id = "categoryId-field"  class = "Product-form" size=10 maxlength=10 ></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></div>Product Description: </td>
        <td><input type="text" name="productDesc"  id = "productDesc-field"  class = "Product-form" size=10 maxlength=50 ></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Shoe Price: </div></td>
        <td><input type="text" name="productPrice"  id = "productPrice-field"  class = "Product-form" size=10 maxlength=10 ></td>
    </tr>
    <tr><td><input class="submit-button" type="submit" name="Submit2" value="Submit" id = "submit-button"></td></tr>
   
</table>
</form>
</div>
<%

String productId = request.getParameter("productId");
String productName = request.getParameter("productName");
String categoryId = request.getParameter("categoryId");
String productDesc = request.getParameter("productDesc");
String productPrice = request.getParameter("productPrice");
;

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
String sql = "UPDATE product SET productName = ? WHERE productId = ?";
String sql2 = "UPDATE product SET categoryId = ? WHERE productId = ?";
String sql3= "UPDATE product SET productDesc = ? WHERE productId = ?";
String sql4 = "UPDATE product SET productPrice = ? WHERE productId = ?";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql);
      PreparedStatement stmt2 = con.prepareStatement(sql2);
      PreparedStatement stmt3 = con.prepareStatement(sql3);
      PreparedStatement stmt4 = con.prepareStatement(sql4); )
{
    if(productName != null || productName != ""){
        stmt.setString(1, productName);
        stmt.setInt(2, Integer.parseInt("0" + productId));
        stmt.executeUpdate();
    }else{
     
    }
    if(categoryId != null || categoryId != ""){
        stmt2.setInt(1, Integer.parseInt("0" + categoryId));
        stmt2.setInt(2, Integer.parseInt(productId));
        stmt2.executeUpdate();
    }else{
     
    }
    if(productDesc != null || productDesc != ""){
        stmt3.setString(1, productDesc);
        stmt3.setInt(2, Integer.parseInt(productId));
        stmt3.executeUpdate();
    }else{
     
    }
    if(productPrice != null || productPrice != ""){
        stmt4.setDouble(1, Double.parseDouble("0" + productPrice));
        stmt4.setInt(2, Integer.parseInt(productId));
        stmt4.executeUpdate();
}   else{
     
 }
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
//response.sendRedirect("admin.jsp");
// Close connection
%>

</body>
</html>