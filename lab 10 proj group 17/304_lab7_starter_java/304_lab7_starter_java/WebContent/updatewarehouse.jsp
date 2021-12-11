<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.util.Locale" %>


<!DOCTYPE html>
<html>
<head>
<title>Update Warehouse</title>
<link rel="stylesheet" href="updateproduct.css">
</head>
<body>
	<%@ include file="header.jsp" %>

<br />
<h1><center>Update Warehouse</center></h1>
<br />
<div align="center">
<form name="MyForm1" method=post action="#">
    <table style="display:inline">
    <tr class= "spacerows">
        <td><p>Warehouse ID:</p></td>
        <td><input type="text" name="wId"  id = "productId-field"  class = "Product-form" size=2 maxlength=2 required></td>
    </tr>
    <tr class= "spacerows">
        <td><p> Name: </p> </td>
        <td><input type="text" name="wName"  id = "productName-field"  class = "Product-form" size=10 maxlength=50 required></td>
    </tr>
    
    <tr><td><input class="submit-button" type="submit" name="Submit2" value="Submit" id = "submit-button"></td></tr>
   
</table>
</form>
</div>
<%

String wId = request.getParameter("wId");
String wName = request.getParameter("wName");


//Note: Forces loading of SQL Server driver
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";


try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}
String sql = "UPDATE warehouse SET warehouseName = ? WHERE warehouseId = ?";

try ( Connection con = DriverManager.getConnection(url, uid, pw);
      PreparedStatement stmt = con.prepareStatement(sql); )
{   
    
    

    
    if(wId == null) {

    }else {
        if(wName != null && wName != ""){
            stmt.setString(1, wName);
            stmt.setInt(2, StringtoInt(wId, 0));
            stmt.executeUpdate();
        }else{
        }
        
    }





 
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
//response.sendRedirect("admin.jsp");
// Close connection
%>


<%!
    int StringtoInt(String x, int y) {

        try {
            return Integer.parseInt(x);
        }
        catch (NumberFormatException e) {
            return y;
        }
    }

    double StringtoDouble(String x, double y) {

        try {
            return Double.parseDouble(x);
        }
        catch (NumberFormatException e) {
            return y;
        }
    }






%>

</body>
</html>