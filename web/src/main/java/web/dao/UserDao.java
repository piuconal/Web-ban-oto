package web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import web.model.User;

public class UserDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public UserDao(Connection con) {
		this.con = con;
	}

	public ArrayList<User> data = new ArrayList<>();

	public ArrayList<User> selectAllUser() {
		ArrayList<User> ketQua = new ArrayList<User>();
		try {
			query = "select * from cart.users";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while(rs.next()) {
				int maKhachHang = rs.getInt("id");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String password = rs.getString("password");
				String isAdmin = rs.getString("isadmin");
				String isAdminProduct = rs.getString("isadminproduct");
				
				User user = new User(maKhachHang, name, email, password, isAdmin, isAdminProduct);
				ketQua.add(user);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ketQua;
	}

	public User userLogin(String email, String password) {
		User user = null;
		try {
			query = "select * from cart.users where email=? and password=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			pst.setString(2, password);
			rs = pst.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print((e.getMessage()));
		}
		return user;
	}

	public String getUsernameByUserId(int userId) {
		String username = null;
		try {
			query = "select name from cart.users where id=?";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, userId);
			rs = pst.executeQuery();
			if (rs.next()) {
				username = rs.getString("name");
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return username;
	}

	public boolean isAdmin(String email) {
		boolean isAdmin = false;
		try {
			query = "select * from cart.users where email=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			if (rs.next()) {
				String isAdminValue = rs.getString("isadmin");
				if (isAdminValue != null && isAdminValue.equals("1")) {
					isAdmin = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return isAdmin;
	}

	public boolean isAdminProduct(String email) {
		boolean isAdminProduct = false;
		try {
			query = "select name from cart.users where email=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			if (rs.next()) {
				String isAdminProductValue = rs.getString("isadminproduct");
				if (isAdminProductValue != null && isAdminProductValue.equals("1")) {
					isAdminProduct = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		return isAdminProduct;
	}
	
	public int insertUser(User user) {
		int ketQua = 0;
		try {
			query = "insert into cart.users(id, name, email, password, isadmin, isadminproduct)" 
			+ " values (?,?,?,?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setInt(1, user.getId());
			pst.setString(2, user.getName());
			pst.setString(3, user.getEmail());
			pst.setString(4, user.getPassword());
			pst.setString(5, user.getIsAdmin());
			pst.setString(6, user.getIsAdminProduct());
			ketQua = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ketQua;
	}

}
