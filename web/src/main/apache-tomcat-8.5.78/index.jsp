<%@ page import = "web.connection.DbCon" %>
<%@ page import = "web.model.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    User auth = (User) request.getSession().getAttribute("auth");
    if(auth != null){
    	request.setAttribute("auth", auth);
    }
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>

<%@include file="includes/head.jsp"%>
</head>
<body>
	<%@include file="includes/nav.jsp"%>
	<div class="container">
		<div class=" card-header">All product</div>
		<div class="box">
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d1.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d1.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d2.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d3.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d4.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
			<div class="box-content">
				<div class="card" >
					<img class="card-img-top" src="./product-images/d5.png">
					<div class="card-body">
						<h5 class="card-title">Card title</h5>
						<h6 class = "price">Price : $542</h6>
						<h6 class = "category">Category: some category</h6>
						<div class="card-btn">
							<a href="#" class="add-btn">Add to cart</a> <a href="#"
								class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@include file="includes/footer.jsp"%>
</body>
</html>