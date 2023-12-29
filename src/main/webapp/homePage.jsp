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
      <div id="notice" class="notice">

      </div>
    </article>

    <article>
      <h2>最新投票调查</h2>
      <!-- 添加最新投票调查的内容 -->
    </article>

    <article>
      <h2>最新食堂推荐菜品</h2>
      <!-- 添加最新食堂推荐菜品的内容 -->
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
    window.onload=getNotice
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

        const adminElement = document.createElement("h3");
        adminElement.textContent = "管理员:"+noticeData.admin.name+" 食堂:"+noticeData.admin.canteen.name;

        const titleElement = document.createElement("h2");
        titleElement.textContent = "标题："+noticeData.title;

        const timeElement = document.createElement("p");
        timeElement.textContent = "时间："+noticeData.time;

        const contentElement = document.createElement("p");
        contentElement.textContent = "内容："+noticeData.content;

        noticeElement.appendChild(adminElement)
        noticeElement.appendChild(titleElement);
        noticeElement.appendChild(timeElement);
        noticeElement.appendChild(contentElement);

        noticeContainer.appendChild(noticeElement);
      });
    }
  </script>
</html>
