<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<%
    // DATABASE CONNECTION-------------
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/urls","root","root");    
    PreparedStatement stmt;
    
    //----------------------------------
 %>
<%
    String shortLink = request.getParameter("shortLink");
    String longLink = "";

    try {
        String query = "SELECT longURL FROM allurls WHERE smallURL = ?";
        stmt = con.prepareStatement(query);
        stmt.setString(1, shortLink);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            longLink = rs.getString("longURL");
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    request.setAttribute("shortURL", shortLink);
    request.setAttribute("actualURL", longLink);
    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
    dispatcher.forward(request, response);
%>
