<%@page import="web.dao.OrderDao"%>
<%@page import="web.dao.UserDao"%>
<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
<%@page import="web.model.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User auth = (User) request.getSession().getAttribute("");
if (auth != null) {
	request.setAttribute("admin", auth);
}
ProductDao productDao = new ProductDao(DbCon.getConnection());
OrderDao orderDao = new OrderDao(DbCon.getConnection());
List<Order> orders = orderDao.getAllOrders();
List<Order> theoSP = orderDao.getAllOrdersProductNames();

// UserDao userDao = new UserDao(DbCon.getConnection());
// ArrayList<User> users = userDao.selectAllUser();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.table-container {
	display: flex;
	flex-direction: column;
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 15px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

/* th:last-child, td:last-child {
        text-align: right;
      } */
button {
	background-color: #4caf50;
	color: white;
	border: none;
	padding: 10px 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	cursor: pointer;
}

button:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	<%@include file="./includes/tieude.jsp"%>
	<div class="table-container">
		<table>
			<thead>
				<tr>
					<th>Order id</th>
					<th>Product id</th>
					<th>Name</th>
					<th>Quantity</th>
					<th>Price</th>
				</tr>
			</thead>
			<tbody></tbody>
			<%
			for (Order o : orders) {
			%>
			<tr>
				<td><%=o.getOrderId()%></td>
				<td><%=o.getId()%></td>
				<td><%=o.getName()%></td>
				<td><%=o.getQuantity()%></td>
				<td><%=o.getPrice()%></td>
			</tr>
			<%
			}
			%>

		</table>
		<h1>Thống kê theo số lượng sản phẩm</h1>
		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody></tbody>
			<%
			for (Order t : theoSP) {
			%>
			<tr>
				<td><%=t.getName()%></td>
				<td><%=t.getQuantity()%></td>
			</tr>
			<%
			}
			%>

		</table>
		<form action="" method="GET">
			<label for="productName">Chọn tên sản phẩm:</label> <select
				name="productName" id="productName">
				<%
				for (Order order : orders) {
				%>
				<option value="<%=order.getName()%>"><%=order.getName()%></option>
				<%
				}
				%>
			</select> <input type="submit" value="Xem số lượng">
		</form>
		<%
		String selectedProduct = request.getParameter("productName");
		if (selectedProduct != null) {
			for (Order order : orders) {
				if (order.getName().equals(selectedProduct)) {
		%>
		<h1>Kết quả</h1>
		<p>
			Tên sản phẩm:
			<%=order.getName()%></p>
		<p>
			Số lượng:
			<%=order.getQuantity()%></p>
		<%
		}
		}
		}
		%>
	
</body>
</html>