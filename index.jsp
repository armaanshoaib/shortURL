<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Short URL Generator</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>shortURL</title>
    <link rel="icon" href="link.png" type="image/x-icon" />
 
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f3f4f6;
            color: #333;
            height: 100vh;
            margin: 0;
            flex-direction: column;
        }
#genDiv{   
     background: #262334;
    margin: 1rem 0;
    text-align: center;
    margin-left: 20px;
    margin-right: 20px;
    padding: 1rem;
    border-radius: 8px;
    box-shadow: 4px 4px 8px 8x rgba(0, 0, 0, 0.2);
    animation-name: fade-in;
    animation-duration: 1s; 
}
@keyframes fade-in{
    from{
        opacity : 0;
    }
    to{
        opacity : 100;    
    }
}
#button {
            width: auto;
            padding: 10px;
            background-color: #4a90e2;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            transition: 0.2s
        }
        #button:hover {
            background-color: #357ABD;
        }
        #resultArea {
            display: none;
        }
        
        #dispLink{
            font-family: sans-serif;
            font-size: 8px;
            
        }
        #inputlongLink{
            width: 90%;
            padding: 12px 20px;
            margin: 8px 0;
            border-radius: 4px;
            box-sizing: border-box; 
            background-color:  #2D2839;
            border-color: wheat;
            text-align: center;
            color: white;
        }
        ::placeholder {
            text-align: center; 
        }
        #inputShortLink{
            width: auto;
            padding: 12px 20px;
            margin: 8px 0;
            border-radius: 4px;
            box-sizing: border-box; 
            background-color:  #2D2839;
            border-color: wheat;
            text-align: center;
            color: white;
        }
        #dispLink{
            font-family: verdana;
            font-size: 20px;
            color:lightsteelblue;
        }
        #copyBtn{
            width: 10%;
            padding: 2px;           
            background-color: transparent;
            color: white;
            border-color: yellow;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.2s;
            font-size: 15px;
            margin-bottom: 5px;
            margin-left: 5px;
            padding-bottom: 3px;            
                
        }
        footer {
           padding: 10px;
  position: fixed;
  left: 0;
  bottom: 0;
  width: 100%;
  background-color: #132232;
  color: gray;
  text-align: center;
}
    </style>
    <script>
        function copyText(id) {
            var copyText = document.getElementById(id).innerText;
            navigator.clipboard.writeText(copyText).then(function() {
                alert('Copied to clipboard');
            });
        }
    </script>
</head>
<body>
    <div id='genDiv'>
        <form method="post" action='generate.jsp'>
             <h1 style="font-family: verdana;font-size: 28px;text-align: center; color: violet">SHORTEN URL</h1>
            <input type='text' placeholder="Enter looooong URL here..." name='longLink' id="inputlongLink" required>
            <br>
            <button type='submit' id="button">Generate short link</button>
        </form>

      
        <% 
            String smallURL = (String) request.getAttribute("smallURL");
            String longURL = (String) request.getAttribute("longURL");
            if (smallURL != null) { 
        %>
            <p id='dispLink'>Original Link: <%= longURL %></p>
            <p id='dispLink'>Generated Short Link: <span style="color:yellow;" id="shortURL"><%= smallURL %></span></p>
            <button onclick='copyText("shortURL")' id='copyBtn'>Copy URL</button>
        <% } %>
    </div>
<!--==================================================================================== -->
    <div id='genDiv'>
        
        <form method="post" action='retrieve.jsp'>
             <h1 style="font-family: verdana;font-size: 28px;text-align: center; color: violet">Retrieve Long URL</h1>
            <input type='text' placeholder="Enter short URL here..." name='shortLink' id="inputShortLink" required>
            <br>
            <button type='submit' id="button">Retrieve long URL</button>
        </form>

        <% 
            String shortURL = (String) request.getAttribute("shortURL");
            String actualURL = (String) request.getAttribute("actualURL");
            if (actualURL != null && !actualURL.isEmpty()) {
        %>
            <p id='dispLink'>Short Link: <%= shortURL %></p>
            <p id='dispLink'>Retrieved Long Link: <span style="color:yellow;"><%= actualURL %></span></p>
        <% } else if (request.getAttribute("shortURL") != null) { %>
            <h3 style='color:red; font-size:20px; font-family:consolas;'>NO URL FOUND!</h3>
        <% } %>
    </div>
</body>
<footer>
    <label>Project done by ArmaanShoaib.</label>
    <a href ="https://github.com/armaanshoaib" style="color: antiquewhite">GitHub</a>
    
</footer>
</html>
