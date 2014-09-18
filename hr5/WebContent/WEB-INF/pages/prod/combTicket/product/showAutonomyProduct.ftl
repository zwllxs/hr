<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="iframe_content mt10">
		<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>注：产品创建后，不能变更所属的品类</div>
		<form id="dataForm">
			<input type="hidden" name="productId" id="productId" value="${productId!''}">
			<input type="hidden" name="categoryId" value="${categoryId}">
			<input type="hidden" id="logContent" value="${logContent}">
			<div class="p_box box_info">
	            <table class="e_table form-inline">
	                <tbody>
	                    <tr>
	                        <td width="90" class="e_label td_top"><i class="cc1">*</i>组合套餐：</td>
	                        <td>
								<table class="e_table form-inline" id="suppGoodsList" >
								 	<tr>
										<td width="200">产品名称</td>												 	
										<td width="200">商品名称</td>												 	
										<td width="100">成人数/儿童数</td>												 	
										<td width="200">价格模式</td>												 	
										<td width="80">打包数量</td>												 	
										<td width="60">操作</td>												 	
								 	</tr>
								 	<#if prodPackageGroup??>
								 		<input type="hidden" name="groupId" id="groupId" value="${prodPackageGroup.groupId}">
									 	<#if prodPackageGroup.prodPackageDetails??  && prodPackageGroup.prodPackageDetails?size &gt; 0>
									 		<#assign index=0> 
									 		<#list prodPackageGroup.prodPackageDetails as prodPackageDetail>
											 	<tr id="${prodPackageDetail.detailId}">
											 		<input type="hidden" value="${prodPackageDetail.suppGoods.prodProduct.productName}" name="productNames"/>
													<td>${prodPackageDetail.suppGoods.prodProduct.productName}</td>												 	
													<td>${prodPackageDetail.suppGoods.goodsName}</td>												 	
													<td>${prodPackageDetail.suppGoods.adult}/${prodPackageDetail.suppGoods.child}</td>												 	
													<td>
														<input type="hidden" value="${prodPackageDetail.detailId}" name="detailIds"/>
														<select class="MAKEUP_PRICE" detailId="${prodPackageDetail.detailId}" id="priceTypes${prodPackageDetail.detailId}" style="width:100px;">
															<#if prodPackageDetail.priceType=='MAKEUP_PRICE'>
																<option value="FIXED_PRICE">固定加价</option>
																<option selected="selected" value="MAKEUP_PRICE">百分比加价</option>
															<#else>
																<option selected="selected" value="FIXED_PRICE">固定加价</option>
																<option value="MAKEUP_PRICE">百分比加价</option>
															</#if>
														</select>
														<input type="text" style="width:100px;" value="${prodPackageDetail.priceYuan?string("0.##")}" name="prices${prodPackageDetail.detailId}" errorEle="code${prodPackageDetail.detailId}" id="prices${prodPackageDetail.detailId}" required/>
														<#if prodPackageDetail.priceType=='MAKEUP_PRICE'>
															<div id="showMakeupPrice${prodPackageDetail.detailId}">%</div>
														<#else>
															<div id="showMakeupPrice${prodPackageDetail.detailId}" style="display:none;">%</div>
														</#if>
														<div id="code${prodPackageDetail.detailId}Error" style="display:inline"></div>
													</td>												 	
													<td>
														<select id="packageCounts${prodPackageDetail.detailId}" style="width:50px;">
															<#assign packageCount=10> 
															<#list 1..packageCount as pCount>
																<#if prodPackageDetail.packageCount==pCount>
																	<option value="${pCount!''}" selected="selected">${pCount}</option>
															    <#else>
															    	<option value="${pCount}" <#if i==pCount>selected="selected"</#if> >${pCount}</option>
																</#if>
															</#list>																			
														</select>
													</td>												 	
													<td>
														<a class='delDetail' href='javascript:void(0);' data="${prodPackageDetail.detailId}" onclick="delSuppGoodsDetail(this);">删除</a>
													</td>												 	
											 	</tr>
											 	<#assign index=index+1> 											 			
									 		</#list>
									 	</#if>	
								 	</#if>										 	
								 </table>									                        
	                        </td>
	                    </tr>
	             </table>
                 <table class="e_table form-inline">
                    <tr>
                    	<td class="operate mt10"><a id="showAdd" href="javascript:void(0);" data="${productId}" class="btn btn_cc1">添加组合商品</a></td>
                        <td class="">
                        </td>
                    </tr>	                    
                    <tr height="50px;">
                        <td class="operate mt10">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所属分公司：
                        	<select name="filiale" id="filiale" required>
								<option value="">请选择</option>
							  	<#list filiales as filiale>
							  		<option value="${filiale.code}" <#if prodPackageGroup?? && prodPackageGroup.prodProduct?? && (prodPackageGroup.prodProduct.filiale == filiale.code) >selected</#if>>${filiale.cnName}</option>
							  	</#list>
						  	</select>
						 </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="operate mt10">
                        	组合产品设计人员：
                        	<input type="text" class="w35" <#if prodPackageGroup?? && prodPackageGroup.prodProduct??> value="${prodPackageGroup.prodProduct.managerName}" </#if> name="managerName" id="managerName" required>
                        </td>
                        <td>
							<input type="hidden" <#if prodPackageGroup?? && prodPackageGroup.prodProduct??> value="${prodPackageGroup.prodProduct.managerId}" </#if> name="managerId" id="managerId">	                        
                        </td>
                    </tr>
	            </table>
	        </div>
		</form>
	</div>
	<div class="fl operate" style="margin:20px;">
		<a class="btn btn_cc1" href="javascript:void(0);" id="saveOrUpdate">保存</a>
	</div>
	
	<form id="saveForm">
		
	</form>
	
	<#include "/base/foot.ftl"/>
