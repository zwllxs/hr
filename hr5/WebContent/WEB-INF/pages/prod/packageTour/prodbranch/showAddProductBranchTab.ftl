<div class="iframe_content mt10">
	<div class="p_box box_info p_line">
		<div id="brand_tab" class="price_tab">
			<input type="hidden" id="productId" value="${productId}"/>
			<input type="hidden" id="branchId" value="${branchId}"/>
			<input type="hidden" id="productBranchId" value="${productBranchId}"/>
			<input type="hidden" id="mainProdBranchId" value="${mainProdBranchId}"/>
			<input type="hidden" id="branchCode" value="${bizBranch.branchCode}"/>
			<ul class="J_tab ui_tab">
				<li id="show1" ><a href="javascript:;">${bizBranch.branchName}信息</a></li>
				<li id="show2" ><a href="javascript:;">销售信息</a></li>
			</ul>
		</div>            
	</div>
	<div class="detailInfo" id="detailInfo">
	</div>
</div>

<script>
	$(function(){
		var obj = $('#show1');
		showPage(obj);
	 	$("#brand_tab ul li").click(function(e) {
	 		var productBranchId = $('#productBranchId').val();
	 		//判断产品规格是已经维护
			if($(this).attr('id')=='show2' && productBranchId==""){
				$.alert("请先维护产品规格");
				return;
			}
	        showPage($(this));
	    });
	});
	 
	function showPage(obj){
		$("#detailInfo").html("");
	    var productId = $("#productId").val();
	    var branchId = $('#branchId').val();
	    var productBranchId = $('#productBranchId').val();
	    var mainProdBranchId = $('#mainProdBranchId').val();
	    var branchCode = $('#branchCode').val();
	    
		var url = ''; 
		if(productId.length<=0){
			obj = $('#show1');
		}
		var id = obj.attr('id');
		if(id=='show1'){
			url = '/vst_back/packageTour/prod/prodbranch/showAddProductBranch.do?productId='+productId+"&branchId="+branchId+"&productBranchId="+productBranchId+"&mainProdBranchId="+mainProdBranchId;
		}else if(id=='show2'){
			url = '/vst_back/tour/goods/goods/showUpdateSuppGoods.do?branchId='+productBranchId;
		}
		for(var i=1;i<=2; i++){
			$('#show'+i).attr('class','');
		}
		obj.attr('class','active');
		var iframe = "<iframe id=\"main\" class=\"iframeID\" src=\""+url+"\" style=\"overflow-x:scroll; overflow-y:scroll;\" width=\"920\" height=\"300\" frameborder=\"no\" scrolling=\"auto\"/>";
		$(".detailInfo").append(iframe);
		$("#main").load(function(){
			var srollPos=$(window).scrollTop();
			var mainheight;
			totalheight = parseFloat($(window).height()+parseFloat(srollPos));	
			if(branchCode == 'addition' ){
				//mainheight = 420;
			}else if(branchCode == 'changed_hotel'){
				mainheight = 500;
			}else{
				mainheight = 350;
			}
			//totalwidth=parseFloat($(window).width()+parseFloat(srollPos));			
			//var mainwidth = totalwidth - 400;
			
			$(this).width(920);
			$(this).height(mainheight);
		});	
	}
	
</script>	