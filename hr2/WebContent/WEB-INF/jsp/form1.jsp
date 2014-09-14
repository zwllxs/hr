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

不使用commandName，后台默认使用command作为绑定属性
<hr>
<form:form action="formTag/form.do" method="post">  
    <table>  
        <tr>  
            <td>Name:</td><td><form:input path="name"/></td>  
        </tr>  
        <tr>  
            <td>Age:</td><td><form:input path="age"/></td>  
        </tr>  
        <tr>  
            <td colspan="2"><input type="submit" value="提交"/></td>  
        </tr>  
    </table>  
</form:form> 

使用commandName指定后台绑定的属性
<hr>
<form:form action="formTag/form.do" commandName="person" method="post">  
    <table>  
        <tr>  
            <td>Name:</td><td><form:input path="name"/></td>  
        </tr>  
        <tr>  
            <td>Age:</td><td><form:input path="age"/></td>  
        </tr>  
        <tr>  
            <td colspan="2"><input type="submit" value="提交"/></td>  
        </tr>  
    </table>  
</form:form> 

使用modelAttribute指定后台绑定的属性 method="delete" 
<hr>
<form:form action="save1.do"  modelAttribute="person" method="delete">  
    <table>  
        <tr>  
            <td>Name:</td><td><form:input path="name"/></td>  
        </tr>  
        <tr>  
            <td>Age:</td><td><form:input path="age"/></td>  
        </tr>  
        <tr>  
            <td colspan="2"><input type="submit" value="提交"/></td>  
        </tr>  
    </table>  
</form:form> 


使用commandName指定后台绑定的属性
<hr>
<form:form action="save2.do" commandName="person" method="post">  
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
            <td>roles(form:checkboxes(用List)): </td>
            <td>
            	role2List: <form:checkboxes path="roleList" items="${role2List }"/>
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>roles(form:checkboxes(用Map)): </td>
            <td>
            	role2List: <form:checkboxes path="roleList" items="${map2 }" delimiter=",   " />
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>性别(form:radiobutton): </td>
            <td>
            	 <form:radiobutton path="sex" value="1"/>男  
                 <form:radiobutton path="sex" value="0"/>女  
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>球类爱好(form:radiobuttons): </td>
            <td>
            	 <form:radiobuttons path="favoriteBall" items="${ballMap}" delimiter="&nbsp;---"/>  
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>球类爱好(form:select): </td>
            <td>
            	 <form:select path="favoriteBall" items="${ballMap}"  />  
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>球类爱好(form:select(如果指定了数据源，则只显示数据源的数据)): </td>
            <td>
            	 <form:select path="favoriteBall" items="${ballMap}" >
            	 	<form:option value="6">地球</form:option>
            	 	<form:option value="6">地球</form:option>
            	 	<form:option value="6">地球</form:option>
            	 </form:select>  
            	<br> 
            </td>  
        </tr>  
        <tr>  
            <td>球类爱好(form:select(指定数据源，又想加自己的东西)): </td>
            <td>
            	 <form:select path="favoriteBall"  >
            	 	<form:option value="">请选择</form:option>
            	 	<form:options items="${ballMap}"/>
            	 </form:select>  
            	<br> 
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