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
      <!-- 添加社区热门话题的内容 -->
    </article>

    <aside>
      <h2>提示</h2>
      <!-- 添加提示内容，例如最新评论点赞、未看社区信息提示、未看投诉回复提示 -->
    </aside>
  </section>
  </body>
  <script>
    window.onload = function() {
      getNotice();
      getRecommend();
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
  </script>
</html>
