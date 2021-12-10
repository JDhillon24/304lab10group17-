<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link rel="stylesheet" href="addproduct.css">
</head>
<body>
	<%@ include file="header.jsp" %>

<br />
<h1><center>Add New Shoe</center></h1>
<br />
<div align="center">
<form name="MyForm1" method=post action="#">
    <table style="display:inline">
    <tr class= "spacerows">
        <td><center></center><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Shoe Name: </div></center></td>
        <td><center><input type="text" name="name"  id = "pname-field" class = "Product-form" size=10 maxlength=10 required></center></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Category Id: </div></td>
        <td><input type="text" name="categoryId"  id = "categoryId-field"  class = "Product-form" size=10 maxlength=10 required></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></div>Shoe Type: </td>
        <td><input type="text" name="productDesc"  id = "productDesc-field"  class = "Product-form" size=10 maxlength=20 required></td>
    </tr>
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Shoe Price: </div></td>
        <td><input type="text" name="productPrice"  id = "productPrice-field"  class = "Product-form" size=10 maxlength=10 required></td>
    </tr>
    <tr><td><input class="submit-button" type="submit" name="Submit2" value="Submit" id = "submit-button"></td></tr>
   
</table>
</form>
</div>
<%

String name = request.getParameter("name");
String catname = request.getParameter("categoryId");
String productDesc = request.getParameter("productDesc");
String productPrice = request.getParameter("productPrice");

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
String sql = "INSERT INTO product (productName, categoryId, productDesc, productPrice) VALUES (?, ?, ?, ?)";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql); )
{
    if(name != null && catname != null && productDesc != null && productPrice != null){
   	    stmt.setString(1, name);
   	    stmt.setInt(2, Integer.parseInt(catname));
   	    stmt.setString(3, productDesc);
   	    stmt.setDouble(4, Double.parseDouble(productPrice));
   	    stmt.executeUpdate();
        response.sendRedirect("admin.jsp");
    }else{
        
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


                

