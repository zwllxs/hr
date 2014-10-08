<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../common/head.jsp"></jsp:include>

<!DOCTYPE html>
<!-- saved from url=(0040)http://www.zwllxs.icoc.cc/col.jsp?id=102 -->
<html xmlns="http://www.w3.org/1999/xhtml" class="g_html"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>中威尔软件</title>



<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Cache-Control" content="no-transform">
<meta name="renderer" content="webkit">


<link type="text/css" href="res/css/base.min.css" rel="stylesheet">
<link type="text/css" href="res/css/492.min.css" rel="stylesheet" id="templateFrame" class="templateFrameClass">





<link type="text/css" href="res/css/pattern4.min.css" rel="stylesheet">
		


<link type="text/css" href="res/css/siteGuide.min.css" rel="stylesheet">
<meta name="keywords" content="">
<meta name="description" content="">


<style id="stylemodule">
</style>
<style id="styleHeaderTop" type="text/css">
</style>
<style id="stylefooter" type="text/css">
</style>
<style id="styleWebSite" type="text/css">
</style>
<style id="stylenav" type="text/css">
#nav {top:49px;}
#nav {left:298px;}
</style>













</head>

<body class="g_body g_locale2052 ">


















	
<script language="javascript" type="text/javascript">
	function onLogout(){
		$('#topBarMsg').show();
		$('#topBarMsg').html('正在退出系统...');
		$.ajax({
			type: 'post',
			url: 'ajax/login_h.jsp?cmd=logoutMember',
			error: function(){
				alert('退出系统失败');
				$('#topBarMsg').hide();
			},
			success: function(result){
				var result = jQuery.parseJSON(result);
				if(result.success){
					top.location.href = 'index.jsp';
					return;
				}
				$('#topBarMsg').html('退出系统失败');
			}
		});
	}
</script>
<div id="memberBarArea" class="memberBarArea g_editPanel">
	<div id="arrow" class="g_arrow g_arrow_up"></div>
	<div id="memberBar" class="memberBar">
		<div class="left">

			<div style="float:left;">
				<span class="memberHello">您好，请</span>
				<a class="memberOption" href="http://www.zwllxs.icoc.cc/login.jsp">[登录]</a>
				<a class="memberOption" href="http://www.zwllxs.icoc.cc/signup.jsp">[注册]</a>
			</div>
			

		</div>

		<div id="topBarMsg" style="display:none; position:absolute; top:0; left:0; width:100%; height:100%; background:#eee; text-align:center;"></div>
	</div>
</div>

	 



	<div id="g_main" class="g_main g_col102 " style="top: 25px; width: 1263px; ">
	<div id="web" class="g_web ">
		<table class="webTopTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="webTop" class="webTop">
						
	<div id="corpTitle" class="corpTitle corpTitle2" fontpatterntitle="true" style="top:9px;left:-8px;">
		<a id="corpLink" hidefocus="true" style="text-decoration:none;">
			<div id="primaryTitle" style=" font-size:60px;font-family:微软雅黑;font-weight: bolder;color: #ffffff;pointer-events:none;">中威尔软件</div>
			<div id="subTitle" style="font-size:40px;"></div>
		</a>
	</div>

						
						
					</div>
				</td>
			</tr>
		</tbody></table>

		<table class="absTopTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="absTopForms" class="forms sideForms absForms">
						<div style="position:absolute;"></div><!-- for ie6 -->
						
					</div>
				</td>
			</tr>
		</tbody></table>
		<table class="webNavTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="webNav" class="webNav webNavDefault">
						<div id="nav" class="nav nav2">
