<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">酒店</a> &gt;</li>
            <li><a href="#">商品维护</a> &gt;</li>
            <li class="active">供应商合同关联</li>
        </ul>
</div>
<div class="iframe_content mt10">
        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">1.酒店自签，暂不支持“现付”请勿勾选</p>
            <p class="pl15">2.当“商品名”=“规格名”时，前台只显示规格的名称</p>      
        </div>
        <div class="p_box box_info">
        <form method="post" action='/vst_back/goods/goods/findSuppGoodsList.do' id="searchForm">
            <input type="hidden" name="prodProduct.bizCategory.categoryName" value="${suppGoods.prodProduct.bizCategory.categoryName!''}">
            <input type="hidden" name="prodProduct.productId" value="${suppGoods.prodProduct.productId!''}">
           <input type="hidden" name="prodProduct.bizCategory.categoryId" value="${suppGoods.prodProduct.bizCategory.categoryId!''}">
        
            <table class="e_table form-inline">
            <tbody>             
                </tr>
                    <tr>
	                    <td width="150" class="e_label td_top"><i class="cc1">*</i>选择供应商：</td>
	                    <td class="w18" colspan='5'>
	                    <input type="hidden" name="productId" value="${suppGoods.prodProduct.productId!''}">
	                    <input type="text" placeholder="请输入供应商名称" class="w35 search" name="suppSupplier.supplierName" id="supplierName" <#if suppGoods != null && suppGoods.suppSupplier != null>value="${suppGoods.suppSupplier.supplierName}"</#if> >
                	    <input type="hidden"  name="supplierId" id="supplierId" value="${suppGoods.supplierId!''}" required=true>
                	    
	                    <!--<a class="btn btn_cc1" id="selectSupplierButton">选择供应商</a><span class="cc3">(仅针对供应商进行查询)</span>-->
	                    <a class="btn btn_cc1" id="search_button">查询供应商商品</a>
                    	<div class="cc3"> 注：下面的内容维护人员、商品默认合同，添加新商品时均为默认值。 </div></td>
                    </tr>
                    <tr>
	                    <td class="e_label td_top">内容维护人员：</td>
	                    <td class="w18" colspan='5'>
	                    
	                    <input type="text" name="contentManagerName" id="contentManagerName" class="w35 search" placeholder="请输入维护人员名称"
	                    <#if suppGoods!=null>value="${suppGoods.contentManagerName!''}"</#if> >
                    	<input type="hidden"  name="contentManagerId" id="contentManagerId"  
	                    	<#if suppGoods!=null>value="${suppGoods.contentManagerId!''}"</#if>>
	                    	<div class="cc3"> 注：后续会对其内容质量进行考核。 </div>
	                    </td>
                    </tr>
                    <tr>
	                    <td class="e_label td_top">商品默认合同：</td>
	                    <td class="w18" colspan='5'>
	                    	<label id="contractName" name="contractName"><#if suppGoods!=null && suppGoods.suppContract != null>${suppGoods.suppContract.contractName!''}</#if></label>
	                    	<input type="hidden" id="contractId" name="contractId"
	                    	<#if suppGoods!=null && suppGoods.suppContract != null>value="${suppGoods.suppContract.contractId!''}"</#if>><a id="change_button" href="#">[更改]</a></td>
                    </tr>
                    <tr>
                        <td class="e_label">所属规格：</td>
                        <td colspan='5'>
                            <select id="productBranchId" name="productBranchId">
                            	<option value=""></option>
                            	<#list prodProductBranchList as prodProductBranch>
	            					<option value="${prodProductBranch.productBranchId!''}" <#if suppGoods?? && suppGoods.prodProductBranch?? && prodProductBranch.productBranchId == suppGoods.prodProductBranch.productBranchId> selected </#if>> ${prodProductBranch.branchName!''}</option>
	                			</#list>
					        </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="e_label"></td>
                        <td><div class="fl operate"><a class="btn btn_cc1" id="new_button">添加新商品</a></div></td>
                    </tr>
                </tbody>
            </table>
        </div>
 <!-- 主要内容显示区域\\ -->        
                <#if suppGoodsMap??> 
	                <#list suppGoodsMap?keys as testKey>
	                	<#assign suppGoodsList=suppGoodsMap[testKey] >          
        
        <div class="p_box box_info">
            <div class="f16 mb10">${testKey?substring(1,testKey?last_index_of("_"))}
            <#if suppGoodsList?? && suppGoodsList?size &gt; 0> 
            <a target="iframeMain" class="f12 fb" href="/vst_back/goods/timePrice/showGoodsTimePrice.do?prodProduct.productId=${suppGoods.prodProduct.productId!''}&prodProductBranch.bizBranch.branchId=${testKey?substring(testKey?last_index_of("_")+1,testKey?length)}&suppSupplier.supplierId=${suppGoods.supplierId!''}&suppSupplier.supplierName=${suppGoods.suppSupplier.supplierName!''}">[查看/维护时间价格表]</a>
            </#if>
            </div>
            
            <table class="p_table table_center">
                <thead>
                    <tr>
                        <th>规格名</th>
                        <th>商品名称</th>
                        <th>商品编号</th>
                        <th>是否有效</th>                        
                        <th>支付对象</th>
                        <th>驴妈妈自有销售</th>
                        <th>可分销</th>
                        <th>产品经理</th>
                        <th>内容维护人员</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <#if suppGoodsList?? && suppGoodsList?size &gt; 0>
                
                	<#list suppGoodsList as suppGoods> 
						<tr>
							<td>${suppGoods.prodProductBranch.branchName!''}</td>
							<td>${suppGoods.goodsName!''} </td>
							<td>${suppGoods.suppGoodsId!''} </td>
							<td>
							<#if suppGoods.cancelFlag == "Y"> 
							<span style="color:green" class="cancelProp">有效</span>
							<#else>
							<span style="color:red" class="cancelProp">无效</span>
							</#if>
							</td>							
							<td>
								<#list payTargetList as list> 
				                    	<#if suppGoods?? && suppGoods.payTarget==list.code>${list.cnName!''}</#if>
				                </#list>
							</td>
							<td><#if suppGoods.lvmamaFlag =="Y">是<#else>否</#if></td>
							<td><#if suppGoods.distributeFlag =="Y">是<#else>否</#if></td>
							<td>${suppGoods.managerName!''} </td>
							<td>${suppGoods.contentManagerName!''} </td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp" data=${suppGoods.suppGoodsId}>编辑</a>
		                            <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${suppGoods.suppGoodsId},'objectType':'SUPP_GOODS_GOODS'}">操作日志</a> 
		                            <#if suppGoods.cancelFlag == "Y"> 
		                            <a href="javascript:void(0);" class="cancelProp" data="N" suppGoodsId=${suppGoods.suppGoodsId}>设为无效</a>
		                            <#else>
		                            <a href="javascript:void(0);" class="cancelProp" data="Y" suppGoodsId=${suppGoods.suppGoodsId}>设为有效</a>
		                            </#if>		                            
		                 	</td>
						</tr>
						</#list>
                <#else>
					<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td></tr>
		    	</#if>
		    	</tbody>
            </table>
        </div>
					</#list>
				</#if>
 </div>
