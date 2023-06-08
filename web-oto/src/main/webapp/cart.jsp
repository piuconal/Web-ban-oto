<%@ page import="web.model.*"%>
<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
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
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if (cart_list != null) {
	ProductDao pDao = new ProductDao(DbCon.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	int total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("total", total);
	request.setAttribute("cart_list", cart_list);
	DecimalFormat decimalFormat = new DecimalFormat("#,###");
	String formattedTotal = decimalFormat.format(total);
	request.setAttribute("formattedTotal", formattedTotal);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
<link rel="stylesheet" href="./css/cart.css">
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>
	<style>
body {
	background: url("./product-images/hot.png");
}
</style>
     <%@include file="includes/nav.jsp"%>
	<div class="container1">

		<div class="price">$ ${(total>0)?formattedTotal:0}</div>
		<a class="btn-check-out" href="cart-check-out">Check out</a>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Price</th>
					<th scope="col">Buy Now</th>
					<th scope="col">Cancel</th>
				</tr>
			</thead>
			<tbody>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
						double price = c.getPrice();

						DecimalFormatSymbols symbols = new DecimalFormatSymbols();
						symbols.setGroupingSeparator(',');

						DecimalFormat formatter = new DecimalFormat("#,###", symbols);
						String formattedPrice = formatter.format(price);
				%>
				<tr>
					<td><%=c.getName()%> </br> <img class="card-img-top"
						src="./product-images/<%=c.getImage()%>"
						style="width: 200px; height: 100px;"></td>
					<td><%=c.getCategory()%></td>
					<td>$ <%=formattedPrice%></td>
					<td>
						<form action="order-now" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%=c.getId()%>"
								class="form-input">
							<div class="form-group d-flex justify-content-between">
								<a class="btn-decre"
									href="quantity-inc-dec?action=dec&id=<%=c.getId()%>">-</a> <input
									type="text" name="quantity" class="form-control"
									value="<%=c.getQuantity()%>" readonly> <a
									class="btn-incre"
									href="quantity-inc-dec?action=inc&id=<%=c.getId()%>">+</a>
							</div>
							<button type="submit" class="btn-sm">Buy</button>
						</form>
					</td>
					<td><a href="remove-from-cart?id=<%=c.getId()%>"
						class="btn-danger"> Remove </a></td>
				</tr>

				<%
				}
				}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>
</html>