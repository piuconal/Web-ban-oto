<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
<%@page import="web.model.*"%>
<%@page import="java.util.*"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getAllProducts();
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>HOME</title>
<link rel="stylesheet" href="./css/index.css">

</head>
<body>
	<%@include file="includes/nav.jsp"%>
	<div class="container">
		<div class="card-header">All Products</div>

		<div class="searchcar">
			<h3>Search car</h3>
			<form class="search" action="search" method="GET">
				<input type="text" name="keyword"> <input type="submit"
					value="Search">
			</form>
		</div>

		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
			%>
			<div class="box-content">
				<div class="card">
					<img class="card-img-top" src="./product-images/<%=p.getImage()%>">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price"><%=p.getPrice()%></h6>
						<h6 class="category">
							Category:
							<%=p.getCategory()%></h6>
						<div class="card-btn">
							<a href="add-to-cart?id=<%=p.getId()%>" class="add-btn">Add to cart</a> 
							<a href="order-now?quantity=1&id=<%=p.getId()%>" class="buy-btn">Buy Now</a>
						</div>
					</div>
				</div>	
			</div>
			<%
			}
			} else {
			out.println("No product");
			}
			%>
		</div>
	</div>
	<%@include file="includes/footer.jsp"%>
</body>
</html>