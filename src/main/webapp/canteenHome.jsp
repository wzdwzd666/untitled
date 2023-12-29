<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂交流社区</title>
</head>
<body>
<header>
  <div>
    <h2>欢迎${user.type}:${user.name}</h2>
  </div>
  <div class="logo">
    <h1>食堂交流社区</h1>
  </div>
  <nav>
    <ul>
      <li><a href="homePage.jsp" target="frame" id="home">首页</a></li>
      <li><a href="canteenTopic.jsp" target="frame" id="topic">交流社区</a></li>
<!--      <li><a href="#">我的消息</a> </li>-->
      <li><a href="user-detail.jsp" target="frame" id="detail">我的信息</a></li>
      <li><a href="index.jsp">退出登录</a></li>
    </ul>
  </nav>
</header>
<iframe name="frame" id="frame" src="homePage.jsp"></iframe>
</body>
</html>
