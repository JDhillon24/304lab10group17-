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
<title>YOUR NAME Grocery Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
	// TODO: Get order id
	String orderId = request.getParameter("orderId");
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	String sql = "SELECT orderproduct.productId, orderproduct.quantity, productinventory.quantity FROM orderproduct JOIN productinventory ON orderproduct.productId = productinventory.productId WHERE orderId = ?";
	String insertquery = "INSERT INTO shipment(shipmentDate, warehouseId) VALUES (?,?)";
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
	java.sql.Date date = new java.sql.Date(System.currentTimeMillis());
	String shipcheck = "SELECT * FROM shipment ORDER BY shipmentId DESC";


	try
	{	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e)
	{
		out.println("ClassNotFoundException: " +e);
	}
	
	try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement pstmt = con.prepareStatement(sql);
	  Statement stmt = con.createStatement();
	  Statement stmt2 = con.createStatement();
	  Statement stmt3 = con.createStatement();
	  PreparedStatement pstmt2 = con.prepareStatement(insertquery);)
{	
	con.setAutoCommit(false);
	pstmt.setString(1, orderId);
	ResultSet rst = pstmt.executeQuery();

	

	pstmt2.setDate(1, date);
	pstmt2.setInt(2, 1);
	pstmt2.executeUpdate();
	con.commit();

	ResultSet rst2 = stmt2.executeQuery(shipcheck);
	rst2.next();
	int shipid = rst2.getInt(1);

	if(!rst.isBeforeFirst()) {
		out.println("<h1>Shipment not done. Invalid orderId.</h1>");
		con.rollback();

	}else{
		while(rst.next()) {
			if(rst.getInt(3) >= rst.getInt(2)) {
				out.println("<h2>Ordered product: " +rst.getInt(1)+" Qty: "+rst.getInt(2)+" Previous inventory: "+rst.getInt(3)+" New inventory: "+(rst.getInt(3)-rst.getInt(2)));
				String updatequery = "UPDATE productinventory SET quantity = " +(rst.getInt(3)-rst.getInt(2))+ " WHERE productId = " +rst.getInt(1);
				stmt.executeUpdate(updatequery);
				con.commit();
			}else {
				out.println("<h1>Shipment not done. Insufficient inventory for product id: "+rst.getInt(1)+"</h1>");
				con.rollback();
				break;
			}
		}

		ResultSet rst3 = stmt3.executeQuery(shipcheck);
		rst3.next();

		if(rst3.getInt(1) == shipid) {
			out.println("<h1>Shipment fully processed.</h1>");

		}
		




	}


	
	
	
	
	con.setAutoCommit(true);

}catch (SQLException ex) 
{ 	out.println(ex); 
}



          
	// TODO: Check if valid order id
	
	// TODO: Start a transaction (turn-off auto-commit)
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
