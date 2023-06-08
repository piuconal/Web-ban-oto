<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
body{
	background-image: url("./product-images/login.png");
	background-size: cover;
}

.signup-container {
	margin: 150px 0 0 100px;
	max-width: 400px;
	padding: 20px;
	border-radius: 5px;
}

.signup-container h2 {
	text-align: center;
}

.signup-form {
	margin-top: 20px;
}

.form-group {
	margin-bottom: 20px;
}

.form-group label {
	display: block;
	font-weight: bold;
	margin-bottom: 5px;
}

.form-group input[type="text"], .form-group input[type="email"],
	.form-group input[type="password"] {
	width: 95%;
	padding: 10px;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.form-group input[type="submit"] {
	background-color: #4CAF50;
	color: white;
	border: none;
	padding: 10px;
	border-radius: 5px;
	cursor: pointer;
}

.form-group input[type="submit"]:hover {
	background-color: #45a049;
}
</style>
</head>
<body>
	
	<div class="signup-container">
		<h2>Signup</h2>
		<form class="signup-form" action="sign-up" method="post">
			<div class="form-group">
				<label for="name">Name</label> <input type="text" id="name"
					name="name" required>
			</div>
			<div class="form-group">
				<label for="email">Email</label> <input type="email" id="email"
					name="email" required>
			</div>
			<div class="form-group">
				<label for="password">Password</label> <input type="password"
					id="password" name="password" required>
			</div>
			<div class="form-group">
				<input type="submit" value="Signup" style = "margin-right:50px">
				<a href = "login.jsp" style = "color:red">Đã có tài khoản</a>
			</div>
		</form>
	</div>
</body>
</html>

