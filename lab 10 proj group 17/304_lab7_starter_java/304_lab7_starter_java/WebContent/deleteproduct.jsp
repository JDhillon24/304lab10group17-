<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link rel="stylesheet" href="deleteproduct.css">
</head>
<body>
	<%@ include file="header.jsp" %>

<br />
<h1><center>Delete Product</center></h1>
<br />
<div align="center">
<form name="MyForm1" method=post action="#">
    <table style="display:inline">
    <tr class= "spacerows">
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Product ID: </div></td>
        <td><input type="text" name="productId"  id = "productId-field"  class = "Product-form" size=2 maxlength=2 required></td>
    </tr>
    <tr><td><input class="submit-button" type="submit" name="Submit2" value="Submit" id = "submit-button"></td></tr>
   
</table>
</form>
</div>
<%

String productId = request.getParameter("productId");
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
String sql = "DELETE FROM product WHERE productId = ?";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql); )
{
    if(productId != null ){
   	    stmt.setInt(1, Integer.parseInt(productId));
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