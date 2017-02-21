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


<title>更新短信模板</title>
</head>
<body onload="showTime()">
<div class="wrap">
    <div class="nav">
      <div class="logo">
        <a href=""></a>
      </div>
      <ul class="ul">
        <li class="cur"><a href="javaScript:;">更新短信模板</a></li>
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
   	           <li  class="cur"><strong class="icon11"><span><a href="/ZhongCaiBao/sms/findAll.action?currentPage=1">短信模版</a></span></strong></li>
          <li><strong class="icon11"><span><a href="/ZhongCaiBao/userinfo/findAll.action?currentPage=1">发送短信</a></span></strong></li>
   	      <ol class="ol2" style="display:none">
                <li><span><a href="/ZhongCaiBao/userinfo/findAll.action?currentPage=1">所有用户</a></span></li>
                <li><span><a href="/ZhongCaiBao/lcract/findAllLCR.action?currentPage=1">理财人</a></span></li>
                <li ><span><a href="/ZhongCaiBao/jkract/findAllJKR.action?currentPage=1">借款人</a></span></li>
              </ol>
              
            </ul>
          </div>
      </div>
    <div class="article">
            <div class="article_top">
              <div id="time" class="p"></div>
              <ul>
                <li>您当前的位置:</li>
                <li><a href="">首页</a>></li>
                <li>更新短信模板</li>
              </ul>
            </div>
            <div id="mod_table">
            <div class="mod_table">
                <div class="mod_title">
               更新短信模板
                </div>
                <div class="mod_table_main">

                    <s:form action="/sms/modifySms.action" method="post">
                                       <ul  class="mod_table_main_ul">
                                          <li><strong>I D：</strong><span style="font-size:16px;line-height: 32px;"><s:property value="sms.id"/></span></li>
                                           <li><strong>Cid：</strong><input type="text" name="sms.cid" value="<s:property value="sms.cid"/>"></li>
                                          <li><strong>标题：</strong><input type="text" name="sms.remark" value="<s:property value="sms.remark"/>"></li>
                                          <li><strong>内容：</strong><input type="text" name="sms.contents" value="<s:property value="sms.contents"/>"></li>
                                          <li><strong>录入人：</strong><s:property  value="sms.cusinfo"/></span></li>
                                        <li><p style="margin-left:30px;"><input type="submit" name="submit" onclick="up()" class="btn" value="确认" id="reg-btn"></p></li>
                                      </ul> 
                                 </s:form>
                </div>  
     
            </div>
      </div>
</div>
     <script src="js/houtai.js"></script>
</body>
</html>