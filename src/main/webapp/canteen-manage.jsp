<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂管理</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f5f5f5;
      color: #333;
      text-align: center;
    }

    header {
      background-color: #4caf50;
      color: white;
      padding: 20px;
    }

    section {
      padding: 20px;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }

    th {
      background-color: #333;
      color: white;
    }

    form {
      width: 50%;
      margin: 0 auto;
      background-color: white;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    }

    input[type="text"], input[type="submit"] {
      width: 100%;
      padding: 10px;
      margin: 5px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
    }

    input[type="submit"] {
      background-color: #4caf50;
      width: 200px;
      color: white;
      cursor: pointer;
      border: none;
    }

    input[type="submit"]:hover {
      background-color: #45a049;
    }
  </style>
</head>
<body>
<header>
  <h2>食堂管理</h2>
</header>
<section>
  <table>
    <thead>
    <tr>
      <th>食堂名称</th>
      <th>营业时间</th>
      <th>介绍</th>
      <th>Action</th>
    </tr>
    </thead>
    <tbody>
    <!-- 这里使用后端数据填充表格 -->
    <tr>
      <c:forEach var="canteen" items="${canteenList}">
        <td>${canteen.name}</td>
        <td>${canteen.startTime}-${canteen.endTime}</td>
        <td>${canteen.info}</td>
        <td>
          <button onclick="editCanteen('${canteen.name}', '${canteen.startTime}-${canteen.endTime}', '${canteen.info}')">编辑</button>
          <button onclick="confirmDelete()">删除</button>
        </td>
      </c:forEach>
    </tr>
    </tbody>
  </table>
  <input type="submit" value="添加新食堂" onclick="newCanteen()">
  <!-- 编辑弹窗 -->
  <dialog id="editDialog">
    <label for="newCanteenName">新的食堂名称:</label>
    <input type="text" id="newCanteenName" name="newCanteenName">
    <label for="newLocation">新的位置:</label>
    <input type="text" id="newLocation" name="newLocation">
    <label for="newBusinessHours">新的营业时间:</label>
    <input type="text" id="newBusinessHours" name="newBusinessHours">
    <button onclick="saveEdit()">保存</button>
  </dialog>

  <!-- 删除确认弹窗 -->
  <dialog id="deleteDialog">
    <p>确认删除食堂: <span id="deleteCanteenName"></span> 吗？</p>
    <button onclick="confirmDelete()">确认删除</button>
    <button onclick="closeDeleteDialog()">取消</button>
  </dialog>
  <dialog id="newDialog">
    <h2>添加食堂</h2>
    <label for="canteenName">食堂名称:</label>
    <input type="text" id="canteenName" name="canteenName" required>
    <label for="location">位置:</label>
    <input type="tim" id="location" name="location" required>
    <label for="businessHours">营业时间:</label>
    <input type="text" id="businessHours" name="businessHours" required>
    <input type="submit" value="添加">
  </dialog>
</section>
<script>
  var editingCanteenName;

  function editCanteen(name, location, hours) {
    editingCanteenName = name;
    document.getElementById('newCanteenName').value = name;
    document.getElementById('newLocation').value = location;
    document.getElementById('newBusinessHours').value = hours;
    document.getElementById('editDialog').showModal();
  }
  function newCanteen(){
    document.getElementById('newDialog').showModal();
  }

  function saveEdit() {
    var newName = document.getElementById('newCanteenName').value;
    var newLocation = document.getElementById('newLocation').value;
    var newHours = document.getElementById('newBusinessHours').value;

    if (newName && newLocation && newHours) {
      // Implement editing logic
      alert('编辑食堂: ' + newName);
      document.getElementById('editDialog').close();
    }
  }

  function confirmDelete(name) {
    document.getElementById('deleteCanteenName').textContent = name;
    document.getElementById('deleteDialog').showModal();
  }

  function closeDeleteDialog() {
    document.getElementById('deleteDialog').close();
  }

  document.getElementById('canteenForm').addEventListener('submit', function (event) {
    event.preventDefault();
    var canteenName = document.getElementById('canteenName').value;
    var location = document.getElementById('location').value;
    var businessHours = document.getElementById('businessHours').value;

    document.getElementById('canteenName').value = '';
    document.getElementById('location').value = '';
    document.getElementById('businessHours').value = '';

    alert('添加食堂: ' + canteenName);
  });
</script>
</body>
</html>
