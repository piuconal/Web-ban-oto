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
UserDao userDao = new UserDao(DbCon.getConnection());
ArrayList<User> users = userDao.selectAllUser();
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
	<h1>Day la trang thong ke tai khoan</h1>
	<div class="table-container">
		<table>
			<tr>
				<th>Id User</th>
				<th>Name</th>
				<th>Email</th>
				<th>Is Admin</th>
			</tr>
			<%
			if (!users.isEmpty()) {
				for (User us : users) {
			%>
			<tr>
				<td><%=us.getId()%></td>
				<td><%=us.getName()%></td>
				<td><%=us.getEmail()%></td>
				<td><%=us.getIsAdmin()%></td>
				<td><button>Sửa tài khoản</button></td>
			</tr>
			<%
			}
			}
			%>
		</table>
	</div>
</body>
</html>