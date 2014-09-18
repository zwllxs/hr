<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>驴妈妈旅游网后台管理系统</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link rel="stylesheet" href="/vst_back/css/ui-common.css">
<link rel="stylesheet" href="/vst_back/css/ui-components.css">
<link rel="stylesheet" href="/vst_back/css/ui-panel.css">
</head>
<body>
<!-- 顶部导航\\ -->
<div class="topbar">
	<a class="logo" href="/panel/"><h1>驴妈妈业务系统<small>业务系统</small></h1></a>
    <p class="top_list">
    	<a href="#">新增任务</a> |
    	<a href="#">我的公告</a> |
        <a href="#">我的任务</a> |
        <a href="#">我的消息</a>
    </p>
	<p>操作员：<span>chenlinjun</span> / <span>陈琳君</span>　[<a class="B" href="">修改密码</a>]　[<a class="B" href="">退出系统</a>]</p>
</div><!-- //顶部导航 -->

<!-- 边栏\\ -->
<div id="panel_aside" class="panel_aside">
	<span id="oper_aside" class="icon-arrow-left"></span>
    <span id="oper_set" class="icon-set"></span>
	<div class="aside_box">
		<ul id="aside_list" class="aside_list ul_oper_list">
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/category/findCategoryList.do"><span class="icon-tag"></span> 品类管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/prod/product/findProductList.do"><span class="icon-tag"></span> 产品管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/goods/house/findHouseControlProductList.do"><span class="icon-tag"></span> 房态管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/category/findBizPropPoolList.do"><span class="icon-tag"></span> 属性池管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/dict/findDictDefList.do"><span class="icon-tag"></span> 字典定义管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/dict/findDictList.do"><span class="icon-tag"></span> 字典管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/districtSign/findDistrictSignList.do"><span class="icon-tag"></span>地理位置管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/district/findDistrictList.do"><span class="icon-tag"></span>行政区管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/biz/dest/findDestList.do"><span class="icon-tag"></span>目的地管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/front/destAround/findDestList.do"><span class="icon-tag"></span>第2目的地管理</a></li>
            <li class="oper_item"><a target="iframeMain" href="/vst_back/front/destAdvertising/findDestList.do"><span class="icon-tag"></span>目的地广告管理</a></li> 
            <li class="oper_item"><a target="iframeMain" href="/vst_back/pet/smsSend/testSendSms.do"><span class="icon-tag"></span> 短信测试</a></li> 
            <li class="oper_item"><a target="iframeMain" href="/vst_back/pet/emailSend/testSendEmail.do"><span class="icon-tag"></span> 邮件测试</a></li> 
            <li class="oper_item"><a target="iframeMain" href="/vst_back/pet/uploadFile/testUploadFile.do"><span class="icon-tag"></span> 文件上传测试</a></li> 
            <li class="oper_item"><a target="iframeMain" href="/vst_back/supp/suppContract/findSupplierContractList.do"><span class="icon-tag"></span>合同管理</a></li> 
            <li class="oper_item"><a target="iframeMain" href="/vst_back/supp/suppContractCheck/findSupplierContractCheckList.do"><span class="icon-tag"></span>供应商合同管理</a></li> 
			<li class="oper_item"><a target="iframeMain" href="/vst_back/biz/seoLink/findSeoLinkList.do?seoType=DISTRICT"><span class="icon-tag"></span>seo管理</a></li>
			<li class="oper_item"><a target="iframeMain" href="/vst_back/ship/shipCompany/findShipCompanyList.do"><span class="icon-tag"></span>邮轮公司管理</a></li>
			<li class="oper_item"><a target="iframeMain" href="/vst_back/insurance/InsurCatRule/findInsurCatRuleList.do"><span class="icon-tag"></span>保险配置规则管理</a></li>
			<li class="oper_item"><a target="iframeMain" href="/vst_back/biz/orderRequired/showOrderRequired.do"><span class="icon-tag"></span>下单必添项</a></li>
			<li class="oper_item"><a target="iframeMain" href="/vst_back/ebooking/userManager/findEbookingSupplierList.do?permId=6475"><span class="icon-tag"></span>EBK门票绑定</a></li>
		</ul><!-- //ul aside_list -->
	</div>
</div><!-- //边栏 -->
<div id="panel_control" class="panel_control"></div>
<!-- 工作区\\ -->
<div id="panel_main" class="panel_main">
	<iframe id="iframeMain" name="iframeMain" src="" frameborder="0" style=" height:100%; background:#fff"></iframe>
	<div class="scoll-mask"></div>
</div><!-- //工作区 -->


<!-- 底部\\ -->
<div class="footer"></div><!-- //底部 -->
<script src="http://pic.lvmama.com/js/new_v/jquery-1.7.min.js"></script>
<script src="/vst_back/js/panel-custom.js"></script>
<script>
	
</script>

</body>
</html>