<div class="navMainContent"><table class="navTop" cellpadding="0" cellspacing="0"><tbody><tr><td class="navTopLeft"></td><td class="navTopCenter"></td><td class="navTopRight"></td></tr></tbody></table>
<table class="navContent" cellpadding="0" cellspacing="0">
<tbody><tr>
<td class="navLeft"></td>
<td class="navCenterContent" id="navCenterContent" valign="top" align="left">
<div id="navCenter" class="navCenter" style="width: 480px; ">
<div class="itemPrev" style="display: none; "></div>
<div class="itemContainer">
<table class="item itemCol2 itemIndex1" cellpadding="0" cellspacing="0" colid="2" id="nav2" onclick="document.location.href=&quot;/&quot;" _jump="document.location.href=&quot;/&quot;">
<tbody><tr>
<td class="itemLeft"></td>
<td class="itemCenter"><a hidefocus="true" style="outline:none;" href="http://www.zwllxs.icoc.cc/" onclick="return false;"><span class="itemName0">首页</span></a></td>
<td class="itemRight"></td>
</tr>
</tbody></table>
<div class="itemSep"></div><table class="item itemCol4 itemIndex2" cellpadding="0" cellspacing="0" colid="4" id="nav4" onclick="document.location.href=&quot;/nl.jsp&quot;" _jump="document.location.href=&quot;/nl.jsp&quot;">
<tbody><tr>
<td class="itemLeft"></td>
<td class="itemCenter"><a hidefocus="true" style="outline:none;" href="http://www.zwllxs.icoc.cc/nl.jsp" onclick="return false;"><span class="itemName0">新闻动态</span></a></td>
<td class="itemRight"></td>
</tr>
</tbody></table>
<div class="itemSep"></div><table class="item itemCol102 itemIndex3 itemSelected itemSelectedIndex3" cellpadding="0" cellspacing="0" colid="102" id="nav102" onclick="document.location.href=&quot;/col.jsp?id=102&quot;" _jump="document.location.href=&quot;/col.jsp?id=102&quot;">
<tbody><tr>
<td class="itemLeft"></td>
<td class="itemCenter"><a hidefocus="true" style="outline:none;" href="res/css/中威尔软件_联系我们.htm" onclick="return false;"><span class="itemName0">联系我们</span></a></td>
<td class="itemRight"></td>
</tr>
</tbody></table>
<div class="itemSep"></div><table class="item itemCol101 itemIndex4" cellpadding="0" cellspacing="0" colid="101" id="nav101" onclick="document.location.href=&quot;/col.jsp?id=101&quot;" _jump="document.location.href=&quot;/col.jsp?id=101&quot;">
<tbody><tr>
<td class="itemLeft"></td>
<td class="itemCenter"><a hidefocus="true" style="outline:none;" href="http://www.zwllxs.icoc.cc/col.jsp?id=101" onclick="return false;"><span class="itemName0">关于我们</span></a></td>
<td class="itemRight"></td>
</tr>
</tbody></table>
<div class="itemSep"></div><table class="item itemCol9 itemIndex5" cellpadding="0" cellspacing="0" colid="9" id="nav9" onclick="document.location.href=&quot;/msgBoard.jsp&quot;" _jump="document.location.href=&quot;/msgBoard.jsp&quot;">
<tbody><tr>
<td class="itemLeft"></td>
<td class="itemCenter"><a hidefocus="true" style="outline:none;" href="http://www.zwllxs.icoc.cc/msgBoard.jsp" onclick="return false;"><span class="itemName0">留言板</span></a></td>
<td class="itemRight"></td>
</tr>
</tbody></table>
</div>
<div class="itemNext" style="display: none; "></div>
</div>
</td>
<td class="navRight"></td>
</tr>
</tbody></table>
<table class="navBottom" cellpadding="0" cellspacing="0"><tbody><tr><td class="navBottomLeft"></td><td class="navBottomCenter"></td><td class="navBottomRight"></td></tr></tbody></table>
</div>
</div>

					</div>
				</td>
			</tr>
		</tbody></table>
		<table class="webHeaderTable" cellpadding="0" cellspacing="0" id="webHeaderTable">
			<tbody><tr>
				<td align="center" class="webHeaderTd">
					<div id="webHeader" class="webHeader">
						<table class="headerTable" cellpadding="0" cellspacing="0">
							<tbody><tr>
								<td class="headerCusLeft"></td>
								<td class="headerCusMiddle" align="center" valign="top">
									<div class="headerNav">
								
									</div>
								</td>
								<td class="headerCusRight"></td>
							</tr>
						</tbody></table>
					</div>
				</td>
			</tr>
		</tbody></table>

		<table class="webBannerTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="webBanner" class="webBanner" style="">
						<table class="bannerTable" cellpadding="0" cellspacing="0">
							<tbody><tr>
								<td class="bannerLeft"></td>
								<td class="bannerCenter" align="center" valign="top">
									<div class="bannerTop"></div>
