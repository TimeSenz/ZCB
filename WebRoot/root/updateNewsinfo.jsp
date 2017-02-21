<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 1.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
 <base href="<%=basePath%>">
    <link type="text/css" rel="stylesheet" href="css/common.css">
    <link type="text/css" rel="stylesheet" href="css/houtai.css">
     <link type="text/css" rel="stylesheet" href="css/hDate.css">
     <link rel="Shortcut Icon" href="../images/zcb-icon.ico">

  <script src="js/jquery-1.6.4.min.js"></script>
<script type="text/javascript" src="js/hDate.js"></script>
  <script type="text/javascript">
  $(function(){
$("#Text2").click(function (e) {
  var ths = this;
  calendar.show({
    id: this, ok: function () {
     
    }
  });
});

  })

</script>


<title>预览新闻</title>
</head>
<body onload="showTime()">
<div class="wrap">
    <div class="nav">
      <div class="logo">
        <a href=""></a>
      </div>
      <ul class="ul">
        <li class="cur"><a href="javaScript:;">预览新闻</a></li>
      </ul>
      <p class="p"><a href="/ZhongCaiBao/root/choiceLogin.jsp">退出</a></p>
    </div>
  <div class="main">
      <div class="aside">
          <div class="aside_top">
            <input type="text" placeholder="搜索">
            <dl>
              <dt></dt>
              <dd><p><s:property value="#session.cusinfo.name"/><span><a>欢迎您</a></span></p>
              <p><span>新消息(<i>0</i>)</span><span>日报(<i>0</i>)</span></p></dd>
            </dl>
          </div>
          <div class="aside_main">
             <ul>
        	  <li><strong class="icon11"><span><a href="/ZhongCaiBao/newsinfo/findAllByDong.action?currentPage=1">新闻动态</a></span></strong></li>
	          <li><strong class="icon11"><span><a href="/ZhongCaiBao/newsinfo/findAllByGong.action?currentPage=1">新闻公告</a></span></strong></li>
	          <li><strong class="icon11"><span><a href="/ZhongCaiBao/newsinfo/findAllByHuan.action?currentPage=1">还款公告</a></span></strong></li>
	          <li><strong class="icon11"><span><a href="/ZhongCaiBao/newsinfo/findAllByMei.action?currentPage=1">媒体报道</a></span></strong></li>
   	          <li><strong class="icon11"><span><a href="/ZhongCaiBao/root/showCoupon.jsp">优惠券</a></span></strong></li>
   	          <li><strong class="icon11"><span><a href="">短信模版</a></span></strong></li>
   	          <li><strong class="icon11"><span><a href="">发送短信</a></span></strong></li>
              
            </ul>
          </div>
      </div>
    <div class="article">
            <div class="article_top">
              <div id="time" class="p"></div>
              <ul>
                <li>您当前的位置:</li>
                <li><a href="">首页</a>></li>
                <li>更新新闻</li>
              </ul>
            </div>
            <div id="mod_table">
            <div class="mod_table">
                <div class="mod_title">
                  更新新闻
                </div>
                <div class="mod_table_main">

                    <s:form action="/newsinfo/modify.action" method="post">
               
                                           <input type="hidden" name="a" id="a" value="<s:property value="newsinfo.contents"/>" />
                                           <input type="hidden" id="contents" name="contents"  />
                                       <ul  class="mod_table_main_ul">
                                         <li><strong>I D：</strong><span style="font-size:16px;line-height: 32px;"><s:property value="newsinfo.id"/></span></li>
                                          <li><strong>标题：</strong><input type="text" name="newsinfo.title" value="<s:property value="newsinfo.title"/>"></li>
                                          
                                        <li><strong>时间：</strong><input type="text" name="newsinfo.time" id="Text2" value="<s:property value="newsinfo.time"/>"></li>
                                        <li><strong>备注：</strong><input type="text" name="newsinfo.remark" value="<s:property value="newsinfo.remark"/>"></li>
                                          <li><strong>类型：</strong><select name="newsinfo.type" id=""><option value="动">新闻动态</option><option value="公">新闻公告</option><option value="还">还款公告</option><option value="媒">媒体报道</option></select></li>

                                       <li><strong>录入人：</strong><s:property  value="newsinfo.cusinfo"/></span></li>
                                       <li><strong>内容：</strong>
                                          <script id="container" name="content" type="text/plain">
                                                
                                          </script>
                                          </li>
                                        <li><p style="margin-left:30px;"><input type="submit" name="submit" onclick="up()" class="btn" value="确认" id="reg-btn"></p></li>
                                      </ul> 
                                 </s:form>
                </div>  
     
            </div>
      </div>
</div>
</div>
</div>
<!-- 
 <h3>更新新闻</h3>
       <div>
             <s:form action="/newsinfo/modify.action">
             
             <input type="hidden" name="a" id="a" value="<s:property value="newsinfo.contents"/>" />
             <input type="hidden" id="contents" name="contents"  />
         <ul>
           <li><strong>I D：</strong><span style="font-size:16px;line-height: 32px;"><s:property value="newsinfo.id"/></span></li>
          <li><strong>标题：</strong><s:textfield  name="newsinfo.title"></s:textfield></li>
          <li><strong>内容：</strong>
          加载编辑器的容器
          <script id="container" name="content" type="text/plain">
                
          </script>
          </li>
          <li><strong>时间：</strong><s:textfield  name="newsinfo.time"></s:textfield></li>
          <li><strong>备注：</strong><s:textfield  name="newsinfo.remark"></s:textfield></li>
            <li><strong>类型：</strong><s:textfield  name="newsinfo.type"></s:textfield></li>
          **动：新闻动态
                   公：新闻公告
         <li><strong>录入人：</strong><s:property  value="newsinfo.cusinfo"/></span></li>
          <li><p style="margin-left:30px;"><input type="submit" name="submit" onclick="up()" class="btn" value="确认" id="reg-btn"></p></li>
        </ul> 
   </s:form> -->
  <!-- 配置文件 -->
    <script type="text/javascript"  src="${pageContext.request.contextPath}/ueditor-1.4.3/ueditor.config.js"></script>
<!--     编辑器源码文件 -->
    <script type="text/javascript" src="${pageContext.request.contextPath}/ueditor-1.4.3/ueditor.all.js"></script>     
    <!-- 实例化编辑器 -->
    <script type="text/javascript"> 
    	  var ue = UE.getEditor('container');
          //对编辑器的操作最好在编辑器ready之后再做
          ue.ready(function(){
        	  //设置编辑器的内容
        	  var a= document.getElementById("a").value;
        	    ue.setContent(a);
      })
      </script>
      <script type="text/javascript"> 
      var ue = UE.getEditor('container');
      function up(){
        	  var editor = new UE.Editor();
              editor.execCommand('blod');
              var uee = UE.getEditor('container');
              //对编辑器的操作最好在编辑器ready之后再做
              uee.ready(function(){
              //获取内容
              var txt = uee.getContent();
              document.getElementById("contents").value=txt;
          })
          }
     
    </script>
     <script src="js/houtai.js"></script>
</body>
</html>