<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>修改风控人员</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <link type="text/css" rel="stylesheet" href="css/common.css">
    <link type="text/css" rel="stylesheet" href="css/houtai.css">
    <link rel="Shortcut Icon" href="../images/zcb-icon.ico">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <div class="wrap">
    <div class="nav">
            <div class="logo">
                <a href=""></a>
            </div>
            
    </div>
    <div class="main main1" style="background:#32323a;position: relative;">
     <div class="index index1" >
       <h3>修改风控人员</h3>
       <div>
       <form action="<%=path%>/riskinfo/modify.action" method="post">
       <ul>
          <li><strong>I D：</strong><span style="font-size:16px;line-height: 32px;"><s:property value="riskinfo.id"/></span></li>
          <li><strong>登录名：</strong><s:textfield  name="riskinfo.login"></s:textfield></li>
          <li><strong>密码：</strong><s:textfield  name="riskinfo.password"></s:textfield></li>
          <li><strong>姓名：</strong><s:textfield  name="riskinfo.name"></s:textfield></li>
          <li><strong>电话：</strong><s:textfield  name="riskinfo.phone"></s:textfield></li>
         
            <li><strong>所属公司：</strong><input type="text" name="riskinfo.comname" value=" <s:property value="riskinfo.comname"/>" autocomplete="off"></span></li>
           <li><strong>类别：</strong>
                              <select name="riskinfo.bidper" id="">
                                <option value="<s:property value="riskinfo.bidper"/>">
                                
                                 <s:if test="riskinfo.bidper==1">
  										总公司（未更改）
  									</s:if><s:else>
  									    分公司（未更改）
  									</s:else>
                                </option>
                                <option value="1">总公司</option>
                                <option value="0">分公司</option>
                              </select>


             </li>
          <li><p style="margin-left:30px;"><input type="submit" name="submit" class="btn" value="确认" id="reg-btn"></p></li>
        </ul> 
         </form>

         </div>
        </div>
     </div>
   </div>
  </body>
</html>
