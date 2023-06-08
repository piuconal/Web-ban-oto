

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
<%@include file="includes/tieude.jsp"%>
	<div class="container">
		<h1 class="title">Quản lý đơn hàng</h1>
		<table class="table">
			<thead>
				<tr>
					<th>User Name</th>
					<th>ID Order</th>
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
					<td><%=order.getOrderId() %></td>
					<td><%= order.getName() %></td>
					<td><%= order.getPrice() %></td>
					<td><%= order.getDate() %></td>
					<td><button class="btn btn-confirm"><%=order.getStatus() %></button></td>
					<td><button class="btn btn-cancel">Cancel</button></td>
					<td><button class="btn btn-status"><%= order.getPayment() %></button></td>
				</tr>
				<% } %>
			</tbody>
		</table>
	</div>
	<div id="confirmPopup" class="popup">
		<div class="popup-content">
			<h2>Xác nhận đơn hàng</h2>
			<p>Bạn có chắc chắn muốn xác nhận đơn hàng này?</p>
			<div class="popup-buttons">
				<button class="btn" id="btn-confirm-popup">Xác nhận</button>
				<button class="btn" id="btn-cancel-popup">Hủy</button>
			</div>
		</div>
	</div>
	<div id="confirmPayment" class="popup">
		<div class="popup-content">
			<h2>Xác nhận đơn hàng đã thanh toán</h2>
			<p>Bạn có chắc chắn muốn xác nhận đơn hàng này đã được thanh toán
				toàn bộ?</p>
			<div class="popup-buttons">
				<button class="btn" id="btn-confirm-pop">Xác nhận</button>
				<button class="btn" id="btn-cancel-pop">Hủy</button>
			</div>
		</div>
	</div>
	<div id="confirmCancel" class="popup">
		<div class="popup-content">
			<h2>Xác nhận hủy đơn hàng</h2>
			<p>Bạn có chắc chắn muốn hủy đơn hàng này ?</p>
			<div class="popup-buttons">
				<button class="btn" id="btn-confirm-cancel">Xác nhận</button>
				<button class="btn" id="btn-cancel-cancel">Hủy</button>
			</div>
		</div>
	</div>

</body>
<script src="./js/a_order.js">
</script>
</html>

