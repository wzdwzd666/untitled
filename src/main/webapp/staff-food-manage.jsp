<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>菜品管理</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
  <h1>食堂菜品列表</h1>
<section>
  <input type="submit" value="添加新菜品" onclick="document.getElementById('newDialog').showModal();">
  <table id="foodTable">
    <thead>
    <tr>
      <th>菜品编号</th>
      <th>菜品名称</th>
      <th>菜系</th>
      <th>图片</th>
      <th>价格</th>
    </tr>
    </thead>
    <tbody>
    <!-- 这里使用后端数据填充表格 -->
    <c:forEach var="food" items="${foodList}">
      <c:if test="food.canteenId==admin.canteenId">
        <tr id="${food.id}">
          <td >${food.id}</td>
          <td >${food.name}</td>
          <td ><img src="${food.image}" style='max-width: 100px; max-height: 100px;' alt="food image"></td>
          <td >${food.price}</td>
          <td>
            <button onclick="editFood('${food.id}','${admin.canteenId}')">编辑</button>
            <button onclick="deleteFood('${food.id}')">删除</button>
          </td>
        </tr>
      </c:if>
    </c:forEach>
    </tbody>
  </table>

  <!-- 编辑弹窗 -->
  <dialog id="editDialog">
    <h2>编辑菜品信息</h2>
    <label for="name">新的菜品名称:</label>
    <input type="text" id="name" name="name" required>
    <label for="cuisine">新的菜系:</label>
    <select id="cuisine" name="cuisine">
      <c:forEach var="cuisine" items="${cuisineList}">
        <option id="${cuisine}" name="${cuisine}">${cuisine}</option>
      </c:forEach>
    </select>
    <label for="image">新的图片:</label>
    <input type="file" id="image" name="image">
    <label for="price">新的价格:</label>
    <input type="number" id="price" name="price">
    <input type="submit" onclick="saveEdit()" value="保存信息">
    <input type="submit" onclick="document.getElementById('editDialog').close();" value="取消">
  </dialog>

  <!-- 新增食堂弹窗 -->
  <dialog id="newDialog">
    <h2>新增菜品</h2>
    <label for="foodName">菜品名称:</label>
    <input type="text" id="foodName" name="foodName" required>
    <label for="foodCuisine">菜系:</label>
    <select id="foodCuisine" name="cuisine">
      <c:forEach var="cuisine" items="${cuisineList}">
        <option id="food${cuisine}">${cuisine}</option>
      </c:forEach>
    </select>
    <label for="foodImage">新的图片:</label>
    <input type="file" id="foodImage">
    <label for="foodPrice">新的价格:</label>
    <input type="number" id="foodPrice">
    <input type="submit" onclick="insertCanteen()" value="新增食堂">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
<script>
  let foodId;
  let canteenId;
  function editFood(id,id1) {
    console.log(id+"打开编辑弹窗")
    foodId=id
    canteenId=id1
    const row = document.getElementById(id)
    console.log(row
            .elements[3].src)
    document.getElementById('name').value = row.elements[1].value
    document.getElementById('cuisine').value = row.elements[2].value
    document.getElementById('image').src = row.elements[3].src
    document.getElementById('price').value = row.elements[4].value
    document.getElementById('editDialog').showModal();
  }
  function saveEdit() {
    const name = document.getElementById('name').value;
    const cuisine = document.getElementById('cuisine').value;
    const image = document.getElementById('image').src;
    const price = document.getElementById('price').value;
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'edit',
        id: foodId,
        canteenId: canteenId,
        name: name,
        cuisine: cuisine,
        image: image,
        price: price,
      }),
    };
    fetch("FoodServlet",postOptions)
            .then(() => {
              location.reload()
              alert("编辑成功")
              document.getElementById('editDialog').close();
            })
            .catch(error => {
              console.error("编辑出错:", error);
            });
  }
  function deleteFood(id) {
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
        id:id,
      }),
    };
    fetch("FoodServlet",postOptions)
            .then(() => {
              location.reload()
              alert("删除成功")
              document.getElementById('deleteDialog').close()
            })
            .catch(error => {
              console.error("删除出错:", error);
            });
  }
  function insertCanteen() {
    const name = document.getElementById('foodName').value;
    const cuisine = document.getElementById('foodCuisine').value;
    const image = document.getElementById('foodImage').src;
    const price = document.getElementById('foodPrice').value;
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'insert',
        name: name,
        cuisine: cuisine,
        image: image,
        price: price,
      }),
    };
    fetch("FoodServlet",postOptions)
            .then(() => {
              location.reload()
              alert("添加成功")
              document.getElementById('newDialog').close()
            })
            .catch(error => {
              console.error("添加出错:", error)
            });
  }
</script>
</body>
</html>
