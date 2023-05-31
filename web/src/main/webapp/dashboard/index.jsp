<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%
Connection connection = null;
try {
	String url = "jdbc:mysql://localhost:3306/cart";
	String username = "root";
	String password = "1234";
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(url, username, password);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException e) {
	e.printStackTrace();
}

// Retrieve products from the database
String selectQuery = "SELECT * FROM cart.products";
Statement statement = connection.createStatement();
ResultSet resultSet = statement.executeQuery(selectQuery);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product List</title>
</head>
<style>
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
}

.image-cell img {
	width: 200px;
	height: 100px;
}

.container_ad {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.form-container {
	width: 400px;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	background-color: #f2f2f2;
	margin: 0 auto;
}

.form-container h2 {
	text-align: center;
	margin-bottom: 20px;
}

.form-container label {
	display: block;
	margin-bottom: 10px;
}

.form-container input[type="text"], .form-container input[type="number"],
	.form-container input[type="file"] {
	width: 90%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.form-container input[type="submit"] {
	width: 90%;
	padding: 8px;
	border: none;
	border-radius: 4px;
	background-color: #4CAF50;
	color: #fff;
	cursor: pointer;
}

.form-container input[type="submit"]:hover {
	background-color: #45a049;
}

.action-buttons {
	margin-left: -30px;
}

.action-buttons a {
	display: inline-block;
	padding: 8px 12px;
	margin: 0 5px;
	border: none;
	border-radius: 4px;
	text-decoration: none;
	color: #fff;
	cursor: pointer;
	font-weight: bold;
}

.edit-button {
	background-color: #2196F3;
}

.delete-button {
	background-color: #F44336;
}
</style>
<body>
	<div class="container">
		<div class="form-container">
			<form method="post" action="create.jsp" enctype="multipart/form-data">
				<h2>Create Product</h2>
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" required><br> <br> <label for="price">Price:</label>
				<input type="number" id="price" name="price" step="0.01" required><br>
				<br> <label for="category">Category:</label> <input type="text"
					id="category" name="category" required><br> <br>
				<label for="image">Image:</label> <input type="file" id="image"
					name="image" required><br> <br> <input
					type="submit" value="Create">
			</form>


		</div>
	</div>
	<h1>Product List</h1>
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
						href="edit.jsp?id=<%=resultSet.getInt("id")%>">Edit</a> <a
						class="delete-button"
						href="delete.jsp?id=<%=resultSet.getInt("id")%>"
						onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
				</div></td>
		</tr>
		<%
		}
		%>
	</table>
</body>
</html>
