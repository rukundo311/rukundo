<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="false" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>STOCK MANAGEMENT SYSTEM</h1><hr><br>
    
        <form method="POST">
            <h2><center>Signin</center></h2>
            <hr>
            <input type="email" name="email" placeholder="Enter Email Here"><br><br>
            <input type="password" name="password" placeholder="Enter Password Here"><br><br>
            <button name="submit">LogIn</button>
            <p>I don't Have Any Account <a href="signup.jsp">SignUp Here</a></p>
        </form>
        <%
            if (request.getParameter("submit") != null) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");

                String url = "jdbc:mysql://localhost:3306/stock_management";
                String user = "root"; 
                String pass = "";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    conn = DriverManager.getConnection(url, user, pass);
                    
             
                    String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, password); 
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                       
                        HttpSession session = request.getSession();
                        session.setAttribute("userEmail", email);
                        
                        out.println("<h3>Login Successful!</h3>");
                        out.println("<p>Welcome, " + email + "!</p>");
                        response.sendRedirect("dashboard.jsp");
                    } else {
                        out.println("<h3>Invalid email or password!</h3>");
                    }
                } catch (Exception e) {
                    out.println("<h3>Error: " + e.getMessage() + "</h3>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            }
        %>
</body>
</html>
