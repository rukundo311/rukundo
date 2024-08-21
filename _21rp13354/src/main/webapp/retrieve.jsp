<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Product Search</title>
    <style type="text/css">
    		form{
	justify-content: center;
	align-items: center;
	margin-top: 115px;
	width:65%;
	height: 100px;
	margin-left: 220px;
	box-shadow:2px 4px 8px chocolate;
	border-radius:10px;
	background-color: green;
	text-align:center;
		}
		hr{
	height:3px;
	background-color: black;
	margin:7px

}
 button{
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius:5px;
	font-size: 18px;
	cursor: pointer;
	outline: none; 


}
 button:hover{
	background-color: chocolate;
}
form input{
width:250px;
	height:40px;
	border:none;
	outline: none;
	border-bottom:1px solid blue;
	border-radius: 8px;
	text-align: center;
	background-color: #d7d7e6;
	font-size: 15px;
	color: blue;


}
        table {
            border-collapse: collapse;
            background-color: #cdf489;
        }
        td {
            padding: 10px;
        }
        th {
            background-color: gainsboro;
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
        body {
            background-color: lightskyblue;
        }
        p {
            font-family: sans-serif;
            font-size: 35px;
            background-color: cornflowerblue;
            color: darkblue;
            width: 100%;
            height: 50px;
            border-radius: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <button><a href="dashboard.jsp" style="text-decoration:none;">Go TO Home</a></button><br>
    
    <form method="get" action="">
    <b>Enter ID you want to Retrieve</b><hr>
        <input type="text" name="productcode" placeholder="Enter Product Code" required>
        <button type="submit">Search</button>
    </form>
    
    <p><b>List of Retrieved Products!</b></p>
    
    <table border="1">
        <tr>
            <th>Product Code</th>
            <th>Product Name</th>
            <th>Quantity</th>
            <th>Price</th>
        </tr>
        <%
        String url = "jdbc:mysql://localhost:3306/stock_management";
        String user = "root"; 
        String pass = "";
        String productCode = request.getParameter("productcode");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
            conn = DriverManager.getConnection(url, user, pass);
            
            String sql;
            if (productCode != null && !productCode.isEmpty()) {
                sql = "SELECT * FROM product WHERE productcode = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, productCode);
            } else {
                sql = "SELECT * FROM product";
                pstmt = conn.prepareStatement(sql);
            }

            rs = pstmt.executeQuery();

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
                    <td><%= price %></td>
                </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </table>
</body>
</html>
