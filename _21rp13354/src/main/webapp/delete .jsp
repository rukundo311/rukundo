<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
    <style type="text/css">
        body {
            background-color: lightskyblue;
            font-family: Arial, sans-serif;
        }
        .message {
            font-size: 20px;
            color: green;
        }
        .error {
            font-size: 20px;
            color: red;
        }
        button {
            border-color: darkblue;
            border-radius: 7px;
            height: 40px;
            width: 150px;
        }
        button:hover {
            background-color: white;
            color: red;
            border-color: red;
        }
    </style>
</head>
<body>
    <%
        String url = "jdbc:mysql://localhost:3306/stock_management";
        String user = "root"; 
        String pass = "";
        Connection conn = null;
        PreparedStatement pstmt = null;

        String productCode = request.getParameter("productcode");
        String message = "";

        if (productCode != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, pass);
                
                // SQL delete statement
                String sql = "DELETE FROM product WHERE productcode = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, productCode);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    message = "Product deleted successfully!";
                } else {
                    message = "Product not found!";
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
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

    <div class="message"><%= message %></div>
    <br>
    <button><a href="dashboard.jsp" style="text-decoration:none; color: black;">Go Back to Dashboard</a></button>
</body>
</html>
