<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<header>
  <h2>食堂信息列表</h2>
</header>
<section>
  <table id="canteenTable">
    <thead>
    <tr>
      <th>食堂编号</th>
      <th>食堂名称</th>
      <th>营业时间</th>
      <th>介绍</th>
      <th>Action</th>
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
  <input type="submit" value="添加新食堂" onclick="newCanteen()">

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
    <input type="submit" onclick="insertCanteen()" value="新增">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
<script>
  let canteenId;
  let canteenName;
  const xhr = new XMLHttpRequest();
  function editCanteen(id, name, startTime, endTime, info) {
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
          const row=document.getElementById(canteenId)
          row.cells[1].innerHTML = newName
          row.cells[2].innerHTML = newStartTime+"-"+newEndTime
          row.cells[3].innerHTML = newInfo
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
  }
  function confirmCanteen() {
    alert("确定删除吗")
    xhr.open('POST', 'CanteenServlet', true)
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhr.send('type=delete & id=' + canteenId )
    xhr.onreadystatechange = function () {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
          //删除
          const deleteRow=document.getElementById(canteenId)
          deleteRow.remove()
          alert('删除成功');
        }
      }
      document.getElementById('deleteDialog').close()
    }
  }
  function newCanteen(id){
    canteenId=id;
    document.getElementById('newDialog').showModal();
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
          const newId = xhr.responseText;
          console.log(newId);
          //更新数据
          const newRow = document.getElementById('canteenTable').insertRow(-1);
          newRow.id = newId;
          newRow.insertCell(0).innerHTML = newId;
          newRow.insertCell(1).innerHTML = newName;
          newRow.insertCell(2).innerHTML = newStartTime+'-'+newEndTime;
          newRow.insertCell(3).innerHTML = newInfo;
          newRow.insertCell(4).innerHTML = "<button onclick=\"editCanteen("+newId+","+newName+","+newStartTime+","+newEndTime+","+newInfo+"')\">编辑</button>\n" +
                  "<button onclick=\"deleteCanteen("+newId+","+newName+")\">删除</button>";
          alert('添加成功');
        }
      }
      document.getElementById('newDialog').close();
    }
  }
</script>
</body>
</html>
