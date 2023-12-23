<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
  <title>食堂系统管理</title>
  <link rel="stylesheet" type="text/css" href="/assets/css/layui.css"/>
  <link rel="stylesheet" type="text/css" href="/assets/css/admin.css"/>
</head>
<body>
<div class="main-layout" id='main-layout'>
  <!--侧边栏-->
  <div class="main-layout-side">
    <div class="m-logo" style="color:white;line-height:60px;text-align:center; font-size:18px;">
      <span>食堂系统管理</span>
    </div>
    <ul class="layui-nav layui-nav-tree" lay-filter="leftNav">
      <li class="layui-nav-item">
        <a href="javascript:"  data-url="student-list.html" ><i class="iconfont">&#xe604;</i>食堂管理</a>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:" data-url="score-list.html"><i class="iconfont">&#xe60c;</i>账号管理</a>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:" data-url="score-account.html"><i class="iconfont">&#xe604;</i>评价信息管理</a>
      </li>
      <li class="layui-nav-item">
        <a href="javascript:"  data-id='6' data-url="loginOut" data-text="退出登录"><i class="iconfont">&#x1006;</i>交流社区管理</a>
      </li>
    </ul>
  </div>
  <!--右侧内容-->
  <div class="main-layout-container">
    <!--头部-->
    <div class="main-layout-header">
      <div class="menu-btn" id="hideBtn">
      </div>
      <ul class="layui-nav" lay-filter="rightNav">
        <li class="layui-nav-item" ><a href="javascript:" data-url="loginOut" style="color:black" >退出</a></li>
      </ul>
    </div>
    <!--主体内容-->
    <div class="main-layout-body">
      <!--tab 切换-->
      <div class="layui-tab layui-tab-brief main-layout-tab" lay-filter="tab" lay-allowClose="true">
        <ul class="layui-tab-title">
          <li class="layui-this welcome">操作面板</li>
        </ul>
        <div class="layui-tab-content">
          <div class="layui-tab-item layui-show" style="background: #f5f5f5;">
            <iframe src="student-list.html" id="iframInfo" width="100%" height="100%" name="iframe" scrolling="auto" class="iframe" framborder="0"></iframe>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!--遮罩-->
  <div class="main-mask">
  </div>
</div>
<script src="assets/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
  $(".layui-nav-item a").on('click',function(){
    var address=$(this).attr("data-url");
    if(undefined==address||"undefined"==address){
      alert("未配置地址");
    }else{
      if("loginOut"==address){
        loginOut();
      }else{
        $("#iframInfo").attr("src",address);
      }
    }
  })
  function loginOut(){
    $.ajax({
      //几个参数需要注意一下
      type: "POST",//方法类型
      dataType: "json",//预期服务器返回的数据类型
      url: "/user/loginOut",//url
      data: {},
      success: function (result) {
        if (result.code == "0") {
          location.href="/login.html";
        }else{
          alert(result.msg);
        }
      },
      error : function() {
        layer.msg('服务器错误', {
          icon: 5
        });
      }
    });
  }
</script>
<script src="assets/js/layui.js" type="text/javascript" charset="utf-8"></script>
<script src="assets/js/common.js" type="text/javascript" charset="utf-8"></script>
<script src="assets/js/main.js" type="text/javascript" charset="utf-8"></script>
</body>
</html>

