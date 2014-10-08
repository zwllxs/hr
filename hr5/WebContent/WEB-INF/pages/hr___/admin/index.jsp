<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../common/head.jsp"></jsp:include>
    
<html>
<head>
    <title>itcastoa</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
</head>
<frameset rows="100,*,25" framespacing="0" border="0" frameborder="0">
	<frame noresize name="topmenu" src="${basePath}/hr/admin/frame/top.html" target="contents"  scrolling="no" />
	<frameset cols="180,*" id="resize">
		<frame noresize name="menu" src="${basePath}/hr/admin/frame/left.html" target="desktop" scrolling="yes" />
		<frame noresize name="desktop" src="${basePath}/hr/admin/frame/desktop.html" scrolling="yes" />
	</frameset>
	<frame noresize name="status_bar" scrolling="no" src="${basePath}/hr/admin/frame/bottom.html" />
</frameset>
 
<noframes>  
	<body></body>
</noframes>

</html>
