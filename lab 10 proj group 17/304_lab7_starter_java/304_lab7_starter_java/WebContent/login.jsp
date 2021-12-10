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
<h1>Please Login to System</h1>

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<br>
<form name="MyForm" method=post action="validateLogin.jsp">
<table style="display:inline">
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></div></td>
	<td><input type="text" name="username"  id = "username-field" placeholder = "Username" class = "login-form" size=10 maxlength=10></td>
</tr>
<tr>
	<td><div align="right"><font face="Arial, Helvetica, sans-serif" size="2"></div></td>
	<td><input type="password" name="password" id = "password-field" placeholder = "Password" class = "login-form" size=10 maxlength="10"></td>
</tr>
</table>
<br/>
<br>
<input class="submit" type="submit" name="Submit2" value="Log In" id = "submit-button">
</form>

</div>

</body>
</html>

