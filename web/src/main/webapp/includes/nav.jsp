<head>
<link rel="stylesheet" type="text/css" href="./css/nav.css">
</head>

<body>
	<div class="navbar-content">
		<img src="./product-images/logo.png">
		<ul class="navbar-nav">
			<li class="nav-item"><a href="index.jsp">HOME</a></li>
			<li class="nav-item"><a href="cart.jsp">CART</a></li>
			<%
			if (auth != null) {
			%>
			<li class="nav-item"><a href="order.jsp">ORDER</a></li>
			<li class="nav-item"><a href="log-out">LOGOUT</a></li>
			<%
			} else {
			%>
			<li class="nav-item"><a href="login.jsp">LOGIN</a></li>
			<%
			}
			%>
		</ul>
	</div>
</body>

