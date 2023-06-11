<%@page import="web.dao.CommentDao"%>
<%@page import="web.dao.UserDao"%>
<%@page import="web.dao.ProductDao"%>
<%@page import="web.connection.DbCon"%>
<%@page import="web.model.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.DecimalFormatSymbols"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
UserDao userDao = new UserDao(DbCon.getConnection());
//ProductDao productDao = new ProductDao(DbCon.getConnection());

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang Comment</title>
<style>
.container {
	margin: 50px 0 0 100px;
}

.product-image {
	width: 580px;
}

.product-image img {
	border-radius: 20px;
}

.product-info {
	margin-left: 200px;
	flex-shrink: 1;
}

.product-info p {
	font-size: 20px;
	font-weight: 900;
}

.product-info h3 {
	margin-left: 30px;
	font-size: 30px;
	font-weight: 900;
}

.comments {
	margin-top: 20px;
	max-height: 220px;
	overflow-y: auto;
}

.comment-list {
	list-style: none;
	padding: 0;
	margin: 0;
}

.comment-item {
	margin-bottom: 10px;
	list-style: none;
}

.comment-item span {
	color: gray;
}

.comment-item p {
	margin-top: 5px;
}

form {
	margin-top: 20px;
}

form label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

form input[type="text"], form select {
	width: 200px;
	margin-bottom: 10px;
	padding: 5px;
	font-size: 14px;
}

form button[type="submit"] {
	padding: 10px 20px;
	font-size: 16px;
	background-color: #4CAF50;
	color: white;
	border: none;
	cursor: pointer;
}

.view-cmt {
	margin: -29% 0 0 55%;
}
</style>
</head>

<body>
	<%@include file="includes/nav.jsp"%>
	<%
	String productIdParam = request.getParameter("productId");
	int productId = Integer.parseInt(productIdParam);

	ProductDao productDao = new ProductDao(DbCon.getConnection());
	Product product = productDao.getSingleProduct(productId);
	if (product != null) {
		double price = product.getPrice();
		DecimalFormatSymbols symbols = new DecimalFormatSymbols();
		symbols.setGroupingSeparator(',');
		DecimalFormat formatter = new DecimalFormat("#,###", symbols);
		String formattedPrice = formatter.format(price);
	%>
	<div class="container">
		<div class="product-image">
			<img class="card-img-top"
				src="./product-images/<%=product.getImage()%>" width="100%">
		</div>
		<div class="product-info">
			<p>
				<%=product.getName()%></p>
			<h3>
				$
				<%=formattedPrice%>
			</h3>
		</div>
	</div>

	<div class="view-cmt">
		<%-- Hiển thị các comment của sản phẩm --%>
		<h2>Comments</h2>
		<div class="comments">
			<%
			CommentDao commentDao = new CommentDao(DbCon.getConnection());
			List<Comment> comments = commentDao.getAllCommentByProductId(productId);
			if (!comments.isEmpty()) {
			%>
			<ul class="comment-list">
				<%
				for (Comment comment : comments) {
				%>
				<li class="comment-item"><%=userDao.getUsernameByUserId(comment.getUid())%>
					<span>=> Đã đánh giá <%=comment.getRate()%>🌟
				</span>
					<p>
						Bình luận:
						<%=comment.getComment()%></p></li>
				<%
				}
				%>
			</ul>

			<%
			} else {
			%>
			<p>No comments available.</p>
			<%
			}
			%>
		</div>
		<%
		} else {
		%>
		<h1>Product not found.</h1>
		<%
		}
		%>

		<%
		if (auth != null) {
			String username = userDao.getUsernameByUserId(auth.getId());
		%>
		<form action="danh-gia" method="POST">
			<div>
				<label for="username">Tài khoản đánh giá:</label> <span
					id="username"><%=username%></span>
			</div>
			<input type="hidden" name="productCode" value="<%=productIdParam%>">
			<input type="text" id="comment" name="comment"
				placeholder="Bình luận"><br> <select id="rating"
				name="rating">
				<option value="1">1 🌟</option>
				<option value="2">2 🌟</option>
				<option value="3">3 🌟</option>
				<option value="4">4 🌟</option>
				<option value="5">5 🌟</option>
			</select> <br>
			<button type="submit">Gửi đánh giá</button>
		</form>
		<%
		}
		%>
	</div>

</body>
</html>
