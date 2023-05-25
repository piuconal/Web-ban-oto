<%@page import="model.*"%>
<%@page import="database.*"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
KhachHangDAO khachHangDAO = new KhachHangDAO();
ArrayList<KhachHang> khachHangs = khachHangDAO.selectAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="dashboard/css/style.css">
<link rel="stylesheet"
	href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css">
<title>Dashboard</title>
</head>
<body>
	<body id="body">
		<div class="l-navbar" id="navbar">
			<div class="nav">
				<div>
					<a href="#" class="nav-logo"> <!-- <img src="img/anh-dep-gai-xinh.jpg" alt="" class="nav-logo-icon"> -->
						<span class="nav-logo-text nav-icon">Test</span>
					</a>
					<div class="nav-toggle" id="nav-toggle">
						<i class='bx bxs-right-arrow'></i>
					</div>
					<ul class="nav-list">
						<a href="#" class="nav-link" id="home-icon"> <i
							class='bx bxs-grid nav-icon'></i> <span class="nav-text">Home</span>
						</a>
						<a href="#" class="nav-link" id="user-icon"> <i
							class='bx bxs-user nav-icon'></i> <span class="nav-text">User</span>
						</a>
						<a href="#" class="nav-link" id="price-icon"> <i
							class='bx bxs-dollar-circle nav-icon'></i> <span class="nav-text">Price</span>
						</a>
						<a href="#" class="nav-link" id="note-icon"> <i
							class='bx bxs-bell nav-icon'></i> <span class="nav-text">Notification</span>
						</a>
						<a href="#" class="nav-link" id="rate-icon"> <i
							class='bx bx-test-tube nav-icon'></i> <span class="nav-text">Rate</span>
						</a>
						<a href="#" class="nav-link" id="delivery-icon"> <i
							class='bx bxs-package nav-icon'></i> <span class="nav-text">Delivery</span>
						</a>
					</ul>
				</div>
				<a href="khach-hang?hanhDong=dang-xuat" class="nav-link"> <i
					class='bx bx-log-out-circle nav-icon'></i> <span class="nav-text">Close</span>
				</a>
			</div>
		</div>
		<div class="content">
			<div class="trang" id="home-page">
				<p>day la trang home dashboard</p>
			</div>
			<div class="trang" id="user-page">
				<p>Đây là trang user</p>
				<table>
					<tr>
						<th>ten</th>
						<th>tuoi</th>
						<th>dia chi</th>
					</tr>
					
					<tr>
						<%
						if (!khachHangs.isEmpty()) {
							for (KhachHang k : khachHangs) {
						%>
							<td><%=k.getHoVaTen() %></td>
							<td><%=k.getNgaySinh() %></td>
							<td><%=k.getDiaChi() %></td>
							
					</tr>
						<%
							}
						}
						%>
				</table>
			</div>
			<div class="trang" id="price-page">Day la trang tong gia tien</div>
			<div class="trang" id="note-page">Day la trang thong bao</div>
			<div class="trang" id="rate-page">Day la trang comment</div>
			<div class="trang" id="delivery-page">
				<p>Đây là trang delivery</p>
			</div>
		</div>
	</body>
<!-- -----------------Js---------------- -->
	<script src="dashboard/JS/main.js"></script>
</body>
</html>