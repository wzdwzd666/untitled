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
      <th>食堂ID</th>
      <th>菜系</th>
      <th>图片</th>
      <th>价格</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="food" items="${foodList}">
      <c:if test="${food.canteenId==admin.canteenId}">
        <tr id="${food.id}">
          <td >${food.id}</td>
          <td >${food.name}</td>
          <td >${food.canteenId}</td>
          <td >${food.cuisine}</td>
          <td ><img src='${food.image}' style='max-width: 100px;' alt="food image"></td>
          <td >${food.price}</td>
          <td>
            <button onclick="editFood('${food.id}')">编辑</button>
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
    <div><label for="price">新的价格:</label></div>
    <input type="text" id="price" name="price">
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
    <label for="foodImage">图片:</label>
    <input type="file" id="foodImage">
    <div><label for="foodPrice">价格:</label></div>
    <input type="text" id="foodPrice">
    <input type="submit" onclick="insertCanteen()" value="新增菜品">
    <input type="submit" onclick="document.getElementById('newDialog').close();" value="取消">
  </dialog>
</section>
<script>
  let foodId;
  function editFood(id) {
    console.log(id+"打开编辑弹窗")
    foodId=id
    const row=document.getElementById(id)
    document.getElementById('name').value = row.cells[1].textContent
    document.getElementById('cuisine').value = row.cells[3].textContent
    document.getElementById('price').value = row.cells[5].textContent
    document.getElementById('editDialog').showModal();
  }
  function saveEdit() {
    console.log("开始保存")
    const name = document.getElementById('name').value;
    const cuisine = document.getElementById('cuisine').value;
    const image = document.getElementById('image').files[0];
    const price = document.getElementById('price').value;
    if(image===undefined){
      console.log("未添加图片")
      const path=document.getElementById(foodId).cells[4].querySelector('img').src
      // 创建 URL 对象
      const imgUrl = new URL(path);
      // 获取相对路径
      const relativePath = imgUrl.pathname;
      console.log("相对路径:",relativePath)
      const options={
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'edit',
          id: foodId,
          name: name,
          cuisine: cuisine,
          image: relativePath,
          price: price,
        }),
      }
      fetch("FoodServlet",options)
              .then(()=>{
                console.log("保存成功")
                location.reload()
                document.getElementById('editDialog').close();
              })
              .catch(error=>{
                console.error("菜品保存出错",error)
              })
    }else {
      console.log("保存更改")
      const formData=new FormData()
      formData.append('type','image')
      formData.append('image',image)
      const postOptions = {
        method: 'POST',
        // headers: {
        //   'Content-Type': 'multipart/form-data',
        // },
        body: formData,
      };
      fetch("FileServlet", postOptions)
              .then(response => response.text())
              .then(imageUrl => {
                console.log("图片保存成功"+imageUrl)
                const options = {
                  method: 'POST',
                  headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: new URLSearchParams({
                    type: 'edit',
                    id: foodId,
                    name: name,
                    cuisine: cuisine,
                    image: imageUrl,
                    price: price,
                  }),
                }
                fetch("FoodServlet", options)
                        .then(() => {
                          console.log("菜品保存成功")
                          location.reload()
                          document.getElementById('editDialog').close();
                        })
                        .catch(error => {
                          console.error("菜品保存出错", error)
                        })
              })
              .catch(error => {
                console.error("图片保存出错:", error);
              });
    }
  }
  function deleteFood(id) {
    if(!confirm("确定删除吗")){
      return
    }
    const path=document.getElementById(id).cells[4].querySelector('img').src
    // 创建 URL 对象
    const imgUrl = new URL(path);
    // 获取相对路径
    const relativePath = imgUrl.pathname;
    const formData = new FormData()
    formData.append('type','delete')
    formData.append('path',relativePath)
    const fileOptions = {
      method: 'POST', // 设置请求方法为 POST
      body: formData
    };
    fetch("FileServlet",fileOptions)
            .then(() => {
              console.log("文件删除成功")
            })
            .catch(error => {
              console.error("文件删除出错:", error);
            });
    const foodOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'delete',
        id: id,
        path: relativePath,
      }),
    };
    fetch("FoodServlet",foodOptions)
            .then(() => {
              console.log("food删除成功")
              location.reload()
              alert("删除成功")
            })
            .catch(error => {
              console.error("food删除出错:", error);
            });
  }
  function insertCanteen() {
    const name = document.getElementById('foodName').value;
    const cuisine = document.getElementById('foodCuisine').value;
    const image = document.getElementById('foodImage').files[0];
    const price = document.getElementById('foodPrice').value;
    const formData=new FormData()
    formData.append('type','image')
    formData.append('image',image)
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      // headers: {
      //   'Content-Type': 'multipart/form-data',
      // },
      body: formData,
    };
    fetch("FileServlet",postOptions)
            .then(response => response.text())
            .then(imageUrl => {
              console.log("新增图片"+imageUrl)
              const options={
                method: 'POST',
                headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                  type: 'insert',
                  name: name,
                  cuisine: cuisine,
                  image: imageUrl,
                  price: price,
                }),
              }
              fetch("FoodServlet",options)
                      .then(()=>{
                        location.reload()
                        alert("添加成功")
                        document.getElementById('newDialog').close();
                      })
                      .catch(error=>{
                        console.error("新增出错",error)
                      })
            })
            .catch(error => {
              console.error("图片保存出错:", error)
            });
  }
</script>
</body>
</html>
