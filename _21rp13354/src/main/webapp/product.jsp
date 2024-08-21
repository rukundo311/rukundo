<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
     
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div class="logo">
		<img src="image/logo.png" width="200px">
	</div>
<div class="cantainer">
	<h1>STOCK MANAGEMENT SYSTEM</h1><br>
<div class="image">
		<img src="image/image.jpg">
	</div>

	<div class="contents">
   <form method="POST">
   	<h2>Insert a Product</h2>
		  <hr>
	<input type="text" name="name" placeholder="Enter  Product Name Here"><br><br>
	<input type="text" name="quantity" placeholder="Enter  Quantity Here"><br><br>
	<input type="text" name="price" placeholder="Enter  Unity Price Here"><br><br>
   	<button  name="submit">Send</button>
   </form>
   </div>
    <%
            if (request.getParameter("submit") != null) {
                String name = request.getParameter("name");
                String quantity = request.getParameter("quantity");
                String price = request.getParameter("price");
                
                String url = "jdbc:mysql://localhost:3306/stock_management";
                String user = "root"; 
                String pass = "";

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    conn = DriverManager.getConnection(url, user, pass);
                    
                   
                    String sql = "INSERT INTO product (productname,quantity,price) VALUES (?,?,?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, name);
                    pstmt.setString(2, quantity);
                    pstmt.setString(3, price);
                   
                    pstmt.executeUpdate();

                    out.println("<h3>New product Recorded Successful!</h3>");
                    out.println("<p>Name: " + name + "</p>");
                    response.sendRedirect("dashboard.jsp");
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>
        
</body>
</html>