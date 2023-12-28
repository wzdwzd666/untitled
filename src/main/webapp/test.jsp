<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>食堂交流社区</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
</head>
<body>
<header>
    <nav>
        <div class="logo">
            <img src="logo.png" alt="食堂交流社区">
        </div>
        <div class="user">
            欢迎，[用户名]
            <ul>
                <li><a href="#">个人信息</a></li>
                <li><a href="#">设置</a></li>
                <li><a href="#">退出</a></li>
            </ul>
        </div>
        <ul class="nav-links">
            <li><a href="#">社区</a></li>
            <li><a href="#">食堂推荐</a></li>
            <li><a href="#">投票调查</a></li>
            <li><a href="#">食堂排名</a></li>
            <li><a href="#">菜品排名</a></li>
            <li><a href="#">投诉建议</a></li>
        </ul>
        <div class="notifications">
            <ul>
                <li><a href="#">你有1条未读评论</a></li>
                <li><a href="#">你有2条未读点赞</a></li>
                <li><a href="#">你有1条未读投诉回复</a></li>
            </ul>
        </div>
    </nav>
</header>
<main>
    <iframe src="canteenHome.jsp"></iframe>
</main>
</body>
<style>
    /* CSS代码 */

    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
    }

    header {
        background-color: #333;
        color: #fff;
        padding: 10px;
    }

    .logo {
        float: left;
    }

    .logo img {
        height: 50px;
    }

    .user {
        float: right;
    }

    .user ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    .user ul li {
        display: inline-block;
        margin-right: 10px;
    }

    .user ul li a {
        color: #fff;
        text-decoration: none;
    }

    .nav-links {
        float: right;
    }

    .nav-links ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    .nav-links ul li {
        display: inline-block;
        margin-right: 10px;
    }

    .nav-links ul li a {
        color: #fff;
        text-decoration: none;
    }

    .notifications {
        float: right;
    }

    .notifications ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    .notifications ul li {
        display: inline-block;
        margin-right: 10px;
    }

    .notifications ul li a {
        color: #fff;
        text-decoration: none;
    }

    main {
        margin-top: 50px;
    }

    iframe {
        width: 100%;
        height: 800px;
    }

    .home-content {
        padding: 20px;
    }

    .module {
        margin-bottom: 20px;
    }

    .module h2 {
        font-size: 1.5em;
        margin-bottom: 10px;
    }

    .module ul {
        list-style-type: none;
        margin: 0;
        padding: 0;
    }

    .module ul li {
        margin-bottom: 5px;
    }

    .module ul li a {
        color: #333;
        text-decoration: none;
    }
</style>
</html>