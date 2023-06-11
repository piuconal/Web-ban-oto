package web.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("id"));
		PreparedStatement deleteStatement = null;
		Connection connection = null;
		try {
			String url = "jdbc:mysql://sql9.freesqldatabase.com:3306";
			String username = "sql9624488";
			String password = "r1qDDsFYhd";
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection(url, username, password);

			String deleteQuery = "DELETE FROM sql9624488.products WHERE id = ?";
			deleteStatement = connection.prepareStatement(deleteQuery);
			deleteStatement.setInt(1, productId);
			deleteStatement.executeUpdate();

			connection.close();

			response.sendRedirect("admin_product.jsp");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