<div id="banner" class="banner" style=""></div>

									
								</td>
								<td class="bannerRight"></td>
							</tr>
						</tbody></table>
					</div>
				</td>
			</tr>
		</tbody></table>

		<table class="absMiddleTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="absForms" class="forms sideForms absForms">
						
					</div>
				</td>
			</tr>
		</tbody></table>

		<table class="webContainerTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="webContainer" class="webContainer">
						<div id="container" class="container">
	<table class="containerTop" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td class="left"></td>
			<td class="center"></td>
			<td class="right"></td>
		</tr>
	</tbody></table>

	<table class="containerMiddle" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td id="containerMiddleLeft" class="containerMiddleLeft">
					
					
					
					
			</td>

			<td class="containerMiddleCenter">
				<div id="containerMiddleCenterTop" class="containerMiddleCenterTop">
					
				</div>

				<div id="containerForms" class="containerForms">
					<div id="topForms" class="column forms mainForms topForms" style="display:none">
						
					</div>

					<table class="containerFormsMiddle" cellpadding="0" cellspacing="0">
						<tbody><tr>
							<td valign="top" id="containerFormsLeft" class="containerFormsLeft">
								<div class="containerFormsLeftTop">
								</div>
								<div id="leftForms" class="column forms sideForms leftForms">
									<div id="module333" _indexclass="formIndex1" class="form form333 formIndex1 formStyle40" title="" style="" _side="0" _intab="0" _inmulmcol="0" _autoheight="1" _global="true" _independent="false">
<table class="formTop formTop333" cellpadding="0" cellspacing="0"><tbody><tr><td class="left"></td><td class="center"></td><td class="right"></td></tr></tbody></table>
<table class="formBanner formBanner333" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="left left333"></td>
<td class="center center333" valign="top">
<table cellpadding="0" cellspacing="0" class="formBannerTitle formBannerTitle333"><tbody><tr>
<td class="titleLeft titleLeft333" valign="top">
</td>
<td class="titleCenter titleCenter333" valign="top">
<div class="titleText titleText333"><span>
在线客服</span></div>
</td>
<td class="titleRight titleRight333" valign="top">
</td>
</tr></tbody></table>
</td>
<td class="right right333"></td>
</tr></tbody></table>
<table class="formMiddle formMiddle333" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="formMiddleLeft formMiddleLeft333"></td>
<td class="formMiddleCenter formMiddleCenter333" valign="top">
<div class="formMiddleContent formMiddleContent333  ">
<div id="serOnline-container333" class="serOnline-container"><div class="serOnline-service"><div class="serOnline-list-v lineH-21 "><a hidefocus="true" href="http://wpa.qq.com/msgrd?v=3&uin=100000&site=qq&menu=yes" target="_blank"><span class="serOnline-img qqImg">&nbsp;</span>客服一</a></div><div class="serOnline-list-v lineH-21 lastData"><a hidefocus="true" href="http://wpa.qq.com/msgrd?v=3&uin=100000&site=qq&menu=yes" target="_blank"><span class="serOnline-img qqImg">&nbsp;</span>客服一</a></div></div><div class="serOnline-separation-line g_separator"></div><div class="serOnline-worktime"><div class="marBL-10"><span class="worktime-header-img">&nbsp;</span><span style="font-size:15px;"><b>工作时间</b></span></div><div class="serOnline-list-v "><span>周一至周五 ：8:30-17:30</span></div><div class="serOnline-list-v lastData"><span>周六至周日 ：9:00-17:00</span></div></div><div class="serOnline-separation-line g_separator"></div><div class="serOnline-contact"><div class="marBL-10"><span class="contact-header-img">&nbsp;</span><span style="font-size:15px;"><b>联系方式</b></span></div><div class="serOnline-list-v"><span>陈经理：13000000000</span></div></div></div></div>
</td>
<td class="formMiddleRight formMiddleRight333"></td>
</tr></tbody></table>
<table class="formBottom formBottom333" cellpadding="0" cellspacing="0"><tbody><tr><td class="left left333"></td><td class="center center333"></td><td class="right right333"></td></tr></tbody></table>
<div class="clearfloat clearfloat333"></div>
</div>


								</div>
								<div class="containerFormsLeftBottom">
								</div>
							</td>

							<td valign="top" id="containerFormsCenter" class="containerFormsCenter">
					
								<div id="centerTopForms" class="column forms mainForms centerTopForms">
									<div id="module323" _indexclass="formIndex1" class="form form323 formIndex1 formStyle18 modulePattern modulePattern73" title="" style="" _side="0" _intab="0" _inmulmcol="0" _autoheight="1" _global="false" _independent="false">
