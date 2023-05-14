<%@page import="web.dao.ProductDao"%>
<%@ page import = "web.connection.DbCon" %>
<%@ page import = "web.model.*" %>
<%@page import = "java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
    User auth = (User) request.getSession().getAttribute("auth");
    if(auth != null){
    	request.setAttribute("auth", auth);
    }
    
    ProductDao pd = new ProductDao(DbCon.getConnection());
    List<Product> products = pd.getAllProducts();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel = "stylesheet"  href = "./css/index.css">

<%@include file="includes/head.jsp"%>
</head>
<body>
	<%@include file="includes/nav.jsp"%>
<div class="container">
    <div class="card-header">All product</div>
    <div class="row">
        <%
            if (!products.isEmpty()) { 
             for (Product p : products) { 
             %>
                <div class="box-content">
                    <div class="card">
                        <img class="card-img-top" src="./product-images/<%=p.getImage() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%=p.getName() %></h5>
                            <h6 class="price">Price: $<%=p.getPrice() %></h6>
                            <h6 class="category">Category: <%=p.getCategory() %></h6>
                            <div class="card-btn">
                                <a href="add-to-cart?id =<%= p.getId() %>" class="add-btn" >Add to cart</a>
                                <a href="#" class="buy-btn">Buy Now</a>
                            </div>
                        </div>
                    </div>
                </div>
     <% } 
         }else{
        	 out.println("no product");
         }
        %>
    </div>
</div>
		<%@include file="includes/footer.jsp"%>
</body>
</html>