<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
<%@page import="web.model.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
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
<title>Search</title>
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
			<li><a href="search.jsp?category=Bugatti">Bugatti</a></li>
			<li><a href="search.jsp?category=Lamborghini">Lamborghini</a></li>
			<li><a href="search.jsp?category=Ferrari">Ferrari</a></li>
			<li><a href="search.jsp?category=Porsche">Porsche</a></li>
			<li><a href="search.jsp?category=Mercedes">Mercedes</a></li>
			<li><a href="search.jsp?category=McLaren">McLaren</a></li>
			<li><a href="search.jsp?category=Bentley">Bentley</a></li>
			<li><a href="search.jsp?category=Rolls-Royce">Rolls-Royce</a></li>
			<li><a href="search.jsp?category=Aston Martin">Aston Martin</a></li>
			<li><a href="search.jsp?category=Audi">Audi</a></li>
		</ul>

		<div class="searchcar">
			<form class="search" action="search.jsp" method="GET">
				<input class="tkxe" type="text" name="keyword"
					placeholder="Search car....."> <input class="btn-search"
					type="submit" value="Search">
			</form>

			<ul class="menu2">
				<li><a href="search.jsp?maxPrice=300000">Down $300,000</a></li>
				<li><a href="search.jsp?minPrice=500000&maxPrice=1000000">$500,000
						- 1,000,000 </a></li>
				<li><a href="search.jsp?minPrice=1000000&maxPrice=3000000">$1,000,000
						- 3,000,000 </a></li>
				<li><a href="search.jsp?minPrice=3000000">Up $3,000,000</a></li>
			</ul>
		</div>
		<%
		String searchKeyword = request.getParameter("keyword");
		String minPriceStr = request.getParameter("minPrice");
		String maxPriceStr = request.getParameter("maxPrice");
		String category = request.getParameter("category");
		int minPrice = 0; // Default minimum price
		int maxPrice = Integer.MAX_VALUE; // Default maximum price

		if (minPriceStr != null && !minPriceStr.isEmpty()) {
			minPrice = Integer.parseInt(minPriceStr);
		}

		if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
			maxPrice = Integer.parseInt(maxPriceStr);
		}
		%>

		<div class="row">
			<%
			if (!products.isEmpty()) {
				for (Product p : products) {
					if ((searchKeyword != null && !searchKeyword.isEmpty()
					&& !p.getName().toLowerCase().contains(searchKeyword.toLowerCase()))
					|| (category != null && !category.isEmpty() && !p.getCategory().equalsIgnoreCase(category))
					|| p.getPrice() < minPrice || p.getPrice() > maxPrice)
				continue;
					// Lấy giá trị số từ đối tượng p
					double price = p.getPrice();

					// Tạo đối tượng DecimalFormatSymbols với mã hóa ISO-8859-1
					DecimalFormatSymbols symbols = new DecimalFormatSymbols();
					symbols.setGroupingSeparator(',');

					// Tạo đối tượng DecimalFormat với định dạng số và DecimalFormatSymbols
					DecimalFormat formatter = new DecimalFormat("#,###", symbols);
					String formattedPrice = formatter.format(price);
			%>
			<div class="box-content">
				<div class="card">
					<img class="card-img-top" src="./product-images/<%=p.getImage()%>">
					<div class="card-body">
						<h5 class="card-title"><%=p.getName()%></h5>
						<h6 class="price">
							$
							<%=formattedPrice%>
						</h6>
						<h6 class="category">
							Category:
							<%=p.getCategory()%></h6>
						<div class="card-btn">
							<button class="add-btn" onclick="addToCart(<%=p.getId()%>)">Add
								to cart</button>
							<select class="add-buy">
								<option value="">Payment methods</option>
								<option value="option1">Installment</option>
								<option value="option2">Pay away</option>
							</select>
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
		<script>
    function addToCart(productId) {
    	var xhr = new XMLHttpRequest();
        xhr.open('GET', 'add-to-cart?id=' + productId, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4 && xhr.status === 200) {
            }
        };
        xhr.send();
    }
</script>
</body>
</html>
