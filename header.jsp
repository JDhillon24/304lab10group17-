<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Readex+Pro:wght@300&display=swap" rel="stylesheet">
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
                   
                    <%  
                    String userName = (String) session.getAttribute("authenticatedUser");
                    if (userName != null) {
                        out.println("<h3 style=\"color:White;\" align=\"center\" class=\"h3\">Signed in as: "+userName+"</h3>");
                        out.println("<li><span><a href=\"logout.jsp\" class=\"button\">Logout</a></span></li>");
                        out.println("<li><span><a href=\"listprod.jsp\" class=\"button\">Begin Shopping</a></span></li>");
                        out.println("<li><span><a href=\"listorder.jsp\" class=\"button\">List All Orders</a></span></li>");
                        out.println("<li><span><a href=\"customer.jsp\" class=\"button\">Customer Info</a></span></li>");
                        out.println("<li><span><a href=\"admin.jsp\" class=\"button\">Administrators</a></span></li>");
                        out.println("<li><span><a href=\"showcart.jsp\"  class=\"button\">Cart</a></span></li>");
                    
                    }else {
                        out.println("<li><span><a href=\"login.jsp\" class=\"button\">Login</a></span></li>");
                        out.println("<li><span><a href=\"createaccount.jsp\" class=\"button\">Register</a></span></li>");
                        out.println("<li><span><a href=\"listprod.jsp\" class=\"button\">Begin Shopping</a></span></li>");
                        out.println("<li><span><a href=\"listorder.jsp\" class=\"button\">List All Orders</a></span></li>");
                        out.println("<li><span><a href=\"customer.jsp\" class=\"button\">Customer Info</a></span></li>");
                        out.println("<li><span><a href=\"admin.jsp\" class=\"button\">Administrators</a></span></li>");
                        out.println("<li><span><a href=\"showcart.jsp\"  class=\"button\">Cart</a></span></li>");


                    }
                    
                    
                    
                    %>
                </nav>
            </div>
        </header>



</body>
</head>