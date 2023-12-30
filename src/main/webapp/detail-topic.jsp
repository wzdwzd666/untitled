<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>帖子详细页面</title>
  <link rel="stylesheet" href="assets/css/home.css">
  <link rel="stylesheet" href="assets/css/manage.css">
  <style>
    body{
      text-align: center;
    }
  </style>
</head>
<body>
    <h2>标题:<span id="title"></span></h2>
    <h1 style="visibility: hidden;">帖子:<span id="topicId">${param.topicId}</span></h1>
    <h2>用户:
      <c:forEach var="user" items="${userList}">
        <c:if test="user.id==param.userId">
          ${user.name}
        </c:if>
      </c:forEach></h2>
    <p>时间:<span id="time"></span></p>
    <img alt="topicImage" src="" id="image" style="width: 600px">
    <h2>内容</h2>
    <p id="content"> </p>
    <label for="replyContent"></label>
    <input type="text" id="replyContent">
    <input type="submit" onclick="topicEvaluate()" value="发表评价">
    <div class="actions">
      <button id="likeButton">点赞</button>
      <div>点赞数:<span id="likeCount"></span></div>
    </div>
    <div>
      <c:forEach var="topicEvaluate" items="${topicEvaluateList}">
        <c:if test="${topicEvaluate.userId==param.userId and topicEvaluate.topicId==param.topicId}">
          <h2>用户:
            <c:forEach var="user" items="${userList}">
              <c:if test="user.id==topicEvaluate.userId">
                ${user.name}
              </c:if>
            </c:forEach></h2>
          <p>时间：${topicEvaluate.time}</p>
          <p>内容：${topicEvaluate.content}</p>
        </c:if>
      </c:forEach>
    </div>
</body>
<script>
  const topicId=document.getElementById('topicId').textContent
  window.onload=getTopic
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }
  function getTopic(){
    console.log(topicId)
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getTopic',
        id: topicId,
      }),
    };
    fetchData('TopicServlet', postOptions)
        .then(data => renderReview(data));
  }
  function renderReview(topic) {
    console.log(topic)
    document.getElementById('title').textContent=topic.title
    document.getElementById('time').textContent=topic.time
    document.getElementById('image').src=topic.image
    document.getElementById('content').textContent=topic.content
    document.getElementById('likeCount').textContent=topic.like
  }
  function topicEvaluate(){

  }
</script>
</html>
