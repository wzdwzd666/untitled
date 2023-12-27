<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/assets/css/styles.css">
  <title>发布公告</title>
</head>
<body>

<div class="container">
  <h2>发布公告</h2>

  <form id="announcementForm">
    <label for="announcementTitle">公告标题:</label>
    <input type="text" id="announcementTitle" name="announcementTitle" required>

    <label for="announcementContent">公告内容:</label>
    <textarea id="announcementContent" name="announcementContent" rows="4" required></textarea>

    <button type="button" onclick="publishAnnouncement()">发布公告</button>
  </form>
</div>

<script>
  function publishAnnouncement() {
    const form = document.getElementById('announcementForm');
    const title = form.elements["announcementTitle"].value;
    const content = form.elements["announcementContent"].value;

    // 在这里可以使用 JavaScript 将标题和内容发送到服务器进行保存

    // 例如，使用 Fetch API 发送 POST 请求
    fetch('AnnouncementServlet', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        title: title,
        content: content,
      }),
    })
            .then(response => response.json())
            .then(data => {
              // 处理成功发布公告的情况
              console.log('公告发布成功', data);
              alert('公告发布成功');
              // 清空表单
              form.reset();
            })
            .catch(error => {
              // 处理发布公告失败的情况
              console.error('公告发布失败', error);
              alert('公告发布失败');
            });
  }
</script>

</body>
</html>
