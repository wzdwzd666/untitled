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
            height: 300px;
        }
        #user{
            cursor: pointer;
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
            /*min-height: 300px;*/
        }
    </style>
</head>
<body>

<header>
    <h1>食堂评价</h1>
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
        <p style='margin-top: 10px' id="avgRating">未评分</p>
        <p style="margin-top: 10px" id="myRating"></p>
    </div>
    <h2>评论</h2>
    <div class="upload-btn-wrapper">
        <label for="evaluate">评论内容:</label><input type="text" name="evaluate" id="evaluate" />
        <div><label for="rating">评分:</label><input type="text" name="rating" id="rating"></div>
        <button onclick="setRating()" id="setRating">发表评分</button>
    </div>
    <!-- 评论区 -->
    <div class="comments" id="comments">
        <!-- 评论区内容 -->
        <div class="comment" id="comment">
            <div id="user-info"><strong ><span id="commenter" class="commenter">评论者1</span>:</strong> <span id="comment-content">这是一个很好的帖子！</span></div>
            <div class="timestamp" id="timestamp" style="margin-left: 20px"></div>
        </div>
    </div>
</section>

<script>
    let canteenId;
    window.onload=function getData(){
        const queryString = window.location.search;
        const urlParams = new URLSearchParams(queryString);
        canteenId = urlParams.get('canteenId');
        console.log(canteenId);
        getCanteen(canteenId);
        getEvaluate(canteenId);
    }
    function fetchData(url, options) {
        return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
    }
    function getCanteen(id) {
        console.log("获取帖子")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getDetailCanteen',
                canteenId: id,
            }),
        };
        fetchData('CanteenServlet', postOptions)
            .then(data => renderCanteen(data));
    }
    function renderCanteen(canteen) {
        console.log("渲染食堂信息", canteen);

        const usernameElement = document.getElementById('user');

        usernameElement.textContent = canteen.name;

        // 其余的渲染逻辑
        document.getElementById('time').textContent = "营业时间:"+canteen.startTime+"-"+canteen.endTime
        document.getElementById('content').innerHTML = "<p>" + canteen.info + "</p>"
        if(canteen.userRating==='还没评分'){
            document.getElementById('myRating').textContent = "你还未评分"
            document.getElementById('setRating').innerText = "评分"
        }else {
            document.getElementById('myRating').textContent = "我的评分:"+canteen.userRating
            document.getElementById('setRating').innerText = "修改评分"
        }
        if(canteen.avgRating==='暂无数据'){
            document.getElementById('avgRating').textContent = "综合评分：" + canteen.avgRating
        }else {
            document.getElementById('avgRating').textContent = "综合评分：" + canteen.avgRating
        }
    }

    function getEvaluate(id) {
        console.log("获取评论")
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getListByCanteenId',
                canteenId: id,
            }),
        };
        fetchData('CanteenEvaluateServlet', postOptions)
            .then(data => renderEvaluate(data));
    }
    function renderEvaluate(list) {
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
            userElement.innerHTML = "<p>用户评分:"+postData.rating+"</p><strong><span class=\"commenter\" id=\"commenter\">" + postData.user.name + "</span>:</strong> <span id=\"comment-content\">" + postData.content + "</span>";
            postElement.appendChild(userElement);
            const commenterElement = userElement.querySelector("#commenter");
            commenterElement.addEventListener('click', function () {
                window.location = 'detail-user.jsp?userId='+postData.user.id;
            });

            const timeElement = document.createElement("div");
            if(postData.admin.name!==undefined){
                timeElement.innerHTML = "<p style='margin-left: 20px'>管理员"+postData.admin.name+" 回复:"+postData.replyContent+"</p>"
            }

            postElement.appendChild(timeElement)
            postsContainer.appendChild(postElement);
        });
    }
    function setRating() {
        const evaluate = document.getElementById('evaluate').value;
        const rating = document.getElementById('rating').value;

        // 判断evaluate是否为空
        if (evaluate.trim() === '') {
            alert("评论不能为空");
            return;
        }
        // 判断rating是否在0到10之间
        const numericRating = parseFloat(rating);
        if (isNaN(numericRating) || numericRating < 0 || numericRating > 10) {
            console.log('评分无效，输入的评分不在0到10之间');
            return;
        }
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'setRating',
                canteenId: canteenId,
                content: evaluate,
                rating: numericRating,
            }),
        };
        fetchData('CanteenEvaluateServlet', postOptions)
            .then(() => window.location.reload());
    }

</script>

</body>
</html>

