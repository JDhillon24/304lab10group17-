<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>ClickForKicks Inc.</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<form action = "#" method = "POST">
    <input type="text" id="textreview" name="textreview" class="textentry" />
    <input type="submit" value="Submit" style="position:absolute; top:660px; left:590px;"/>
</form>
<%
// Get product name to search for
// TODO: Retrieve and display info for the product
String productId = request.getParameter("id");
String shoesize = request.getParameter("shoeSize");
String textreview = request.getParameter("textreview");
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String user = (String) session.getAttribute("authenticatedUser");
String sql = "SELECT productName, productPrice, productImageURL, productDesc FROM product WHERE productId = ?";
String reviewsql ="SELECT userid, reviewDate, reviewComment FROM review JOIN customer ON review.customerId = customer.customerId WHERE productId = ?";
String insertreview = "INSERT INTO review(reviewDate,customerId,productId,reviewComment) VALUES (?,?,?,?)";
String grabCustId = "SELECT customerId FROM customer WHERE userid = ?";

try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}


try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql);
      PreparedStatement stmt2 = con.prepareStatement(reviewsql);
      PreparedStatement stmt3 = con.prepareStatement(insertreview);
      PreparedStatement stmt4 = con.prepareStatement(grabCustId);)
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
    
    out.println("<br>");
    out.println("<br>");
    out.println("<p>Post a Review:</p>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    out.println("<br>");
    
    out.println("<h3>Product Reviews: </h3>");

    stmt4.setString(1, user);
    ResultSet rst3 = stmt4.executeQuery();
    rst3.next();
    int custid = rst3.getInt(1);
    
    if(textreview != null) {
        stmt3.setTimestamp(1, new java.sql.Timestamp(new Date().getTime()));
        stmt3.setInt(2, custid);
        stmt3.setInt(3, Integer.parseInt(productId));
        stmt3.setString(4, textreview);
        stmt3.executeUpdate();
    }
    
    stmt2.setString(1, productId);
    ResultSet rst2 = stmt2.executeQuery();
    out.println("<table><tr><th>User ID</th><th>Date Posted</th><th>Review</th></tr>");
    while(rst2.next()) {
        out.println("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getTimestamp(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
    }
    out.println("</table>");


    
    
} catch (SQLException ex) 
{ 	out.println(ex); 
}


// TODO: If there is a productImageURL, display using IMG tag
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
		
// TODO: Add links to Add to Cart and Continue Shopping
%>

</body>
</html>

