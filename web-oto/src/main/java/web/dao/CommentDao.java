package web.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import web.model.Comment;
import web.model.Order;
import web.model.Product;

public class CommentDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;
    
    public CommentDao(Connection con) {
        this.con = con;
    }
    
    public boolean insertComment(Comment comment) {
        boolean result = false;
        try {
            String query = "INSERT INTO sql9624488.comments (p_id, u_id, comment, rate) VALUES (?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setInt(1, comment.getId());
            pst.setInt(2, comment.getUid());
            pst.setString(3, comment.getComment());
            pst.setInt(4, comment.getRate());
            pst.executeUpdate();
            result = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Comment> getAllComments() {
        List<Comment> comments = new ArrayList<>();
        try {
            query = "SELECT comments.p_id, products.price AS u_price, comments.u_id, comments.comment " +
                    "FROM sql9624488.comments " +
                    "INNER JOIN sql9624488.products ON comments.p_id = products.id";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setId(rs.getInt("p_id"));
                comment.setUid(rs.getInt("u_id"));
                comment.setComment(rs.getString("comment"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public List<Comment> getAllCommentByProductId(int productId) {
        List<Comment> comments = new ArrayList<>();
        try {
            query = "SELECT comments.p_id, products.price AS u_price, comments.u_id, comments.comment, comments.rate " +
                    "FROM sql9624488.comments " +
                    "INNER JOIN sql9624488.products ON comments.p_id = products.id " +
                    "WHERE comments.p_id = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, productId);
            rs = pst.executeQuery();
            while (rs.next()) {
                Comment comment = new Comment();
                comment.setId(rs.getInt("p_id"));
                comment.setUid(rs.getInt("u_id"));
                comment.setComment(rs.getString("comment"));
                comment.setRate(rs.getInt("rate"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

}
