<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂评价信息</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<h2>管理食堂评价</h2>

<h3>管理食堂: ${admin.canteenName}</h3>
<table id="reviewTable">
  <thead>
  <tr>
    <th>评价ID</th>
    <th>用户ID</th>
    <th>食堂ID</th>
    <th>评价内容</th>
    <th>回复管理员ID</th>
    <th>回复内容</th>
    <th>操作</th>
  </tr>
  </thead>
  <tbody>
  <!--    js填充页面-->
  </tbody>
</table>
</body>
<script>
  // 页面加载时获取默认食堂评价信息列表
  window.onload = getCanteenReviews;
  // 使用Fetch API发送请求
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }

  // 获取评价信息列表
  function getCanteenReviews() {
    // 构造 POST 请求的选项对象
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getListByCanteenId',
      }),
    };

    fetchData('CanteenEvaluateServlet', postOptions)
            .then(data => renderReviewList(data));
  }

  // 渲染评价信息列表
  function renderReviewList(list) {
    console.log("渲染列表")
    console.log(list)
    const tableBody = document.getElementById('reviewTable').getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';

    list.forEach(review => {
      const row = tableBody.insertRow(-1);
      row.id = review.id
      row.insertCell(0).textContent = review.id
      row.insertCell(1).textContent = review.user.name
      row.insertCell(2).textContent = review.canteen.name
      row.insertCell(3).textContent = review.content;
      row.insertCell(4).textContent = review.admin.name
      row.insertCell(5).textContent = review.replyContent
      row.insertCell(6).innerHTML = "<button onclick=\"editReview('"+review.id+"', '"+review.replyContent+"')\">回复</button>"
    });
  }

  // 编辑评价信息
  function editReview(id, replyContent) {
    console.log("编辑"+replyContent)
    let newContent
    if (replyContent === undefined) {
      newContent = prompt('编辑回复信息:')
    }else {
      newContent = prompt('编辑回复信息:',replyContent)
    }
    console.log("新回复信息："+newContent)
    if (newContent !== null) {
      // 构造 POST 请求的选项对象
      const postOptions = {
        method: 'POST', // 设置请求方法为 POST
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'edit',
          id: id,
          replyContent: newContent,
        }),
      };
      fetchData('CanteenEvaluateServlet', postOptions)
              .then(data => renderReviewList(data));
    }
  }
</script>
</html>

