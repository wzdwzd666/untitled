<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Page</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background-image: url("image/loginBack.jpg");
      background-repeat: no-repeat;/*图片不重复*/
      overflow: hidden;/*溢出隐藏*/
      background-size: cover;/*背景覆盖窗口*/
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .login-container {
      background-color: transparent;
      border: 2px solid green;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      width: 300px;
      text-align: center;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      display: block;
      font-size: 20px;
      margin-bottom: 8px;
    }

    .form-group input {
      width: 100%;
      padding: 8px;
      box-sizing: border-box;
      border: 1px solid #cccccc;
      border-radius: 4px;
    }

    .form-group input[type="submit"] {
      background-color: #4caf50;
      color: white;
      cursor: pointer;
    }

    .form-group input[type="submit"]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
  <div class="login-container">
    <h2>食堂社区登录</h2>
    <form action="LoginServlet" method="post">
      <div class="form-group">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="text" id="password" name="password" required>
      </div>
      <div class="form-group">
        <input type="submit" value="登录">
      </div>
    </form>
      <div class="form-group">
        <input type="submit" value="注册新用户" onclick="window.location.href='register.jsp';">
      </div>
  </div>
</body>
</html>

