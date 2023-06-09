<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="web.model.*"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}
session.setAttribute("auth", auth);

Connection connection = null;
PreparedStatement deleteStatement = null;

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
String deleteQuery = "DELETE FROM cart.products WHERE id = ?";
deleteStatement = connection.prepareStatement(deleteQuery);
deleteStatement.setInt(1, productId);
deleteStatement.executeUpdate();

response.sendRedirect("admin_product.jsp");
%>
