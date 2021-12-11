<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>ClickForKicks Inventory</title>
</head>
<body>
	<%@ include file="header.jsp" %>
<h1>Inventory List</h1>

<%
//Note: Forces loading of SQL Server driver

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);



try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}


try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{		
	ResultSet rst = stmt.executeQuery("SELECT productName, product.productId, warehouse.warehouseId, warehouseName, quantity FROM product JOIN productinventory ON product.productId = productinventory.productId JOIN warehouse ON productinventory.warehouseId = warehouse.warehouseId ");		
	out.println("<table border = '1'><tr><th>Product Name</th><th>Product Id</th><th>Warehouse Id</th><th>Warehouse Name</th><th>Quantity</th></tr>");
	while (rst.next())
	{	
		out.println("<tr><td>"+rst.getString(1)+"</td>"+"<td>"+rst.getInt(2)+"</td>"+"<td>"+rst.getInt(3)+"</td>"+"<td>"+rst.getString(4)+"</td>"+"<td>"+rst.getInt(5)+"</td></tr>");			
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}

%>

</body>
</html>

