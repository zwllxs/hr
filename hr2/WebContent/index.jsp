<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
  <body>
  		 基础配置  <br/>
		<a href="employe/list.do" target="_blank">加载列表</a> <br>
		<a href="employe/111/addUser.do?id=222"  target="_blank">演示请求路径匹配(@RequestMapping("/employe/*/addUser"),test3(@PathVariable("userId") String userId))</a><br>
		<a href="employe/222.do"  target="_blank">对应后台是@RequestMapping("/employe/${userId}"),由于有$，是访问不到的</a><br>
		<a href="test/222.do"  target="_blank">对应后台是@RequestMapping("/test/{userId}")， test3(@PathVariable("userId") String userId),没有$，所以访问得到</a><br>
		<a href="test4/222.do"  target="_blank">test4(@RequestMapping("/test4/{userId}"),test4(@PathVariable("userId") String name))</a><br>
		<a href="test5/222.do"  target="_blank">test5(@RequestMapping("/test5/{userId}"), test5(@PathVariable("userId2222") String name))</a><br>
		<a href="delete.do?name=zhangwelin"  target="_blank">test6(@RequestMapping(value="/delete.do",method=RequestMethod.POST),test6(String name))</a><br>
		<a href="add.do"  target="_blank">test7(@RequestMapping(value="/add.do",params="name"), test7(String name))</a><br>
		<a href="add.do?name=zhangwelin"  target="_blank">test8(@RequestMapping(value="/add.do",params="name"), test7(String name))</a><br>
		<a href="employe/toadd.do"  target="_blank">跳到增加页面1</a><br>
		<a href="regController.do"  target="_blank">跳到增加页面2</a><br>
		<a href="regController2.do"  target="_blank">跳到增加页面2</a><br>
		
		<br/><br/>表单  <br/>
		<a href="form1.do"  target="_blank">表单1(不走后台,则未绑定bean,表单标签是无法使用的)</a><br>
		<a href="form1/show.do"  target="_blank">表单1(走后台,绑定bean,表单标签)</a><br>
		<a href="form1/showvalid.do"  target="_blank">表单2(表单验证测试(使用实现Validator接口的方式))</a><br>
		<a href="form1/showvalid2.do"  target="_blank">表单3(表单验证测试(使用注解式))</a><br>
		
		
  </body>
</html>
