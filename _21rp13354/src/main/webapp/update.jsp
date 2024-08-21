<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
    <meta charset="ISO-8859-1">
    <title>Update Product</title>
    
    
</head>
<body>
    
    <%
    String url = "jdbc:mysql://localhost:3306/stock_management";
    String user = "root"; 
    String pass = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String productCode = request.getParameter("productcode");
    String currentName = "";
    int currentQuantity = 0;
    double currentPrice = 0.0;

    // Fetch the current product details
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, pass);
        String sql = "SELECT productname, quantity, price FROM product WHERE productcode = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, productCode);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            currentName = rs.getString("productname");
            currentQuantity = rs.getInt("quantity");
            currentPrice = rs.getDouble("price");
        }
    } catch (Exception e) {
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update the product details if the form is submitted
    if (request.getParameter("update") != null) {
        String newName = request.getParameter("name");
        int newQuantity = Integer.parseInt(request.getParameter("quantity"));
        double newPrice = Double.parseDouble(request.getParameter("price"));

        try {
            conn = DriverManager.getConnection(url, user, pass);
            String sql = "UPDATE product SET productname = ?, quantity = ?, price = ? WHERE productcode = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newName);
            pstmt.setInt(2, newQuantity);
            pstmt.setDouble(3, newPrice);
            pstmt.setString(4, productCode);
            pstmt.executeUpdate();  
            response.sendRedirect("dashboard.jsp");
        } catch (Exception e) {
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    %>

    <form method="POST">
    <h1>UPDATE PRODUCT</h1><hr><br>
        <label for="name">Product Name:</label>
        <input type="text" name="name" value="<%= currentName %>" required><br><br>

        <label for="quantity"> Quantity:</label><br><br>
        <input type="number" name="quantity" value="<%= currentQuantity %>" required><br><br>

        <label for="price"> Price:</label><br>
        <input type="text" name="price" value="<%= currentPrice %>" required><br><br>

        <input type="hidden" name="productcode" value="<%= productCode %>">
        <button name="update">Update</button>
    </form>
</body>
</html>
