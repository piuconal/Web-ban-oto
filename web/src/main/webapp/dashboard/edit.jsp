<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.nio.file.*, java.sql.*"%>
<%
Connection connection = null;
PreparedStatement updateStatement = null;
ResultSet productResultSet = null;

try {
	String url = "jdbc:mysql://localhost:3306/cart";
	String username = "root";
	String password = "110602@Hc";
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(url, username, password);
} catch (ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException e) {
	e.printStackTrace();
}

int productId = Integer.parseInt(request.getParameter("id"));

String selectQuery = "SELECT * FROM cart.products WHERE id = ?";
PreparedStatement selectStatement = connection.prepareStatement(selectQuery);
selectStatement.setInt(1, productId);
productResultSet = selectStatement.executeQuery();

if (request.getMethod().equalsIgnoreCase("post")) {
	String name = request.getParameter("name");
	double price = Double.parseDouble(request.getParameter("price"));
	String category = request.getParameter("category");
	Part imagePart = request.getPart("image");
	// Check if a new image is uploaded
	if (imagePart.getSize() > 0) {
		// Generate a unique filename for the new image
		String imageName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

		// Save the new image file to the server
		String imagePath = getServletContext().getRealPath("/product-images/") + File.separator + imageName;
		Files.copy(imagePart.getInputStream(), Paths.get(imagePath), StandardCopyOption.REPLACE_EXISTING);

		// Update the product in the database with the new image
		String updateQuery = "UPDATE cart.products SET name = ?, price = ?, category = ?, image = ? WHERE id = ?";
		updateStatement = connection.prepareStatement(updateQuery);
		updateStatement.setString(1, name);
		updateStatement.setDouble(2, price);
		updateStatement.setString(3, category);
		updateStatement.setString(4, imageName);
		updateStatement.setInt(5, productId);
	} else {
		// Update the product in the database without changing the image
		String updateQuery = "UPDATE cart.products SET name = ?, price = ?, category = ? WHERE id = ?";
		updateStatement = connection.prepareStatement(updateQuery);
		updateStatement.setString(1, name);
		updateStatement.setDouble(2, price);
		updateStatement.setString(3, category);
		updateStatement.setInt(4, productId);
	}

	updateStatement.executeUpdate();

	response.sendRedirect(request.getContextPath() + "/index.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Product</title>
<link rel="icon" href="./product-images/icontab.png">
</head>
<style>
form {
	max-width: 400px;
	margin: 0 auto;
}

label {
	display: block;
	margin-bottom: 5px;
	font-weight: bold;
}

input[type="text"], input[type="number"] {
	width: 100%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-bottom: 10px;
}

input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	padding: 10px 15px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #45a049;
}

p.error {
	color: red;
	font-weight: bold;
}
</style>

<body>
	<form method="post" action="edit.jsp" enctype="multipart/form-data">
		<h1>Edit Product</h1>
		<%
		if (productResultSet.next()) {
		%>
		<input type="hidden" name="id"
			value="<%=productResultSet.getInt("id")%>"> <label for="name">Name:</label>
		<input type="text" id="name" name="name"
			value="<%=productResultSet.getString("name")%>" required><br>
		<br> <label for="price">Price:</label> <input type="number"
			id="price" name="price" step="0.01"
			value="<%=productResultSet.getDouble("price")%>" required><br>
		<br> <label for="category">Category:</label> <input type="text"
			id="category" name="category"
			value="<%=productResultSet.getString("category")%>" required><br>
		<br> <label for="image">Image:</label> <input type="file"
			id="image" name="image"><br> <br> <input
			type="submit" value="Update">
		<%
		} else {
		%>
		<p>Product not found.</p>
		<%
		}
		%>
	</form>
</body>
</html>