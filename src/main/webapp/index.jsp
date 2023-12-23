<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="/assets/css/login.css">
  <title>登录界面</title>
</head>
<body>
  <div class="login-container">
    <h2>食堂社区登录</h2>
    <form action="LoginServlet" method="post">
      <div class="form-group">
        <label>
          <select name="type" >
            <option value="user">师生用户登录</option>
            <option value="admin">管理员登录</option>
          </select>
        </label>
      </div>
      <div class="form-group">
        <label for="account">Account:</label>
        <input type="text" id="account" name="account" required>
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
<script type="text/javascript">
  let error = "${param.error}"
  if(error==="userAccount"){
    alert("用户账号不存在！");
  }else if(error==="userPassword"){
    alert("用户密码错误！")
  }else if(error==="adminAccount"){
    alert("管理员账号不存在！")
  }else if(error==="adminPassword"){
    alert("管理员密码错误！")
  }
</script>
</html>

