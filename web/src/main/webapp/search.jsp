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
<meta charset="UTF-8">
<title>Search Results</title>
<link rel="stylesheet" href="./css/index.css">
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>
	<style>
body {
	background: url("./product-images/hot.png");
}
</style>
	<%@include file="includes/nav.jsp"%>
	<div class="container">
		<ul class="menu">
			<li><a href="#">Buggatii</a></li>
			<li><a href="#">Lamborghini</a></li>
			<li><a href="#">Ferrari</a></li>
			<li><a href="#">Porsche</a></li>
			<li><a href="#">Mercedes</a></li>
			<li><a href="#">McLaren</a></li>
			<li><a href="#">Bentley</a></li>
			<li><a href="#">Rolls-Royce</a></li>
			<li><a href="#">Aston Martin</a></li>
			<li><a href="#">Audi</a></li>
		</ul>

		<div class="searchcar">
			<form class="search" action="search.jsp" method="GET">
				<input class="tkxe" type="text" name="keyword"
					placeholder="Search car....."> <input class="btn-search"
					type="submit" value="Search">
			</form>

			<ul class="menu2">
				<li><a href="#">Down 300,000 $</a></li>
				<li><a href="#">500,000 -> 1,000,000 $</a></li>
				<li><a href="#">1,000,000 -> 3,000,000 $</a></li>
				<li><a href="#">Up 3,000,000 $</a></li>
			</ul>
		</div>
		<%
		String searchKeyword = request.getParameter("keyword");
		%>

		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
					if (searchKeyword != null && !searchKeyword.isEmpty()
					&& !p.getName().toLowerCase().contains(searchKeyword.toLowerCase())) {
				continue; // Skip this product if it doesn't match the search keyword
					}
			%>
			<div class="box-content">
				<div class="card">
					<img class="card-img-top" src="./product-images/<%=p.getImage()%>">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price"><%=p.getPrice()%>
							$
						</h6>
						<h6 class="category">
							Category:
							<%=p.getCategory()%></h6>
						<div class="card-btn">
							<a href="add-to-cart?id=<%=p.getId()%>" class="add-btn">Add
								to cart</a> <a href="order-now?quantity=1&id=<%=p.getId()%>"
								class="buy-btn">Buy Now</a>
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

		<%@include file="includes/footer.jsp"%>
</body>
</html>
