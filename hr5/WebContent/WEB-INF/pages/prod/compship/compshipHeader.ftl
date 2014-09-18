<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_content mt10">
		<div class="p_box box_info p_line">
			<div id="price_tab" class="price_tab">
				<input type="hidden" value="${categoryId}" id="hCategoryId"/>
				<input type="hidden" id="hproductId" value="${productId}"/>
				<ul class="J_tab ui_tab">
					<li id="show1" ><a href="javascript:;">基础信息</a></li>
					<li id="show2" ><a href="javascript:;">组合设计</a></li>
					<li id="show3" ><a href="javascript:;">行程设计</a></li>
					<li id="show4" ><a href="javascript:;">航线设计</a></li>
					<li id="show5" ><a href="javascript:;">合同条款</a></li>
					<li id="show6" ><a href="javascript:;">描述信息</a></li>
					<li id="show7" ><a href="javascript:;">商品信息</a></li>
					<li id="show8">
	                	<a target="iframeMain" href='javascript:void(0);' id="showPhoto" 
	                	<#if categoryId == 11 || categoryId == 12>maxNum="5" minNum="5"</#if>>产品图片</a>
	                </li>
				</ul>
			</div>            
		</div>
		<div class="compship" id="compship">
		</div>
	</div>	
	<#include "/base/foot.ftl"/>
</body>
</html>

<script>
	
	var initLoading = top.pandora.loading("正在努力加载...");
	
	$(function(){
		var obj = $('#show1');
		showPage(obj);
	 	$("#price_tab ul li").click(function(e) {
	        showPage($(this));
	    });
	});
	
	function isNumeric(p) { 
	 if (/^[1-9]\d*$/.test(p))
	     return   true ;
	 else
	     return   false ;
	} 	
	
	function showPage(obj){
		
		$("#compship").html("");
	    var productId = $("#hproductId").val();
	    var categoryId = $('#hCategoryId').val();
		var url = ''; 
		if(productId.length<=0){
			obj = $('#show1');
		}
		
		var id = obj.attr('id');
		if(id=='show8'){
			if(productId==""){
				$.alert("请先创建产品");
				return;
			}
			var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+productId+"&parentId="+productId+"&objectType=PRODUCT_ID&logType=PROD_PRODUCT_PRODUCT_CHANGE";
			var maxNum = $(this).attr("maxNum");
			if(maxNum != null && maxNum.length > 0){
				url += "&maxNum=" + maxNum;
			}
			var minNum = $(this).attr("minNum");
			if(minNum != null && minNum.length > 0){
				url += "&minNum=" + minNum;
			}
		}else if(id=='show7'){
			url = '/vst_back/prod/compship/productInformation/showAddOrUpdateProductInformation.do?productId='+productId+'&categoryId='+categoryId;
		}else if(id=='show6'){
			url = '/vst_back/prod/compship/descinfo/showUpdateDescInfo.do?productId='+productId+'&categoryId='+categoryId;
		}else if(id=='show5'){
			url = '/vst_back/prod/product/prodContractDetail/showAddContractDetailList.do?productId='+productId+'&categoryId='+categoryId;
		}else if(id=='show4'){
			url = '/vst_back/prod/compship/routedesign/showAddRouteDesignList.do?op=update&productId='+productId+'&categoryId='+categoryId;
		}else if(id=='show3'){
			url = '/vst_back/prod/compship/travelDesign/showAddTravelDesignList.do?productId='+productId+'&categoryId='+categoryId;			
		}else if(id=='show2'){
			url = '/vst_back/ship/prod/resourceSelect/showResourceSelect.do?productId='+productId;
		}else{
			if(productId.length<=0){
				url = '/vst_back/prod/compship/baseinfo/showAddBasicInfo.do?categoryId='+categoryId;
			}else{
				url = '/vst_back/prod/compship/baseinfo/showUpdateBasicInfo.do?productId='+productId+'&categoryId='+categoryId;
			}
		}
		for(var i=1;i<=8; i++){
			$('#show'+i).attr('class','');
		}
		obj.attr('class','active');
		var iframe = "<iframe id=\"main\" class=\"iframeID\" src=\""+url+"\" width=\"1000\" height=\"300\" frameborder=\"no\" scrolling=\"auto\"/>";
		$(".compship").append(iframe);
		$("#main").load(function(){
			var srollPos=$(window).scrollTop();
			totalheight=parseFloat($(window).height()+parseFloat(srollPos));			
			var mainheight = totalheight;
			totalwidth=parseFloat($(window).width()+parseFloat(srollPos));			
			var mainwidth = totalwidth-50;
			$(this).width(mainwidth);
			$(this).height(mainheight);
		});	
	}
	
</script>
