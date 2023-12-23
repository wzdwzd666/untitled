<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/assets/css/login.css">
    <title>注册新用户</title>
  </head>
  <body>
  <div class="login-container">
    <h2>新用户注册</h2>
    <form action="RegisterServlet" method="post">
      <div class="form-group">
        <label>
          注册类型
          <select name="type" >
            <option value="user">老师</option>
            <option value="admin">学生</option>
          </select>
        </label>
      </div>
      <div class="form-group">
        <label for="account">Account:</label>
        <input type="text" id="account" name="account" required>
      </div>
      <div class="form-group">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required>
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="text" id="password" name="password" required>
      </div>
      <div class="form-group">
        <input type="submit" value="注册并登录">
      </div>
    </form>
  </div>
  </body>
</html>
