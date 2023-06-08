<%@ page import="web.model.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
	response.sendRedirect("index.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>

<style>
* {
	margin: 0;
	padding: 0;
}

.container {
	padding-top: 80px;
	padding-left: 80px;
	height: 595px;
	background-image: url("./product-images/login.png");
	background-size: cover;
}

.card {
	border: 2px solid black;
	border-radius: 20px;
	width: 25%;
	height: 400px;
	margin: 10px;	
	padding-left: 80px;
}

.card-header {
	padding-top: 50px;
	padding-left: 30px;
	font-size: 30px;
	margin-bottom: 20px;
}
button{
	margin-top: 20px;
	padding: 10px 30px;
	border-radius: 20px;
}
button.btn-login{
	background-color: #f8bbd0;
	cursor: pointer;
}
button.btn-signup{
	background-color: #8ed1fc;
	cursor: pointer;
}
button:hover{
	transform: scale(1.05);
}
input{
	width: 200px;
	padding: 5px;
	border-radius: 20px;
}
.content{
	width: 100px;
}
</style>
<body>
	<%@include file="includes/nav.jsp"%>
	<div class="container">
		<div class="card">
			<div class="card-header text-center">User Login</div>
			<div class="card-body">
				<form action="user-login" method="post">
					<div class="form-group">
						<label>Email</label>
						</br> 
						<input type="email" class="form-control"
							name="Login-email" placeholder="Enter your email" required>
					</div>
					</br>
					<div class="form-group">
						<label>Password</label> 
						</br>	
						<input type="password"
							class="form-control" name="Login-password"
							placeholder="Enter your password" required>
					</div>
					<div class="text-center">
						<button type="submit" class="btn-login">Login</button>
						<button type="submit" class="btn-signup" id = "signup">Sign up</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<script src="./js/signup.js"></script>
</body>

</html>
