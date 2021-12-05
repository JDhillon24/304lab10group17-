<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>
<body>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
String query = "SELECT address, city, state, postalCode, country, CONCAT(firstName, ' ', lastName) FROM customer WHERE customerId = ?";
java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
String sql = "INSERT INTO orderSummary(shiptoAddress, shiptoCity, shiptoState, shiptoPostalCode, shiptoCountry, customerId, orderDate) VALUES (?,?,?,?,?,?,?)";
String sql2 = "INSERT INTO orderProduct VALUES (?,?,?,?)";

@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

// Determine if valid customer id was entered
// Determine if there are products in the shopping cart
// If either are not true, display an error message
if(Integer.parseInt(custId) < 1 || Integer.parseInt(custId) > 5) {
	out.println("<h1>Invalid customer id. Go back to the previous page and try again.</h1>");
}else if(productList == null) {
	out.println("<h1>Your shopping cart is empty!</h1>");
}else {
	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}

	try (Connection con = DriverManager.getConnection(url, uid, pw);
		 PreparedStatement pstmt1 = con.prepareStatement(query);
		 PreparedStatement pstmt2 = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		 PreparedStatement pstmt3 = con.prepareStatement(sql2);
		 Statement stmt = con.createStatement();
		 Statement stmt2 = con.createStatement();)
	{	
		pstmt1.setString(1, custId);
		ResultSet rst = pstmt1.executeQuery();
		rst.next();
		pstmt2.setString(1, rst.getString(1));
		pstmt2.setString(2, rst.getString(2));
		pstmt2.setString(3, rst.getString(3));
		pstmt2.setString(4, rst.getString(4));
		pstmt2.setString(5, rst.getString(5));
		pstmt2.setInt(6, Integer.parseInt(custId));
		pstmt2.setDate(7, date);

		pstmt2.executeUpdate();
		ResultSet keys = pstmt2.getGeneratedKeys();
		keys.next();
		int orderId = keys.getInt(1);
		double total = 0;


		Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext())
			{ 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ( (Integer)product.get(3)).intValue();
				total += (pr * qty);

				pstmt3.setInt(1,orderId);
				pstmt3.setInt(2,Integer.parseInt(productId));
				pstmt3.setInt(3,qty);
				pstmt3.setDouble(4,pr);
				pstmt3.executeUpdate();
				
			}
		String sql3 = "UPDATE orderSummary SET totalAmount = " + total + " WHERE orderId = " + orderId;
		stmt.executeUpdate(sql3);
		out.println("<h1>Your Order Summary</h1>");
		
		String sql4 = "SELECT orderProduct.productId AS productId, productName, quantity, price, (quantity*price) AS subtotal FROM product JOIN orderProduct ON product.productId = orderProduct.productId WHERE orderId = " + orderId;
		ResultSet rst2 = stmt2.executeQuery(sql4);
		out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");
		while (rst2.next()) {
			out.println("<tr><td>"+rst2.getInt(1)+"</td>"+"<td>"+rst2.getString(2)+"</td>"+"<td>"+rst2.getInt(3)+"</td>"+"<td>"+currFormat.format(rst2.getDouble(4))+"</td>"+"<td>"+currFormat.format(rst2.getDouble(5))+"</td></tr>");
		}
		
			

		out.println("</table>");

		out.println("<h1>Order completed. Will be shipped soon...</h1>");
		out.println("<h1>Your order reference number is: " +orderId+"</h1>");
		out.println("<h1>Shipping to customer: " +custId+ " Name: "+rst.getString(6)+"</h1>");
		String link = "index.jsp";
		out.println("<h2><a href ="+link+">Return to Shopping</a></h2>");

		productList.clear();

	}
	catch (SQLException ex) 
	{ 	out.println(ex); 
	}





}

// Make connection

// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully
%>
</BODY>
</HTML>

