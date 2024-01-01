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
            cursor: pointer;
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
        .post-actions {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin: 10px 35px;
        }

        button.view-button {
            background-color: #008CBA; /* Blue background */
            color: white;
            border: none;
            padding: 8px 16px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            cursor: pointer;
        }
    </style>
</head>
<body>

<header>
    <h1>用户主页</h1>
    <!-- 返回按钮 -->
    <button class="return-button" onclick="history.back()">返回</button>
</header>

<section>
    <!-- 用户信息 -->
    <div class="user-info">
        <div>账号:<span id="account"></span></div>
        <h2 ><span id="name"></span> <span id="type"></span></h2>
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
</section>

<script>
    // 使用 JavaScript 从后端获取用户信息和帖子数据
    window.onload = function () {
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        const id = urlParams.get('userId');
        console.log(id);
        getUserInfo(id);
        getUserPosts(id);
    }
    function fetchData(url, options) {
        return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
    }

    // 获取用户信息
    function getUserInfo(id) {
        console.log("获取用户信息")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getUser',
                userId: id,
            }),
        };
        fetchData('UserServlet', postOptions)
            .then(user => {
                document.getElementById('account').textContent=user.account
                document.getElementById('name').textContent=user.name
                document.getElementById('type').textContent=user.type
            });

    }

    // 获取用户帖子
    function getUserPosts(id) {
        console.log("获取用户帖子信息")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getByUserId',
                userId: id,
            }),
        };
        fetchData('TopicServlet', postOptions)
            .then(list => {
                const postsContainer = document.getElementById('post-container');
                // 清空容器
                postsContainer.innerHTML = "";
                list.forEach(postData => {
                    const postElement = document.createElement("div");
                    postElement.classList.add("post");
                    postElement.id = postData.id;

                    postElement.addEventListener('click', function () {
                        window.location='detail-topic.jsp?topicId='+postData.id
                    });

                    const userElement = document.createElement("h2");
                    userElement.innerHTML = "<span id=\"username\">"+postData.user.name+"</span>"
                    postElement.appendChild(userElement)

                    const timeElement = document.createElement("div");
                    timeElement.classList.add("timestamp")
                    timeElement.textContent = postData.time
                    postElement.appendChild(timeElement)

                    const contentElement = document.createElement("div");
                    contentElement.classList.add("content");
                    if(postData.image===undefined){
                        contentElement.innerHTML = "<p class='post-content'>"
                    }else {
                        contentElement.innerHTML = "<p class='post-content'>" + postData.content + "</p>" + "<img alt='图片' style='width: 200px;' class='post-image'  src=" + postData.image + ">";
                    }
                    postElement.appendChild(contentElement);

                    const actionsElement = document.createElement("div");
                    actionsElement.classList.add("post-actions");
                    actionsElement.innerHTML =
                        "<div class=\"like-count\">点赞数：<span id=\"like-count\">"+postData.like+"</span></div>"+
                        "<button class='view-button' onclick=\"showDetail('" + postData.id + "')\">查看</button>"
                    postElement.appendChild(actionsElement);


                    postsContainer.appendChild(postElement);
                });
            });
    }
    function showDetail(id){
        window.location='detail-topic.jsp?topicId='+id
    }
</script>

</body>
</html>

