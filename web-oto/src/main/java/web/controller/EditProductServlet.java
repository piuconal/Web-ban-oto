package web.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("id"));

		Connection connection = null;
		try {
			String url = "jdbc:mysql://sql9.freesqldatabase.com:3306";
			String username = "sql9624488";
			String password = "r1qDDsFYhd";
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, username, password);

			String selectQuery = "SELECT * FROM sql9624488.products WHERE id=?";
			PreparedStatement preparedStatement = connection.prepareStatement(selectQuery);
			preparedStatement.setInt(1, productId);
			ResultSet resultSet = preparedStatement.executeQuery();
			if (resultSet.next()) {
				String name = resultSet.getString("name");
				double price = resultSet.getDouble("price");
				String category = resultSet.getString("category");
				String image = resultSet.getString("image");

				request.setAttribute("productId", productId);
				request.setAttribute("name", name);
				request.setAttribute("price", price);
				request.setAttribute("category", category);
				request.setAttribute("image", image);

				RequestDispatcher dispatcher = request.getRequestDispatcher("edit.jsp");
				dispatcher.forward(request, response);
			} else {
				/* response.sendRedirect("error.jsp"); */
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("id"));
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

			String updateQuery = "UPDATE sql9624488.products SET name=?, price=?, category=?, image=? WHERE id=?";
			PreparedStatement preparedStatement = connection.prepareStatement(updateQuery);
			preparedStatement.setString(1, name);
			preparedStatement.setDouble(2, price);
			preparedStatement.setString(3, category);
			preparedStatement.setString(4, image);
			preparedStatement.setInt(5, productId);
			preparedStatement.executeUpdate();

			response.sendRedirect("admin_product.jsp");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (connection != null) {
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
