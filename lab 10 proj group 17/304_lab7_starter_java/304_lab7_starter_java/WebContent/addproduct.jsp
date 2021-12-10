<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Add Product</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
	<%@ include file="header.jsp" %>

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
%>
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<h1><center>Add New Shoe</center></h1>
<br />
<form name="MyForm1" method=post action="validateLogin.jsp">
    <table style="display:inline">
    <tr>
        <td><center></center><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Shoe Name: </div></center></td>
        <td><center><input type="text" name="pname"  id = "pname-field" class = "Product-form" size=10 maxlength=10></center></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Category Id: </div></td>
        <td><input type="text" name="categoryId"  id = "categoryId-field"  class = "Product-form" size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></div>Shoe Type: </td>
        <td><input type="text" name="productDesc"  id = "productDesc-field"  class = "Product-form" size=10 maxlength=10></td>
    </tr>
    <tr>
        <td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2">Shoe Price: </div></td>
        <td><input type="text" name="productPrice"  id = "productPrice-field"  class = "Product-form" size=10 maxlength=10></td>
    </tr>
<%
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();
	  Statement stmt2 = con.createStatement();) 
{		
	
}
catch (SQLException ex) 
{ 	out.println(ex); 
}


// Close connection
%>

</body>
</html>


                