<table class="formTop formTop323" cellpadding="0" cellspacing="0"><tbody><tr><td class="left"></td><td class="center"></td><td class="right"></td></tr></tbody></table>
<table class="formBanner formBanner323" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="left left323"></td>
<td class="center center323" valign="top">
<table cellpadding="0" cellspacing="0" class="formBannerTitle formBannerTitle323"><tbody><tr>
<td class="titleLeft titleLeft323" valign="top">
</td>
<td class="titleCenter titleCenter323" valign="top">
<div class="titleText titleText323"><span>
联系我们</span></div>
</td>
<td class="titleRight titleRight323" valign="top">
</td>
</tr></tbody></table>
</td>
<td class="right right323"></td>
</tr></tbody></table>
<table class="formMiddle formMiddle323" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="formMiddleLeft formMiddleLeft323"></td>
<td class="formMiddleCenter formMiddleCenter323" valign="top">
<div id="moduleLoading323" class="ajaxLoading2" style="width: 730px; height: 304px; display: none; "></div><div class="formMiddleContent formMiddleContent323  " style="display: block; ">
<iframe id="mapframe323" name="mapframe" frameborder="0" scrolling="no" height="300" width="600" src="res/css/mapPanel.htm"></iframe></div>
</td>
<td class="formMiddleRight formMiddleRight323"></td>
</tr></tbody></table>
<table class="formBottom formBottom323" cellpadding="0" cellspacing="0"><tbody><tr><td class="left left323"></td><td class="center center323"></td><td class="right right323"></td></tr></tbody></table>
<div class="clearfloat clearfloat323"></div>
</div>


								</div>
								<div class="containerFormsCenterMiddle">
									<div id="middleLeftForms" class="column forms mainForms middleLeftForms" style="display:none">
									
									</div>
									<div id="middleRightForms" class="column forms mainForms middleRightForms" style="display:none">
									
									</div>	
								</div>
								<div id="centerBottomForms" class="column forms mainForms centerBottomForms" style="display:none">
									
								</div>
							</td>

							<td valign="top" id="containerFormsRight" class="containerFormsRight" style="display:none">
								<div class="containerFormsRightTop">
								</div>
								<div id="rightForms" class="column forms sideForms rightForms">
									
								</div>
								<div class="containerFormsRightBottom">
								</div>
							</td>
						</tr>
					</tbody></table>

					<div id="bottomForms" class="column forms mainForms bottomForms" style="display:none">
						
					</div>

					<div id="containerPlaceholder" class="containerPlaceholder"></div>
					
				</div>

				<div id="containerMiddleCenterBottom" class="containerMiddleCenterBottom">
				</div>

			</td>

			<td id="containerMiddleRight" class="containerMiddleRight"></td>
		</tr>
	</tbody></table>
	
	<table class="containerBottom" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td class="left"></td>
			<td class="center"></td>
			<td class="right"></td>
		</tr>
	</tbody></table>
</div>

					</div>
				</td>
			</tr>
		</tbody></table>		

		<table class="absBottomTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center">
					<div id="absBottomForms" class="forms sideForms absForms">
						<div style="position:absolute;"></div><!-- for ie6 -->
						
					</div>
				</td>
			</tr>
		</tbody></table>

		<table id="webFooterTable" class="webFooterTable" cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td align="center" valign="top">
					<div id="webFooter" class="webFooter">
						



<div id="footer" class="footer" style="">
	<table class="footerTop" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td class="topLeft"></td>
			<td class="topCenter"></td>
			<td class="topRight"></td>
		</tr>
	</tbody></table>
	<table class="footerMiddle" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td class="middleLeft"></td>
			<td class="middleCenter" align="center">
				<div class="footerContent">

					<div id="footerNav" class="footerNav">
