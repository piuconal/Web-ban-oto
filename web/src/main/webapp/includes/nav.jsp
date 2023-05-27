<head>
<link rel="stylesheet" type="text/css" href="./css/nav.css">
</head>

<body>
	<div class="navbar-content">
		<img src="./product-images/logo.png">
		<div class="navbar-nav">
			<a href="index.jsp">HOME</a> 
			<a href="cart.jsp">CART</a> 
			<a href="order.jsp">ORDER	</a>
			<%
			if (auth != null) {
			%>
			<a href="log-out">LOGOUT</a>
			<%
			} else {
			%>
			<a href="login.jsp">LOGIN</a>
			<%
			}
			%>
		</div>
	</div>
</body>

