<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂交流社区首页</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    header {
      background-color: #007DDB;
      color: #fff;
      text-align: center;
      padding: 1em;
    }

    nav {
      display: flex;
      justify-content: space-around;
      background-color: green;
      padding: 0.5em;
    }

    section {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      padding: 1em;
    }

    article {
      background-color: #fff;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin: 0.5em;
      flex: 1 1 300px;
      padding: 1em;
    }

    aside {
      background-color: #f4f4f4;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin: 0.5em;
      flex: 0 1 300px;
      padding: 1em;
    }
    footer {
      position: fixed;
      bottom: 0;
      left: 0;
      width: 100%;
      background-color: #333;
      color: #fff;
      text-align: center;
      padding: 1em;
    }
    iframe{
      width: 100%;
      height: 80%;
      border: none;
      overflow: hidden;
    }
  </style>
</head>
<body>
<header>
  <h1>食堂交流社区网站</h1>
</header>

<nav>
  <a>欢迎${user.type}:${user.name}</a>
  <a href="canteen-home.jsp" target="frame">首页</a>
  <a href="canteen-community.jsp" target="frame">交流社区</a>
  <a href="detail-user.jsp?userId=${user.id}" target="frame">我的信息</a>
  <a href="index.jsp">退出登录</a>
</nav>

  <iframe src="canteen-home.jsp" id="frame" name="frame"></iframe>

<footer>
  &copy; 2023 食堂交流管理社区
</footer>
</body>
<script>
  const iframe = document.getElementById('frame');

  // 添加滚轮事件监听器到 iframe
  iframe.addEventListener('wheel', (event) => {
    // 阻止 iframe 的滚轮事件
    event.preventDefault();

    // 将滚轮事件传递给整个页面
    window.scrollBy(0, event.deltaY);
  });
</script>
</html>
