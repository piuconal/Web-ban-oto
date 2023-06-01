<head>
<style>
<
style>body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
}

.navbar {
	background-color: #333;
	overflow: hidden;
	height: 50px;
	display: flex;
	align-items: center;
}

.navbar a {
	color: white;
	text-align: center;
	text-decoration: none;
	padding: 20px 20px;
}

.navbar a:hover {
	background-color: #ddd;
	color: black;
}
</style>
</head>
<body>
	<div class="navbar">
		<a href="thongke.jsp">Report</a>
		<a href="#">Product Management</a> 
		<a href="userManagement.jsp">User Management</a>
		<a href="order.jsp">Order Management</a>
		<%
			if (auth != null) {
			%>
			<a href="log-out">LOGOUT</a>
			<%
			}
			
			%>
	</div>
</body>