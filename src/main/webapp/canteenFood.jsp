<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂菜品</title>
  <link rel="stylesheet" type="text/css" href="assets/css/home.css">
  <link rel="stylesheet" type="text/css" href="assets/css/manage.css">
</head>
<body>
<div class="hero">
  <h1>食堂菜品列表</h1>
  <input type="submit" value="返回" onclick="history.back()">
  <table id="foodTable">
    <thead>
    <tr>
      <th>菜品编号</th>
      <th>菜品名称</th>
      <th>食堂ID</th>
      <th>菜系</th>
      <th>图片</th>
      <th>价格</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="food" items="${foodList}">
      <c:if test="${food.canteenId==param.canteenId}">
        <tr id="${food.id}">
          <td >${food.id}</td>
          <td >${food.name}</td>
          <td >${food.canteenId}</td>
          <td >${food.cuisine}</td>
          <td ><img src='${food.image}' style='max-width: 100px;' alt="food image"></td>
          <td >${food.price}</td>
        </tr>
      </c:if>
    </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>
