package web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import web.connection.DbCon;

@WebServlet("/CancelStatusServlet")
public class CancelStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        Connection connection = null;
        PreparedStatement statement = null;
        PrintWriter out = null;

        try {
            connection = DbCon.getConnection();

            String sql = "UPDATE sql9624488.orders SET o_status = 'Canceled', o_payment = 'Canceled' WHERE o_id=?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, orderId);

            int rowsAffected = statement.executeUpdate();

            if (rowsAffected > 0) {
                response.setContentType("text/plain");
                response.setCharacterEncoding("UTF-8");
                out = response.getWriter();
                out.write("success");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cập nhật trạng thái không thành công.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi cơ sở dữ liệu.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi không tìm thấy lớp driver cơ sở dữ liệu.");
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

           
        }
    }
}
