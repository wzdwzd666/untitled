<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>帖子内容</title>
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
            width: 500px;
        }

        .post {
            border: 1px solid #888;
            padding: 10px;
            margin-bottom: 20px;
        }
        #user{
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

        .comments {
            margin-top: 10px;
        }

        .comment {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
        }
        .commenter {
            cursor: pointer;
        }
        .like-count {
            font-size: 16px;
            margin-bottom: 10px;
        }
        input[type="text"] {
            width: 80%;
            padding: 8px;
            margin: 5px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        button {
            padding: 8px 12px;
            font-size: 14px;
            background-color: green;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .timestamp {
            color: #888;
        }
        .content{
            background: #f4f4f4;
            margin: 20px;
            min-height: 300px;
        }
    </style>
</head>
<body>

<header>
    <h1>帖子内容</h1>
    <!-- 返回按钮 -->
    <button onclick="history.back()">返回</button>
</header>

<section id="post-container">
    <!-- 帖子内容 -->
    <div class="post" id="post-1">
        <h2><span id="user"></span></h2>
        <div id="time" class="timestamp"></div>
        <div id="content" class="content">
            <p class="post-content">帖子正文内容...</p>
            <img alt="帖子图片" id="image" src="">
        </div>
        <!-- 点赞区域 -->
        <div class="like-count">点赞数：<span id="like-count">0</span></div>
        <button class="like-button" id="like-button" onclick="like()">点赞</button>
    </div>
    <h2>评论</h2>
    <div class="upload-btn-wrapper">
        <input type="text" name="evaluate" id="evaluate" />
        <button onclick="postComment(${param.topicId})">发表评论</button>
    </div>
    <!-- 评论区 -->
    <div class="comments" id="comments">
        <!-- 评论区内容 -->
        <div class="comment" id="comment">
            <div id="user-info"><strong ><span id="commenter" class="commenter">评论者1</span>:</strong> <span id="comment-content">这是一个很好的帖子！</span></div>
            <div class="timestamp" id="timestamp"></div>
        </div>
    </div>
</section>

<script>
    let topicId;
    window.onload=function getData(){
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        topicId = urlParams.get('topicId');
        console.log(topicId);
        getTopic(topicId);
        getComment(topicId);
        getLike(topicId);
    }
    function fetchData(url, options) {
        return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
    }
    function getTopic(id) {
        console.log("获取帖子")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getTopic',
                id: id,
            }),
        };
        fetchData('TopicServlet', postOptions)
            .then(data => renderTopic(data));
    }
    function renderTopic(topic) {
        console.log("渲染帖子", topic);

        // 获取用户名元素
        const usernameElement = document.getElementById('user');

        // 设置用户名文本内容
        usernameElement.textContent = topic.user.name;

        // 添加点击事件监听器
        usernameElement.addEventListener('click', function () {
            // 这里放置点击用户名时的操作，比如跳转到用户详情页
            window.location = 'detail-user.jsp?userId=' + topic.user.id;
        });

        // 其余的渲染逻辑
        document.getElementById('time').textContent = topic.time;
        if(topic.image===undefined){
            document.getElementById('content').innerHTML = "<p>" + topic.content + "</p>";
        }else {
            document.getElementById('content').innerHTML = "<p>" + topic.content + "</p>" + "<img alt='图片' style='width: 350px;' class='post-image'  src=" + topic.image + ">";
        }
        document.getElementById('like-count').textContent = topic.like;
    }

    function getComment(id) {
        console.log("获取评论")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getById',
                topicId: id,
            }),
        };
        fetchData('TopicEvaluateServlet', postOptions)
            .then(data => renderComment(data));
    }
    function renderComment(list) {
        console.log("渲染评论", list)
        const postsContainer = document.getElementById('comments');
        // 清空容器
        postsContainer.innerHTML = "";

        list.forEach(postData => {
            const postElement = document.createElement("div");
            postElement.classList.add("comment");
            postElement.id=postData.id


            const userElement = document.createElement("div");
            userElement.classList.add("user-info");
            userElement.innerHTML = "<strong><span class=\"commenter\" id=\"commenter\">" + postData.user.name + "</span>:</strong> <span id=\"comment-content\">" + postData.content + "</span>";
            postElement.appendChild(userElement);
            const commenterElement = userElement.querySelector("#commenter");
            commenterElement.addEventListener('click', function () {
                window.location = 'detail-user.jsp?userId='+postData.user.id;
            });

            const timeElement = document.createElement("div");
            timeElement.classList.add("timestamp");
            timeElement.textContent = postData.time

            postElement.appendChild(timeElement)
            postsContainer.appendChild(postElement);
        });
    }
    function getLike(topicId) {
        console.log("发表评论")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'checkLike',
                topicId: topicId,
            }),
        };
        fetchData('TopicServlet', postOptions)
            .then(data => {
                document.getElementById('like-button').innerText = data.message
            });
    }
    function postComment(topicId) {
        console.log("发表评论")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'postComment',
                topicId: topicId,
                content: document.getElementById('evaluate').value
            }),
        };
        fetchData('TopicEvaluateServlet', postOptions)
            .then(data => {
                document.getElementById('evaluate').value = ""
                renderComment(data)
            });
    }
    function like() {
        console.log("点赞")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'like',
                id: topicId,
            }),
        };
        fetchData('TopicServlet', postOptions)
            .then(data => {
                console.log(data.message)
                if (data.message=='点赞') {
                    document.getElementById('like-button').innerText = data.message
                } else {
                    document.getElementById('like-button').innerText = data.message
                }
                document.getElementById('like-count').textContent = data.like;
            });
    }
</script>

</body>
</html>
