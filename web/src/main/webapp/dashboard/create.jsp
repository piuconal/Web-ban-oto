<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<%
// Lấy dữ liệu từ yêu cầu POST
String name = request.getParameter("name");
double price = Double.parseDouble(request.getParameter("price"));
String category = request.getParameter("category");
String image = request.getParameter("image");

// Kết nối tới cơ sở dữ liệu
Connection connection = null;
try {
	String url = "jdbc:mysql://localhost:3306/cart";
	String username = "root";
	String password = "110602@Hc";
	Class.forName("com.mysql.cj.jdbc.Driver");
	connection = DriverManager.getConnection(url, username, password);
} catch (SQLException e) {
	e.printStackTrace();
}

// Thêm dữ liệu vào bảng
String insertQuery = "INSERT INTO cart.products (name, price, category, image) VALUES (?, ?, ?, ?)";
PreparedStatement statement = connection.prepareStatement(insertQuery);
statement.setString(1, name);
statement.setDouble(2, price);
statement.setString(3, category);
statement.setString(4, image);
statement.executeUpdate();

// Đóng kết nối
connection.close();
%>


