package web.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.connection.DbCon;
import web.dao.UserDao;

/**
 * Servlet implementation class ThayDoiTrangThaiTaiKhoan
 */
@WebServlet("/thay-doi-trang-thai")
public class CustomAC extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CustomAC() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Lấy giá trị userId từ request
		String hanhDong = request.getParameter("Email");
		try {
			UserDao userDao = new UserDao(DbCon.getConnection());
			if (userDao.isAdmin(hanhDong) == true) {
				thayDoiAD(request, response);
			} else {
				thayDoiUser(request, response);
			}
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

	private void thayDoiUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String email = request.getParameter("Email");

			UserDao userDao = new UserDao(DbCon.getConnection());
			// Thực hiện thay đổi trạng thái người dùng
			boolean ketQua = userDao.thayDoiTrangThaiUser(email);

			// Chuyển hướng đến trang kết quả
			if (ketQua) {
				response.sendRedirect("userManagement.jsp");
			} else {
				response.sendRedirect("userManagement.jsp");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void thayDoiAD(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String email = request.getParameter("Email");

			UserDao userDao = new UserDao(DbCon.getConnection());
			// Thực hiện thay đổi trạng thái người dùng
			boolean ketQua = userDao.thayDoiTrangThaiAD(email);

			// Chuyển hướng đến trang kết quả
			if (ketQua) {
				response.sendRedirect("userManagement.jsp");
			} else {
				response.sendRedirect("userManagement.jsp");
			}
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}