<span class="footerNavItem" id="footer2"><a hidefocus="true" href="http://www.zwllxs.icoc.cc/">首页</a></span>
<span class="footerSep">|</span>
<span class="footerNavItem" id="footer101"><a hidefocus="true" href="http://www.zwllxs.icoc.cc/col.jsp?id=101">关于我们</a></span>
<span class="footerSep">|</span>
<span class="footerNavItem" id="footer102"><a hidefocus="true" href="res/css/中威尔软件_联系我们.htm">联系我们</a></span>

					</div>

					<div class="footerInfo">
						<font face="Arial">©</font>2014&nbsp;中威尔软件&nbsp;版权所有
					</div>

					<div class="footerSupport">

<span class="footerFaisco">技术支持：<a hidefocus="true" href="http://www.faisco.com/?_ta=4" onclick="Site.logDog(100065, 0);" target="_blank">凡科网</a></span>
<span class="footerSep">|</span>
<span class="footerMobile"><a hidefocus="true" href="http://m.zwllxs.icoc.cc/" target="_blank">手机版</a></span>
<span class="footerSep">|</span>
<span id="footerLogin" class="footerLogin"><a name="popupLogin" hidefocus="true" href="javascript:;" onclick="Site.popupLogin(&quot;http://www.faisco.cn&quot;,4185468);Fai.closeTip(&quot;#footerLogin&quot;);return false;">管理登录</a></span>

						<span class="bgplayerButton" id="bgplayerButton" style="display:none;"></span>
					</div>
					
					
					
				</div>
			</td>
			<td class="middleRight"></td>
		</tr>
	</tbody></table>
	<table class="footerBottom" cellpadding="0" cellspacing="0">
		<tbody><tr valign="top">
			<td class="bottomLeft"></td>
			<td class="bottomCenter"></td>
			<td class="bottomRight"></td>
		</tr>
	</tbody></table>	

</div>

						
					</div>
				</td>
			</tr>
		</tbody></table>

		<div class="clearfloat"></div>
	</div>	
</div>

	<!-- 左下角广告-->
	
<div class="siteAdvertisement_box" style="">
	<div class="siteAdvertisement_Inner">
		<div class="siteAdvertisement_title">
			<a class="reportUrl" href="http://www.faisco.com/ts.html?t=3&a=zwllxs" target="_blank">举报</a>
			<a class="closeImg" href="javascript:void(0)"></a>
		</div>
	

		<a class="siteAdvertisement_adImg" target="_blank" href="http://www.faisco.com/?_ta=4"><img src="res/images/faisco_ad.jpg" width="125" height="125" alt="轻松建网站"></a>
	</div>
	<a class="freeJZ" href="http://www.faisco.com/?_ta=4" target="_blank"><span>免费建站</span></a>

</div>





<div class="floatLeftTop" style="top: 25px; ">
	<div id="floatLeftTopForms" class="forms sideForms floatForms">
		
	</div>
</div>
<div class="floatRightTop" style="top: 25px; ">
	<div id="floatRightTopForms" class="forms sideForms floatForms">
		
	</div>
</div>
<div class="floatLeftBottom">
	<div id="floatLeftBottomForms" class="forms sideForms floatForms">
		
	</div>
</div>
<div class="floatRightBottom">
	<div id="floatRightBottomForms" class="forms sideForms floatForms">
		<div id="module37" _indexclass="formIndex1" class="form  formIndex1 formStyle67" title="" style="position: absolute; top: -376px; left: 0px; width: 180px; overflow: visible; " _side="1" _intab="0" _inmulmcol="0" _autoheight="1" _global="true" _independent="false">
