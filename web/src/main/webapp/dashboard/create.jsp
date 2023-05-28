<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.nio.file.*, java.sql.*"%>
<%
Connection connection = null;
PreparedStatement insertStatement = null;

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

if (request.getMethod().equalsIgnoreCase("post")) {
	String name = request.getParameter("name");
	double price = Double.parseDouble(request.getParameter("price"));
	String category = request.getParameter("category");
	Part imagePart = request.getPart("image");

	// Generate a unique filename for the image
	String imageName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();

	// Save the image file to the server
	String imagePath = getServletContext().getRealPath("/product-images/") + File.separator + imageName;
	Files.copy(imagePart.getInputStream(), Paths.get(imagePath), StandardCopyOption.REPLACE_EXISTING);

	// Insert the product into the database
	String insertQuery = "INSERT INTO cart.products (name, price, category, image) VALUES (?, ?, ?, ?)";
	insertStatement = connection.prepareStatement(insertQuery);
	insertStatement.setString(1, name);
	insertStatement.setDouble(2, price);
	insertStatement.setString(3, category);
	insertStatement.setString(4, imageName);
	insertStatement.executeUpdate();

	response.sendRedirect(request.getContextPath() + "/index.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Create Product</title>
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>
	<h1>Create Product</h1>
	<form method="post" action="create.jsp" enctype="multipart/form-data">
		<label for="name">Name:</label> <input type="text" id="name"
			name="name" required><br> <br> <label for="price">Price:</label>
		<input type="number" id="price" name="price" step="0.01" required><br>
		<br> <label for="category">Category:</label> <input type="text"
			id="category" name="category" required><br> <br> <label
			for="image">Image:</label> <input type="file" id="image" name="image"
			required><br> <br> <input type="submit"
			value="Create">
	</form>
</body>
</html>
