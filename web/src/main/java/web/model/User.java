package web.model;

public class User {
	private int id;
	private String name;
	private String email;
	private String password;
	private String isAdmin;
	private String isAdminProduct;
	public User() {

	}
	public User(int id, String name, String email, String password, String isAdmin, String isAdminProduct) {
		super();
		this.id = id;
		this.name = name;
		this.email = email;
		this.password = password;
		this.isAdmin = isAdmin;
		this.isAdminProduct = isAdminProduct;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getIsAdminProduct() {
		return isAdminProduct;
	}
	public void setIsAdminProduct(String isAdminProduct) {
		this.isAdminProduct = isAdminProduct;
	}

}
