<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/assets/css/styles.css">
  <title>管理员信息</title>
</head>
<body>

<div class="container">
  <h1>管理员信息</h1>

  <form id="adminForm">
    <label for="adminId">管理员编号:</label>
    <input type="text" id="adminId" name="adminId" value="${admin.id}" readonly required >

    <label for="adminAccount">管理员账号:</label>
    <input type="text" id="adminAccount" name="adminAccount" value="${admin.account}" readonly required>

    <label for="adminName">管理员姓名:</label>
    <input type="text" id="adminName" name="adminName" value="${admin.name}" readonly required>

    <label for="adminPassword">登录密码:</label>
    <input type="text" id="adminPassword" name="adminPassword" value="${admin.password}" readonly required>

    <label>管理的食堂:</label>
    <h3>编号:${admin.canteenId}
      <c:forEach var="canteen" items="${canteenList}">
        <c:if test="${canteen.id==admin.canteenId}">
          名字:${canteen.name}
        </c:if>
      </c:forEach>
    </h3>
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
    }
    isEditing = !isEditing; // 切换编辑状态
    document.getElementById('adminName').readOnly = !isEditing
    document.getElementById('adminPassword').readOnly = !isEditing
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
        type: 'adminEdit',
        id: form.elements["adminId"].value,
        newName: form.elements["adminName"].value,
        newPassword: form.elements["adminPassword"].value,
      }),
    };
    fetch("AdminServlet", postOptions)
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
