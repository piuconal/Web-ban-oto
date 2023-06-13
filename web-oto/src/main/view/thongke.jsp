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
User auth = (User) request.getSession().getAttribute("admin");
if (auth != null) {
	request.setAttribute("admin", auth);
}
session.setAttribute("admin", auth);

ProductDao productDao = new ProductDao(DbCon.getConnection());
OrderDao orderDao = new OrderDao(DbCon.getConnection());
List<Order> orders = orderDao.getAllOrders();
List<Order> theoSP = orderDao.getAllOrdersProductNames();
List<Order> odr = orderDao.getUserbyProductOrder();
UserDao userDao = new UserDao(DbCon.getConnection());
List<Product> products = productDao.getAllProducts();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.table-container {
	display: flex;
	width: 100%;
}

table {
	width: 100%;
	border-collapse: collapse;
	/* display: none; */
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
	width: 26%;
	border: 1px solid #ccc;
}

button:hover {
	background-color: #45a049;
}

.column {
	display: none;
}

.active {
	display: block;
}
</style>
</head>
<body>
	<%@include file="./includes/tieude.jsp"%>
	<div class="table-container">
		<button class="btn-table">Thống kê theo số lượng sản phẩm đã
			bán được</button>

		<button class="btn-table">Xem khách hàng đã mua sản phẩm
			được chọn</button>

		<button class="btn-table">Thống kê sản phẩm đã bán được theo
			từng ngày</button>

		<button class="btn-table">Thống kê sản phẩm theo khách hàng</button>

	</div>

	<div class="section">

		<div class="column active">
			<table id="bang2">
				<thead>
					<tr>
						<th>Name</th>
						<th>Quantity</th>
					</tr>
				</thead>
				<tbody>
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
				</tbody>
			</table>
		</div>

		<div class="column">
			<form action="" method="GET">
				<label for="productName">Chọn tên sản phẩm:</label> <select
					name="productName" id="productName">
					<%
					for (Product product : products) {
					%>
					<option value="<%=product.getName()%>"><%=product.getName()%></option>
					<%
					}
					%>
				</select> <input type="submit" value="Xem số lượng">
				<%
				String selectedProduct = request.getParameter("productName");
				boolean productNameDisplayed = false; // Kiểm tra xem đã hiển thị tên sản phẩm hay chưa

				if (selectedProduct != null) {
					for (Order order : odr) {
						if (order.getName().equals(selectedProduct)) {
					if (!productNameDisplayed) { // Hiển thị tên sản phẩm một lần
						productNameDisplayed = true;
				%>
				<h1>Kết quả</h1>
				<h2>
					Tên sản phẩm:
					<%=order.getName()%></h2>
				<table id="bang4">
					<thead>
						<tr>
							<th>Tên người mua</th>
							<th>Số lượng</th>
						</tr>
						<%
						}
						%>
					</thead>
					<tbody>
						<tr>
							<td><%=userDao.getUsernameByUserId(order.getUid())%></td>
							<td><%=order.getQuantity()%></td>
						</tr>
						<%
						}
						}
						}

						if (!productNameDisplayed && selectedProduct != null) {
						%>
						<h1>Kết quả</h1>
						<p>Không tìm thấy thông tin cho sản phẩm được chọn.</p>
						<%
						}
						if (productNameDisplayed) { // Đóng bảng nếu đã hiển thị tên sản phẩm
						%>
					</tbody>
				</table>
				<%
				}
				%>
			</form>

		</div>

		<div class="column">
			<%-- Gọi phương thức DAO để lấy danh sách đơn hàng --%>
			<%
			List<Order> ordersDay = orderDao.getAllOrdersProductNamesByDate();
			%>
			<%-- Tạo danh sách các ngày --%>
			<%
			List<String> dates = new ArrayList<>();
			for (Order order : ordersDay) {
				if (!dates.contains(order.getDate())) {
					dates.add(order.getDate());
				}
			}
			%>
			<%-- Hiển thị báo cáo sản phẩm --%>
			<table id="bang4" border="1">
				<thead>
					<tr>
						<th>Product Name</th>
						<%-- In các ngày làm tiêu đề cột --%>
						<%
						for (String date : dates) {
						%>
						<th><%=date%></th>
						<%
						}
						%>
					</tr>
				</thead>
				<tbody>
					<%
					List<String> displayedProducts = new ArrayList<>();
					for (Order order : ordersDay) {
						String productName = order.getName();
						if (!displayedProducts.contains(productName)) {
					%>
					<tr>
						<td><%=productName%></td>
						<%-- In số lượng bán được cho từng ngày --%>
						<%
						for (String date : dates) {
							int quantity = 0;
							for (Order o : ordersDay) {
								if (o.getName().equals(productName) && o.getDate().equals(date)) {
							quantity = o.getQuantity();
							break;
								}
							}
						%>
						<td><%=quantity%></td>
						<%
						}
						%>
					</tr>
					<%
					displayedProducts.add(productName);
					}
					}
					%>
					<%-- In hàng tổng sản phẩm --%>
					<tr>
						<td><strong>Total Quantity</strong></td>
						<%
						for (String date : dates) {
							int total = 0;
							for (Order o : ordersDay) {
								if (o.getDate().equals(date)) {
							total += o.getQuantity();
								}
							}
						%>
						<td><%=total%></td>
						<%
						}
						%>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="column">
			<table id="bang5">
				<tr>
					<th>User Name</th>
					<th>Product Name</th>
					<th>Total Quantity</th>
				</tr>
				<%
				List<Order> od = orderDao.getUsersByProduct();
				for (Order order : od) {
				%>
				<tr>
					<td><%=userDao.getUsernameByUserId(order.getUid())%></td>
					<td><%=order.getName()%></td>
					<td><%=order.getQuantity()%></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>

	</div>
</body>
<script>
	const btns = document.getElementsByClassName("btn-table");
	const columns = document.getElementsByClassName("column");
	for (let i = 0; i < btns.length; i++) {
		btns[i].addEventListener("click", function() {
			columns[i].classList.add("active");
			for (let j = 0; j < btns.length; j++) {
				if (j != i) {
					columns[j].classList.remove("active");
				}
			}
		});
	}
</script>
</html>