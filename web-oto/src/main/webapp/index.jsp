<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
<%@page import="web.model.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.DecimalFormatSymbols"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

int productsPerPage = 4; // Số sản phẩm trên mỗi trang
int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1; // Trang hiện tại
int offset = (currentPage - 1) * productsPerPage; // Vị trí bắt đầu lấy sản phẩm

ProductDao pd = new ProductDao(DbCon.getConnection());
List<Product> products = pd.getProductsByPage(offset, productsPerPage); // Lấy danh sách sản phẩm cho trang hiện tại
int totalProducts = pd.getTotalProducts(); // Tổng số sản phẩm

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}

session.setAttribute("auth", auth);
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home-PiuOto</title>
<link rel="stylesheet" href="./css/index.css">
<link rel="icon" href="./product-images/icontab.png">
</head>

<style>
body {
	background: url("./product-images/hot.png");
}
</style>

<body>
	<%@include file="includes/nav.jsp"%>

	<!-- banner -->
	<div class="banner">
		<iframe
			src="https://www.youtube.com/embed/p_is7qzLuFM?autoplay=1&mute=1"></iframe>
	</div>
	<!-- end banner -->

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
			<form class="search" action="search-car" method="GET">
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

		<div class="row">
			<%
			String searchKeyword = request.getParameter("keyword");
			if (!products.isEmpty()) {
				for (Product p : products) {
					if (searchKeyword != null && !searchKeyword.isEmpty()
					&& !p.getName().toLowerCase().contains(searchKeyword.toLowerCase())) {
				continue;
					}
					double price = p.getPrice();

					DecimalFormatSymbols symbols = new DecimalFormatSymbols();
					symbols.setGroupingSeparator(',');
					DecimalFormat formatter = new DecimalFormat("#,###", symbols);
					String formattedPrice = formatter.format(price);
			%>
			<div class="box-content">
				<div class="card">
					<a href="comment.jsp?productId=<%=p.getId()%>"> <img
						class="card-img-top" src="./product-images/<%=p.getImage()%>">
					</a>
					<div class="card-body">
						<a href="comment.jsp?productId=<%=p.getId()%> ">
							<h5 class="card-title"><%=p.getName()%></h5>
						</a>

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
			}
			%>
		</div>

		<ul class="pagination" id="pagination">
			<%
			int totalPages = (int) Math.ceil((double) totalProducts / productsPerPage);
			for (int i = 1; i <= totalPages; i++) {
				if (i == currentPage) {
			%>
			<li class="active"><a href="?page=<%=i%>"><%=i%></a></li>
			<%
			} else {
			%>
			<li><a href="?page=<%=i%>"><%=i%></a></li>
			<%
			}
			}
			%>
		</ul>
	</div>
	<%@include file="includes/footer.jsp"%>

	<script src="./js/index.js"></script>
</body>
</html>