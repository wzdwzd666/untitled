<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
  <head>
    <title>错误信息</title>
  </head>
  <body>
  <c:if test="${param.type=='username'}">
    <h1>用户名不存在</h1>
  </c:if>
  <c:if test="${param.type=='password'}">
    <h1>密码错误</h1>
  </c:if>
  <c:if test="${param.type=='3'}">
    <h1>用户名已经被注册</h1>
  </c:if>
  <input type="submit" value="返回" onclick="history.back();">
  </body>
</html>
