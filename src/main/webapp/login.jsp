    <%-- 
        Document   : login
        Created on : Feb 28, 2024, 9:57:34 AM
        Author     : Shashank
    --%>

    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Login Page</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
            <style>
                body, html {
      height: 100%;
    }

    * {
      box-sizing: border-box;
    }   

    .bg-img {
      /* The image used */


      /* Control the height of the image */
      min-height: 400px;
      min-width: 400px;

      /* Center and scale the image nicely */
      background-position: center;
      background-repeat: no-repeat;
      background-size: cover;
      position: relative;
    }
    .img{
        margin-left: 50px;
        margin-top: 50px;
        min-height:250px;
        min-width: 250px; 
    }

    /* Add styles to the form container */
    .container {
      position: absolute;
      top: 75%;
      left: 50%;
      transform: translate(-50%, -50%);
      margin: 30px;
      max-width: 300px;
      padding: 16px;
      background-color: white;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px 6px rgba(0, 0, 0, 0.23);
      border-radius: 5px;
    }

    /* Full-width input fields */
      input[type=text], input[type=password] {
      width: 100%;
      padding: 15px;
      margin: 5px 0 22px 0;
      border: none;
      background: #f1f1f1;
    }

    input[type=text]:focus, input[type=password]:focus {
      background-color: #ddd;
      outline: none;
    }

    /* Set a style for the submit button */
    .btn {
      background-color:  #0397d6;
      color: white;
      padding: 16px 20px;
      border: none;
      cursor: pointer;
      width: 100%;
      opacity: 0.9;
    }

    .btn:hover {
      opacity: 1;
    }
                </style>
                <script>
    function togglePassword() {
        var passwordInput = document.getElementById("password");
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }
    
   function login(username, password) {
    if (username !== 'Admin' || password !== 'Admin@123') {
        document.getElementById('login-message').innerText = 'Invalid username or password. Please try again.';
        return false;
    }
    return true;
}
    </script>
        </head>
        <body>
            <div class="bg-img">
                <img class="img"  src="data:image/png;base64,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" alt="bg img">
      <form action="login" method="post" class="container">
        <h1>Login</h1>
        <div id="login-message" style="color: red;"></div>    
        <label ><b>User Name</b></label>
          <label ></label><input type="text" placeholder="Enter Username" name="username" id="username" required>

        <label ><b>Password</b></label>
        <input type="password" id="password" placeholder="Enter Password" name="password"   required>

        <input type="checkbox" id="showPassword" onclick="togglePassword()"> <!-- Checkbox for show password -->
        <label for="showPassword">Show Password</label>


        <button type="submit" class="btn">Login</button>
      </form>
    </div>
        </body>
    </html>