<table class="formTop formTop37" cellpadding="0" cellspacing="0"><tbody><tr><td class="left"></td><td class="center"></td><td class="right"></td></tr></tbody></table>
<table class="formBanner formBanner37" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="left left37"></td>
<td class="center center37" valign="top">
<table cellpadding="0" cellspacing="0" class="formBannerTitle formBannerTitle37"><tbody><tr>
<td class="titleLeft titleLeft37" valign="top">
</td>
<td class="titleCenter titleCenter37" valign="top">
<div class="titleText titleText37"><span>
分享网站</span></div>
</td>
<td class="titleRight titleRight37" valign="top">
</td>
</tr></tbody></table>
<div class="formBannerOther formBannerOther37">
<div class="formBannerBtn formBannerBtn37">
<div class="btns"><a hidefocus="true" href="javascript:;" onclick="Site.closeAd(&quot;module37&quot;);return false;" class="aclose"><span class="g_close"></span></a></div></div>
</div>
</td>
<td class="right right37"></td>
</tr></tbody></table>
<table class="formMiddle formMiddle37" cellpadding="0" cellspacing="0"><tbody><tr>
<td class="formMiddleLeft formMiddleLeft37"></td>
<td class="formMiddleCenter formMiddleCenter37" valign="top">
<div class="formMiddleContent formMiddleContent37  ">
<div class="shareInfo"><div class="shareCtrl shareNotTitlePanel shareMt"><a hidefocus="true" title="分享到腾讯微博" href="javascript:;" onclick="window.open(&quot;http://v.t.qq.com/share/share.php?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon qq_weibo"></div><div class="shareCtrl">腾讯微博</div></a><a hidefocus="true" title="分享到复制网址" href="javascript:;" onclick="Site.copyWebSite(&#39;http://www.zwllxs.icoc.cc&#39;)"><div class="shareIcon copy"></div><div class="shareCtrl">复制网址</div></a><a hidefocus="true" title="分享到新浪微博" href="javascript:;" onclick="window.open(&quot;http://service.weibo.com/share/share.php?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon sina_weibo"></div><div class="shareCtrl">新浪微博</div></a><a hidefocus="true" title="分享到QQ空间" href="javascript:;" onclick="window.open(&quot;http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon qq_zone"></div><div class="shareCtrl">QQ空间</div></a><a hidefocus="true" title="分享到开心网" href="javascript:;" onclick="window.open(&quot;http://www.kaixin001.com/repaste/share.php?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon kaixin001"></div><div class="shareCtrl">开心网</div></a><a hidefocus="true" title="分享到人人网" href="javascript:;" onclick="window.open(&quot;http://share.renren.com/share/buttonshare.do?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon renren"></div><div class="shareCtrl">人人网</div></a><a hidefocus="true" title="分享到豆瓣网" href="javascript:;" onclick="window.open(&quot;http://shuo.douban.com/!service/share?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon douban"></div><div class="shareCtrl">豆瓣网</div></a><a hidefocus="true" title="分享到淘江湖" href="javascript:;" onclick="window.open(&quot;http://share.jianghu.taobao.com/share/addShare.htm?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon taojianghu"></div><div class="shareCtrl">淘江湖</div></a><a hidefocus="true" title="分享到搜狐微博" href="javascript:;" onclick="window.open(&quot;http://t.sohu.com/third/post.jsp?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon sohu_weibo"></div><div class="shareCtrl">搜狐微博</div></a><a hidefocus="true" title="分享到网易微博" href="javascript:;" onclick="window.open(&quot;http://t.163.com/article/user/checkLogin.do?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon netease_weibo"></div><div class="shareCtrl">网易微博</div></a><a hidefocus="true" title="分享到百度空间" href="javascript:;" onclick="window.open(&quot;http://apps.hi.baidu.com/share/?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon baidu_hi"></div><div class="shareCtrl">百度空间</div></a><a hidefocus="true" title="分享到百度贴吧" href="javascript:;" onclick="window.open(&quot;http://tieba.baidu.com/i/app/open_share_api?title=%E4%B8%AD%E5%A8%81%E5%B0%94%E8%BD%AF%E4%BB%B6&amp;url=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&amp;site=http%3A%2F%2Fwww.zwllxs.icoc.cc%2F%3F_sc%3D1&quot;)"><div class="shareIcon baidu_tieba"></div><div class="shareCtrl">百度贴吧</div></a></div><div class="clearfloat"></div></div></div>
</td>
<td class="formMiddleRight formMiddleRight37"></td>
</tr></tbody></table>
<table class="formBottom formBottom37" cellpadding="0" cellspacing="0"><tbody><tr><td class="left left37"></td><td class="center center37"></td><td class="right right37"></td></tr></tbody></table>
<div class="clearfloat clearfloat37"></div>
<div id="module37SideBtn" class="g_sideBtn" style="top: 47px; left: -25px; "><div class="g_sideBtn_t g_sB_rt"></div><div class="g_sideBtn_c g_sB_rc"><span class="g_sideBtn_tl">
分享网站</span></div><div class="g_sideBtn_b g_sB_rb"></div><div class="g_sideBtn_extend g_sB_re"></div></div></div>


	</div>
