<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>
<%@page import="java.sql.*" %>
<%
    // DATABASE CONNECTION-------------
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/urls","root","root");    
    PreparedStatement stmt;
    
    //----------------------------------
 %>
<%
    String longURL = request.getParameter("longLink");
    String temp = "";
    String alpha = "abcdefghijklmnopqrstuvwxyz1234567890";
    Random rand = new Random();

    for (int i = 0; i < 6; i++) {
        int randIndex = rand.nextInt(alpha.length());
        temp += alpha.charAt(randIndex);
    }

    String smallURL = "https://shortURL.io/" + temp;

    try {
        String query = "INSERT INTO allurls (longURL, smallURL) VALUES (?, ?)";
        stmt = con.prepareStatement(query);
        stmt.setString(1, longURL);
        stmt.setString(2, smallURL);
        stmt.executeUpdate();
        stmt.close();
        con.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }

    request.setAttribute("smallURL", smallURL);
    request.setAttribute("longURL", longURL);
    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
    dispatcher.forward(request, response);
%>