</body>
</html>
<script>

	vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
	var showAddSuppGoodsDialog;
	
	$(function(){
		
	   $('.MAKEUP_PRICE').live('change',function(){
	   		var data = $(this).attr('detailId');
	   		var showMakeupPrice = $(this).val();
	   		if(showMakeupPrice=='MAKEUP_PRICE'){
	   			$('#showMakeupPrice'+data).show();
	   		}else{
	   			$('#showMakeupPrice'+data).hide();
	   		}
	   });
		
		
	   function createItem(name,value){
	     	$("#saveForm").append('<input type=hidden name='+name+' value='+value+'>');
	   }
		
		// 验证正整数
		var rq = /^[0-9]*[1-9][0-9]*$/;
		
		// 添加组合商品信息
		$('#showAdd').bind('click',function(){
			var productId = $(this).attr('data');
			showAddSuppGoodsDialog = new xDialog("/vst_back/combTicket/prod/product/autonomy/showAddAutonomySuppGoods.do?productId="+productId,{},{title:"添加商品",iframe:true,width:1000,height:800});
			return;
		});
		
		// 保存或修改打包信息
		$("#saveOrUpdate").bind('click',function(){
			
			var size = $('#suppGoodsList').find('tr').size();
			if(size<=1){
				$.alert('请添加组合商品!!');
				return;
			}
			
			$("#saveForm").empty();
			
			if(!$("#dataForm").validate({
				rules : {
				},
				messages : {
				}
			}).form()){
				$(this).removeAttr("disabled");
				return false;
			}			
			
			// 构造表单
			$('input[type=hidden][name=detailIds]').each(function(){
				 var id = $(this).val();
				 var priceType = $('#priceTypes'+id).val();
				 createItem('priceTypes',priceType);		
				 var price = $('#prices'+id).val(); 
				 createItem('prices',Math.round(parseFloat(price)*100));
				 var packageCount = $('#packageCounts'+id).val();
				 createItem('packageCounts',packageCount);
				 createItem('detailIds',id);
			});
			$("#saveForm").append($('input[type=hidden][name=categoryId]')); 
			var filiale = $('#filiale').val();
			createItem('filiale',filiale);
			var productId = $('#productId').val();
			createItem('productId',productId);
			var managerId = $('#managerId').val();
			createItem('managerId',managerId);
			var managerName = $('#managerName').val();
			createItem('managerName',managerName);
			var logContent = $('#logContent').val();		
			//遮罩层
	    	var loading = top.pandora.loading("正在努力保存中...");		
			$.ajax({
				url : "/vst_back/combTicket/prod/product/autonomy/updateProdPackageDetail.do",
				type : "post",
				data : $("#saveForm").serialize()+"&logContent="+logContent,
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						$.alert(result.message,function(){
							window.location.reload();
						});
					}else {
						$.alert(result.message);
					}
				},error:function(){ 
	                loading.close();
	            }
			});
		});		
	});
	
	// 删除组合商品信息
	function delSuppGoodsDetail(obj){
		var detailId = $(obj).attr('data');
		var productId = $('#productId').val();
		$.confirm('确定是否删除?', function () {
			$.ajax({
				url : "/vst_back/combTicket/prod/product/autonomy/deleteProdPackageDetail.do",
				type : "post",
				dataType:"JSON",
				data:{'detailId':detailId,productId:productId},
				success : function(result) {
					if (result.code == "success") {
						$.alert(result.message,function(){
							$('#'+detailId).remove();
						});
					}else {
						$.alert(result.message);
					}
				}
			});
		});		
	}
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a,.delDetail").remove();
	}
</script>