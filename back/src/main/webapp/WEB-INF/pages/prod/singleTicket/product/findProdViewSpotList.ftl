
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="tiptext tip-warning">
    <ul class="iframe_nav">
        <li>注：<br></li>
        <li>1，游玩景点之间是可以排序的。<br></li>
    </ul>
</div>
	<div class="iframe_content">
	    <div class="p_box box_info">
			<form method="post" action='/vst_back/prod/product/findProductList.do' id="searchForm">
		        <table class="s_table">
		            <tbody>
		                <tr>
		                    <td class=" operate mt10">
		                    	<a class="btn btn_cc1" data="${prodViewSpot.productId}" data1="${prodViewSpot.spotId}" id="new_button">添加</a>
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
		                <th>游玩景点</th>
		                <th width="350px">操作</th>
		            </tr>
		        </thead>
	            <tbody>
					<#list prodViewSpots as prodViewSpot> 
						<tr>
							<td>${prodViewSpot.spotId!''} </td>
							<td>${prodViewSpot.spotName!''} </td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="edit" data="${prodViewSpot.productId}" data1="${prodViewSpot.spotId}">编辑</a>
		                        <a href="javascript:void(0);" class="delete" data="${prodViewSpot.productId}" data1="${prodViewSpot.spotId}">删除</a>
		                        <a class="moveUp" href="javascript:void(0);" data="${prodViewSpot.productId}" data1="${prodViewSpot.spotId}" <#if prodViewSpot_index=0> style="display:none"</#if>>向上</a> 
								<a class="moveDown" href="javascript:void(0);" data="${prodViewSpot.productId}" data1="${prodViewSpot.spotId}" <#if prodViewSpot_index=prodViewSpots?size-1> style="display:none"</#if>>向下</a>
								<a href="javascript:void(0);" class="showPhoto" data="${prodViewSpot.spotId}" parentId="${prodViewSpot.spotId}" logType="PROD_TICKET_PLAY">图片</a> 
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
			var spotId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodViewSpot/showProdViewSpotInfo.do",{productId:productId,spotId:spotId},{title:"游玩景点",width:800,height:450});
			return;
		});
		
		//修改
		$("a.edit").bind("click",function(){
			var productId = $(this).attr("data");
			var spotId = $(this).attr("data1");
			categorySelectDialog = new xDialog("/vst_back/singleTicket/prod/prodViewSpot/showProdViewSpotInfo.do",{productId:productId,spotId:spotId},{title:"游玩景点",width:800,height:450});
			return false;
		});
		
		//删除
		$("a.delete").bind("click",function(){
			var spotId = $(this).attr("data1");
			$.confirm('确定是否删除?', function () {
				$.ajax({
					url : "/vst_back/singleTicket/prod/prodViewSpot/deleteProdViewSpot.do",
					type : "post",
					dataType:"JSON",
					data : {"spotId":spotId},
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
			var spotId = $(this).attr("data1");
			
			var trLength = $("a.moveDown").length; 
			var $tr = $(this).parents("tr"); 
			if ($tr.index() != 0) { 
				var a = $tr.find("td:first").text(); 
				var b = $tr.prev().find("td:first").text(); 
				if(updateSeq(a,b)){ 
					$tr.prev().before($tr); 
					if($tr.index() == 0){ 
						$tr.next().find("td:last").find(".moveUp").show(); 
						$tr.find("td:last").find(".moveUp").hide(); 
					}else if($tr.index() == trLength - 2){ 
						$tr.next().find("td:last").find(".moveDown").hide(); 
						$tr.find("td:last").find(".moveDown").show(); 
					} 
				} 				
			}			
		});
		
		//向下
		$("a.moveDown").bind("click",function(){
			var productId = $(this).attr("data");
			var spotId = $(this).attr("data1");
			var trLength = $("a.moveDown").length; 
			var $tr = $(this).parents("tr"); 
			if ($tr.index() != trLength - 1) { 
				var a = $tr.find("td:first").text(); 
				var b = $tr.next().find("td:first").text(); 
				if(updateSeq(a,b)){
					$tr.next().after($tr); 
					if($tr.index() == 1){ 
						$tr.prev().find("td:last").find(".moveUp").hide(); 
						$tr.find("td:last").find(".moveUp").show(); 
					}else if($tr.index() == trLength - 1){ 
						$tr.prev().find("td:last").find(".moveDown").show(); 
						$tr.find("td:last").find(".moveDown").hide(); 
					} 					
				}
			} 
		});
		
		function updateSeq(upSpotId,downSpotId) { 
			//添加ajax 
			$.ajax({
				url : "/vst_back/singleTicket/prod/prodViewSpot/updateProdViewSpotSeq.do",
				type : "post",
				dataType:"JSON",
				data : {"upSpotId":upSpotId,"downSpotId":downSpotId},
				success : function(result) {
					if (result.code == "success") {
					}else {
					}
				}
			});	
			return true;		
		}
		
		// Comphoto
		$("a.showPhoto").bind("click",function(){
			var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+$(this).attr("data")+"&parentId="+$(this).attr("parentId")
					+"&objectType=TICKET_PLAY&logType="+$(this).attr("logType") + "&minNum=1&maxNum=2";
			new xDialog(url,{},{title:"图片列表",iframe:true,width:"885px",height:"1000px"});
		});
		
	});
	
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>

</html>
