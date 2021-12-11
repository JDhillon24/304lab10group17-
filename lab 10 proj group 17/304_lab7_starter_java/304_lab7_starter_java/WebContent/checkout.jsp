<html>
<head>
<title>Checkout</title>
<link rel="stylesheet" href="checkout.css">
</head>
<body>
<%@ include file="header.jsp" %>

<h1 align="center">Enter your info to complete the transaction:</h1>
<br>
<div align="center">
<form method="POST" action="order.jsp">
<table>
<tr class="spacerows"><td>Customer ID:</td><td><input type="text" name="customerId" size="20" required></td></tr>
<tr class="spacerows"><td>Password:</td><td><input type="password" name="password" size="20" maxlength=16 required></td></tr>
<tr class="spacerows"><td>Credit Card No:</td><td><input type="text" name="ccnumber" size="20" maxlength=16 pattern="[0-9]{16}" required></td></tr>
<tr class="spacerows"><td>Expiry Date (MMYY):</td><td><input type="text" name="expiry" size="20" maxlength=4 required></td></tr>
<tr class="spacerows">
<td><p>Address:</p></td>
<td><input type="text" name="address" size=20 maxlength=40 required></td>
</tr>
<tr class="spacerows">
<td><p>City:</p></td>
<td><input type ="text" name="city" size=20 maxlength=20 required></td>
</tr>
<tr class="spacerows">
<td><p>State:</p></td>
<td><input type="text" name="state" size=20 maxlength=20 required></td>
</tr>
<tr class="spacerows">
<td><p>Postal Code:</p></td>
<td><input type="text" name="postalcode" size=20 maxlength=7 required></td>
</tr>
<tr class="spacerows">
<td><p>Country:</p></td>
<td><input type="text" name="country" size=20 maxlength=20 required></td>
</tr>
<tr class="spacerows"><td><input type="submit" class="createbutton" value="Submit"></td></tr>
</table>
</form>
</div>
</body>
</html>

