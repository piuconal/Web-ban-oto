package web.dao;

import java.sql.*;
import java.util.*;

import web.model.Cart;
import web.model.Product;

public class ProductDao {
	private Connection con;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public ProductDao(Connection con) {
		super();
		this.con = con;
	}

	public List<Product> getAllProducts() {
		List<Product> book = new ArrayList<>();
		try {

			query = "select * from sql9624488.products";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();

			while (rs.next()) {
				Product row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setImage(rs.getString("image"));
				row.setPrice(rs.getInt("price"));
				row.setImage(rs.getString("image"));

				book.add(row);
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return book;
	}

	public Product getSingleProduct(int id) {
		Product row = null;
		try {
			query = "select * from sql9624488.products where id=? ";

			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			ResultSet rs = pst.executeQuery();

			while (rs.next()) {
				row = new Product();
				row.setId(rs.getInt("id"));
				row.setName(rs.getString("name"));
				row.setCategory(rs.getString("category"));
				row.setPrice(rs.getInt("price"));
				row.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}

		return row;
	}

	public int getTotalCartPrice(ArrayList<Cart> cartList) {
		int sum = 0;
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "select price from sql9624488.products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while (rs.next()) {
						sum += rs.getInt("price") * item.getQuantity();
					}

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return sum;
	}

	public List<Cart> getCartProducts(ArrayList<Cart> cartList) {
		List<Cart> book = new ArrayList<>();
		try {
			if (cartList.size() > 0) {
				for (Cart item : cartList) {
					query = "select * from sql9624488.products where id=?";
					pst = this.con.prepareStatement(query);
					pst.setInt(1, item.getId());
					rs = pst.executeQuery();
					while (rs.next()) {
						Cart row = new Cart();
						row.setId(rs.getInt("id"));
						row.setName(rs.getString("name"));
						row.setCategory(rs.getString("category"));
						row.setPrice(rs.getInt("price") * item.getQuantity());
						row.setQuantity(item.getQuantity());
						row.setImage(rs.getString("image"));

						book.add(row);
					}

				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return book;
	}

	public List<Product> getProductsByPage(int offset, int limit) {
		List<Product> products = new ArrayList<>();
		String query = "SELECT * FROM sql9624488.products LIMIT ?, ?";
		try (PreparedStatement statement = con.prepareStatement(query)) {
			statement.setInt(1, offset);
			statement.setInt(2, limit);
			ResultSet resultSet = statement.executeQuery();
			while (resultSet.next()) {
				int id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				String category = resultSet.getString("category");
				String image = resultSet.getString("image");
				int price = resultSet.getInt("price");

				Product product = new Product(id, name, category, price, image);
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return products;
	}

	public int getTotalProducts() {
		int total = 0;
		String query = "SELECT COUNT(*) AS total FROM sql9624488.products";
		try (PreparedStatement statement = con.prepareStatement(query);
				ResultSet resultSet = statement.executeQuery()) {
			if (resultSet.next()) {
				total = resultSet.getInt("total");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return total;
	}
}