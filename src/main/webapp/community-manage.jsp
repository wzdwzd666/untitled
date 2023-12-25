<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>食堂评价信息管理</title>
    <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
    <style>
        .canteenSelect {
            padding: 8px;
            font-size: 16px;
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<h2>食堂评价信息列表</h2>

<label for="canteenSelect">选择食堂：</label>
<select id="canteenSelect" class="canteenSelect" onchange="getCanteenReviews()">
    <!-- 这里应该通过后端获取食堂列表动态生成选项 -->
    <option value="1">食堂1</option>
    <option value="2">食堂2</option>
    <option value="3">食堂3</option>
</select>

<table id="reviewTable" border="1">
    <thead>
    <tr>
        <th>ID</th>
        <th>内容</th>
        <th>食堂</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <!-- 评价信息将通过后端动态生成 -->
    </tbody>
</table>
</body>
<script>
    // 使用Fetch API发送请求
    function fetchData(url, options) {
        return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
    }

    // 获取评价信息列表
    function getCanteenReviews() {
        const selectedCanteenId = document.getElementById('canteenSelect').value;
        fetchData(`ReviewServlet?type=getList&canteenId=${selectedCanteenId}`)
            .then(data => renderReviewList(data));
    }

    // 渲染评价信息列表
    function renderReviewList(list) {
        const tableBody = document.getElementById('reviewTable').getElementsByTagName('tbody')[0];
        tableBody.innerHTML = '';

        list.forEach(review => {
            const row = tableBody.insertRow(-1);
            const cell1 = row.insertCell(0);
            const cell2 = row.insertCell(1);
            const cell3 = row.insertCell(2);
            const cell4 = row.insertCell(3);

            cell1.innerHTML = review.id;
            cell2.innerHTML = review.content;
            cell3.innerHTML = review.canteen;
            cell4.innerHTML = `<button onclick="editReview(${review.id}, '${review.content}')">编辑</button>
                                   <button onclick="deleteReview(${review.id})">删除</button>`;
        });
    }

    // 编辑评价信息
    function editReview(id, content) {
        const newContent = prompt('编辑评价信息:', content);
        if (newContent !== null) {
            const selectedCanteenId = document.getElementById('canteenSelect').value;
            const formData = new FormData();
            formData.append('type', 'edit');
            formData.append('id', id);
            formData.append('newContent', newContent);
            formData.append('canteenId', selectedCanteenId);

            fetchData('ReviewServlet', { method: 'POST', body: formData })
                .then(() => getCanteenReviews());
        }
    }

    // 删除评价信息
    function deleteReview(id) {
        if (confirm('确认删除评价信息？')) {
            const selectedCanteenId = document.getElementById('canteenSelect').value;
            const formData = new FormData();
            formData.append('type', 'delete');
            formData.append('id', id);
            formData.append('canteenId', selectedCanteenId);

            fetchData('ReviewServlet', { method: 'POST', body: formData })
                .then(() => getCanteenReviews());
        }
    }

    // 页面加载时获取默认食堂评价信息列表
    window.onload = getCanteenReviews;
</script>
</html>

