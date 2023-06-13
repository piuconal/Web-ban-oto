<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%@page import="web.model.*"%>
<%@page import="web.connection.DbCon"%>
<%
User auth = (User) request.getSession().getAttribute("admin");
if (auth != null) {
	request.setAttribute("admin", auth);
}
session.setAttribute("admin", auth);

Connection connection = null;
try {
	String url = "jdbc:mysql://sql9.freesqldatabase.com:3306";
	String username = "sql9624488";
	String password = "r1qDDsFYhd";
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(url, username, password);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException e) {
	e.printStackTrace();
}

String selectQuery = "SELECT * FROM sql9624488.products";
Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery(selectQuery);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product List</title>
<link rel="stylesheet" href="./css/admin_product.css">
<link rel="icon" href="./product-images/icontab.png">
</head>

<body>
	<%@include file="includes/tieude.jsp"%>

	<div class="body">
		<div class="container">
			<div class="form-container">
				<form method="post" action="create-product">
					<h2>Create Product</h2>
					<label for="name">Name:</label> <input type="text" id="name"
						name="name" required><br> <br> <label
						for="price">Price:</label> <input type="number" id="price"
						name="price" step="0.01" required><br> <br> <label
						for="category">Category:</label> <input type="text" id="category"
						name="category" required><br> <br> <label
						for="image">Image:</label> <input type="text" id="image"
						name="image" required><br> <br> <input
						type="submit" value="Create">
				</form>
			</div>
		</div>

		<div class="product-list-container">
			<h1>Product List</h1>
			<div class="product-list">
				<table>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Price</th>
						<th>Category</th>
						<th>Image</th>
						<th>Action</th>
					</tr>
					<%
					while (resultSet.next()) {
						double price = resultSet.getInt("price");

						DecimalFormatSymbols symbols = new DecimalFormatSymbols();
						symbols.setGroupingSeparator(',');
						DecimalFormat formatter = new DecimalFormat("#,###", symbols);
						String formattedPrice = formatter.format(price);
					%>
					<tr>
						<td><%=resultSet.getInt("id")%></td>
						<td><%=resultSet.getString("name")%></td>
						<td>$ <%=formattedPrice%></td>
						<td><%=resultSet.getString("category")%></td>
						<td class="image-cell"><img class="card-img-top"
							src="<%=request.getContextPath()%>/product-images/<%=resultSet.getString("image")%>"
							alt="Product Image"></td>
						<td><div class="action-buttons">
								<a class="edit-button"
									href="edit-product?id=<%=resultSet.getInt("id")%>">Edit</a> <a
									class="delete-button"
									href="delete-product?id=<%=resultSet.getInt("id")%>"
									onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
							</div></td>
					</tr>
					<%
					}
					%>
				</table>
			</div>
		</div>
	</div>
</body>
</html>