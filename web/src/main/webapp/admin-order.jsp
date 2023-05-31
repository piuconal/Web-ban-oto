
<%@page import="java.util.ArrayList"%>
<%@ page import="web.connection.DbCon"%>
<%@ page import="web.model.*"%>
<%@page import="web.dao.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    ProductDao productDap =  new ProductDao(DbCon.getConnection());
    UserDao userDao = new UserDao(DbCon.getConnection());
    OrderDao orderDao = new OrderDao(DbCon.getConnection());
    List<Order> orders = orderDao.getAllOrders();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin - Orders</title>
<link rel="stylesheet" href="./css/admin-order.css">
</head>
<body>
	<div class = "container">
	<h1 class = "title">Quản lý đơn hàng</h1>
	<table class ="table">
		<thead>
			<tr>
				<th>User Name</th>
				<th>Product Name</th>
				<th>Price</th>
				<th>Order Date</th>
				<th>Confirm Order</th>
				<th>Cancel Order</th>
				<th>Payment Status</th>
			</tr>
		</thead>
		<tbody>
			<% for (Order order : orders) { 
				int orderId = order.getOrderId();
				int Uid = order.getUid();
				String username = userDao.getUsernameByUserId(Uid);
			%>
			<tr>
				<td><%= username %></td>
				<td><%= order.getName() %></td>
				<td><%= order.getPrice() %></td>
				<td><%= order.getDate() %></td>
				<td><button class = "btn brn-confirm">Confirm</button></td>
				<td><button class = "btn btn-cancel">Cancel</button></td>
				<td><button class= "btn btn-status">Waiting..</button>
			</tr>
			<% } %>
		</tbody>
	</table>
	</div>
</body>
</html>

