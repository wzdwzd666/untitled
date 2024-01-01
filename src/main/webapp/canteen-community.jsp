<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>交流社区</title>
  <style>
    body {
      background-color: #f4f4f4;
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    header {
      background-color: #333;
      color: white;
      padding: 10px;
      text-align: center;
      height: 130px;
    }

    .search-bar {
      margin-top: 10px;
    }

    input[type="text"] {
      padding: 5px;
    }

    button {
      padding: 5px;
      cursor: pointer;
    }

    #posts {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-around;
      margin: 20px;
    }
    #username{
      cursor: pointer;
    }
    .post {
      border: 1px solid #888;
      padding: 10px;
      margin: 10px;
      width: 500px;
      min-height: 300px;
      background: #fff;
      position: relative;
    }
    .post-content{
      background: #f4f4f4;
      margin: 20px;
      min-height: 300px;
    }
    .post-image {
      display: block;
      margin: 0 auto;
    }

    .post-actions {
      display: flex;
      justify-content: space-between;
      position: relative;
      margin: 10px 35px;
    }

    .timestamp {
      color: #888;
    }
    section {
      margin: 15px;
    }
    button.search-button {
      background-color: #4CAF50; /* Green background */
      color: white;
      border: none;
      padding: 8px 16px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      margin-left: 5px;
      cursor: pointer;
    }

    /* Style for the View Details button */
    button.view-button {
      background-color: #008CBA; /* Blue background */
      color: white;
      border: none;
      padding: 8px 16px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 14px;
      cursor: pointer;
    }
    .close {
      background-color: #f44336; /* Red background */
      color: white;
      float: right;
      font-size: 28px;
      font-weight: bold;
      cursor: pointer;
    }

    .close:hover {
      background-color: #d32f2f; /* Darker red background on hover */
      color: white;
    }
    input[type="text"] {
      /*width: 60%;*/
      padding: 8px;
      margin: 5px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
    }
    dialog{
      width: 400px;
      padding: 20px;
    }
  </style>
</head>
<body>
<header>
  <h1>交流社区</h1>
  <div class="search-bar">
<!--    <button class="search-button" onclick="history.back()">返回</button>-->
    <input type="text" id="searchContent" name="searchContent" placeholder="Search...">
    <button class="search-button" onclick="searchTopic()" >搜索</button>
<!--    <button class="search-button" onclick="">热度排序</button>-->
<!--    <button class="search-button" onclick="">时间排序</button>-->
    <button class="search-button" onclick="document.getElementById('postDialog').showModal();">发表帖子</button>
    </div>
  </div>
</header>

<section id="posts">

</section>

<dialog id="postDialog">
  <h2>发表帖子</h2>
  <label for="content">内容:</label>
  <input type="text" id="content" name="content" style="width: 100%" required>
  <div style="margin-top: 15px">
    <label for="image">图片:</label>
    <input type="file" id="image">
  </div>
  <div style="margin-top: 20px">
    <button class="search-button" onclick="addTopic()">发表</button>
    <button class="search-button" onclick="document.getElementById('postDialog').close();">取消</button>
  </div>
</dialog>
</body>
<script>
  window.onload = function() {
    getTopic();
    // getRecommend();
  };
  function searchTopic() {
    const searchContent = document.getElementById("searchContent").value;
    // 构造 POST 请求的选项对象
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'searchTopic',
        searchContent: searchContent,
      }),
    };
    fetchData('TopicServlet', postOptions)
            .then(data => renderTopic(data))
            .catch(error => {
              console.error("搜索话题出错:", error);
            });
  }
  function fetchData(url, options) {
    return fetch(url, options)
            .then(response => response.json())
            .catch(error => console.error('Error:', error));
  }
  function getTopic() {
    console.log("获取帖子")
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'getAll',
      }),
    };
    fetchData('TopicServlet', postOptions)
            .then(data => renderTopic(data));
  }
  function renderTopic(list) {
    console.log("渲染", list)
    const postsContainer = document.getElementById('posts');
    // 清空容器
    postsContainer.innerHTML = "";

    list.forEach(postData => {
      const postElement = document.createElement("div");
      postElement.classList.add("post");
      postElement.id=postData.id

      const userElement = document.createElement("div");
      userElement.classList.add("user-info");
      userElement.innerHTML = "<h2><span class='user' id='username'>"+postData.user.name+"</span></h2>"+
              "<span class='timestamp'>"+postData.time+"</span>";
      userElement.id = postData.user.id
      postElement.appendChild(userElement);
      const commenterElement = userElement.querySelector("#username");
      commenterElement.addEventListener('click', function () {
        window.location = 'detail-user.jsp?userId='+postData.user.id;
      });

      const contentElement = document.createElement("div");
      contentElement.classList.add("post-content");
      if(postData.image===undefined){
        contentElement.innerHTML = "<p>" + postData.content + "</p>"
      }else {
        contentElement.innerHTML = "<p>" + postData.content + "</p>" + "<img alt='图片' style='width: 350px;' class='post-image'  src=" + postData.image + ">";
      }
      postElement.appendChild(contentElement);

      const actionsElement = document.createElement("div");
      actionsElement.classList.add("post-actions");
      actionsElement.innerHTML =
              " <button class='view-button' onclick=\"showDetail('" + postData.id + "')\">查看</button>" +
              "<button class='view-button' onclick=\"addLike('" + postData.id + "')\" id='like-button-" + postData.id + "'>点赞" + postData.like + "</button>" +
              "<button class='view-button' onclick=\"cancelLike('" + postData.id + "')\">取消点赞</button>";
      postElement.appendChild(actionsElement);

      postsContainer.appendChild(postElement);
    });
  }
  function showDetail(id){
    window.location='detail-topic.jsp?topicId='+id
  }
  function addLike(id) {
    console.log("点赞")
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'addLike',
        id: id,
      }),
    };
    fetchData('TopicServlet', postOptions)
            .then(data => {
              console.log(data.message)
              if (data.message=='点赞过了') {
                alert(data.message)
              } else {
                document.getElementById('like-button-' + id).innerText = "点赞" + data.message;
                alert("点赞成功")
              }
            });
  }
  function cancelLike(id) {
    console.log("取消点赞")
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: new URLSearchParams({
        type: 'cancelLike',
        id: id,
      }),
    };
    fetchData('TopicServlet', postOptions)
            .then(data => {
              console.log(data)
              if(data.message=='还没点赞'){
                  console.log("取消")
                  alert(data.message)
              }else {
                console.log("成功")
                document.getElementById('like-button-' + id).innerText = "点赞" + data.message;
                alert("取消点赞成功")
              }
            });
  }
  function addTopic() {
    const content = document.getElementById('content').value;
    const image = document.getElementById('image').files[0];
    const formData=new FormData()
    formData.append('type','topic')
    formData.append('image',image)
    const postOptions = {
      method: 'POST', // 设置请求方法为 POST
      body: formData,
    };
    fetch("FileServlet",postOptions)
            .then(response => response.text())
            .then(imageUrl => {
              console.log("帖子图片"+imageUrl)
              const options={
                method: 'POST',
                headers: {
                  'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: new URLSearchParams({
                  type: 'addTopic',
                  content: content,
                  image: imageUrl,
                }),
              }
              fetch("TopicServlet",options)
                      .then(response => response.json())
                      .then(data =>{
                        renderTopic(data)
                        alert("发表成功")
                        document.getElementById('postDialog').close();
                      })
                      .catch(error=>{
                        console.error("发表出错",error)
                      })
            })
            .catch(error => {
              console.error("图片保存出错:", error)
            });
  }
</script>
</html>
