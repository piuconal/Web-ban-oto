<%@page import="java.util.*"%>
<%@ page import = "web.model.*" %>
<%@page import="web.dao.ProductDao"%>
<%@ page import = "web.connection.DbCon" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    User auth = (User) request.getSession().getAttribute("auth");
    if(auth != null){
    	request.setAttribute("auth", auth);
    }
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
    List<Cart> cartProduct = null;
    if(cart_list != null){
    	ProductDao pDao = new ProductDao(DbCon.getConnection());
    	cartProduct = pDao.getCartProducts(cart_list);
    	request.setAttribute("cart_list", cart_list);
    }
   %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart</title>
<link rel = "stylesheet" href = "./css/cart.css">
<%@include file = "includes/head.jsp" %>
</head>
<body>
<%@include file = "includes/nav.jsp" %>
<div class = "container">
        <div class = "price">Total Price: $542</div>
        <a class = "btn-check-out" href = "#">Check out</a>
        <table class = "table">
            <thead>
                <tr>
                    <th scope="col">Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Price</th>
                    <th scope="col">Buy Now</th>
                    <th scope="col">Cancel</th>
                </tr>
            </thead>
            <tbody>
            <%if(cart_list != null){
            	for(Cart c : cartProduct){
              %>
                    <tr>
                        <td><%= c.getName() %></td>
                        <td><%= c.getCategory() %></td>
                        <td>$<%= c.getPrice() %></td>
                        <td>
                            <form action = "" method ="post" class = "form">
                                <input type = "hidden" name = "id" value = "<%= c.getId() %>" class = "form-input">
                                <div class = "form-group">
                                    <a class = "btn-incre" href ="#">+</a>
                                    <input type ="text" name = "quantity" class ="form-control" value ="<%=c.getQuantity()%>" readonly>
                                    <a class = "btn-decre" href ="#">-</a>
                                </div>
                            </form>
                        </td>
                        <td><button>Cancel</button></td>
                    </tr>
            	<%}
            }
            	%>
            
            </tbody>
        </table>
    </div>
<%@include file = "includes/footer.jsp" %>
</body>
</html></html>