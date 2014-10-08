<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>	
<jsp:include page="../common/head.jsp"></jsp:include>
<html>
<head>
<meta http-equiv=content-type content="text/html; charset=gbk" />
<title>itcast oa</title>
<link href="${basePath}/res/admin/css/blue/login.css" type=text/css rel=stylesheet />
</head>
<body leftmargin=0 topmargin=0 marginwidth=0 marginheight=0
	class=pagebody>
	<form:form method="post" name="actform" commandName="user" method="post" action="${basePath}/admin/login2.html">
		<div id="centerareabg">
			<div id="centerarea">
				<div id="logoimg">
					<img border="0" src="${basePath}/res/admin/css/blue/images/logo.png" />
				</div>
				<div id="logininfo">
					<table border=0 cellspacing=0 cellpadding=0 width=100%>
						<tr>
							<td width=45 class="subject"><img border="0"
								src="${basePath}/res/admin/css/blue/images/login/userId.gif" /></td>
							<td><input size="20" class="textfield" type="text"
								name="userName" />
								 <div><form:errors cssStyle="color:red;font-size:10px;" path="userName"/></div>
								</td>
							<td rowspan="2" style="padding-left: 10px;"><input
								type="image"
								src="${basePath}/res/admin/css/blue/images/login/userLogin_button.gif" /></td>
						</tr>
						<tr>
							<td class="subject"><img border="0"
								src="${basePath}/res/admin/css/blue/images/login/password.gif" /></td>
							<td><input size="20" class="textfield" type="password"
								name="password" /></td>
						</tr>
					</table>
				</div>
				<div id="copyright">
					<a href="javascript:void(0)">&copy; 2014-10-2 zwl 软件</a>
				</div>
			</div>
		</div>
	</form:form>
</body>

</html>
