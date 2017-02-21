<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Integer totalPage=(Integer)request.getAttribute("totalPage");
Integer areaPage=(Integer)request.getAttribute("areaPage");
System.out.println("gdsfherktgfuierghjdfdgrthb"+areaPage);
Integer currentPage=(Integer)request.getAttribute("currentPage");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
    <base href="<%=basePath%>">
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>root放款批准 借款人 放款</title>
  <link type="text/css" rel="stylesheet" href="css/common.css">
  <link type="text/css" rel="stylesheet" href="css/houtai.css">
  <link rel="Shortcut Icon" href="../images/zcb-icon.ico">
  <script src="js/jquery-1.6.4.min.js"></script>
  <script>
  $(function(){
      $(".nav .ul li").click(function(){
        $(this).addClass('cur').siblings().removeClass('cur');
      })
  })
  </script>
</head>
<body onload="showTime()">
<div class="wrap">
  <div class="nav">
      <div class="logo">
        <a href=""></a>
      </div>
      <ul class="ul">
        <li><a href="/ZhongCaiBao/rootact/records.action">资金流水</a></li>
        <li class="cur"><a href="/ZhongCaiBao/rootact/rootAct.action?currentPage=1">放款批准</a></li>
        <li><a href="/ZhongCaiBao/finance/findAll.action">用户管理</a></li>
      </ul>
      <p class="p"><a href="/ZhongCaiBao/root/choiceLogin.jsp">退出</a></p>
  </div>
  <div class="main">
    <div class="aside">
      <div class="aside_top">
        <input type="text" placeholder="搜索">
        <dl>
          <dt></dt>
          <dd><p><s:property value="#session.rootinfo.name"/><span><a>欢迎您</a></span></p>
          <p><span>新消息(<i>0</i>)</span><span>日报(<i>0</i>)</span></p></dd>
        </dl>
      </div>
      <div class="aside_main">
        <ul>
          <div>
              <li class="li"><strong class="icon5"><span>借款人</span></strong></li>
              <ol class="ol1">
                <li class="cur">放款</li>
                <li>放款未批准</li>
                <li>放款已确认</li>
              </ol>
          </div>
          <div>
          <li style="border-top:1px solid #42424a" class="li"><strong class="icon6"><span>理财人</span></strong></li>
          <ol style="display:none" class="ol2">
                <li class="cur">放款</li>
                <li>放款未批准</li>
                <li>放款已确认</li>
              </ol>
          </div>
        </ul>
      </div>
    </div>
    <div class="article">
      <div class="article_top">
       <div id="time" class="p"></div>
        <ul>
          <li>您当前的位置:</li>
          <li><a href="">首页</a>></li>
          <li>放款批准</li>
        </ul>
      </div>
      <div class="mod_table">
        <div class="mod_title">
          托管账户
        </div>
        <div id="mod_table_main">
          <div class="mod_table_main mod_table_main1">
  <s:form name="f1">
  <input type="hidden" id="currentPage" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="areaPage" name="areaPage" value="<%=areaPage %>" />
         借款人放款:<br/>
   <table border="0" id="table_test">
   <tr>
   <td>ID</td>
   <td>标ID</td>
   <td>详情</td>
   <td>借款人</td>
   <td>金额</td>
   <td>备注</td>
   <td>状态</td>
   <td>时间</td>
   <td>操作</td>
   </tr>
   <s:if test="jkr_allowed_list.size==0">
		<tr><td style="border:none;border: none;position: absolute;left: 50%;font-size: 25px;top: 230px;color:#555">暂无数据</td></tr>
   </s:if>
       <s:elseif test="%{jkr_allowed_list==''}">
		<tr><td style="border:none;border: none;position: absolute;left: 50%;font-size: 25px;top: 230px;color:#555">暂无数据</td></tr>
   </s:elseif>
   <s:iterator value="jkr_allowed_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.bid_reason"/></td>
   <td><s:property value="#vo.jkr_name"/> </td> 
   <td><s:property value="#vo.zcrje"/></td> 
   <td><s:property value="#vo.remark"/></td>
    <td><s:property value="#vo.state"/> </td> 
   <td><s:property value="#vo.time"/></td> 
   <td> <a href="rootact/changeJkract.action?flag=2&id=${vo.id}">确认</a>
        <a href="rootact/changeJkract.action?flag=0&id=${vo.id}">取消</a>
   </td>
  <!--  <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>   
   </s:iterator>
   </table>
   <s:if test="jkr_allowed_list.size!=0">
   <div class="pagination Pagination1">
    <a href="javascript:nlastPage()" >上一页</a>
   <% 
     System.out.println("+++dfdsfsdfsdf++"+areaPage);
     for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++)
     
     {
    %>
    <a href="javascript:nfindByPage('<%=i %>')"  class="click"><%=i %></a>
    <%
    }
     %>
    <a href="javascript:nnextPage()">下一页</a>
    </div>
    </s:if>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("currentPage").value= parseInt(document.getElementById("currentPage").value)+1;  
             if(parseInt(document.getElementById("currentPage").value)>parseInt(document.getElementById("areaPage").value*5)){
               document.getElementById("areaPage").value=parseInt(document.getElementById("areaPage").value)+1;
             }
            f1.submit();
         }
         function nfindByPage(pp){
           document.getElementById("currentPage").value=pp;
             f1.submit();
         }
          function nlastPage(){
             document.getElementById("currentPage").value= parseInt(document.getElementById("currentPage").value)-1;  
             if(parseInt(document.getElementById("currentPage").value)<(parseInt(document.getElementById("areaPage").value-1)*5)+1){
               document.getElementById("areaPage").value=   parseInt(document.getElementById("areaPage").value)-1;
             }
            f1.submit();
         }
         
      </script>
     </s:form>
  <s:form name="f2">
    <input type="hidden" id="currentPag" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="areaPag" name="areaPage" value="<%=areaPage %>" />   
    <table border="0" id="table_test">
      <tr>
   <th>ID</th>
   <th>标ID</th>
   <th>详情</th>
   <th>借款人</th>
   <th>金额</th>
   <th>备注</th>
    <th>状态</th>
    <th>时间</th>
   </tr>
   <s:iterator value="jkr_not_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.bid_reason"/></td>
   <td><s:property value="#vo.jkr_name"/> </td> 
   <td><s:property value="#vo.zcrje"/></td> 
   <td><s:property value="#vo.remark"/></td>
    <td><s:property value="#vo.state"/> </td> 
   <td><s:property value="#vo.time"/></td> 
  <!--  <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   </table>
    <a href="javascript:nlastPage()">上一页</a>
     <%
       for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
      %>
       <a href="javascript:nfindByPage('<%=i %>')" ><%=i %></a>
     <%
     }
      %>
     <a href="javascript:nnextPage()">下一页</a>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("currentPag").value= parseInt(document.getElementById("currentPag").value)+1;  
             if(parseInt(document.getElementById("currentPag").value)>parseInt(document.getElementById("areaPag").value*5)){
               document.getElementById("areaPag").value=parseInt(document.getElementById("areaPag").value)+1;
             }
            f2.submit();
         }
         function nfindByPage(pp){
           document.getElementById("currentPag").value=pp;
             f2.submit();
         }
          function nlastPage(){
             document.getElementById("currentPag").value= parseInt(document.getElementById("currentPag").value)-1;  
             if(parseInt(document.getElementById("currentPag").value)<(parseInt(document.getElementById("areaPag").value-1)*5)+1){
               document.getElementById("areaPag").value=   parseInt(document.getElementById("areaPag").value)-1;
             }
            f2.submit();
         }
      </script>
   </s:form>
   <s:form name="f3">
     <input type="hidden" id="currentPa" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="areaPa" name="areaPage" value="<%=areaPage %>" />
    <table border="0" id="table_test">
      <tr>
   <td>ID</td>
   <td>标ID</td>
   <td>详情</td>
   <td>借款人</td>
   <td>金额</td>
   <td>备注</td>
    <td>状态</td>
    <td>时间</td>
   </tr>
   <s:iterator value="jkr_confirm_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.bid_reason"/></td>
   <td><s:property value="#vo.jkr_name"/> </td> 
   <td><s:property value="#vo.zcrje"/></td> 
   <td><s:property value="#vo.remark"/></td>
    <td><s:property value="#vo.state"/> </td> 
   <td><s:property value="#vo.time"/></td> 
  <!--  <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   </table>
    <a href="javascript:nlastPage()">上一页</a>
     <%
       for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
      %>
       <a href="javascript:nfindByPage('<%=i %>')" ><%=i %></a>
     <%
     }
      %>
     <a href="javascript:nnextPage()">下一页</a>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("currentPa").value= parseInt(document.getElementById("currentPa").value)+1;  
             if(parseInt(document.getElementById("currentPa").value)>parseInt(document.getElementById("areaPa").value*5)){
               document.getElementById("areaPa").value=parseInt(document.getElementById("areaPa").value)+1;
             }
            f3.submit();
         }
         function nfindByPage(pp){
           document.getElementById("currentPa").value=pp;
             f3.submit();
         }
          function nlastPage(){
             document.getElementById("currentPa").value= parseInt(document.getElementById("currentPa").value)-1;  
             if(parseInt(document.getElementById("currentPa").value)<(parseInt(document.getElementById("areaPa").value-1)*5)+1){
               document.getElementById("areaPa").value=   parseInt(document.getElementById("areaPa").value)-1;
             }
            f3.submit();
         }
      </script>
   </s:form>
  <s:form name="f4"> 
    <input type="hidden" id="currentP" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="areaP" name="areaPage" value="<%=areaPage %>" />
    <table border="0" id="table_test">
      <tr>
   <td>ID</td>
   <td>标ID</td>
   <td>理财人姓名</td>
   <td>金额</td>
   <td>手续费</td>
   <td>银行</td>
   <td>银行卡号</td>
    <td>支付平台</td>
    <td>时间</td>
    <td>备注</td>
    <td>状态</td>
   </tr>
   <s:iterator value="lcr_allowed_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.lcrname"/></td> 
   <td><s:property value="#vo.money"/></td>
   <td><s:property value="#vo.charge"/> </td> 
   <td><s:property value="#vo.bankname"/></td> 
   <td><s:property value="#vo.bankid"/></td>
    <td><s:property value="#vo.payment"/> </td> 
   <td><s:date name="#vo.time" format="yyyy-MM-dd HH:mm:ss" /></td> 
    <td><s:property value="#vo.remark"/> </td> 
   <td><s:property value="#vo.state"/></td> 
    <td> <a href="rootact/changeLcract.action?flag=2&id=${vo.id}">确认</a>
        <a href="rootact/changeLcract.action?flag=0&id=${vo.id}">取消</a>
   </td>
  <!--  <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   </table>
   <a href="javascript:nlastPage()">上一页</a>
     <%
       for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
      %>
       <a href="javascript:nfindByPage('<%=i %>')" ><%=i %></a>
     <%
     }
      %>
     <a href="javascript:nnextPage()">下一页</a>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("currentP").value= parseInt(document.getElementById("currentP").value)+1;  
             if(parseInt(document.getElementById("currentP").value)>parseInt(document.getElementById("areaP").value*5)){
               document.getElementById("areaP").value=parseInt(document.getElementById("areaP").value)+1;
             }
            f4.submit();
         }
         function nfindByPage(pp){
           document.getElementById("currentP").value=pp;
             f4.submit();
         }
          function nlastPage(){
             document.getElementById("currentP").value= parseInt(document.getElementById("currentP").value)-1;  
             if(parseInt(document.getElementById("currentP").value)<(parseInt(document.getElementById("areaP").value-1)*5)+1){
               document.getElementById("areaP").value=   parseInt(document.getElementById("areaP").value)-1;
             }
            f4.submit();
         }
      </script>
   </s:form>
   <s:form name="f5">
     <input type="hidden" id="current" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="area" name="areaPage" value="<%=areaPage %>" />
    <table border="0" id="table_test">
      <tr>
   <td>ID</td>
   <td>标ID</td>
   <td>理财人姓名</td>
   <td>金额</td>
   <td>手续费</td>
   <td>银行</td>
   <td>银行卡号</td>
    <td>支付平台</td>
    <td>时间</td>
    <td>备注</td>
    <td>状态</td>
   </tr>
   <s:iterator value="lcr_not_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.lcrname"/></td> 
   <td><s:property value="#vo.money"/></td>
   <td><s:property value="#vo.charge"/> </td> 
   <td><s:property value="#vo.bankname"/></td> 
   <td><s:property value="#vo.bankid"/></td>
    <td><s:property value="#vo.payment"/> </td> 
   <td><s:date name="#vo.time" format="MM/dd/yy" /></td> 
    <td><s:property value="#vo.remark"/> </td> 
   <td><s:property value="#vo.state"/></td> 
    <!-- <td> <a href="rootact/changeLcract.action?flag=2&id=${vo.id}">确认</a>
        <a href="rootact/changeLcract.action?flag=0&id=${vo.id}">取消</a>
   </td>
   <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   </table>
   <a href="javascript:nlastPage()">上一页</a>
     <%
       for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
      %>
       <a href="javascript:nfindByPage('<%=i %>')" ><%=i %></a>
     <%
     }
      %>
     <a href="javascript:nnextPage()">下一页</a>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("current").value= parseInt(document.getElementById("current").value)+1;  
             if(parseInt(document.getElementById("current").value)>parseInt(document.getElementById("area").value*5)){
               document.getElementById("area").value=parseInt(document.getElementById("area").value)+1;
             }
            f5.submit();
         }
         function nfindByPage(pp){
           document.getElementById("current").value=pp;
             f5.submit();
         }
          function nlastPage(){
             document.getElementById("current").value= parseInt(document.getElementById("current").value)-1;  
             if(parseInt(document.getElementById("current").value)<(parseInt(document.getElementById("area").value-1)*5)+1){
               document.getElementById("area").value=   parseInt(document.getElementById("area").value)-1;
             }
            f5.submit();
         }
      </script>
   </s:form>
   <s:form name="f6">
     <input type="hidden" id="c" name="currentPage" value="<%=currentPage %>" />
  <input type="hidden" id="a" name="areaPage" value="<%=areaPage %>" />
    <table border="0"  id="table_test">
      <tr>
   <td>ID</td>
   <td>标ID</td>
   <td>理财人姓名</td>
   <td>金额</td>
   <td>手续费</td>
   <td>银行</td>
   <td>银行卡号</td>
    <td>支付平台</td>
    <td>时间</td>
    <td>备注</td>
    <td>状态</td>
   </tr>
   <s:iterator value="lcr_confirm_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.lcrname"/></td> 
   <td><s:property value="#vo.money"/></td>
   <td><s:property value="#vo.charge"/> </td> 
   <td><s:property value="#vo.bankname"/></td> 
   <td><s:property value="#vo.bankid"/></td>
    <td><s:property value="#vo.payment"/> </td> 
   <td><s:date name="#vo.time" format="MM/dd/yy" /></td> 
    <td><s:property value="#vo.remark"/> </td> 
   <td><s:property value="#vo.state"/></td> 
    <!-- <td> <a href="rootact/changeLcract.action?flag=2&id=${vo.id}">确认</a>
        <a href="rootact/changeLcract.action?flag=0&id=${vo.id}">取消</a>
   </td>
   <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   </table>
    <a href="javascript:nlastPage()">上一页</a>
     <%
       for(int i=(areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
      %>
       <a href="javascript:nfindByPage('<%=i %>')" ><%=i %></a>
     <%
     }
      %>
     <a href="javascript:nnextPage()">下一页</a>
      <script type="text/javascript">
         function nnextPage(){
             document.getElementById("c").value= parseInt(document.getElementById("c").value)+1;  
             if(parseInt(document.getElementById("c").value)>parseInt(document.getElementById("a").value*5)){
               document.getElementById("a").value=parseInt(document.getElementById("a").value)+1;
             }
            f6.submit();
         }
         function nfindByPage(pp){
           document.getElementById("c").value=pp;
             f6.submit();
         }
          function nlastPage(){
             document.getElementById("c").value= parseInt(document.getElementById("c").value)-1;  
             if(parseInt(document.getElementById("c").value)<(parseInt(document.getElementById("a").value-1)*5)+1){
               document.getElementById("a").value=   parseInt(document.getElementById("a").value)-1;
             }
            f6.submit();
         }
      </script>
   </s:form>
          </div>  
        </div>
        </div>
      </div>
     <script src="js/houtai.js"></script>

</body>
</html>