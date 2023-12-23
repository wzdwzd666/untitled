<!--<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>-->
<!--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>-->
<!--<html lang="en">-->
<!--<head>-->
<!--  <meta charset="UTF-8">-->
<!--  <meta name="renderer" content="webkit">-->
<!--  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->
<!--  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />-->
<!--  <title>学生成绩管理系统</title>-->
<!--  <link rel="stylesheet" type="text/css" href="assets/admin/layui/css/layui.css"/>-->
<!--  <link rel="stylesheet" type="text/css" href="assets/admin/css/admin.css"/>-->
<!--</head>-->
<!--<body>-->
<!--<div class="main-layout" id='main-layout'>-->
<!--  &lt;!&ndash;侧边栏&ndash;&gt;-->
<!--  <div class="main-layout-side">-->
<!--    <div class="m-logo" style="color:white;line-height:60px;text-align:center; font-size:18px;">-->
<!--      <span>学生成绩管理系统</span>-->
<!--    </div>-->
<!--    <ul class="layui-nav layui-nav-tree" lay-filter="leftNav">-->
<!--      <li class="layui-nav-item">-->
<!--        <a href="javascript:;"  data-url="student-list.html" ><i class="iconfont">&#xe604;</i>学生管理</a>-->
<!--      </li>-->
<!--      <li class="layui-nav-item">-->
<!--        <a href="javascript:;" data-url="score-list.html"><i class="iconfont">&#xe60c;</i>成绩管理</a>-->
<!--      </li>-->
<!--      <li class="layui-nav-item">-->
<!--        <a href="javascript:;" data-url="score-account.html"><i class="iconfont">&#xe604;</i>学生总成绩</a>-->
<!--      </li>-->
<!--      <li class="layui-nav-item">-->
<!--        <a href="javascript:;"  data-id='6' data-url="loginOut" data-text="退出登录"><i class="iconfont">&#x1006;</i>退出登录</a>-->
<!--      </li>-->
<!--    </ul>-->
<!--  </div>-->
<!--  &lt;!&ndash;右侧内容&ndash;&gt;-->
<!--  <div class="main-layout-container">-->
<!--    &lt;!&ndash;头部&ndash;&gt;-->
<!--    <div class="main-layout-header">-->
<!--      <div class="menu-btn" id="hideBtn">-->
<!--        &lt;!&ndash; <a href="javascript:;">-->
<!--            <span class="iconfont">&#xe60e;</span>-->
<!--        </a> &ndash;&gt;-->
<!--      </div>-->
<!--      <ul class="layui-nav" lay-filter="rightNav">-->
<!--        &lt;!&ndash; 					  <li class="layui-nav-item"><a href="javascript:;"  data-id='4' data-text="邮件系统"><i class="iconfont">&#xe603;</i></a></li>-->
<!--                              <li class="layui-nav-item">-->
<!--                                <a href="javascript:;" data-url="admin-info.html" style="color:black" data-id='5' data-text="个人信息">个人信息</a>-->
<!--                              </li>-->
<!--                               &ndash;&gt;-->
<!--        <li class="layui-nav-item" ><a href="javascript:;" data-url="loginOut" style="color:black" >退出</a></li>-->
<!--      </ul>-->
<!--    </div>-->
<!--    &lt;!&ndash;主体内容&ndash;&gt;-->
<!--    <div class="main-layout-body">-->
<!--      &lt;!&ndash;tab 切换&ndash;&gt;-->
<!--      <div class="layui-tab layui-tab-brief main-layout-tab" lay-filter="tab" lay-allowClose="true">-->
<!--        <ul class="layui-tab-title">-->
<!--          <li class="layui-this welcome">操作面板</li>-->
<!--        </ul>-->
<!--        <div class="layui-tab-content">-->
<!--          <div class="layui-tab-item layui-show" style="background: #f5f5f5;">-->
<!--            &lt;!&ndash;1&ndash;&gt;-->
<!--            <iframe src="student-list.html" id="iframInfo" width="100%" height="100%" name="iframe" scrolling="auto" class="iframe" framborder="0"></iframe>-->
<!--            &lt;!&ndash;1end&ndash;&gt;-->
<!--          </div>-->
<!--        </div>-->
<!--      </div>-->
<!--    </div>-->
<!--  </div>-->
<!--  &lt;!&ndash;遮罩&ndash;&gt;-->
<!--  <div class="main-mask">-->

<!--  </div>-->
<!--</div>-->
<!--<script src="assets/js/jquery-3.3.1.min.js"></script>-->
<!--<script type="text/javascript">-->
<!--  $(".layui-nav-item a").on('click',function(){-->
<!--    var address=$(this).attr("data-url");-->
<!--    if(undefined==address||"undefined"==address){-->
<!--      alert("未配置地址");-->
<!--    }else{-->
<!--      if("loginOut"==address){-->
<!--        loginOut();-->
<!--      }else{-->
<!--        $("#iframInfo").attr("src",address);-->
<!--      }-->
<!--    }-->
<!--  })-->
<!--  /* 	$("#loginOut").on('click',loginOut); */-->
<!--  function loginOut(){-->
<!--    $.ajax({-->
<!--      //几个参数需要注意一下-->
<!--      type: "POST",//方法类型-->
<!--      dataType: "json",//预期服务器返回的数据类型-->
<!--      url: "/user/loginOut",//url-->
<!--      data: {},-->
<!--      success: function (result) {-->
<!--        if (result.code == "0") {-->
<!--          location.href="/login.html";-->
<!--        }else{-->
<!--          alert(result.msg);-->
<!--        }-->
<!--      },-->
<!--      error : function() {-->
<!--        layer.msg('服务器错误', {-->
<!--          icon: 5-->
<!--        });-->
<!--      }-->
<!--    });-->
<!--  }-->
<!--</script>-->
<!--<script src="assets/admin/layui/layui.js" type="text/javascript" charset="utf-8"></script>-->
<!--<script src="assets/admin/js/common.js" type="text/javascript" charset="utf-8"></script>-->
<!--<script src="assets/admin/js/main.js" type="text/javascript" charset="utf-8"></script>-->

<!--</body>-->
<!--</html>-->

