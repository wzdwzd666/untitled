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
      <th>食堂</th>
      <th>菜系</th>
      <th>图片</th>
      <th>价格</th>
      <th>是否推荐</th>
      <th>推荐时间</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>

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
  window.onload = getFoodReviews;
  // 使用Fetch API发送请求
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }

  // 获取评价信息列表
  function getFoodReviews() {
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

    fetchData('FoodServlet', postOptions)
            .then(data => {
              renderReviewList(data)
            });
  }
  // 渲染评价信息列表
  function renderReviewList(list) {
    console.log("渲染列表")
    console.log(list)
    const tableBody = document.getElementById('foodTable').getElementsByTagName('tbody')[0];
    tableBody.innerHTML = '';

    list.forEach(review => {
      const row = tableBody.insertRow(-1);
      row.id = review.id
      row.insertCell(0).textContent = review.id
      row.insertCell(1).textContent = review.name
      row.insertCell(2).textContent = review.canteen.name
      row.insertCell(3).textContent = review.cuisine
      // 插入图片
      if(review.image == undefined){
        row.insertCell(4).textContent = "无"
      }else {
        console.log(review.image)
        row.insertCell(4).innerHTML = "<img src='" + review.image + "' alt='Review Image' style='max-width: 100px'>"
      }
      row.insertCell(5).textContent = review.price
      row.insertCell(6).textContent = review.recommend
      row.insertCell(7).textContent = review.time
      row.insertCell(8).innerHTML = "<button onclick=\"editFood('"+review.id+"')\">编辑</button>"+
              " <button onclick=\"deleteFood('"+review.id+"','"+review.name+"')\">删除</button>"+
              " <button onclick=\"recommend('"+review.id+"','"+review.name+"')\">推荐</button>"+
              " <button onclick=\"deleteRecommend('"+review.id+"', '"+review.name+"')\">取消推荐</button>"
    });
  }
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
    if(image == undefined){
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
              .then(response => response.json())
              .then(data=>{
                console.log("保存成功")
                renderReviewList(data)
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
                        .then(response => response.json())
                        .then(data=> {
                          console.log("菜品保存成功")
                          renderReviewList(data)
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
  function deleteFood(id,name) {
    if(!confirm("确定删除菜品:"+name+"吗")){
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
            .then(response => response.json())
            .then(data => {
              console.log("food删除成功")
              renderReviewList(data)
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
                      .then(response => response.json())
                      .then(data =>{
                        renderReviewList(data)
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
  function recommend(id, name){
    if(!confirm("确定推荐菜品:"+name+"吗")){
      return;
    }
    const options={
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'addRecommend',
        id: id,
      }),
    }
    fetch("FoodServlet",options)
            .then(response => response.json())
            .then(data =>{
              renderReviewList(data)
              alert("推荐成功")
              document.getElementById('newDialog').close();
            })
            .catch(error=>{
              alert("网络错误")
              console.error("推荐出错",error)
            })
  }
  function deleteRecommend(id, name){
    if(!confirm("确定取消推荐菜品:"+name+"吗")){
      return;
    }
    const options={
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'deleteRecommend',
        id: id,
      }),
    }
    fetch("FoodServlet",options)
            .then(response => response.json())
            .then(data =>{
              renderReviewList(data)
              alert("取消推荐成功")
              document.getElementById('newDialog').close();
            })
            .catch(error=>{
              alert("网络错误")
              console.error("推荐出错",error)
            })
  }
</script>
</body>
</html>
