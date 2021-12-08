<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>ClickForKicks Inc.</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>



<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
String shoesize = request.getParameter("shoeSize");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String sql = "SELECT productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?";

try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}


try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql);)
{
    stmt.setString(1, productId);
    ResultSet rst = stmt.executeQuery();
    rst.next();

    out.println("<h2>"+rst.getString(1)+"</h2>");
    out.println("<table><tr>"+rst.getString(4)+"</tr><tr><th>Id</th><td>"+productId+"</td>"+"</tr><tr><th>Price</th><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
    String image = rst.getString(3);
	if (image != null)
		out.println("<img src=\""+image+"\" align='left'>");
    
    out.println("</table>");
    String link = "\"addcart.jsp?id=" + productId + "&name=" + rst.getString(1) + "&price=" + rst.getString(2) + "&shoeSize=" + shoesize  + "\"";    
    String link2 = "\"listprod.jsp" + "\"";
    out.println("<h3><a href="+link+">Add to Cart</a></h3>");
    out.println("<h3><a href="+link2+">Continue Shopping</a></h3>");
    out.println("Current Size Selected: " +shoesize);
    
} catch (SQLException ex) 
{ 	out.println(ex); 
}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

