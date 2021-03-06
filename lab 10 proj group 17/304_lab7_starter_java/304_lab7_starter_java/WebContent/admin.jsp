<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
<link rel="stylesheet" href="admin.css">
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="../auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>


<%
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
} 
// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try (Connection con = DriverManager.getConnection(url, uid, pw);
Statement stmt = con.createStatement();
Statement stmt2 = con.createStatement();)
{	
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
	
	ResultSet rst = stmt.executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");		
	out.println("<h3>Customer List</h3>");
	ResultSet rst2 = stmt2.executeQuery("SELECT customerId, CONCAT(firstName, ' ', lastName) FROM customer");
	out.println("<table border = '1'><tr><th>Customer Id</th><th>Customer Name</th></tr>");
		while (rst2.next())
		{	
	out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getString(2)+"</td></tr>");
		}
	out.println("</table></td></tr>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>
	<nav>
		<%
		String userName1 = (String) session.getAttribute("authenticatedUser");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"addproduct.jsp\" class=\"button\">Add New Product</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"deleteproduct.jsp\" class=\"button\">Delete Product</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"updateproduct.jsp\" class=\"button\">Update Product</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"addwarehouse.jsp\" class=\"button\">Add Warehouse</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"addcustomer.jsp\" class=\"button\">Add New Customer</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"updatewarehouse.jsp\" class=\"button\">Update Warehouse</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"updatecustomer.jsp\" class=\"button\">Update Customer</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"viewinventory.jsp\" class=\"button\">View Inventory</a></span></li>");
		out.println("<br>");
		out.println("<br>");
		out.println("<br>");
		out.println("<li><span><a href=\"shiporder.jsp\" class=\"button\">Ship Order</a></span></li>");
		%>
	</nav>

</body>
</html>

