<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 1.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/common.css">
<link type="text/css" rel="stylesheet" href="../css/index.css">
</head>
  <script src="../js/jquery-1.6.4.min.js"></script> 

<script type="text/javascript">

var xhr;


function createXHR(){
	/* if(window.ActiveXObject){
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	}else if(window.XMLHttpRequest){
		xhr = new XMLHttpRequest();
	}else{
		alert("can't create xhr object!");
	} */
     try {  
    	 xhr = new ActiveXObject("Msxml2.XMLHTTP"); // ie msxml3.0+（IE7.0及以上）  
     } catch (e) {  
         try {  
        	 xhr = new ActiveXObject("Microsoft.XMLHTTP"); //ie msxml2.6（IE5/6）  
         } catch (e2) {  
        	 xhr = false;  
         }  
     }  
     if (!xhr && typeof XMLHttpRequest != 'undefined') {// Firefox, Opera 8.0+, Safari  
    	 xhr = new XMLHttpRequest();  
     }  
}
function ajaxGet(){
	alert("ajaxGet()");	
	var currentPage=document.getElementById("currentPage").value;
	var pageSize=document.getElementById("pageSize").value;
	var starTime=document.getElementById("starTime").value;
	var endTime=document.getElementById("endTime").value;
	
	alert("currentPage:"+currentPage);
	createXHR();
	var action="/ZhongCaiBao/mobile/findAllBulkbid.action?"
		+"currentPage="+currentPage
		+"&pageSize="+pageSize
		+"&starTime="+starTime
		+"&endTime="+endTime;
	alert("ajaxAction:"+action);
	xhr.open("get", action);
		
    xhr.send(null);
	xhr.onreadystatechange=doResponse;
	
}
function ajaxPost(){
	alert("ajaxPost()");	
	var currentPage=document.getElementById("currentPage").value;
	var pageSize=document.getElementById("pageSize").value;
	var starTime=document.getElementById("starTime").value;
	var endTime=document.getElementById("endTime").value;
	
	alert("currentPage:"+currentPage);
	createXHR();
	
	var action="/ZhongCaiBao/mobile/findAllBulkbid.action"
	
	xhr.open("post", action,true);
	xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	xhr.send(+"currentPage="+currentPage
			+"&pageSize="+pageSize
			+"&starTime="+starTime
			+"&endTime="+endTime);
	alert("ajaxAction:"+action);
	
		
    
	xhr.onreadystatechange=doResponse;
	
}
function doResponse(){
	 //alert("doResponse()");
	 if(xhr.readyState==4&&xhr.status==200){
		 var json=xhr.responseText;
		  alert("json:"+json);
/* 		  var string = '{"name":"frank", "age":29, "birthday":"1978-1-1"}';
 */		  
 	//string 转换成json数组
 	var user = JSON.parse(json);
 for(var j=0; j<user.length; j++) {
	 var insertText = "<li class='ui-list-item fn_clear'><span class='ui-list-field fleft text-big w260'>"+user[j].reason+"</span><span class='ui-list-field fleft text-big w260'>"+user[j].bidtype+"</span></li>"; 
     document.getElementById("id").innerHTML = document.getElementById("id").innerHTML+insertText;
} 
		  
	 }

}



</script>

<body>
<ul  class="ui-list-loan ui-list-m" id="id">
<li class="fn_clear" id="loan-list-header">
                            <span class="ui-list-title fleft gray w260">借款标题</span>
                            <span class="ui-list-title fleft gray w80">标的类型</span>
                            <span class="ui-list-title fleft gray w120">年利率</span>
                            <span class="ui-list-title fleft gray w160">金额</span>
                            <span class="ui-list-title fleft gray w100">期限</span>
                            <span class="ui-list-title fleft gray w110">进度</span>
                            <span class="ui-list-title fleft gray w80"></span>
                        </li>
           <li class="ui-list-item fn_clear" id="js_water_box">
           <span id=""></span>
                   
                   </li>     
</ul>
currentPage:<input id="currentPage" type="text" value="1"/><br>
pageSize:<input  id="pageSize"  type="text" value="2"/><br>
starTime:<input id="starTime"  type="text" value="2000-1-1"/><br>
endTime:<input  id="endTime" type="text" value="2050-1-1"/><br>
<input type="button" value="ajaxGet" onclick="ajaxGet()"/>
<input type="button" value="ajaxPost" onclick="ajaxPost()"/>
<<<<<<< .mine
=======
<input type="button" value="上一页" onclick="up()"/>
<input type="button" value="下一页" onclick="down()"/>

<br><input type="text"  id="maxPage" name="maxPage" />
>>>>>>> .r334
</body>
</html>