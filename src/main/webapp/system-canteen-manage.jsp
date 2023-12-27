<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>系统食堂管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<header>
  <h2>食堂信息列表</h2>
</header>
<section>
  <input type="submit" value="添加新食堂" onclick="document.getElementById('newDialog').showModal();">
  <table id="canteenTable">
    <thead>
    <tr>
      <th>食堂编号</th>
      <th>食堂名称</th>
      <th>营业时间</th>
      <th>介绍</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <!-- 这里使用后端数据填充表格 -->
    <c:forEach var="canteen" items="${canteenList}">
      <tr id="${canteen.id}">
        <td >${canteen.id}</td>
        <td >${canteen.name}</td>
        <td >${canteen.startTime}-${canteen.endTime}</td>
        <td >${canteen.info}</td>
        <td>
          <button onclick="editCanteen('${canteen.id}','${canteen.name}', '${canteen.startTime}', '${canteen.endTime}', '${canteen.info}')">编辑</button>
          <button onclick="deleteCanteen('${canteen.id}','${canteen.name}')">删除</button>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <!-- 编辑弹窗 -->
  <dialog id="editDialog">
    <h2>编辑食堂信息</h2>
    <label for="newCanteenName">新的食堂名称:</label>
    <input type="text" id="newCanteenName" name="newCanteenName" required>
    <label for="newStartTime">新的开始营业时间:</label>
    <div><input type="time" id="newStartTime" name="newStartTime" min="6:00" max="11:00" required></div>
    <label for="newEndTime">新的结束营业时间:</label>
    <div><input type="time" id="newEndTime" name="newEndTime" min="15:00" max="23:30" required></div>
    <div><label for="newInfo">新的介绍</label></div>
    <input type="text" name="newInfo" id="newInfo" required>
    <input type="submit" onclick="saveEdit()" value="保存信息">
    <input type="submit" onclick="document.getElementById('editDialog').close();" value="取消">
  </dialog>

  <!-- 删除确认弹窗 -->
  <dialog id="deleteDialog">
    <h2>确认</h2>
    <p>确认删除食堂: <span id="deleteCanteenName"></span> 吗？</p>
    <button onclick="confirmCanteen()">确认删除</button>
    <button onclick="document.getElementById('deleteDialog').close();">取消</button>
  </dialog>

  <!-- 新增食堂弹窗 -->
  <dialog id="newDialog">
    <h2>新增食堂</h2>
    <label for="canteenName">食堂名称:</label>
    <input type="text" id="canteenName" name="canteenName" required>
    <label for="startTime">开始营业时间:</label>
    <input type="time" id="startTime" name="startTime" min="6:00" max="11:00" required>
    <label for="endTime">结束营业时间:</label>
    <input type="time" id="endTime" name="endTime" min="15:00" max="23:30" required>
    <div><label for="info">相关信息:</label></div>
    <input type="text" id="info" name="info" required>
    <input type="submit" onclick="insertCanteen()" value="新增食堂">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
<script>
  let canteenId;
  const xhr = new XMLHttpRequest();
  function editCanteen(id, name, startTime, endTime, info) {
    console.log(id+"打开编辑弹窗")
    canteenId=id;
    document.getElementById('newCanteenName').value = name;
    document.getElementById('newStartTime').value = startTime;
    document.getElementById('newEndTime').value = endTime;
    document.getElementById('newInfo').value = info;
    document.getElementById('editDialog').showModal();
  }
  function saveEdit() {
    const newName = document.getElementById('newCanteenName').value;
    const newStartTime = document.getElementById('newStartTime').value;
    const newEndTime = document.getElementById('newEndTime').value;
    const newInfo = document.getElementById('newInfo').value;
    xhr.open('POST', 'CanteenServlet',true)
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhr.send('type=edit&id='+canteenId+'&newName='+newName+'&newStartTime='+newStartTime+'&newEndTime='+newEndTime+'&newInfo='+newInfo)
    xhr.onreadystatechange = function () {
      if(xhr.readyState===4) {
        if(xhr.status===200) {
          //更新数据
          console.log(canteenId+"保存编辑数据")
          location.reload();
          alert('编辑成功');
        }
      }
    }
    document.getElementById('editDialog').close();
  }
  function deleteCanteen(id,name) {
    canteenId=id;
    document.getElementById('deleteCanteenName').textContent = name;
    document.getElementById('deleteDialog').showModal();
    console.log(canteenId+"打开删除弹窗")
  }
  function confirmCanteen() {
    if(!confirm("确定删除吗")){
      return
    }
    xhr.open('POST', 'CanteenServlet', true)
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhr.send('type=delete&id='+canteenId )
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          console.log(canteenId+"删除")
          //删除
          location.reload()
          alert('删除成功');
        }
      }
      document.getElementById('deleteDialog').close()
    }
  }
  function insertCanteen() {
    const newName = document.getElementById('canteenName').value;
    const newStartTime = document.getElementById('startTime').value;
    const newEndTime = document.getElementById('endTime').value;
    const newInfo = document.getElementById('info').value;
    xhr.open('POST', 'CanteenServlet', true)
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhr.send('type=insert&id=' + canteenId + '&newName=' + newName + '&newStartTime=' + newStartTime + '&newEndTime=' + newEndTime + '&newInfo=' + newInfo)
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          const result = xhr.responseText;
          if (result === "食堂名称已存在") {
            alert(result)
            return
          }
          console.log(result+"新增食堂");
          //更新数据
          location.reload();
          alert("添加成功")
        }
      }
    }
    document.getElementById('newDialog').close();
  }
</script>
</body>
</html>
