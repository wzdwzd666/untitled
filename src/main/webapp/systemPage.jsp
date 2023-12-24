<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>后台管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<header>
  <h2>后台管理系统</h2>
</header>
<nav>
  <a class="align-left" style="">系统管理员：${admin.name}</a>
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
