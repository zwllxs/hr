<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>第一个form1</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 
  </head>
<body>
<center>

使用commandName指定后台绑定的属性
<hr>
<form:form action="save3.do" commandName="person" method="post">  
    <table>  
    	 <tr>  
            <td>所有错误信息:</td>  
            <td><form:errors path="*"/></td>  
        </tr> 
        <tr>  
            <td>Name:</td><td><form:input path="name"/><form:errors path="name"/></td>  
        </tr>  
        <tr>  
            <td>Age:</td><td><form:input path="age"/><form:errors path="age"/></td>  
        </tr>  
        <tr>  
            <td>marry:</td><td><form:checkbox path="married"/></td>  
        </tr>  
        <tr>  
            <td>roles(form:checkbox): </td>
            <td>
            	role1: <form:checkbox path="roleList" value="1"/>
            	role2: <form:checkbox path="roleList" value="2"/>
            	role3: <form:checkbox path="roleList" value="3"/>
            	role4: <form:checkbox path="roleList" value="5"/>
            	role5: <form:checkbox path="roleList" value="4"/>
            	role8: <form:checkbox path="roleList" value="8"/>
            	<br>${person.roleList }- 
            </td>  
        </tr>  
        <tr>  
            <td>自我介绍 </td>
            <td>
            	 <form:textarea path="introduction" rows="4" cols="30"/>
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td colspan="2"><input type="submit" value="提交"/></td>  
        </tr>  
    </table>  
</form:form> 
	 
</center>
</body>
</html>