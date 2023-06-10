<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%@page import="web.model.*"%>
<%
User auth = (User) request.getSession().getAttribute("admin");
if (auth != null) {
	request.setAttribute("admin", auth);
}
session.setAttribute("admin", auth);

String name = request.getParameter("name");
double price = Double.parseDouble(request.getParameter("price"));
String category = request.getParameter("category");
String image = request.getParameter("image");

Connection connection = null;
try {
	String url = "jdbc:mysql://sql9.freesqldatabase.com:3306";
	String username = "sql9624488";
	String password = "r1qDDsFYhd";
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(url, username, password);
} catch (SQLException e) {
	e.printStackTrace();
}

String insertQuery = "INSERT INTO sql9624488.products (name, price, category, image) VALUES (?, ?, ?, ?)";
PreparedStatement statement = connection.prepareStatement(insertQuery);
statement.setString(1, name);
statement.setDouble(2, price);
statement.setString(3, category);
statement.setString(4, image);
statement.executeUpdate();

connection.close();
%>


