<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>后台管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
  <style>
    .selected {
      background-color: #333333; /* 设置选中时的背景色 */
    }
  </style>
</head>
<body>
<header>
  <h2>后台管理系统</h2>
</header>
<nav>
  <a class="align-left">系统管理员：${admin.name}</a>
  <a href="canteen-manage.jsp" target="frame" id="canteen" onclick="changeColor('canteen')" class="selected">食堂管理</a>
  <a href="account-manage.jsp" target="frame" id="account" onclick="changeColor('account')">账号管理</a>
  <a href="evaluate-manage.jsp" target="frame" id="evaluate" onclick="changeColor('evaluate')">评价信息</a>
  <a href="community-manage.jsp" target="frame" id="community" onclick="changeColor('community')">交流社区</a>
  <a href="index.jsp" class="align-right">退出登录</a>
  <a href="user-detail.jsp" class="align-right" target="frame" id="detail" onclick="changeColor('detail')">个人信息</a>
</nav>
<section>
  <iframe name="frame" id="frame" src="canteen-manage.jsp"></iframe>
</section>
</body>
<script>
  // 点击链接时改变导航栏颜色
  function changeColor(linkId) {
    // 移除所有链接上的选中样式
    const navLinks = document.querySelectorAll('nav a');
    navLinks.forEach(link => link.classList.remove('selected'));

    // 将当前点击的链接添加选中样式
    const currentLink = document.getElementById(linkId);
    currentLink.classList.add('selected');
  }
</script>
</html>