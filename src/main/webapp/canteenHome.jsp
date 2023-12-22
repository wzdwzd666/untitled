<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>食堂交流社区</title>
  <link rel="stylesheet" type="text/css">
</head>
<body>
<header>
  <div class="logo">
    <h1>食堂交流社区</h1>
  </div>
  <nav>
    <ul>
      <li><a href="#">首页</a></li>
      <li><a href="#">关于我们</a></li>
      <li><a href="#">服务</a></li>
      <li><a href="#">我的信息</a></li>
    </ul>
  </nav>
</header>

<main>
  <section class="hero">
    <h2>欢迎来到食堂交流社区</h2>
    <p>发现美丽的世界，留下美好的记忆。</p>
    <a href="#" class="cta-button">了解更多</a>
  </section>

  <section class="features">
    <div class="feature">
      <img src="icon1.png" alt="Feature 1">
      <h3>特色服务1</h3>
      <p>描述特色服务1的信息。</p>
    </div>
    <div class="feature">
      <img src="icon2.png" alt="Feature 2">
      <h3>特色服务2</h3>
      <p>描述特色服务2的信息。</p>
    </div>
    <div class="feature">
      <img src="icon3.png" alt="Feature 3">
      <h3>特色服务3</h3>
      <p>描述特色服务3的信息。</p>
    </div>
  </section>

  <section class="testimonial">
    <h2>客户评价</h2>
    <div class="quote">
      <p>"美丽网站提供了出色的服务，让我留下深刻的印象。"</p>
      <cite>- 某位满意客户</cite>
    </div>
  </section>
</main>

<footer>
  <p>&copy; 2023 美丽网站</p>
</footer>

</body>
<style>
  /* 样式表，用于定义页面的样式 */
  body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f5f5f5;
    color: #333;
  }

  header {
    background-color: #fff;
    padding: 20px;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    position: fixed;
    width: 100%;
    z-index: 1000;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logo h1 {
    margin: 0;
    font-size: 24px;
    color: #333;
  }

  nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
  }

  nav ul li {
    margin-right: 20px;
  }

  nav ul li a {
    text-decoration: none;
    color: #333;
    font-weight: bold;
  }

  main {
    padding-top: 80px;
  }

  .hero {
    text-align: center;
    padding: 100px 20px;
    background-color: #ffcccb;
  }

  .hero h2 {
    margin-bottom: 20px;
    font-size: 36px;
    color: #333;
  }

  .hero p {
    font-size: 18px;
    color: #666;
  }

  .cta-button {
    display: inline-block;
    padding: 10px 20px;
    margin-top: 20px;
    background-color: #ff6666;
    color: #fff;
    text-decoration: none;
    font-weight: bold;
    border-radius: 5px;
  }

  .features {
    display: flex;
    justify-content: space-around;
    align-items: flex-start;
    flex-wrap: wrap;
    padding: 50px;
    background-color: #fff;
  }

  .feature {
    text-align: center;
    max-width: 300px;
    margin-bottom: 30px;
  }

  .feature img {
    width: 80px;
    height: 80px;
    margin-bottom: 20px;
  }

  .testimonial {
    text-align: center;
    padding: 100px 20px;
    background-color: #ffcccb;
  }

  .quote {
    max-width: 600px;
    margin: 0 auto;
  }

  footer {
    background-color: #333;
    color: #fff;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    width: 100%;
  }

</style>
</html>
