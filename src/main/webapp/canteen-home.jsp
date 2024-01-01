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

<!--    <article>-->
<!--      <h2>最新投票调查</h2>-->
<!--      &lt;!&ndash; 添加最新投票调查的内容 &ndash;&gt;-->
<!--    </article>-->
    <article>
      <h2>高评分食堂</h2>
      <div id="canteen" class="info">

      </div>
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

  </section>
  </body>
  <script>
    window.onload = function() {
      getNotice();
      getCanteen();
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
          contentElement.innerHTML = "<p>" + postData.content + "</p>" + "<img alt='图片' style='width: 200px;' class='post-image'  src=" + postData.image + ">"
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
    function getCanteen() {
      const postOptions = {
        method: 'POST', // 设置请求方法为 POST
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          type: 'getPopularCanteen',
        }),
      };
      fetchData('CanteenServlet', postOptions)
              .then(data => renderCanteen(data));
    }
    function renderCanteen(list) {
      console.log(list)
      const canteenContainer = document.getElementById('canteen');
      // 清空容器
      canteenContainer.innerHTML = "";

      list.forEach(data => {
        const canteenElement = document.createElement("div");
        canteenElement.classList.add("canteen");

        const titleElement = document.createElement("h2");
        titleElement.textContent = data.name;

        const timeElement = document.createElement("p");
        timeElement.textContent = "营业时间:"+data.startTime+"-"+data.endTime;

        const contentElement = document.createElement("p");
        contentElement.textContent = "介绍："+data.info;

        const ratingElement = document.createElement("p");
        if(data.avgRating=='暂无数据'){
          ratingElement.textContent = "综合评分：" + data.avgRating
        }else {
          ratingElement.textContent = "综合评分：" + data.avgRating
        }
        ratingElement.id=data.id

        const actionsElement = document.createElement("div");
        if(data.userRating==='还没评分'){
          actionsElement.innerHTML =
                  "<div style='margin-top: 10px'>未评分</div>" +
                  "<button class='view-button' onclick=\"window.location='canteen-food.jsp?canteenId="+data.id+"'\">菜品</button>"+
                  "<button class='view-button' style='margin-left: 10px' onclick=\"window.location='detail-canteen.jsp?canteenId="+data.id+"'\">查看</button>" +
                  "<button class='view-button' style='margin-left: 10px' onclick=\"setRating('" + data.id + "')\">评分</button>";
        }else {
          actionsElement.innerHTML =
                  "<div style='margin-top: 10px'>你的评分:"+data.userRating+"</div>" +
                  "<button class='view-button' onclick=\"window.location='canteen-food.jsp?canteenId="+data.id+"'\">菜品</button>"+
                  "<button class='view-button' style='margin-left: 10px' onclick=\"window.location='detail-canteen.jsp?canteenId="+data.id+"'\">查看</button>" +
                  "<button class='view-button' style='margin-left: 10px' onclick=\"setRating('" + data.id + "')\">修改评分</button>";
        }

        canteenElement.appendChild(titleElement);
        canteenElement.appendChild(timeElement);
        canteenElement.appendChild(contentElement);
        canteenElement.appendChild(ratingElement);
        canteenElement.appendChild(actionsElement);

        canteenContainer.appendChild(canteenElement);
      });
    }
    function setRating(canteenId) {
      const rating = prompt("输入评分");
      //转化数字
      const numericRating = parseFloat(rating);
      if (rating === null) {
        console.log("用户取消输入评分。");
      } else if (rating.trim() === "") {
        console.log("评分取消，没有输入内容。");
      } else {
        const content = prompt("输入评价内容")
        if (content === null) {
          console.log("用户取消输入评分。");
        } else if (content.trim() === "") {
          console.log("评分取消，没有输入内容。");
        } else {
          // 将输入的评分转换为数字
          const numericRating = parseFloat(rating);

          // 判断评分是否在0到10之间
          if (!isNaN(numericRating) && numericRating >= 0 && numericRating <= 10) {
            console.log("评分有效，可以继续处理。");
            const postOptions = {
              method: 'POST', // 设置请求方法为 POST
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: new URLSearchParams({
                type: 'setRating',
                canteenId: canteenId,
                content: content,
                rating: numericRating,
              }),
            };
            fetch('CanteenEvaluateServlet', postOptions)
                    .then(() => window.location.reload());
          } else {
            alert("评分无效，请输入0到10之间的数字。");
            // 在这里可以处理评分无效的情况
          }
        }
      }
    }
  </script>
</html>
