<link rel ="stylesheet" type = "text/css" href = "/webapp/css/nav.css">
<nav class ="navbar">
        <div class ="container">
            <a class ="brand" href = "index.jsp">Shopping cart</a>    
            <!-- <button class = "navbar-toggle" type ="button"></button>   -->
            <div class = "navbar-content">
                <ul class ="navbar-nav">
                    <li class ="nav-item"><a href = "index.jsp">Home</a></li>
                    <li class ="nav-item"><a href = "cart.jsp">Cart</a></li>
                    <%
                    if(auth != null){ %>
                    	<li class ="nav-item"><a href = "order.jsp">Order</a></li>
                        <li class ="nav-item"><a href = "log-out">Logout</a></li>
                    <%}else{%>
                    	 <li class ="nav-item"><a href = "login.jsp">Login</a></li>
                   <% }
                    %>
                    
                   
                </ul>
            </div> 
        </div>
    </nav>