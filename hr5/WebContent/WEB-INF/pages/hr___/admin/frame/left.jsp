<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="../../../common/head.jsp"></jsp:include>

<html>
<head>
<title>导航菜单</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script language="JavaScript" src="${basePath}/res/js/menu.js"></script>
<link type="text/css" rel="stylesheet"
	href="${basePath}/res/css/blue/menu.css" />
<script type="text/javascript">
	var basePath = "";
	var SubImg = '${basePath}/res/css/images/MenuIcon/menu_arrow_close.gif';
	var SubImgOpen = '${basePath}/res/css/images/MenuIcon/menu_arrow_open.gif';
</script>
</head>
<body style="margin: 0">
	<div id="Menu">
		<ul id="MenuUl">
			<li class="level1">
				<div onClick="menuClick(this);" id="MEMU_FUNC20057"
					style="cursor: pointer;" class="level1Style">
					<img src="${basePath}/res/css/images/MenuIcon/FUNC20057.gif"
						class="Icon" /> 审批流转
				</div>
				<ul style="display: none;" id="MEMU_FUNC20057_d" class="MenuLevel2">
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="list/list.html">列表页</a>
						</div>
					</li>
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="edit/edit.html">编辑页面</a>
						</div>
					</li>

				</ul>
			</li>
			<li class="level1">
				<div onClick="menuClick(this);" style="cursor: pointer;"
					id="MEMU_FUNC20058" class="level1Style">
					<img src="${basePath}/res/css/images/MenuIcon/FUNC20057.gif"
						class="Icon" /> 审批流转22
				</div>
				<ul style="display: none;" id="MEMU_FUNC20058_d" class="MenuLevel2">
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="list/list.html">列表页</a>
						</div>
					</li>
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="edit/edit.html">编辑页面</a>
						</div>
					</li>

				</ul>
			</li>
			<li class="level1">
				<div onClick="menuClick(this);" style="cursor: pointer;"
					id="MEMU_FUNC20064" class="level1Style">
					<img src="${basePath}/res/css/images/MenuIcon/FUNC20064.gif"
						class="Icon" /> 网上交流222
				</div>
				<ul style="display: none;" id="MEMU_FUNC20064_d" class="MenuLevel2">
					<li class="level2">
						<div onClick="subMenuClick(this);" id="MEMU_FUNC20002"
							class="level2Style" style="cursor: pointer;">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_close.gif"
								id="MEMU_FUNC20002_img" /> 短消息
						</div>
						<ul style="display: none;" id="MEMU_FUNC20002_d"
							class="MenuLevel2">
							<li class="level3Head"><a target="desktop"
								href="Person_Message/saveUI.html">发送短消息</a></li>
							<li class="level33"><a target="desktop"
								href="Person_Message/inbox.html">已接收</a></li>
							<li class="level33"><a target="desktop"
								href="Person_Message/outbox.html">已发送</a></li>
							<li class="level32"><a target="desktop"
								href="Person_Message/draftbox.html">草稿箱</a></li>
						</ul>
					</li>
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="list/list.html">列表页</a>
						</div>
					</li>
					<li class="level2">
						<div class="level2Style">
							<img
								src="${basePath}/res/css/images/MenuIcon/menu_arrow_single.gif"
								id="MEMU_FUNC20059_img" /> <a target="desktop"
								href="edit/edit.html">编辑页面</a>
						</div>
					</li>
				</ul>
			</li>

		</ul>
	</div>
</body>
</html>
