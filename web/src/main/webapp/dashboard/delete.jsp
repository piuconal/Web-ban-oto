<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
Connection connection = null;
PreparedStatement deleteStatement = null;

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

if (request.getMethod().equalsIgnoreCase("post")) {
	int productId = Integer.parseInt(request.getParameter("id"));
	// Delete the product from the database
	String deleteQuery = "DELETE FROM cart.products WHERE id = ?";
	deleteStatement = connection.prepareStatement(deleteQuery);
	deleteStatement.setInt(1, productId);
	deleteStatement.executeUpdate();

	response.sendRedirect(request.getContextPath() + "/index.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Delete Product</title>
<link rel="icon" href="./product-images/icontab.png">
</head>
<body>
	<h1>Delete Product</h1>
	<form method="post" action="delete.jsp">
		<input type="hidden" name="id" value="<%=request.getParameter("id")%>">
		<p>Are you sure you want to delete this product?</p>
		<input type="submit" value="Delete">
	</form>
</body>
</html>