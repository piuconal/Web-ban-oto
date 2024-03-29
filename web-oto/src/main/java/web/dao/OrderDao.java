package web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import web.model.*;

public class OrderDao {

	private Connection con;

	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public OrderDao(Connection con) {
		super();
		this.con = con;
	}

	public boolean insertOrder(Order model) {
		boolean result = false;
		try {
			query = "insert into sql9624488.orders (p_id, u_id, o_quantity, o_date) values(?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, model.getId());
			pst.setInt(2, model.getUid());
			pst.setInt(3, model.getQuantity());
			pst.setString(4, model.getDate());
			pst.executeUpdate();
			result = true;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	public List<Order> userOrders(int id) {
		List<Order> list = new ArrayList<>();
		try {
			query = "select * from sql9624488.orders where u_id=? order by orders.o_id desc";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				ProductDao productDao = new ProductDao(this.con);
				int pId = rs.getInt("p_id");
				Product product = productDao.getSingleProduct(pId);
				order.setOrderId(rs.getInt("o_id"));
				order.setId(pId);
				order.setName(product.getName());
				order.setCategory(product.getCategory());
				order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
				order.setQuantity(rs.getInt("o_quantity"));
				order.setDate(rs.getString("o_date"));
				order.setStatus(rs.getString("o_status"));
				list.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return list;
	}

	public void cancelOrder(int id) {
		// boolean result = false;
		try {
			query = "delete from sql9624488.orders where o_id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, id);
			pst.execute();
			// result = true;
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.print(e.getMessage());
		}
		// return result;
	}

	public List<Order> getAllOrders() {
		List<Order> orders = new ArrayList<>();
		try {
			query = "SELECT orders.*, products.name, products.price FROM sql9624488.orders INNER JOIN sql9624488.products ON orders.p_id = products.id";

			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setOrderId(rs.getInt("o_id"));
				order.setId(rs.getInt("p_id"));
				order.setUid(rs.getInt("u_id"));
				order.setQuantity(rs.getInt("o_quantity"));
				order.setDate(rs.getString("o_date"));
				order.setName(rs.getString("name"));
				order.setPrice(rs.getInt("price"));
				order.setStatus(rs.getString("o_status"));
				order.setPayment(rs.getString("o_payment"));
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return orders;
	}

	public void changeStatus(int id) {
		try {
			 String query = "UPDATE sql9624488.orders SET  o_status = ? WHERE o_id = ?";
			 pst = this.con.prepareStatement(query);
			 pst.setString(1, "Confirmed");
			 pst.setInt(2, id);
			 int rowsUpdated = pst.executeUpdate();
			 
		}catch (Exception e){
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
	public void acceptPayment(int id) {
		try {
			String query = "UPDATE sql9624488.orders SET o_status = ? , o_payment = ? WHERE o_id = ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1,"Done");
			pst.setString(2,"Done");
			pst.setInt(3, id);
			int rowsUpdated = pst.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
	public void cancelStatus(int id) {
		try {
			String query = "UPDATE sql9624488.orders SET o_status = ?, o_payment = ? WHERE o_id = ?";
			pst = this.con.prepareStatement(query);
			pst.setString(1,"Canceled");
			pst.setString(2,"Canceled");
			pst.setInt(3, id);
			int rowsUpdate = pst.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
	}
///---vu dung---////
	public List<Order> getAllOrdersProductNames() {
		List<Order> orders = new ArrayList<>();
		try {
			String query = "SELECT products.name, SUM(orders.o_quantity) AS total_quantity\n"
					+ "FROM sql9624488.orders\n" + "INNER JOIN sql9624488.products ON orders.p_id = products.id\n"
					+ "GROUP BY products.name";

			PreparedStatement pst = this.con.prepareStatement(query);
			ResultSet rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setName(rs.getString("name"));
				order.setQuantity(rs.getInt("total_quantity"));
				orders.add(order);
			}
			rs.close();
			pst.close();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return orders;
	}

	// get id user by Order Product
	public List<Order> getUserbyProductOrder() {
		List<Order> orders = new ArrayList<>();
		try {
			String query = "SELECT orders.u_id AS u_id, products.name AS product_name, SUM(orders.o_quantity) AS total_quantity\n"
					+ "FROM sql9624488.orders\n" + "INNER JOIN sql9624488.products ON orders.p_id = products.id\n"
					+ "GROUP BY orders.u_id, products.name";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setUid(rs.getInt("u_id"));
				order.setName(rs.getString("product_name"));
				order.setQuantity(rs.getInt("total_quantity"));
				orders.add(order);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return orders;
	}

	// get sp by date
	public List<Order> getAllOrdersProductNamesByDate() {
		List<Order> orders = new ArrayList<>();
		try {
			String query = "SELECT orders.o_date, products.name, SUM(orders.o_quantity) AS total_quantity "
					+ "FROM sql9624488.orders " + "INNER JOIN sql9624488.products ON orders.p_id = products.id "
					+ "WHERE orders.o_status = 'done' " + "GROUP BY orders.o_date, products.name";

			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setDate(rs.getString("o_date"));
				order.setName(rs.getString("name"));
				order.setQuantity(rs.getInt("total_quantity"));
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return orders;
	}

	// get orders by user
	public List<Order> getOrdersByUser() {
		List<Order> orders = new ArrayList<>();
		try {
			String query = "SELECT users.name AS user_name, products.name AS product_name, SUM(orders.quantity) AS total_quantity "
					+ "FROM sql9624488.orders " + "INNER JOIN sql9624488.users ON orders.uid = users.id "
					+ "INNER JOIN sql9624488.products ON orders.pid = products.id "
					+ "GROUP BY users.name, products.name";

			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setUid(rs.getInt("u_id"));
//					order.setUserName(UserDao.getUsernameByUserId(rs.getInt("u_id")));
				order.setName(rs.getString("product_name"));
				order.setQuantity(rs.getInt("total_quantity"));
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return orders;
	}

	// get product by User
	public List<Order> getUsersByProduct() {
		List<Order> orders = new ArrayList<>();

		try {
			query = "SELECT orders.u_id AS u_id, products.name AS product_name, SUM(orders.o_quantity) AS total_quantity\n"
					+ "FROM sql9624488.orders\n" + "INNER JOIN sql9624488.products ON orders.p_id = products.id\n"
					+ "GROUP BY orders.u_id, products.name";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();

			while (rs.next()) {
				Order order = new Order();
				order.setUid(rs.getInt("u_id"));
				order.setName(rs.getString("product_name"));
				order.setQuantity(rs.getInt("total_quantity"));
				orders.add(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return orders;
	}

}