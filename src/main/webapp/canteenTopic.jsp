<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>交流社区</title>
  <link rel="stylesheet" href="assets/css/manage1.css">
</head>
<body>
<h2>社区帖子</h2>

<h3>帖子列表</h3>

<table id="topicTable">
  <thead>
  <tr>
    <th>ID</th>
    <th>用户ID</th>
    <th>标题</th>
    <th>发表时间</th>
    <th>内容</th>
    <th>图片</th>
    <th>点赞</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>

  </tbody>
</table>
<script>
  // 页面加载时渲染信息列表
  window.onload = getTopicList;
  // 使用Fetch API发送请求
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }

  // 获取话题列表
  function getTopicList() {
    // 构造 POST 请求的选项对象
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getList',
      }),
    };

    fetchData('TopicServlet', postOptions)
            .then(data => renderTopicList(data));
  }

  // 渲染话题列表
  function renderTopicList(list) {
    console.log("渲染列表")
    console.log(list)
    const tableBody = document.getElementById('topicTable').getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';
    list.forEach(review => {
      const row = tableBody.insertRow(-1);
      row.id = review.id
      row.insertCell(0).textContent = review.id
      row.insertCell(1).textContent = review.userId
      row.insertCell(2).textContent = review.title
      row.insertCell(3).textContent = review.time;
      row.insertCell(4).textContent = review.content
      // 插入图片
      if(review.image === undefined){
        row.insertCell(5).textContent = "无"
      }else {
        console.log(review.image)
        row.insertCell(5).innerHTML = "<img src='" + review.image + "' alt='Review Image' style='max-width: 100px; max-height: 100px;'>"
      }
      row.insertCell(6).textContent = review.like
      row.insertCell(7).innerHTML = "<button onclick=\"likeTopic('"+review.id+"','"+review.like+"')\">点赞</button> " +
              "<button onclick=\"window.location='detail-topic.jsp?topicId="+review.id+"&userId="+review.userId+"'\">查看</button>"
      // row.insertCell(7).innerHTML = "<button onclick=\"likeTopic('"+review.id+"','"+review.like+"')\">点赞</button> " +
      //         "<button onclick=\"window.location='detail-topic.jsp?topicId="+encodeURIComponent(review.id)+
      //         "&userId="+encodeURIComponent(review.userId)+
      //         "&title="+encodeURIComponent(review.title)+
      //         "&time="+encodeURIComponent(review.time)+
      //         "&content="+encodeURIComponent(review.content)+"'\">查看</button>";
    });
  }
  // 删除话题
  function likeTopic(topicId,like) {
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'like',
        id: topicId,
        like: like,
      }),
    };
    fetch('TopicServlet', postOptions)
    //     .then(data => renderReviewList(data));
  }
</script>
</body>
</html>
