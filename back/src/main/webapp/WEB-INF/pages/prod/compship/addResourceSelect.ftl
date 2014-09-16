<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="http://pic.lvmama.com/min/index.php?f=/styles/v5/modules/tip.css,/styles/youlun/youlun_admin.css">
</head>
<body>
<input type="hidden" id="productId" value="${productId}">
<div class="main_all">
	<#--邮轮-->
	<div  categoryCode="category_cruise" id="category_cruise" >
	
	</div>
	<#--岸上观光-->
	<div  categoryCode="category_sightseeing" id="category_sightseeing" style="margin-top:50px">
	
	</div>
	
	<#--签证-->
	<div  categoryCode="category_visa" id="category_visa" style="margin-top:50px">
	
	</div>
	
	<#--邮轮附件项-->
	<div  categoryCode="category_cruise_addition" id="category_cruise_addition" style="margin-top:50px">
	
	</div>	
</div>
<div style="display:block;height:auto;overflow:hidden;margin:0 auto;width:230px;"> 
<a param="{'parentId':${productId},'parentType':'PROD_PRODUCT','logType':'COMPOSE_DESIGN'}" class="showLogDialog" style="float:left;display:block;width:95px;height:24px;line-height:24px;margin-top:23px;margin-left:10px;" href="javascript:void(0);">[查看操作日志]</a>
</div>
<#include "/base/foot.ftl"/>
</html>
<script type="text/javascript">
	var initLoading1 = top.pandora.loading("正在努力加载...");
	var category_cruise_load = false;
	var category_sightseeing_load = false;
	function loadReady(){
		if(category_cruise_load && category_sightseeing_load){
			initLoading1.close();
		}
	}
	$(document).ready(function(){
		var productId = $("#productId").val();
		$.get("/vst_back/ship/prod/resourceSelect/findCombOptionList.do?categoryCode=category_cruise&productId="+productId,function(result){
				$("#category_cruise").html(result);
				category_cruise_load = true;
				loadReady();
		});
		$.get("/vst_back/ship/prod/resourceSelect/findCombOptionList.do?categoryCode=category_sightseeing&productId="+productId,function(result){
				$("#category_sightseeing").html(result);
				category_sightseeing_load = true;
				loadReady();
		});
		
		$.get("/vst_back/ship/prod/resourceSelect/findCombOptionList.do?categoryCode=category_visa&productId="+productId,function(result){
				$("#category_visa").html(result);
				loadReady();
		});
		
		$.get("/vst_back/ship/prod/resourceSelect/findCombOptionList.do?categoryCode=category_cruise_addition&productId="+productId,function(result){
				$("#category_cruise_addition").html(result);
				category_sightseeing_load = true;
				loadReady();
		});		
		
	});
</script>
</body>
</html>
