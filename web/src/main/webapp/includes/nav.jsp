<head>
<link rel="stylesheet" type="text/css" href="./css/nav.css">
</head>

<nav class="navbar">
	<div class="container">
		<img class="logo" src="./product-images/logo.png">
		<!-- <button class = "navbar-toggle" type ="button"></button>   -->
		<div class="navbar-content">
			<ul class="navbar-nav">
				<li class="nav-item"><a href="index.jsp">Home</a></li>
				<li class="nav-item"><a href="cart.jsp">Cart</a></li>
				<%
				if (auth != null) {
				%>
				<li class="nav-item"><a href="order.jsp">Order</a></li>
				<li class="nav-item"><a href="log-out">Logout</a></li>
				<%
				} else {
				%>
				<li class="nav-item"><a href="login.jsp">Login</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>