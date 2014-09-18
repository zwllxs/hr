<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
<link rel="stylesheet" href="/vst_back/css/ui-panel.css">
</head>
<body>
    <!-- 顶部导航\\ -->
    <div class="pg_topbar">
        <h1 class="pg_title">添加产品</h1>
    </div>
    <!-- 边栏\\ -->
    <div class="pg_aside">
        <div class="aside_box" style="overflow-y: auto;">
            <h2 class="f16">产品维护</h2>
            <ul class="pg_list J_list">
                <li class="active"><a target="iframeMain" href='javascript:void(0);' id="product">基本信息</a>
                <input type="hidden" id="isView" value="${isView}">
                <input type="hidden" id="productId" value="${productId}">
                <input type="hidden" id="productName" value="${productName}">
                <input type="hidden" id="categoryId" value="${categoryId}">
                <input type="hidden" id="categoryName" value="${categoryName}">
                <input type="hidden" id="groupType">
                </li>
                <li class="cc1"><a target="iframeMain" href='javascript:void(0);' id="traffic">航班/车次/班次信息</a></li>
                <li class="cc1"><a target="iframeMain" href='javascript:void(0);'  id="productBranch">产品规格</a></li>
            </ul>
            <h2 class="pg_line f16">商品维护</h2>
            <ul class="pg_list J_list">           		
                <li class="cc1"><a 	target="iframeMain" href='javascript:void(0);'  id="suppGoods">商品信息</a></li>
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
	var categorySelectDialog;
	$(document).ready(function(){
	
	 var $LI = $(".J_list").find("li");
		 $IFRAME = $("#iframeMain"); 

        $LI.click(function () {
			$LI.removeClass("active"); 
			$(this).addClass("active");
			
        });
		
		checkAndJump();
		$("#product").parent("li").click(function(){
			checkAndJump();
		});
		
	});

	//产品规格
		$("#productBranch").parent("li").click(function(){
			var productId = $("#productId").val();
			var categoryId = $("#categoryId").val();
			if(productId==""){
				$.alert("请先创建产品");
				return;
			}
			//验证产品
			$.ajax({
					url : "/vst_back/prod/traffic/prodbranch/showProductBranchCheck.do?productId="+productId,
					type : "post",
					async: false,
					dataType : 'json',
					success : function(result) {
						if(result.code == "error"){
							$.alert(result.message);
						}else{
							$(".pg_title").html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("#productName").val()+"   "+"品类:"+$("#categoryName").val()+"   "+"产品ID："+$("#productId").val());
						 	$("#iframeMain").attr("src","/vst_back/prod/traffic/prodbranch/findProductBranchList.do?productId="+productId+"&categoryId="+categoryId);
						}
					},
					error : function(result) {
						$.alert(result.message);
					}
				});
		});

	//判断是修改还是添加
	function checkAndJump(){
		//判断有没有产品ID
		var productId = $("#productId").val();
		var categoryId = $("#categoryId").val();
		//打开选择品类
		if(productId==""){
			$("#iframeMain").attr("src","/vst_back/prod/traffic/showAddProduct.do?categoryId="+categoryId+"&timestamp="+Math.random(10));
		}else{
			$(".pg_title").html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("#productName").val()+"   "+"品类:"+$("#categoryName").val()+"   "+"产品ID："+$("#productId").val());
		    $("#iframeMain").attr("src","/vst_back/prod/traffic/showUpdateProduct.do?productId="+productId+"&timestamp="+Math.random(10));
		}
	}
	
	
	$("#traffic").parent("li").click(function(){
		if($("#productId").val()!=null && $("#productId").val()!=""){
			$("#iframeMain").attr("src","/vst_back/prod/traffic/findTrafficDetailList.do?prodProductId="+$("#productId").val());
		}
	});
	
	$("#suppGoods").parent("li").click(function(){
		if($("#productId").val()!=null && $("#productId").val()!=""){
			$.ajax({
				url : "/vst_back/goods/traffic/showSuppGoodsListCheck.do?productId="+$("#productId").val(),
				type : "post",
				async: false,
				dataType : 'json',
				success : function(result) {
					if(result.code == "error"){
						$.alert(result.message);
					}else{
						$(".pg_title").html("修改产品"+"&nbsp;&nbsp;&nbsp;&nbsp;"+"产品名称："+$("#productName").val()+"   "+"品类:"+$("#categoryName").val()+"   "+"产品ID："+$("#productId").val());
					 	$("#iframeMain").attr("src","/vst_back/goods/traffic/showSuppGoodsList.do?productId="+$("#productId").val());
					}
				},
				error : function(result) {
					$.alert(result.message);
				}
			});
		}
	});
	
    
</script>