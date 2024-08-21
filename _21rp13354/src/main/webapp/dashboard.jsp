<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
     
<!DOCTYPE html>
<html>
<head>
<head>
<link rel="stylesheet" type="text/css" href="dash.css">
	<title>Product Recorded</title>
	
</head>
<body><br><br>
		<button><a href="product.jsp" style="text-decoration:none;" class="active">Add New product</a></button>
		<button><a href="retrieve.jsp" style="text-decoration:none;" class="active">Retrieve</a></button>
		<div class="logout"><button><a href="logout.jsp" style="text-decoration:none;">Log Out</a></button><br><br><br><br>
		</div>
		<hr>
	<center>
		<p><b>
	     List of Recorded Product!	
	</b></p>
<table border="1">
	<tr>
		<th>Product Code</th>
		<th>Product Name</th>
		<th>Quantity</th>
		<th>Unity Price </th>
		<th colspan="2">ACTION</th>
	</tr>
	<%
	String url = "jdbc:mysql://localhost:3306/stock_management";
    String user = "root"; 
    String pass = "";

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); 
            conn = DriverManager.getConnection(url, user, pass);
            stmt = conn.createStatement();
            String sql = "SELECT * FROM product";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                int id = rs.getInt("productcode");
                String name = rs.getString("productname");
                int quantity = rs.getInt("quantity");
                int price = rs.getInt("price");
    %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= quantity %></td>
                    <td><%=price %></td>
                    <td><a href="update.jsp?productcode=<%= id %>">Update</a></td>
                     <td><a href="delete.jsp?productcode=<%= id %>">Delete</a></td>
                </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>