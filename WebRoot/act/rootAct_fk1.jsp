<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
Integer totalPage=(Integer)request.getAttribute("totalPage");
Integer areaPage=(Integer)request.getAttribute("areaPage");
Integer currentPage=(Integer)request.getAttribute("currentPage");
Integer currentPageToo = (Integer) request.getAttribute("currentPageToo");
Integer totalPageToo = (Integer) request.getAttribute("totalPageToo");
Integer areaPageToo = (Integer) request.getAttribute("areaPageToo");
if(currentPageToo==null){
	currentPageToo = 1;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">

    <base href="<%=basePath%>">
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>root放款批准 理财人 放款</title>
  <link type="text/css" rel="stylesheet" href="css/common.css">
  <link type="text/css" rel="stylesheet" href="css/houtai.css">
  <link type="text/css" rel="stylesheet" href="css/fund.css" />
  <link rel="Shortcut Icon" href="../images/zcb-icon.ico">
  <script src="js/jquery-1.6.4.min.js"></script>
  <script type="text/javascript" language="javascript" src="js/pub.js"></script>
  <script>
  $(function(){
      $(".nav .ul li").click(function(){
        $(this).addClass('cur').siblings().removeClass('cur');
      })



  
  
  
  </script>
</head>
<body onload="showTime()">

<div class="pg-container" style="text-align: left">
			<div class="opict" style="display: none;" id="opict"></div>
			<div class="Auditing" id="Auditing" style="display: none;">
			      
			      	<p onclick="chizhiCloses()" style="position:absolute;right: -10px;top: -10px;"><img src="./images/close.png"></p>
			    	<s:form   action="rootact/rootActla.action?currentPage=1">
			      	<table >
				      	<tr>
				      		<th>ID</th><th>姓名</th><th>金额</th><th>支付平台</th><th>时间</th><th>备注</th><th>状态</th><th>选择</th><th></th>
				      	</tr> 	
				      </table>
				      	<table  id="jsonTable" >
				      	
				    </table>
			       		<div class="bts"  style="text-align:center;margin: 15px 0;">
			       				<input type="button"  onclick="affirm()" class="ui-button ui-button-mid ui-button-gray" value="确  认">
      							<input type="button"  onclick="chizhiCloses()" class="ui-button ui-button-mid ui-button-gray" value="取 消">
      					</div> 
      					 <div class="pagination Pagination1">
      			   <input type="hidden"  id="MaxPage"      name="MaxPage" />
				   <input type="hidden"  id="UserLength"   name="UserLength" />
				   <input type="hidden"  id="AreaPage"     name="AreaPage"    value='<%=areaPageToo%>'/>
				   <input type="hidden"  id="TotalPage"    name="TotalPage"   value='<%=totalPageToo %>' />
				   <input type="hidden"  id="currentPageToo"  name="CurrentPage" value='<%=currentPageToo%>'/>
				   <input type="hidden"  id="PageSize"     name="PageSize"    value="10"/>
                   <a href="javascript:;" onclick="up()">上一页</a> 
                  
                   <a href="javascript:;" onclick="down()">下一页</a>
              
                   </div>
                  </s:form>
			      </div>
	





<div class="wrap">
  <div class="nav">
      <div class="logo">
        <a href=""></a>
      </div>
      <ul class="ul">
        <li><a href="/ZhongCaiBao/rootact/records.action?currentPage=1">资金流水</a></li>
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
              <li class="li"><strong class="icon5"><span><a href="/ZhongCaiBao/rootact/rootAct.action?currentPage=1">借款人</a></span></strong></li>
              <ol class="ol1" style="display:none">
                <li class="cur"><a href="/ZhongCaiBao/rootact/rootAct.action?currentPage=1">放款</a></li>
                <li><a href="/ZhongCaiBao/rootact/rootActjn.action?currentPage=1">放款未批准</a></li>
                <li><a href="/ZhongCaiBao/rootact/rootActjc.action?currentPage=1">放款已确认</a></li>
              </ol>
          </div>
          <div>
          <li style="border-top:1px solid #42424a" class="li cur"><strong class="icon6"><span><a href="/ZhongCaiBao/rootact/rootActla.action?currentPage=1">理财人</a></span></strong></li>
          <ol class="ol2">
                <li class="cur"><a href="/ZhongCaiBao/rootact/rootActla.action?currentPage=1">放款</a></li>
                <li><a href="/ZhongCaiBao/rootact/rootActln.action?currentPage=1">放款未批准</a></li>
                <li><a href="/ZhongCaiBao/rootact/rootActlc.action?currentPage=1">放款已确认</a></li>
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


<div class="mod_table_main mod_table_main2">
<div>
 <s:form name="f4"> 
  <input type="hidden" id="currentPage" name="currentPage" value='<%=currentPage %>' />
  <input type="hidden" id="areaPage" name="areaPage" value='<%=areaPage %>' />
  <input type="hidden" id="totalPage" name="totalPage" value='<%=totalPage %>' />
    <table border="0" id="table_test">
      <tr>
   <th>ID</th>
   <th>标ID</th>
   <th>详情</th>
   <th>理财人姓名</th>
   <th>金额</th>
   <th>手续费</th>
   <th>银行</th>
   <th>银行卡号</th>
    <th>支付平台</th>
    <th>时间</th>
    <th>备注</th>
    <th>状态</th>
    <th>操作</th>
   </tr>
   <s:if test="lcr_allowed_list.size==0">
		<tr><td style="border:none;border: none;position: absolute;left: 50%;font-size: 25px;top: 230px;color:#555">暂无数据</td></tr>
   </s:if>
       <s:elseif test="%{lcr_allowed_list==''}">
		<tr><td style="border:none;border: none;position: absolute;left: 50%;font-size: 25px;top: 230px;color:#555">暂无数据</td></tr>
   </s:elseif>
   <s:iterator value="lcr_allowed_list" var="vo">
   <tr>
   <td><s:property value="#vo.id"/></td> 
   <td><s:property value="#vo.bidid"/></td> 
   <td><s:property value="#vo.bidreason" /></td>
   <td><s:property value="#vo.lcrname"/></td> 
   <td><s:property value="#vo.money"/></td>
   <td><s:property value="#vo.charge"/> </td> 
   <td><s:property value="#vo.bankname"/></td> 
   <td><s:property value="#vo.banknumber"/></td>
    <td><s:property value="#vo.payment"/> </td> 
   <td><s:date name="#vo.time" format="yyyy-MM-dd HH:mm:ss" /></td> 
    <td><s:property value="#vo.remark"/> </td> 
   <td><s:property value="#vo.state"/></td> 
   
   
   <s:if  test="#vo.bidid==null"><td style="width: 150px;"><a href="rootact/changeLcract.action?flag=2&id=${vo.id}" class="a5d6">批准</a></s:if>
	<s:else>
	<td style="width: 150px;"><a class="a5d6"   href="javascript:AuditingShow1(<s:property value="#vo.id" />,<s:property value="#vo.bidid" />,'<s:date name="#vo.time" format="yyyy-MM-dd HH:mm:ss" />','<s:property value="#vo.state" />','1')" >批准</a> 
	</s:else>
   
        <a href="rootact/changeLcract.action?flag=0&id=${vo.id}" class="a5d6">不批准</a>
   </td>
  <!--  <td><s:a href="bidinfo/findById.action?id=%{#vo.id}">开始出借</s:a></td> -->
    </tr>
   </s:iterator>
   
   </table>
   <s:if test="lcr_allowed_list.size!=0">
    <div class="pagination Pagination1">
    <a href="javascript:lastPage()" >上一页</a>
    <%
         if(totalPage.intValue()<=5){
          for(int i=1;i<=totalPage.intValue();i++){
        	  if(i==currentPage.intValue()){
     			 %>
     			  <a href="javascript:findByPage('<%=i%>')" class="clicktrue" ><%=i%></a>
     			<%
     		  }else{
     		  %>
     		    <a href="javascript:findByPage('<%=i%>')" class="click" ><%=i%></a>
     		  <% 
     		  }
         }
         }
          else{ if(areaPage.intValue()*5<=totalPage.intValue()){
        	  for(int i= (areaPage.intValue()-1)*5+1;i<=areaPage.intValue()*5;i++){
        		  if(i==currentPage.intValue()){
        			 %>
        			  <a href="javascript:findByPage('<%=i%>')" class="clicktrue" ><%=i%></a>
        			<%
        		  }else{
        		  %>
        		    <a href="javascript:findByPage('<%=i%>')" class="click" ><%=i%></a>
        		  <% 
        		  }
        	  }
          }
               else {
        	       for(int i= (areaPage.intValue()-1)*5+1;i<=totalPage.intValue();i++){
        	    	   if(i==currentPage.intValue()){
        		  %>
    			  <a href="javascript:findByPage('<%=i%>')" class="clicktrue" ><%=i%></a>
    			<%
    		     }else{
    		     %>
    		    <a href="javascript:findByPage('<%=i%>')" class="click" ><%=i%></a>
    		  <% 
    		     }
        	  }
          }
          }
       %>
    <a href="javascript:nextPage()">下一页</a>
    </div>
    </s:if>
      <script type="text/javascript">
      function nextPage(){
    	  if(parseInt( document.getElementById("currentPage").value)<parseInt( document.getElementById("totalPage").value)){
          document.getElementById("currentPage").value= parseInt(document.getElementById("currentPage").value)+1;  
          if(parseInt(document.getElementById("currentPage").value)>parseInt(document.getElementById("areaPage").value*5)){
            document.getElementById("areaPage").value=parseInt(document.getElementById("areaPage").value)+1;
          }
         f4.submit();
      }
    	  else if(parseInt( document.getElementById("currentPage").value)==parseInt( document.getElementById("totalPage").value)){
    		  alert("当前已经是最后一页");
    	  }
      }
         function findByPage(pp){
           document.getElementById("currentPage").value=pp;
             f4.submit();
         }
          function lastPage(){
        	  if(parseInt( document.getElementById("currentPage").value)>1){
             document.getElementById("currentPage").value= parseInt(document.getElementById("currentPage").value)-1;  
             if(parseInt(document.getElementById("currentPage").value)<(parseInt(document.getElementById("areaPage").value-1)*5)+1){
               document.getElementById("areaPage").value=   parseInt(document.getElementById("areaPage").value)-1;
             }
            f4.submit();
         }
        	  else if(parseInt( document.getElementById("currentPage").value)==1){
        		  alert("当前已经是第一页");
        	  }
          }
          
      </script>
   </s:form>
   </div>


 

          </div>  
        </div>
        </div>

      </div>
  </div>
</div>
     <script src="js/houtai.js"></script>
  <script src="js/lcr.js"></script>

</body>
</html>