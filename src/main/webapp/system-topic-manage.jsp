<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>社区话题管理</title>
    <link rel="stylesheet" href="assets/css/manage.css">
</head>
<body>
<h2>社区话题管理</h2>
<div>
    <label for="searchTitle">通过标题搜索:</label>
    <input type="text" id="searchTitle" name="searchTitle" style="width: 200px">
    <button onclick="searchByTitle()">搜索</button>
</div>

<h3>社区帖子列表:</h3>

<table id="topicTable" border="1">
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
        const searchTitle = document.getElementById('searchTitle').value;
        // 构造 POST 请求的选项对象
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'getAll',
                searchTitle: searchTitle,
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
            row.insertCell(1).textContent = review.user.name
            row.insertCell(2).textContent = review.title
            row.insertCell(3).textContent = review.time;
            row.insertCell(4).textContent = review.content
            // 插入图片
            if(review.image === undefined){
                row.insertCell(5).textContent = "无"
            }else {
                console.log(review.image)
                row.insertCell(5).innerHTML = "<img src='" + review.image + "' alt='Review Image' style='max-width: 100px'>"
            }
            row.insertCell(6).textContent = review.like
            row.insertCell(7).innerHTML = "<button onclick=\"deleteTopic('"+review.id+"')\">删除</button>"
        });
    }
    // 删除话题
    function deleteTopic(topicId) {
        console.log("删除:"+topicId)
        if (confirm('确认删除评价信息?')) {
            document.getElementById(topicId).remove();
            const postOptions = {
                method: 'POST', // 设置请求方法为 POST
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                    type: 'delete',
                    id: topicId,
                }),
            };
            fetch('TopicServlet', postOptions)
            //     .then(data => renderReviewList(data));
        }
    }
    // 给文本框添加键盘按下事件监听器
    document.getElementById('searchTitle').addEventListener('keydown', function(event) {
        if (event.key === 'Enter') {
            // 如果按下的是回车键，则触发搜索操作
            searchByTitle();
        }
    });
    // 根据标题搜索话题
    function searchByTitle() {
        const searchTitle = document.getElementById("searchTitle").value;
        // 构造 POST 请求的选项对象
        const postOptions = {
            method: 'POST', // 设置请求方法为 POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({
                type: 'searchByTitle',
                searchTitle: searchTitle,
            }),
        };
        fetchData('TopicServlet', postOptions)
            .then(data => renderTopicList(data))
            .catch(error => {
                console.error("搜索话题出错:", error);
            });
    }
</script>
</body>
</html>
