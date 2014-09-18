<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<link rel="stylesheet" href="/vst_back/css/ui-panel.css">
<!-- 顶部导航\\ -->
    <div class="pg_topbar">
        <h1 class="pg_title">
        	<#if promPromotion.promPromotionId??>
        		维护，促销编号(${promPromotion.promPromotionId}),促销名称:${promPromotion.title}
        	<#else>
        		新增促销
        	</#if>
        	</h1>
    </div>
    <!-- 边栏\\ -->
    <div class="pg_aside">
        <div class="aside_box">
            <h2 class="f16">促销维护</h2>
            <ul class="pg_list">
                <li>
                	<a  target="iframeMain"  href="javascript:void(0);" id="promotionInfo">基本信息</a>
                	<input type="hidden" id="promPromotionId" value="${promPromotion.promPromotionId}">
                	<input type="hidden" id="title" value="${promPromotion.title}">
                </li>
                <li>
                	<a target="iframeMain" href="javascript:void(0);" id="promotionGoods">优惠方案</a>
                	<input type="hidden" id="promResultId" value="${promResult.promResultId}">
                </li>
                <li>
                	<a target="iframeMain" href="javascript:void(0);" id="preferentialSchemes">促销商品</a>
                </li>
            </ul>
        </div>
    </div>
    <!-- //工作区 -->
<div class="pg_main">
    <iframe id="iframeMain" name="iframeMain" src="" frameborder="0" style=" height:100%; background:#fff"></iframe>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	var promotionInfoDialog;
	$(document).ready(function(){
			checkAndJump();
			$("#promotionInfo").click(function(){
				checkAndJump();
			});
			$("#promotionGoods").click(function(){
				 //促销ID
				var promPromotionId = $("#promPromotionId").val();
				var promResultId = $("#promResultId").val();
				$("#iframeMain").attr("src","/vst_back/prom/promotion/showAddPreferentialSchemes.do?promPromotionId="+promPromotionId+"&promResultId="+promResultId);
			});
			$("#preferentialSchemes").click(function(){
				//促销ID
				var promPromotionId = $("#promPromotionId").val();
				$("#iframeMain").attr("src","/vst_back/prom/promotion/showAddPromotionGoods.do?promPromotionId="+promPromotionId);
				
			});
		});
	
	function checkAndJump(){
		//促销ID
		var promPromotionId = $("#promPromotionId").val();
		//if(promPromotionId==""){
		//	promotionInfoDialog = new xDialog("/vst_back/prom/promotion/showAddPromotionInfo.do",{},{title:"添加促销",width:400,height:400});
		//}else{
			$("#iframeMain").attr("src","/vst_back/prom/promotion/showAddPromotionInfo.do?promPromotionId="+promPromotionId);
		//}
	}
	
	function refreshIframeMain(url){
		 $("#iframeMain").attr("src",url);
	}
</script>