<!DOCTYPE html>
<html>
<head>
<title>ClickForKicks Login</title>
<link rel="stylesheet" href="login.css">
</head>
<body>
<%@ include file="header.jsp" %>
<br>

<div style="margin:0 auto;text-align:center;display:inline" >

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<h1>Ship Order</h1>



<br>
<form name="MyForm" method=post action="ship.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"> Order Id: </div></td>
	<td><input type="text" name="orderId"  id = "shiporder-field"  class = "login-form" size=10 maxlength=10></td>
</tr>
</table>
<br/>
<br>
<input class="submit" type="submit" name="Submit2" value="Ship" id = "submit-button">
</form>

</div>

</body>
</html>

