<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.util.Locale" %>

<html>
<head>
<title>ClickForKicks Order Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
// Get customer id
String custId = request.getParameter("customerId");
// Get password
String password = request.getParameter("password");
String ccnumber = request.getParameter("ccnumber");
String expiry = request.getParameter("expiry");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String postalcode = request.getParameter("postalcode");
String country = request.getParameter("country");
// Get shopping cart
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}                

String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String sql = "SELECT customerId, firstName+' '+lastName, password FROM customer WHERE customerId = ?";

try (Connection con = DriverManager.getConnection(url, uid, pw);
PreparedStatement pstmt = con.prepareStatement(sql);)
{	
	if (custId == null || custId.equals(""))
		out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
	else if (productList == null)
		out.println("<h1>Your shopping cart is empty!</h1>");
	else
	{	
		// Check if customer id is a number
		int num=-1;
		try
		{
			num = Integer.parseInt(custId);
		} 
		catch(Exception e)
		{
			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
			return;
		}		
        
		
	                		
        	
				      
   		pstmt.setInt(1, num);
   		ResultSet rst = pstmt.executeQuery();
   		int orderId=0;
   		String custName = "";

   		if (!rst.next())
   		{
   			out.println("<h1>Invalid customer id.  Go back to the previous page and try again.</h1>");
   		}
   		else
   		{	
   			custName = rst.getString(2);
			String dbpassword = rst.getString(3);
				    		
			// make sure the password on the database is the same as the one the user entered
			if (!dbpassword.equals(password)) 
			{
				out.println("The password you entered was not correct.  Please go back and try again.<br>"); 
				return;
			}
		
   			// Enter order information into database
   			sql = "INSERT INTO OrderSummary (customerId, totalAmount, orderDate) VALUES(?, 0, ?);";

   			// Retrieve auto-generated key for orderId
   			PreparedStatement pstmt2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
   			pstmt2.setInt(1, num);
   			pstmt2.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
   			pstmt2.executeUpdate();
   			ResultSet keys = pstmt2.getGeneratedKeys();
   			keys.next();
   			orderId = keys.getInt(1);

   			out.println("<h1>Your Order Summary</h1>");
         	  	out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Product Size</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

           	double total =0;
           	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
           	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
						
           	while (iterator.hasNext())
           	{ 
           		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
                   ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
   				String productId = (String) product.get(0);
                   out.print("<tr><td>"+productId+"</td>");
                   out.print("<td>"+product.get(1)+"</td>");
   				out.print("<td align=\"center\">"+product.get(4)+"</td>");
				out.print("<td align=\"center\">"+product.get(3)+"</td>");
                   String price = (String) product.get(2);
                   double pr = Double.parseDouble(price);
                   int qty = ( (Integer)product.get(3)).intValue();
				   String shoesize = (String) product.get(4);
   				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
                  	out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
                   out.println("</tr>");
                   total = total +pr*qty;

               	sql = "INSERT INTO OrderProduct (orderId, productId, productSize, quantity, price) VALUES(?, ?, ?, ?, ?)";
   				PreparedStatement pstmt3 = con.prepareStatement(sql);
   				pstmt3.setInt(1, orderId);
   				pstmt3.setInt(2, Integer.parseInt(productId));
   				pstmt3.setString(3, shoesize);
   				pstmt3.setInt(4, qty);
				pstmt3.setDouble(5,pr);
   				pstmt3.executeUpdate();				
           	}
           	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
                          	+"<td aling=\"right\">"+currFormat.format(total)+"</td></tr>");
           	out.println("</table>");

   			// Update order total
   			sql = "UPDATE OrderSummary SET totalAmount=? WHERE orderId=?";
   			PreparedStatement pstmt4 = con.prepareStatement(sql);
   			pstmt4.setDouble(1, total);
   			pstmt4.setInt(2, orderId);			
   			pstmt4.executeUpdate();
			out.println("<br>");
			out.println("<h3>Shipping Info:</h3>");
			out.println("<p>"+custName+"</p>");
			out.println("<p>"+address+"</p>");	
			out.println("<p>"+city+", "+state+" "+postalcode+"</p>");
			out.println("<p>"+country+"</p>");
			out.println("<br>");								

   			out.println("<h1>Order completed.  Will be shipped soon...</h1>");
   			out.println("<h1>Your order reference number is: "+orderId+"</h1>");
   			out.println("<h1>Shipping to customer: "+custId+" Name: "+custName+"</h1>");   			
   			
   			// Clear session variables (cart)
   			session.setAttribute("productList", null);    
   		}
   	}
}
catch (SQLException ex)
{ 	out.println(ex);
}
finally
{
	try
	{
		if (con != null)
			con.close();
	}
	catch (SQLException ex)
	{       out.println(ex);
	}
}  
%>                       				
<br>
<h2><a href="index.jsp">Back to Main Page</a></h2>

</body>
</html>
