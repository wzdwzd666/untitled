<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>账号管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<header>
  <h2>师生账号列表</h2>
</header>
<section>
  <input type="submit" value="添加新用户" onclick="document.getElementById('newDialog').showModal()">
  <table id="userTable">
    <thead>
    <tr>
      <th>用户编号</th>
      <th>用户账号</th>
      <th>用户姓名</th>
      <th>用户密码</th>
      <th>用户类型</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <!-- 填充表格 -->
    </tbody>
  </table>

  <!-- 编辑弹窗 -->
  <dialog id="editDialog">
    <h2>编辑用户信息</h2>
    <label for="newUserName">编辑用户姓名:</label>
    <input type="text" id="newUserName" name="newUserName" required>
    <label for="newPassword">编辑用户密码:</label>
    <input type="text" id="newPassword" name="newPassword" min="6:00" max="11:00" required>
    <div>
      <label>
        更改用户类型:
        <select id="newType" name="newType" >
          <option value="老师">老师</option>
          <option value="学生">学生</option>
        </select>
      </label>
    </div>
    <input type="submit" onclick="saveEdit()" value="保存更改">
    <input type="submit" onclick="document.getElementById('editDialog').close();" value="取消">
  </dialog>

  <!-- 删除确认弹窗 -->
  <dialog id="deleteDialog">
    <h2>确认</h2>
    <p>确认删除用户: <span id="deleteUserName"></span> 吗？</p>
    <button onclick="confirmDelete()">确认删除</button>
    <button onclick="document.getElementById('deleteDialog').close();">取消</button>
  </dialog>

  <!-- 新增弹窗 -->
  <dialog id="newDialog">
    <h2>新增用户</h2>
    <label for="userAccount">用户账号:</label>
    <input type="text" id="userAccount" name="userAccount" required>
    <label for="userName">用户姓名:</label>
    <input type="text" id="userName" name="userName" required>
    <label for="userPassword">用户密码:</label>
    <input type="text" id="userPassword" name="userPassword" required>
    <label>
      用户类型:
      <select id="userType" name="userType" >
        <option value="老师">老师</option>
        <option value="学生">学生</option>
      </select>
    </label>
    <input type="submit" onclick="insertUser()" value="新增管理员">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
</body>
<script>
  let userId;
  window.onload = function getData(){
    getUserReviews();
  }
  // 使用Fetch API发送请求
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }

  // 获取评价信息列表
  function getUserReviews() {
    // 构造 POST 请求的选项对象
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getAll',
      }),
    };

    fetchData('UserServlet', postOptions)
            .then(data => renderReviewList(data));
  }
  // 渲染评价信息列表
  function renderReviewList(list) {
    console.log("渲染列表")
    console.log(list)
    const tableBody = document.getElementById('userTable').getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';

    list.forEach(review => {
      const row = tableBody.insertRow(-1);
      row.id = review.id
      row.insertCell(0).textContent = review.id
      row.insertCell(1).textContent = review.account
      row.insertCell(2).textContent = review.name
      row.insertCell(3).textContent = review.password
      row.insertCell(4).textContent = review.type;
      row.insertCell(5).innerHTML = "<button onclick=\"editUser('"+review.id+"')\">编辑</button>"+
              " <button onclick=\"deleteUser('"+review.id+"','"+review.name+"')\">删除</button>"
    });
  }
  function editUser(id) {
    userId=id
    const row=document.getElementById(id)
    document.getElementById('newUserName').value = row.cells[2].textContent
    document.getElementById('newPassword').value = row.cells[3].textContent
    document.getElementById('newType').value = row.cells[4].textContent
    document.getElementById('editDialog').showModal()
  }
  function saveEdit() {
    console.log(userId+"保存更改")
    const newName = document.getElementById('newUserName').value;
    const newPassword = document.getElementById('newPassword').value;
    const newType = document.getElementById('newType').value;
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'edit',
        id: userId,
        name: newName,
        password: newPassword,
        userType: newType,
      }),
    };
    fetchData('UserServlet', postOptions)
            .then(data => {
              renderReviewList(data)
              alert("编辑成功")
              document.getElementById('editDialog').close()
            });
  }
  function deleteUser(id,name) {
    console.log("删除:"+userId)
    userId=id;
    document.getElementById('deleteUserName').textContent = name;
    document.getElementById('deleteDialog').showModal();
  }
  function confirmDelete() {
    if(!confirm("确定删除吗")){
      return
    }
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'delete',
        id: userId,
      }),
    };
    fetchData('UserServlet', postOptions)
            .then(data => {
              renderReviewList(data)
              alert("删除成功")
              document.getElementById('deleteDialog').close()
            });
  }
  function insertUser() {
    const account = document.getElementById('userAccount').value
    const name = document.getElementById('userName').value;
    const password = document.getElementById('userPassword').value;
    const type = document.getElementById('userType').value;
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'insert',
        account: account,
        name: name,
        password: password,
        userType: type,
      }),
    };
    fetchData('UserServlet', postOptions)
            .then(data => {
              if(data.message){
                alert("账号重复!")
                return
              }
              renderReviewList(data)
              alert("添加成功")
              document.getElementById('newDialog').close()
            });
  }
</script>
</html>
