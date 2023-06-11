package web.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.connection.DbCon;
import web.dao.CommentDao;
import web.model.Comment;
import web.model.User;

/**
 * Servlet implementation class DanhGia
 */
@WebServlet("/danh-gia")
public class DanhGia extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DanhGia() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Lấy thông tin đánh giá từ request parameters
		String p_id = request.getParameter("productCode");
        String commentText = request.getParameter("comment");
        String ratingParam = request.getParameter("rating");
        
        // Kiểm tra giá trị ratingParam trước khi chuyển đổi thành số nguyên
        int product_id = 0;
        if (p_id != null && !p_id.isEmpty()) {
        	product_id = Integer.parseInt(p_id);
        }
        
        int rating = 0;
        if (ratingParam != null && !ratingParam.isEmpty()) {
            rating = Integer.parseInt(ratingParam);
        }
        // Lấy thông tin người đánh giá từ session
        User auth = (User) request.getSession().getAttribute("auth");
        int u_id = auth.getId();
        
        // Tạo đối tượng Comment
        Comment cmt = new Comment();
        cmt.setId(product_id);
        cmt.setUid(u_id);
        cmt.setComment(commentText);
        cmt.setRate(rating);
        
        // Thực hiện ghi đánh giá vào cơ sở dữ liệu
        boolean result = false;
		try {
			CommentDao commentDao = new CommentDao(DbCon.getConnection());
			result = commentDao.insertComment(cmt);
			if (result) {
	            // Ghi đánh giá thành công
	            response.sendRedirect("index.jsp");
	        }else {
	        	response.sendRedirect("index.jsp");
	        }
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("index.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			response.sendRedirect("index.jsp");
		}
        
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
