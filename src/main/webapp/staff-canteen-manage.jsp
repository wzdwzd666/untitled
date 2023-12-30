<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/assets/css/styles.css">
  <title>食堂信息</title>
</head>
<body>

<div class="container">
  <h1>管理食堂信息</h1>

  <form id="canteenForm">
    <label for="canteenId">食堂编号:</label>
    <input type="text" id="canteenId" name="canteenId" value="${canteen.id}" readonly required >

    <label for="canteenName">食堂名称:</label>
    <input type="text" id="canteenName" name="canteenName" value="${canteen.name}" readonly required>

    <label for="startTime">营业开始时间:</label>
    <input type="time" id="startTime" name="startTime" value="${canteen.startTime}" readonly required>

    <label for="endTime">营业结束时间:</label>
    <input type="time" id="endTime" name="endTime" value="${canteen.endTime}" readonly required>

    <label for="canteenInfo">食堂简介:</label>
    <input id="canteenInfo" name="canteenInfo" value="${canteen.info}" readonly required>

    <button type="button" onclick="toggleEdit()">编辑</button>
    <button type="button" onclick="saveChanges()">保存</button>
  </form>
</div>
</body>
<script>
  let isEditing = false; // 初始状态为不可编辑
  window.onload = getCanteen
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }
  function getCanteen(){
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getCanteen',
      }),
    };

    fetchData('CanteenServlet', postOptions)
            .then(data => {
              // console.log(data)
              document.getElementById('canteenId').value = data.id
              document.getElementById('canteenName').value = data.name
              document.getElementById('startTime').value = data.startTime
              document.getElementById('endTime').value = data.endTime
              document.getElementById('canteenInfo').value = data.info
             });
  }
  function toggleEdit() {
    if(isEditing===false) {
      console.log("进入编辑")
    }
    const form = document.getElementById("canteenForm");
    const inputs = form.getElementsByTagName("input");

    isEditing = !isEditing; // 切换编辑状态

    for (let i = 1; i < inputs.length; i++) {
      inputs[i].readOnly = !isEditing;
    }
  }

  function saveChanges() {
    console.log("保存")
    if (!isEditing) {
      // 如果是不可编辑状态
      alert("请先点击编辑按钮进行修改！");
      return;
    }
    const form = document.getElementById('canteenForm')
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'staffEdit',
        canteenId: form.elements["canteenId"].value,
        canteenName: form.elements["canteenName"].value,
        canteenStartTime: form.elements["startTime"].value,
        canteenEndTime: form.elements["endTime"].value,
        canteenInfo: form.elements["canteenInfo"].value,
      }),
    };
    fetch("CanteenServlet", postOptions)
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
