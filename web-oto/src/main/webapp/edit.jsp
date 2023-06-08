<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

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

int productId = Integer.parseInt(request.getParameter("id"));

if (request.getMethod().equalsIgnoreCase("post")) {
	String name = request.getParameter("name");
	double price = Double.parseDouble(request.getParameter("price"));
	String category = request.getParameter("category");
	String image = request.getParameter("image");

	String updateQuery = "UPDATE cart.products SET name=?, price=?, category=?, image=? WHERE id=?";
	PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
	preparedStatement.setString(1, name);
	preparedStatement.setDouble(2, price);
	preparedStatement.setString(3, category);
	preparedStatement.setString(4, image);
	preparedStatement.setInt(5, productId);
	preparedStatement.executeUpdate();

	response.sendRedirect("admin_product.jsp");
} else {
	String selectQuery = "SELECT * FROM cart.products WHERE id=?";
	PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
	preparedStatement.setInt(1, productId);
	ResultSet resultSet = preparedStatement.executeQuery();
	if (resultSet.next()) {
		String name = resultSet.getString("name");
		double price = resultSet.getDouble("price");
		String category = resultSet.getString("category");
		String image = resultSet.getString("image");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Product</title>
<link rel="stylesheet" href="./css/edit.css">
</head>

<body>
	<%@include file="includes/tieude.jsp"%>
	<form method="post" action="#">
		<h1>Edit Product</h1>
		<input type="hidden" name="id" value="<%=productId%>"> <label
			for="name">Name:</label> <input type="text" id="name" name="name"
			value="<%=name%>" required><br> <br> <label
			for="price">Price:</label> <input type="number" id="price"
			name="price" value="<%=price%>" step="0.01" required><br>
		<br> <label for="category">Category:</label> <input type="text"
			id="category" name="category" value="<%=category%>" required><br>
		<br> <label for="image">Image:</label> <input type="text"
			id="image" name="image" value="<%=image%>" required><br>
		<br> <input type="submit" value="Update">
	</form>
</body>
</html>
<%
}
}
%>