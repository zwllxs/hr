<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../../common/head.jsp"></jsp:include> 

<HTML>
<HEAD>
    <TITLE>Top</TITLE>
    <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=utf-8" />
	<LINK TYPE="text/css" REL="stylesheet" HREF="${basePath}/res/admin/css/blue/top.css" />
</HEAD>

<BODY CLASS="PageBody" STYLE="margin: 0">

	<DIV ID="Head1">
		<DIV ID="Logo">
			<A ID="msgLink" HREF="javascript:void(0)"></A>
            <FONT COLOR="#0000CC" STYLE="color:#F1F9FE; font-size:28px; font-family:Arial Black, Arial">Itcast OA</FONT> 
			<!--<img border="0" src="style/blue/images/logo.png" />-->
        </DIV>
		
		<DIV ID="Head1Right">
			<DIV ID="Head1Right_UserName">
                <IMG BORDER="0" WIDTH="13" HEIGHT="14" SRC="${basePath}/res/admin/css/images/top/user.gif" /> 您好，<B>管理员</B>
			</DIV>
			<DIV ID="Head1Right_UserDept"></DIV>
			<DIV ID="Head1Right_UserSetup">
            	<A HREF="javascript:void(0)">
					<IMG BORDER="0" WIDTH="13" HEIGHT="14" SRC="${basePath}/res/admin/css/images/top/user_setup.gif" /> 个人设置
				</A>
			</DIV>
			<DIV ID="Head1Right_Time"></DIV>
		</DIV>
		
        <DIV ID="Head1Right_SystemButton">
            <A TARGET="_parent" HREF="${basePath}/admin/un_login.html">
				<IMG WIDTH="78" HEIGHT="20" ALT="退出系统" SRC="${basePath}/res/admin/css/blue/images/top/logout.gif" />
			</A>
        </DIV>
		
        <DIV ID="Head1Right_Button">
            <A TARGET="desktop" HREF="/desktop?method=show">
				<IMG WIDTH="65" HEIGHT="20" ALT="显示桌面" SRC="${basePath}/res/admin/css/blue/images/top/desktop.gif" />
			</A>
        </DIV>
	</DIV>
    
    <DIV ID="Head2">
        <DIV ID="Head2_Awoke">
            <UL ID="AwokeNum">
                <LI><A TARGET="desktop" HREF="javascript:void(0)">
						<IMG BORDER="0" WIDTH="11" HEIGHT="13" SRC="${basePath}/res/admin/css/images/top/msg.gif" /> 消息
						<SPAN ID="msg"></SPAN>
					</A>
				</LI>
                <LI CLASS="Line"></LI>
                <LI><A TARGET="desktop" HREF="javascript:void(0)">
						<IMG BORDER="0" WIDTH="16" HEIGHT="11" SRC="${basePath}/res/admin/css/images/top/mail.gif" /> 邮件
						<SPAN ID="mail"></SPAN>
					</A>
				</LI>
                <LI CLASS="Line"></LI>
				  <!-- 是否有待审批文档的提示1，数量 -->
                <LI><A HREF="Flow_Formflow/myTaskList.html" TARGET="desktop">
                		<IMG BORDER="0" WIDTH="12" HEIGHT="14" SRC="${basePath}/res/admin/css/images/top/wait.gif" /> 
                		待办事项（<SPAN ID="wait" CLASS="taskListSize">1</SPAN>）
                	</A>
                </LI>
				  
                <!-- 是否有待审批文档的提示2，提示审批 -->
                <LI ID="messageArea">您有 1 个待审批文档，请及时审批！★★★★★</LI>
            </UL>
        </DIV>
        
		<DIV ID="Head2_FunctionList">
			<MARQUEE STYLE="WIDTH: 100%;" ONMOUSEOVER="this.stop()" ONMOUSEOUT="this.start()" 
				SCROLLAMOUNT=1 SCROLLDELAY=30 DIRECTION=left>
				<B>这是滚动的消息</B>
			</MARQUEE>
		</DIV>
	</DIV>

</BODY>
</HTML>