<!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
//vst_pet_util.commListSuggest("#supplierName", "#supplierId","/vst_back/supp/supplier/searchSupplierList.do? '${suppJsonList}');
vst_pet_util.commListSuggest("#supplierName", "#supplierId",'/vst_back/supp/supplier/searchSupplierList.do','${suppJsonList}');
</script>


<script>
		var selectContractDialog;
		//供应商合同回调函数
		function onSelectContract(params){
			if(params!=null){
				$("#contractName").text(params.contractName);
				$("#contractId").val(params.contractId);
			}
			selectContractDialog.close();
		}
		//打开选择供应商合同列表
		$("#change_button").click(function(){
			if($("#supplierId").val()!=null && $("#supplierId").val()!=""){			
				selectContractDialog = new xDialog("/vst_back/supp/suppContract/selectContractListBySupplier.do?supplierId="+$("#supplierId").val(),{},{title:"选择供应商合同",width:"600"});

			}else{
				$.alert("请先选择供应商！");
			}
		});
		
		//查询
		$("#search_button").bind("click",function(){
		if($("#supplierId").val()!=null && $("#supplierId").val()!=""){
			$("#searchForm").submit();
		}else{
			$.alert("请先选择供应商！");
		}	
		});
		
		//新建
		$("#new_button").bind("click",function(){
			var brandSize = ${prodProductBranchList?size};
			if(brandSize == 0){
				alert("请先新建规格");
				return false;
			}
			if($("#supplierId").val()!=null && $("#supplierId").val()!=""){	
				new xDialog("/vst_back/goods/goods/showAddSuppGoods.do",{productId:$("input[name='prodProduct.productId']").val(),supplierId:$("#supplierId").val(),contractName:$("#contractName").val(),contractId:$("#contractId").val(),contentManagerId:$("#contentManagerId").val(),contentManagerName:$("#contentManagerName").val(),categoryId:$("input[name='prodProduct.bizCategory.categoryId']").val(),productBranchId:$("#productBranchId").val()},{title:"新增商品",width:800});
			}else{
				$.alert("请先选择供应商！");
			}	
		});
		
		//修改
		$("a.editProp").bind("click",function(){
		var suppGoodsId = $(this).attr("data");
		new xDialog("/vst_back/goods/goods/showUpdateSuppGoods.do",{suppGoodsId:suppGoodsId,productId:$("input[name='prodProduct.productId']").val(),supplierId:$("#supplierId").val(),contractId:$("#contractId").val(),contentManagerId:$("#contentManagerId").val(),categoryId:$("input[name='prodProduct.bizCategory.categoryId']").val(),productBranchId:$("#productBranchId").val()},{title:"编辑商品",width:800});
		});
		
		//设置为有效或无效
		$("a.cancelProp").bind("click",function(){
			var entity = $(this);
			var cancelFlag = entity.attr("data");
			var suppGoodsId = entity.attr("suppGoodsId");
			$.ajax({
				url : "/vst_back/goods/goods/cancelProduct.do",
				type : "post",
				dataType:"JSON",
				data : {"cancelFlag":cancelFlag,"suppGoodsId":suppGoodsId},
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message,function(){
						if(cancelFlag == 'N'){
							entity.attr("data","Y");
							entity.text("设为有效");
							$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
						}else if(cancelFlag == 'Y'){
							entity.attr("data","N");
							entity.text("设为无效");
							$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
						}
					});
				}else {
					$.alert(result.message);
				}
				}
			});
		});
		
		//供应商搜索

		
		
		function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	};
</script>