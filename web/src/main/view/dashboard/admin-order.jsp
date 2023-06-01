
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
ProductDao productDap = new ProductDao(DbCon.getConnection());
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
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>
	<div class="container">
		<h1 class="title">Quản lý đơn hàng</h1>
		<table class="table">
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
				<%
				for (Order order : orders) {
					int orderId = order.getOrderId();
					int Uid = order.getUid();
					String username = userDao.getUsernameByUserId(Uid);
				%>
				<tr>
					<td><%=username%></td>
					<td><%=order.getName()%></td>
					<td><%=order.getPrice()%></td>
					<td><%=order.getDate()%></td>
					<td><button class="btn" id="btn-confirm">Confirm</button></td>
					<td><button class="btn" id="btn-cancel">Cancel</button></td>
					<td><button class="btn" id="btn-status">Waiting..</button></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<div id="confirmPopup" class="popup">
		<div class="popup-content">
			<h2>Xác nhận đơn hàng</h2>
			<p>Bạn có chắc chắn muốn xác nhận đơn hàng này?</p>
			<div class="popup-buttons">
				<button class="btn btn-confirm-popup">Xác nhận</button>
				<button class="btn btn-cancel-popup">Hủy</button>
			</div>
		</div>
	</div>
</body>
</html>

