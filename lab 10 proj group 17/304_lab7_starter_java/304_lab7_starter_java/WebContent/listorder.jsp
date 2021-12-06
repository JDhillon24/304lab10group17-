<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

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
      Statement stmt = con.createStatement();
	  Statement stmt2 = con.createStatement();) 
{		
	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, orderSummary.customerId AS customerId, CONCAT(firstName, ' ', lastName), totalAmount FROM orderSummary JOIN customer ON orderSummary.customerId = customer.customerId");		
	out.println("<table border = '1'><tr><th>Order Id</th><th>Order Date</th><th>Customer Id</th><th>Customer Name</th><th>Total Amount</th></tr>");
	while (rst.next())
	{	String query2 = "SELECT productId, quantity, price, productSize FROM orderProduct WHERE orderId = " + rst.getInt(1);
		ResultSet rst2 = stmt2.executeQuery(query2);
		out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getTimestamp(2)+"</td>"+"<td>"+rst.getInt(3)+"</td>"+"<td>"+rst.getString(4)+"</td>"+"<td>"+currFormat.format(rst.getDouble(5))+"</td></tr>");	
		out.println("<tr align = 'right'><td colspan = '5'><table border = '1'><th>Product Id</th><th>Size</th><th>Quantity</th><th>Price</th></tr>");
		while (rst2.next()) {
			out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getDouble(4)+"</td>"+"<td>"+rst2.getInt(2)+"</td>"+"<td>"+currFormat.format(rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 



// Close connection
%>

</body>
</html>