</div>







	

	<div id="bgMusic" class="bgMusic">
	
	</div>
	


<script type="text/javascript" src="res/css/jquery-core.min.js"></script>
<script type="text/javascript" src="res/css/jquery-mousewheel.min.js"></script>
<script type="text/javascript" src="res/css/fai.min.js"></script>
<script type="text/javascript" src="res/css/jquery-ui-core.min.js"></script>
<script type="text/javascript" src="res/css/site.min.js"></script>
<script type="text/javascript" src="res/css/2052.min.js"></script>
<script type="text/javascript" src="res/css/ZeroClipboard.min.js"></script>






<script type="text/javascript">
Fai.top = window;
var bgmCloseToOpen = false;
window.onerror = function() {
	if (typeof Site == 'undefined') {
		alert('您的网页未加载完成，请尝试按“CTRL+功能键F5”重新加载。');
	}
};
var _colOtherStyleData = {"y":0,"h":0,"independentList":[],"layout4Width":0};						// 当前页面的数据    
var _templateOtherStyleData = {"h":480,"independentList":[],"y":0,"layout4Width":0};						// 全局的数据   
$(function() {
	if(false){
		Fai.ing("",true);
	}
	//topBarMember 
	
	
	// 管理态下, QQ/微博登陆 禁止登陆
	if( _manageMode ) {
		$('#memberBar .l_Btn').click(function(){
			Fai.ing('您目前处于网站管理状态，请先点击网站右上方的“退出”后再登录会员。', true);
		});
		//绑定放大镜遮罩效果事件
		Site.bindEventToOverLayer();
		
		
		
	}
	
	
	
	
	var faiscoAd = $.cookie('faiscoAd',{path:'/'});
	
	if( true && faiscoAd !== "false" ){
		$(".siteAdvertisement_box").show();
	}
	
	

	
	
	
	
	// 绑定退出事件
	$(window).bind("beforeunload", function(e) { 

		 
			if(bgmCloseToOpen){
				Site.bgmFlushContinue();
			}	
	
	
	
	
		
	});
	

	Site.initTemplateLayout(1, true);

	// spider统计
	

	
	// ajax统计
	Site.total({colId:102, pdId:-1, ndId:-1, sc:0, rf:"http://www.zwllxs.icoc.cc/nl.jsp"});
	Site.colLayout4Width();
	Site.initBanner({"_open":false}, {"_open":false}, 0);

Site.initModuleBdMap('mapframe',323,'mapPanel.jsp?id=323&w=', false);


	


	Site.initPage();	// 这个要放在最后，因为模块组初始化时会把一些模块隐藏，导致没有高度，所以要放最后执行

	
	
	
	setTimeout("afterModuleLoaded()", 0);

	if (!_oem && _manageMode) {
		Site.siteGuideInit();
		if( false ){
			$.cookie('_loadedRegStatIframe',true,{ expires: 2 });
		}
	}
	
});

function afterModuleLoaded() {
	Site.initPage2();


} // afterModuleLoaded end

var _portalHost = 'www.faisco.cn';

var _lcid = 2052;
var _userHostName = 'www.zwllxs.icoc.cc';
var _siteDomain = 'http://www.zwllxs.icoc.cc';
var _signupDays = 0;
var _cid = 4185468;
var _resRoot = 'http://0.ss.faidns.com';
var _colId = 102;
var _extId = 0;
var _fromColId = -1;
var _designAuth = false;
var _manageMode = false;
var _oem = false;
var _siteAuth = 0;
var _adm = false;
var _siteVer = 10;
var _manageStatus = false;

var nav2SubMenu=[];
var nav4SubMenu=[];
var nav102SubMenu=[];
var nav101SubMenu=[];
var nav9SubMenu=[];





var _aid = 4185468;

</script>







</body></html>