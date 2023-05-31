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

<link rel="stylesheet" href="./css/cart.css">
</head>
<body>

	<%@include file="includes/nav.jsp"%>

	<div class="container1">
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Date</th>
					<th scope="col">Name</th>
					<th scope="col">Category</th>
					<th scope="col">Quantity</th>
					<th scope="col">Price</th>
					<th scope="col">Cancel</th>
					<th scope="col">Status</th>
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

					<td><a class="btn btn-danger"
						href="cancel-order?id=<%=o.getOrderId()%>">Cancel</a></td>
					<td><%=o.getStatus()%></td>
				<tr>
					<%
					}
					}
					%>
				
			</tbody>
		</table>
	</div>
</body>
</html>