<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<%@ include file="../auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

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
Statement stmt = con.createStatement();)
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
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}
%>

</body>
</html>

