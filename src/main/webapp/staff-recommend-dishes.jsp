<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>推荐菜品</title>
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<h1>食堂推荐菜品</h1>
<section>
  <input type="submit" value="发布推荐菜品" onclick="document.getElementById('newDialog').showModal();">
  <table id="foodTable">
    <thead>
    <tr>
      <th>菜品编号</th>
      <th>菜品名称</th>
      <th>食堂ID</th>
      <th>菜系</th>
      <th>图片</th>
      <th>价格</th>
      <th>推荐</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="food" items="${foodList}">
      <c:if test="${food.canteenId == admin.canteenId && not empty food.recommend}">
        <tr id="${food.id}">
          <td >${food.id}</td>
          <td >${food.name}</td>
          <td >${food.canteenId}</td>
          <td >${food.cuisine}</td>
          <td ><img src='${food.image}' style='max-width: 100px;' alt="food image"></td>
          <td >${food.price}</td>
          <td >${food.recommend}</td>
          <td>
            <button onclick="deleteRecommend('${food.id}')">取消推荐</button>
          </td>
        </tr>
      </c:if>
    </c:forEach>
    </tbody>
  </table>

  <dialog id="newDialog">
    <h2>发布推荐菜品</h2>
    <label for="food">菜品:</label>
    <select id="food" name="food">
      <c:forEach var="food" items="${foodList}">
        <c:if test="${food.canteenId==admin.canteenId && empty food.recommend}">
          <option id="new${food.id}" value="${food.id}">ID:${food.id},名字:${food.name}</option>
        </c:if>
      </c:forEach>
    </select>
    <input type="submit" onclick="addRecommend()" value="发布">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
<script>
  function deleteRecommend(id) {
    if(!confirm("确定取消推荐吗")){
      return
    }
    const foodOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'deleteRecommend',
        id: id,
      }),
    };
    fetch("FoodServlet",foodOptions)
            .then(() => {
              console.log("推荐取消成功")
              location.reload()
              alert("推荐取消成功")
            })
            .catch(error => {
              console.error("推荐取消出错:", error);
            });
  }
  function addRecommend() {
    const id = document.getElementById('food').value;
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'addRecommend',
        id: id,
      }),
    };
    fetch("FoodServlet",postOptions)
            .then(() => {
              console.log("发布成功")
              location.reload()
              alert("发布成功")
            })
            .catch(error => {
              console.error("发布出错:", error)
            });
  }
</script>
</body>
</html>
