<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<h2>All Products</h2>
<% // Get product name to search for
String name = request.getParameter("productName");
		
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
String query1 = "SELECT productId, productName, productPrice FROM product";
String query2 = "SELECT productId, productName, productPrice FROM product WHERE productName LIKE ?";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(query1);
	  PreparedStatement stmt2 = con.prepareStatement(query2);) 
{		
	if(name == "" || name == null ) {
		ResultSet rst1 = stmt.executeQuery();
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst1.next()) {
			String link = "\"addcart.jsp?id=" + rst1.getString(1) + "&name=" + rst1.getString(2) + "&price=" + rst1.getString(3) + "\"";
			String link2 = "\"product.jsp?id=" + rst1.getString(1) + "\"";
			out.println("<tr><td><a href="+link+">Add to Cart</a></td>"+"<td>"+"<a href="+link2+">"+rst1.getString(2)+"</a>"+"</td>"+"<td>"+currFormat.format(rst1.getDouble(3))+"</td></tr>");
		}
		out.println("</table>");

	}else {
		stmt2.setString(1, "%" + name + "%");
		ResultSet rst2 = stmt2.executeQuery();
		out.println("<table><tr><th></th><th>Product Name</th><th>Price</th></tr>");
		while (rst2.next()) {
			String link = "\"addcart.jsp?id=" + rst2.getString(1) + "&name=" + rst2.getString(2) + "&price=" + rst2.getString(3) + "\"";
			String link2 = "\"product.jsp?id=" + rst2.getString(1) + "\"";
			out.println("<tr><td><a href="+link+">Add to Cart</a></td>"+"<td>"+"<a href="+link2+">"+rst2.getString(2)+"</a>"+"</td>"+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table>");
	}
}
catch (SQLException ex) 
{ 	out.println(ex); 
} 

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

</body>
</html>