
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="tiptext tip-warning">
        <ul class="iframe_nav">
            <li>注：<br></li>
            <li>1，景区特色，用于描述景区的主要特点，一般添加4-6个，最多可添加10个。</li>
        </ul>
	</div>
	<div class="iframe_content">
	    <div class="p_box box_info">
			<form method="post" action='/vst_back/prod/product/findProductList.do' id="searchForm">
		        <table class="s_table">
		            <tbody>
		                <tr>
		                    <td class=" operate mt10">
		                    	<a class="btn btn_cc1" data="${prodFeature.productId}" data1="${prodFeature.featureId}" id="new_button">添加</a>
		                    </td>
		                </tr>
		            </tbody>
		        </table>	
			</form>
		</div>
		<!-- 主要内容显示区域\\ -->
		<div class="p_box box_info">
		   	 <table class="p_table table_center">
		        <thead>
		            <tr>
		                <th>ID</th>
		                <th>景区特色</th>
		                <th width="350px">操作</th>
		            </tr>
		        </thead>
	            <tbody>
					<#list prodFeatures as prodFeature> 
						<tr>
							<td>${prodFeature.featureId!''} </td>
							<td>${prodFeature.featureDesc!''} </td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="edit" data="${prodFeature.productId}" data1="${prodFeature.featureId}">编辑</a>
		                        <a href="javascript:void(0);" class="delete" data="${prodFeature.productId}" data1="${prodFeature.featureId}">删除</a>
		                        <a class="moveUp" href="javascript:void(0);" data="${prodFeature.productId}" data1="${prodFeature.featureId}" <#if prodFeature_index=0> style="display:none"</#if>>向上</a> 
								<a class="moveDown" href="javascript:void(0);" data="${prodFeature.productId}" data1="${prodFeature.featureId}" <#if prodFeature_index=prodFeatures?size-1> style="display:none"</#if>>向下</a> 
		                    </td>
						</tr>
					</#list>
	            </tbody>
	        </table>
		</div>
	<!-- //主要内容显示区域 -->
	</div>
<#include "/base/foot.ftl"/>
</body>

<script>
	$(function(){
		var categorySelectDialog;
		//新建
		$("#new_button").bind("click",function(){
			var productId = $(this).attr("data");
			var featureId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodFeature/showProdFeatureInfo.do",{productId:productId,featureId:featureId},{title:"景区特色",width:900,height:300});
			return;
		});
		
		//修改
		$("a.edit").bind("click",function(){
			var productId = $(this).attr("data");
			var featureId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodFeature/showProdFeatureInfo.do",{productId:productId,featureId:featureId},{title:"景区特色",width:900,height:300});
			return false;
		});
		
		//删除
		$("a.delete").bind("click",function(){
			var featureId = $(this).attr("data1");
			$.confirm('确定是否删除?', function () {
				$.ajax({
					url : "/vst_back/singleTicket/prod/prodFeature/deleteProdFeature.do",
					type : "post",
					dataType:"JSON",
					data : {"featureId":featureId},
					success : function(result) {
						if (result.code == "success") {
							$.alert(result.message,function(){
								window.location.reload();
							});
						}else {
							$.alert(result.message);
						}
					}
				});
			});
		});
		
		//向上
		$("a.moveUp").bind("click",function(){
			var productId = $(this).attr("data");
			var featureId = $(this).attr("data1");
			var trLength = $("a.moveDown").length; 
			var $tr = $(this).parents("tr"); 
			if ($tr.index() != 0) { 
				var a = $tr.find("td:first").text(); 
				var b = $tr.prev().find("td:first").text(); 
				if(updateSeq(a,b)){ 
					$tr.prev().before($tr);  
	        		if(trLength ==2){
	        			//如果只有2条数据
	        			$tr.next().find("td:last").find(".moveUp").show(); 
	        			$tr.next().find("td:last").find(".moveDown").hide(); 
	        			$tr.find("td:last").find(".moveDown").show();
	        			$tr.find("td:last").find(".moveUp").hide();
	        		}else{
		        		if($tr.index() == 0){
		        	 		$tr.next().find("td:last").find(".moveUp").show(); 
		        	 		$tr.find("td:last").find(".moveUp").hide();
		        	 	}else if($tr.index() == trLength - 2){
		        	 		$tr.next().find("td:last").find(".moveDown").hide();
		        	 		$tr.find("td:last").find(".moveDown").show();
		        	 	}
	        		}					
				} 				
			}			
		});
		
		//向下
		$("a.moveDown").bind("click",function(){
			var productId = $(this).attr("data");
			var featureId = $(this).attr("data1");
			var trLength = $("a.moveDown").length; 
			var $tr = $(this).parents("tr"); 
			if ($tr.index() != trLength - 1) { 
				var a = $tr.find("td:first").text(); 
				var b = $tr.next().find("td:first").text(); 
				if(updateSeq(a,b)){
					$tr.next().after($tr);
	        		if(trLength ==2){
	        			//如果只有2条数据
	        			$tr.prev().find("td:last").find(".moveDown").show(); 
	        			$tr.prev().find("td:last").find(".moveUp").hide(); 
	        			$tr.find("td:last").find(".moveUp").show();
	        			$tr.find("td:last").find(".moveDown").hide();
	        		}else{
		        		if($tr.index() == 1){
		        	 		$tr.prev().find("td:last").find(".moveUp").hide();
		        	 		$tr.find("td:last").find(".moveUp").show();
		        	 	}else if($tr.index() == trLength - 1){
		        	 		$tr.prev().find("td:last").find(".moveDown").show(); 
		        	 		$tr.find("td:last").find(".moveDown").hide();
		        	 	}
	        		}										
				}
			} 
		});
		
		function updateSeq(upFeatureId,downFeatureId) { 
			//添加ajax 
			$.ajax({
				url : "/vst_back/singleTicket/prod/prodFeature/updateProdFeatureSeq.do",
				type : "post",
				dataType:"JSON",
				data : {"upFeatureId":upFeatureId,"downFeatureId":downFeatureId},
				success : function(result) {
					if (result.code == "success") {
					}else {
					}
				}
			});	
			return true;		
		}
		
	});
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>

</html>
