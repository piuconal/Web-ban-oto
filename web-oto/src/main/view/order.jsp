<%@page import="java.util.ArrayList"%>
<%@ page import="web.connection.DbCon"%>
<%@ page import="web.model.*"%>
<%@page import="web.dao.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
User auth = (User) request.getSession().getAttribute("auth");
List<Order> orders = null;
if (auth != null) {
	request.setAttribute("auth", auth);
	orders = new OrderDao(DbCon.getConnection()).userOrders(auth.getId());
} else {
	response.sendRedirect("login.jsp");
}
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
if (cart_list != null) {
	request.setAttribute("cart_list", cart_list);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order</title>

<link rel="stylesheet" href="./css/admin-order.css">
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>

	<%@include file="includes/nav.jsp"%>

	<div class="container1">
		<table class="table">
			<thead>
				<tr>
					<th>Date</th>
					<th>Name</th>
					<th>Category</th>
					<th>Quantily</th>
					<th>Price</th>
					<th>Cancel</th>
					<th>Status</th>
				</tr>
			</thead>

			<tbody>
				<%
				if (orders != null) {
					for (Order o : orders) {
						double price = o.getPrice();

						DecimalFormatSymbols symbols = new DecimalFormatSymbols();
						symbols.setGroupingSeparator(',');

						DecimalFormat formatter = new DecimalFormat("#,###", symbols);
						String formattedPrice = formatter.format(price);
				%>
				<tr>
					<td><%=o.getDate()%></td>
					<td><%=o.getName()%></td>
					<td><%=o.getCategory()%></td>
					<td><%=o.getQuantity()%></td>
					<td>$<%=formattedPrice%></td>

					<td><a href="cancel-order?id=<%=o.getOrderId()%>">
							<button type="button" class="btn btn-cancel">Cancel</button>
					</a></td>
					<td class="status"><%=o.getStatus() %></td>
				<tr>
					<%
					}
					}
					%>
				
			</tbody>
		</table>
	</div>
	<script src="js/order.js"></script>
</body>
</html>