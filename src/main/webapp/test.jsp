<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
  <head>
    <title>图片</title>
  </head>
  <body>
  <form action="FileServlet" method="post" enctype="multipart/form-data">
      <input type="file" name="file">
      <input type="submit" value="Upload">
  </form>
  <form action="FileServlet" method="get" enctype="multipart/form-data">
      <label>
          <input type="text" id="path" value="\assets\image\food\rey-star-wars-the-last-jedi-4k-er-1920x1080.jpg">
      </label>
      <input type="submit" value="Upload">
  </form>
  </body>
</html>
