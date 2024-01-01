<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
  <head>
    <title>首页</title>
    <link rel="stylesheet" href="assets/css/homePage.css">
  </head>
  <body>
  <section>
    <article>
      <h2>最新活动公告</h2>
      <div id="notice" class="info">

      </div>
    </article>

    <article>
      <h2>最新投票调查</h2>
      <!-- 添加最新投票调查的内容 -->
    </article>

    <article>
      <h2>最新食堂推荐菜品</h2>
      <div id="recommend" class="info">

      </div>
    </article>

    <article>
      <h2>社区热门话题</h2>
      <div id="posts" class="info">

      </div>
    </article>

    <aside>
      <h2>食堂信息</h2>
      <div id="canteen" class="info">

      </div>
    </aside>
  </section>
  </body>
  <script>
    window.onload = function() {
      getNotice();
      getRecommend();
      getTopic();
    };
    function fetchData(url, options) {
      return fetch(url, options)
              .then(response => response.json())
              .catch(error => console.error('Error:', error));
    }
    function getNotice() {
      const postOptions = {
        method: 'POST', // 设置请求方法为 POST
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'getList',
        }),
      };
      fetchData('NoticeServlet', postOptions)
              .then(data => renderNotice(data));
    }
    function renderNotice(list) {
      const noticeContainer = document.getElementById('notice');
      // 清空容器
      noticeContainer.innerHTML = "";

      list.forEach(noticeData => {
        const noticeElement = document.createElement("div");
        noticeElement.classList.add("notice");

        const titleElement = document.createElement("h2");
        titleElement.textContent = "标题："+noticeData.title;

        const adminElement = document.createElement("h3");
        adminElement.textContent = "管理员:"+noticeData.admin.name+" 食堂:"+noticeData.admin.canteen.name;

        const timeElement = document.createElement("p");
        timeElement.textContent = "时间："+noticeData.time;

        const contentElement = document.createElement("p");
        contentElement.textContent = "内容："+noticeData.content;

        noticeElement.appendChild(titleElement);
        noticeElement.appendChild(adminElement)
        noticeElement.appendChild(timeElement);
        noticeElement.appendChild(contentElement);

        noticeContainer.appendChild(noticeElement);
      });
    }
    function getRecommend(){
      const postOptions = {
        method: 'POST', // 设置请求方法为 POST
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'getRecommend',
        }),
      };
      fetchData('FoodServlet', postOptions)
              .then(data => renderRecommend(data));
    }
    function renderRecommend(list) {
      const recommendContainer = document.getElementById('recommend');
      // 清空容器
      recommendContainer.innerHTML = "";

      list.forEach(data => {
        const element = document.createElement("div");
        element.classList.add("recommend");

        const canteenElement = document.createElement("h2");
        canteenElement.textContent = "食堂："+data.canteen.name;

        const foodElement = document.createElement("h4");
        foodElement.textContent = "菜品:"+data.name+" 菜系:"+data.cuisine+" 价格:"+data.price;

        const timeElement = document.createElement("p");
        timeElement.textContent = "时间："+data.time;

        const imageElement = document.createElement("p");
        imageElement.innerHTML = "<img alt='图片' style='width: 300px;' src="+data.image+">";

        element.appendChild(canteenElement);
        element.appendChild(foodElement)
        element.appendChild(timeElement);
        element.appendChild(imageElement);

        recommendContainer.appendChild(element);
      });
    }
    function getTopic() {
      const postOptions = {
        method: 'POST', // 设置请求方法为 POST
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'getPopularTopic',
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
        if(postData.image === undefined){
          contentElement.innerHTML = "<p>" + postData.content + "</p>"
        }else{
          contentElement.innerHTML = "<p>" + postData.content + "</p>" + "<img alt='图片' style='width: 350px;' class='post-image'  src=" + postData.image + ">"
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
  </script>
</html>
