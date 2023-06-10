package web.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbCon {
	private static Connection connection = null;

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		if (connection == null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://sql9.freesqldatabase.com:3306", "sql9624488",
					"r1qDDsFYhd");
			System.out.print("connected");
		}
		return connection;
	}
}
