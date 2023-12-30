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

        /*footer {*/
        /*    background-color: #333;*/
        /*    color: #fff;*/
        /*    text-align: center;*/
        /*    padding: 1em;*/
        /*}*/
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
        .notice {
            /*border: 1px solid #ccc; !* 边框样式，可以根据需要调整颜色和粗细 *!*/
            padding: 10px; /* 内边距，确保内容与边框之间有一定的间距 */
            margin-bottom: 10px; /* 底部外边距，确保不同 notice 之间有足够的间距 */
            background-color: #f9f9f9; /* 背景色，可以根据需要调整 */
        }
        iframe{
            width: 100%;
            height: 100%;
            /*margin: 0;*/
            /*padding: 0;*/
            border: none;
        }
    </style>
</head>
<body>
<header>
    <h1>综合信息首页</h1>
</header>

<nav>
    <a href="#">首页</a>
    <a href="#">促销信息</a>
    <a href="#">投票调查</a>
    <a href="#">食堂推荐</a>
    <a href="#">社区热门</a>
    <a href="#">排名信息</a>
</nav>
<iframe src="canteen-home.jsp"></iframe>
<footer>
    &copy; 2023 食堂交流管理社区
</footer>
</body>
</html>
