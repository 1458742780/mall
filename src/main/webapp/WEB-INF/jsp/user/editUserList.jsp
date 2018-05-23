<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查询用户列表</title>
<script language="JavaScript" src="${pageContext.request.contextPath }/js/jquery-1.4.4.js"></script>
<script type="text/javascript">
 function queryUser(){
	//提交form
	document.userForm.action="${pageContext.request.contextPath }/user/selectUser";
	document.userForm.method="get";
	document.userForm.submit();
} 
 function updateUsers(){
		//提交form
		document.userForm.action="${pageContext.request.contextPath }/user/updateBatch";
		document.userForm.method="post";
		document.userForm.submit();
	} 
 
</script>
</head>
<body> 
<form name="userForm" action="${pageContext.request.contextPath }/items/queryItems.action" method="post">
查询条件：
<table width="100%" border=1>
<tr>
<td>
用户账号：<input id="usercode" name="usercode" type="text">
		<input type="button" value="查询" onclick="javascript:queryUser();"/>
</td>
<td>
<input type="button" value="批量修改" onclick="updateUsers()">
<input type="button" value="批量删除" onclick="">
</td>
</tr>
</table>
用户列表：
<table width="100%" border=1>
<tr>
	<td>*</td>
	<td>用户账号</td>
	<td>用户姓名</td>
	<td>盐</td>
	<td>账号是否锁定</td>
	<td>操作</td>
</tr>
<c:forEach items="${list}" var="item" varStatus="status">
<tr>
	<input type="hidden" name="list[${status.index}].id" value="${item.id }"/>
	<td><input type="checkbox" id="userid" name="userid" value="${item.id }"/></td>
	<td>${item.usercode }</td>
	<td><input id="username" name="username" value="${item.username }"/></td>
	<td>${item.salt }</td>
	<td>
		<c:if test="${item.locked == 0}">否</c:if>
		<c:if test="${item.locked == 1}">是</c:if>
	</td>
	<td>
		<%-- <c:forEach items="${permission}" var="par">
			<a href=javascript:addTab('${par.name }','${baseurl }/${par.url }')>${par.name }</a>
		</c:forEach> --%>
		<input type="button" value="修改" onclick="updateUser()"/>
		<input type="button" value="删除" onclick="deleteUser()"/>
		<input type="button" value="详细信息" onclick=""/>
	</td>
	
</tr>
</c:forEach>


</table>
</form>
</body>
<script type="text/javascript">
function updateUser(){
	var username = $("#username").val();
	var userid = $("#userid").val();
	$.post("${pageContext.request.contextPath }/user/updateUser",
			{ id:userid,username:username},
			 function(data){
			    if(data.isSuccess == true){
			    	alert(data.message);
			    	window.location.reload();
			    	//$(location).attr('href','user/selectAll');
			    }else{
			    	alert(data.message);
			    }
			  },"json");	
}
function deleteUser(){
	var userid = $("#userid").val();
	$.post("${pageContext.request.contextPath }/user/deleteUser",
			{ id:userid},
			 function(data){
			    if(data.isSuccess == true){
			    	alert(data.message);
			    	window.location.reload();
			    	//$(location).attr('href','user/selectAll');
			    }else{
			    	alert(data.message);
			    }
			  },"json");	
}
</script>

</html>