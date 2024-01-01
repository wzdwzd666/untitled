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
    }
  </style>
</head>
<body>

<header>
  <h1>菜品</h1>
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
  </div>
</section>

<script>
  let canteenId;
  window.onload=function getData(){
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    canteenId = urlParams.get('canteenId');
    console.log(canteenId);
    getFood(canteenId);
  }
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }
  function getFood(id) {
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getByCanteen',
        canteenId: id,
      }),
    };
    fetchData('FoodServlet', postOptions)
            .then(data => renderFood(data));
  }
  function renderFood(list) {
    console.log("渲染", list)
    const postsContainer = document.getElementById('post-container');
    // 清空容器
    postsContainer.innerHTML = "";

    list.forEach(postData => {
      const postElement = document.createElement("div");
      postElement.classList.add("post");
      postElement.id=postData.id

      const userElement = document.createElement("div");
      userElement.classList.add("user-info");
      userElement.innerHTML = "<h2><span class='user' id='username'>"+postData.name+"</span></h2><h3>菜系:"+postData.cuisine+"</h3>"+
              "<p>食堂:"+postData.canteen.name+"</p>";
      postElement.appendChild(userElement)

      const contentElement = document.createElement("div");
      contentElement.classList.add("post-content");
      if(postData.image === undefined){
        contentElement.innerHTML = "<p>价格：" + postData.price + "</p>"
      }else{
        contentElement.innerHTML = "<p>价格：" + postData.price + "</p>" + "<img alt='图片' style='width: 200px;' class='post-image'  src=" + postData.image + ">"
      }
      postElement.appendChild(contentElement);

      postsContainer.appendChild(postElement);
    });
  }
</script>

</body>
</html>
