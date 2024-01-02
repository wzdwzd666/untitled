<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="assets/css/styles.css">
  <title>用户信息</title>
</head>
<body>

<div class="container">
  <h2>${user.type}:${user.name}</h2>

  <form id="adminForm">

    <label for="userAccount">用户账号:</label>
    <input type="text" id="userAccount" name="userAccount" value="${user.account}" readonly>

    <label for="userName">用户姓名:</label>
    <input type="text" id="userName" name="userName" value="${user.name}" readonly>

    <label for="userPassword">登录密码:</label>
    <input type="text" id="userPassword" name="userPassword" value="${user.password}" readonly>

    <label for="type">用户类型: ${user.type}</label>
    <select id="type" name="type" class="custom-select" disabled>
      <option value="${user.type}" selected>${user.type}</option>
      <c:if test="${user.type=='学生'}">
        <option value="老师">老师</option>
      </c:if>
      <c:if test="${user.type=='老师'}">
        <option value="学生">学生</option>
      </c:if>
    </select>

    <button type="button" onclick="toggleEdit()">编辑</button>
    <button type="button" onclick="saveChanges()">保存</button>
  </form>
</div>
</body>
<script>
  let isEditing = false; // 初始状态为不可编辑

  function toggleEdit() {
    if(isEditing===false) {
      console.log("进入编辑")
      document.getElementById('type').removeAttribute('disabled')
    }else {
      console.log("退出编辑")
      document.getElementById('type').setAttribute('disabled', 'disabled')
    }
    isEditing = !isEditing; // 切换编辑状态
    document.getElementById('userName').readOnly = !isEditing
    document.getElementById('userPassword').readOnly = !isEditing
  }

  function saveChanges() {
    console.log("保存")
    if (!isEditing) {
      // 如果是不可编辑状态
      alert("请先点击编辑按钮进行修改！");
      return;
    }
    const form = document.getElementById('adminForm')
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'edit',
        name: form.elements["userName"].value,
        password: form.elements["userPassword"].value,
        userType: form.elements["type"].value,
      }),
    };
    fetch("UserServlet", postOptions)
            .then(()=> {
              // 切换回不可编辑状态
              toggleEdit()
              console.log("编辑成功")
              alert("编辑成功")
            })
            .catch(error => {
              console.error("fetch 操作出现问题:", error);
            });
  }
</script>
</html>