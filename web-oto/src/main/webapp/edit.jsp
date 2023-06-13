<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="web.model.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product</title>
    <link rel="stylesheet" href="./css/edit.css">
    <link rel="icon" href="./product-images/icontab.png">
</head>
<%
User auth = (User) request.getSession().getAttribute("admin");
if (auth != null) {
	request.setAttribute("admin", auth);
}
session.setAttribute("admin", auth);

%>
<body>
    <%@include file="includes/tieude.jsp"%>
    <form method="post" action="edit-product">
        <h1>Edit Product</h1>
        <input type="hidden" name="id" value="${productId}">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="${name}" required><br><br>
        <label for="price">Price:</label>
        <input type="number" id="price" name="price" value="${price}" step="0.01" required><br><br>
        <label for="category">Category:</label>
        <input type="text" id="category" name="category" value="${category}" required><br><br>
        <label for="image">Image:</label>
        <input type="text" id="image" name="image" value="${image}" required><br><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>
