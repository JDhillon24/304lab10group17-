<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>ClickForKicks Inc.</title>
  
</head>
<body>
    <header>
            <div class="inner">
                <div class="logo">
                    <div>
                        <a href="index.jsp"> <img src="clickforkickslogo.jpg" alt="Sagars Logo"> </a>
                     </div>
                </div>
    
                <nav>
                     
                    <li><span><a href="login.jsp" class="button">Login</a></span></li>
                    <li><span><a href="listprod.jsp" class="button">Begin Shopping</a></span></li>
                    <li><span><a href="listorder.jsp" class="button">List All Orders</a></span></li>
                    <li><span><a href="customer.jsp" class="button">Customer Info</a></span></li>
                    <li><span><a href="admin.jsp" class="button">Administrators</a></span></li>
                    <li><span><a href="showcart.jsp"  class="button">Cart</a></span></li>
                    
                     
                </nav>
            </div>
        </header>


<%
String userName = (String) session.getAttribute("authenticatedUser");
if (userName != null)
    out.println("<h3 align=\"center\">Signed in as: "+userName+"</h3>");
%>
</body>
</head>