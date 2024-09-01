<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Random" %>
<%@page import="java.sql.*" %>

<%
    String longURL = request.getParameter("longLink");
    String temp = "";
    String alpha = "abcdefghijklmnopqrstuvwxyz1234567890";
    Random rand = new Random();
    String alias = request.getParameter("alias");
    System.out.println("alias = " + alias);
    boolean aliasExist = false;
    String smallURL = "";
    
    if(alias == ""){
         Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/urls","root","root");    
        PreparedStatement stmt;
        // random url generated
        for (int i = 0; i < 6; i++) {
            int randIndex = rand.nextInt(alpha.length());
            temp += alpha.charAt(randIndex);
        }
        smallURL = "https://shortURL.io/" + temp;
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
    }
    else{
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/urls","root","root");    
        PreparedStatement stmt;
        // custom url to be generated with Alias
        smallURL = "https://shortURL.com/"+alias;
        try {
            String query = "select longURL from allurls where smallURL = ?";
            stmt = con.prepareStatement(query);
            stmt.setString(1, smallURL);
            ResultSet rs = stmt.executeQuery();
       
            // collision occurs
            if(rs.next()){
            System.out.println("rs.next(");
                aliasExist = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // handle collision
        if(aliasExist){
            System.out.println("aliasExist");
            request.setAttribute("aliasPresent", "!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
            con.close();
        }
        else{
            smallURL = "https://shortURL.com/"+alias;
            try {
                String query = "INSERT INTO allurls (longURL, smallURL) VALUES (?, ?)";
                stmt = con.prepareStatement(query);
                stmt.setString(1, longURL);
                stmt.setString(2, smallURL);
                stmt.executeUpdate();
                stmt.close();
                con.close();
                System.out.println("Inserted alias into DB : " +  smallURL);
            } catch (SQLException e) {
                    e.printStackTrace();
            }
            request.setAttribute("smallURL", smallURL);
            request.setAttribute("longURL", longURL);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        
        }
        
    }
%>
