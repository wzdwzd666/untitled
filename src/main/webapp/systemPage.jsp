<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>后台管理</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: green;
      color: white;
      padding: 10px;
      text-align: center;
    }

    nav {
      background-color:#007DDB;
      color: white;
      padding: 10px;
      text-align: center;
    }

    nav a {
      display: inline-block;
      padding: 10px 20px;
      text-decoration: none;
      color: white;
      transition: background-color 0.3s;
    }

    nav a:hover {
      background-color: #333;
    }

    nav .align-right {
      float: right;
    }

    nav .align-left {
      float: left;
    }

    section {
      padding: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #333;
      color: white;
    }

    form {
      width: 50%;
      margin: 0 auto;
    }

    input[type="text"], input[type="password"], select {
      width: 100%;
      padding: 8px;
      margin: 5px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
    }

    input[type="submit"] {
      background-color: #4caf50;
      color: white;
      cursor: pointer;
      padding: 10px;
      border: none;
    }

    iframe {
      width: 100%;
      height: 100%;
      border: none;
    }
  </style>
</head>
<body>
<header>
  <h2>后台管理系统</h2>
</header>
<nav>
  <h2 class="align-left">系统管理员：${admin.name}</h2>
  <a href="canteen-manage.jsp" target="frame">食堂管理</a>
  <a href="account-manage.jsp" target="frame">账号管理</a>
  <a href="evaluate-manage.jsp" target="frame">评价信息</a>
  <a href="community-manage.jsp" target="frame">交流社区</a>
  <a href="index.jsp" class="align-right">退出登录</a>
  <a href="user-detail.jsp" class="align-right">个人信息</a>
</nav>
<section>
  <iframe name="frame" id="frame" src="canteen-manage.jsp"></iframe>
</section>
</body>
</html>
