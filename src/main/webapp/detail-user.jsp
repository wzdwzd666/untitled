<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Home</title>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: white;
            padding: 10px;
            text-align: center;
        }

        section {
            margin: 20px auto;
            width: 600px;
        }

        .user-info {
            border: 1px solid #888;
            padding: 10px;
            margin-bottom: 20px;
        }

        .post {
            border: 1px solid #888;
            padding: 10px;
            margin-bottom: 20px;
        }

        .post img {
            max-width: 100%;
            height: auto;
            margin-bottom: 10px;
        }

        .post-content {
            margin-bottom: 10px;
        }

        .return-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin-bottom: 10px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<header>
    <h1>User Home</h1>
</header>

<section>
    <!-- 用户信息 -->
    <div class="user-info">
        <h2><span id="account"></span></h2>
        <div id="name"></div>
        <div id="type"></div>
    </div>

    <!-- 用户帖子 -->
    <h2>用户帖子</h2>
    <div id="post-container">
        <!-- 帖子内容 -->
        <div class="post" id="post-1">
            <h2><span id="user"></span></h2>
            <div id="time" class="timestamp"></div>
            <div id="content">
                <p class="post-content">帖子正文内容...</p>
                <img alt="帖子图片" id="image" src="">
            </div>
        </div>
    </div>

    <!-- 返回按钮 -->
    <button class="return-button" onclick="history.back()">返回</button>
</section>

<script>
    // 使用 JavaScript 从后端获取用户信息和帖子数据
    window.onload = function () {
        getUserInfo();
        getUserPosts();
    }

    // 获取用户信息
    function getUserInfo() {
        // 使用 fetch 或者其他 Ajax 技术从后端获取用户信息，这里只是一个示例
        const userId = "<%= request.getParameter("userId") %>"; // 获取页面传递的用户 ID
        const userInfo = { // 替换成实际的用户信息
            account: "user123",
            name: "John Doe",
            type: "Regular User"
        };

        // 将用户信息显示在页面上
        document.getElementById('account').textContent = "Account: " + userInfo.account;
        document.getElementById('name').textContent = "Name: " + userInfo.name;
        document.getElementById('type').textContent = "Type: " + userInfo.type;
    }

    // 获取用户帖子
    function getUserPosts() {
        // 使用 fetch 或者其他 Ajax 技术从后端获取用户帖子数据，这里只是一个示例
        const userId = "<%= request.getParameter("userId") %>"; // 获取页面传递的用户 ID
        const userPosts = [
            {
                id: 1,
                user: { name: "John Doe" },
                time: "2023-01-01 12:00",
                content: "This is a user post.",
                image: "path/to/image.jpg"
            },
            // 可能有更多的帖子
        ];

        // 将用户帖子显示在页面上
        const postContainer = document.getElementById('post-container');
        userPosts.forEach(post => {
            const postElement = document.createElement("div");
            postElement.classList.add("post");
            postElement.id = "post-" + post.id;

            // 设置帖子内容，类似于之前的例子
            // ...

            postContainer.appendChild(postElement);
        });
    }
</script>

</body>
</html>

