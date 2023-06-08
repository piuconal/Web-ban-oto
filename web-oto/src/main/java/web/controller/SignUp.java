package web.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.connection.DbCon;
import web.dao.UserDao;
import web.model.User;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/sign-up")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignUp() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
		    String ten = request.getParameter("name");
		    String email = request.getParameter("email");
		    String matKhau = request.getParameter("password");
		    
		    request.setAttribute("ten", ten);
		    request.setAttribute("email", email);
		    request.setAttribute("matKhau", matKhau);

		    String url = "";

		    UserDao userDao = new UserDao(DbCon.getConnection());
		    
		    // Tìm số nhỏ nhất chưa xuất hiện trong cơ sở dữ liệu
		    int maKhachHang = userDao.findSmallestAvailableId();
		    
		    String isAdmin = null;
		    User user = new User(maKhachHang, ten, email, matKhau, isAdmin);
		    userDao.insertUser(user);
		    url = "thanhcong.jsp";
		    response.sendRedirect("./thanhcong.jsp");
		} catch (ClassNotFoundException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		} catch (SQLException e) {
		    // TODO Auto-generated catch block
		    e.printStackTrace();
		}


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}