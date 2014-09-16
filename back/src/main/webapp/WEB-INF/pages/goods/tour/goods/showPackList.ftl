<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_content mt10" style="width:1020px;height:500px;">
<#assign routeNum = '' />
<#assign stayNum = '' />
<#if prodProduct.prodLineRoute ?? >
	<#assign routeNum=prodProduct.prodLineRoute.routeNum />
	<#assign stayNum=prodProduct.prodLineRoute.stayNum />
</#if>
<input type="hidden" id = "productId" name="productId" value="${productId }"/>
<input type="hidden" id = "groupId" name="groupId" />

<form action="" method="post" id="dataForm">
			<div class="p_box box_info p_line" style="border:solid 1px #aaa">
	            <div class="box_content">
	                <table class="e_table form-inline" style="width: 1017px" >
	                    <tbody>
		                <tr style="background-color:#E4E4E4">
		                	<td class="e_label" width="20px" style="font-weight:bold;text-align: left">酒店</td>
		                	<td class="e_label" width="10px" style="font-weight:bold;text-align: left">
		                		行程：${routeNum}天${ stayNum}晚
		                	</td>
		                	<td class="e_label" width="20px" style="text-align: right"><a class="btn btn_cc1" onclick="addGroup('${categoryId}')" selectCategoryId="${categoryId}">插入时间段</a></td>
		                </tr>
	                	</tbody>
	                </table>
	            </div>
	            <div style="overflow-y:scroll;height: 300px;">
	                <table  style="width: 1000px">
	                    <tbody>
	                     <#if packGroupList?? >
	    						<#list packGroupList as packGroup> 
	    							<#if packGroup?? && packGroup.prodPackageGroupHotel??>
	    								<tr>
						                	<td   style="font-weight:bold;text-align: left;width:300px">
						                		第${packGroup.prodPackageGroupHotel.stayDays?substring(0,1)}晚——第 ${packGroup.prodPackageGroupHotel.stayDays?substring(packGroup.prodPackageGroupHotel.stayDays?length - 1,packGroup.prodPackageGroupHotel.stayDays?length) } 晚 【备注：${packGroup.prodPackageGroupHotel.remark}】
						                	</td>
						                	<td  style="text-align: right">
						                		<a class="btn btn_cc1" onclick="addProductBranch()" >新增房型</a>
						                		<a class="btn btn_cc1" onclick="selectPackGroupProductBranch('${packGroup.groupId }','${categoryId}')" >选择未归组商品</a>
												<a class="btn btn_cc1" onclick="deletePackGroup('${packGroup.groupId }')">删除该段</a>
						                	</td>
						                </tr>
						                <tr>
						                	<td colspan="2">
											  <div class="p_box box_info">
											    <table class="p_table table_center" style="width: 1000px">
									                <thead>
									                	<tr>
									                    <th>商品编号</th>
									                    <th>酒店名称</th>
									                    <th>商品</th>
									                    <th>商品是否有效</th>
									                    <th>操作</th>
									                    </tr>
									                </thead>
									                 <tbody>
															<#list packGroup.prodPackageDetails as detail> 
																<#if detail?? && detail.suppGoods??>
																	<tr>
																		<td>${detail.suppGoods.suppGoodsId!''} </td>
																		<td>${detail.hotelName!''}</td>
																		<td>${detail.suppGoods.goodsName!''}</td>
																		<td>
																			<#if detail.suppGoods.cancelFlag =='Y'>
																				有效
																			</#if>
																			<#if detail.suppGoods.cancelFlag =='N'>
																				无效
																			</#if>
																		</td>
																		<td>
																			<a style="cursor:pointer" onclick="updatePackGroupDetail('${detail.suppGoods.productBranchId}')">编辑</a>
																			<a href="javascript:void(0);" class="editFlag"  data=${detail.suppGoods.suppGoodsId!''} data2="${detail.suppGoods.cancelFlag}">${(detail.suppGoods.cancelFlag=='N')?string("商品设为有效", "商品设为无效")}</a>
																		</td>
																	</tr>
																	</#if>
															</#list>
										                </tbody>
									               </table>
									               </div>
						                	</td>
						                </tr>						                
	    							</#if>
	    							
	    						 </#list>
				         </#if>
				         
				         
	                	</tbody>
	                </table>
	            </div>
	            
	             <!-- 未归组商品 -->
           <div style="overflow-y:scroll;height: 400px;">
               <table  style="width: 784px">
                   <tbody>
                    	<tr>
		                	<td  style="font-weight:bold;text-align: left;width:300px">
		                		未归组商品
		                	</td>
		                </tr>
		                <tr>
		                	<td >
							  <div class="p_box box_info">
							    <table class="p_table table_center" style="width: 1000px">
					                <thead>
					                    <th>商品编号</th>
					                    <th>酒店名称</th>
					                    <th>商品</th>
					                    <th>商品是否有效</th>
					                    <th>操作</th>
					                    </tr>
					                </thead>
					                 <tbody> <#if unPackList??>
											<#list unPackList as unChangedHotel> 
												<tr>
													<td>${unChangedHotel.suppGoodsId!''} </td>
													<td>${unChangedHotel.hotelName!''}</td>
													<td>${unChangedHotel.suppGoodsName!''}</td>
													<td>
														<#if unChangedHotel.cancelFlag =='Y'>
															有效
														<#else>
															无效
														</#if>
													</td>
													<td>
														<a style="cursor:pointer" onclick="updatePackGroupDetail('${unChangedHotel.productBranchId}')">编辑</a>
														<a href="javascript:void(0);" class="editFlag" data=${unChangedHotel.suppGoodsId!''} data2="${unChangedHotel.cancelFlag}">${(unChangedHotel.cancelFlag=='N')?string("商品设为有效", "商品设为无效")}</a>
													</td>
												</tr>
											</#list> </#if>
						                </tbody>
					               </table>
					               </div>
		                	</td>
		                </tr>						                
               	</tbody>
               </table>
           </div>
           <!-- 未归组结束 -->
	        </div>
</form>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var addGroupDialog, selectProductDialog;
function addGroup(categoryId){
	var url = "/vst_back/productPack/line/showAddGroup.do?groupType=CHANGE"  + "&productId=" + $("#productId").val();
	url += "&selectCategoryId=" + categoryId ;
	addGroupDialog = new xDialog(url,{},{title:"插入时间段",iframe:true,width:"500",height:"180"});
} 

//设为有效/无效
$("a.editFlag").bind("click",function(){
	 var suppGoodsId = $(this).attr("data");
	 var cancelFlag = $(this).attr("data2") == "N" ? "Y": "N";
	 var msg = cancelFlag == "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
	 	$.get("/vst_back/packageTour/prod/prodbranch/editSuppGoodsFlag.do?suppGoodsId="+suppGoodsId+"&cancelFlag="+cancelFlag, function(result){
	   		confirmAndRefresh(result);
	    });
	 });
});

//关联规格与产品或者商品
function onSavePackGroupDetail(params){
	selectProductDialog.close();
	window.location.reload();
}

/**
 * 加入产品规格
 */
function selectPackGroupProductBranch(groupId,selectCategoryId){
	var groupType = $(window.parent.document).find("#groupType").val();
	var categoryParentId = $("#categoryParentId").val();
	
	var url = "/vst_back/productPack/line/showSelectChangedHotelProductList.do?groupType=CHANGE" + "&groupId=" + groupId  
		+ "&productId=" + $("#productId").val()
		+ "&selectCategoryId=" + selectCategoryId;
	if(groupType != 'HOTEL'){
		url += "&categoryParentId=" + categoryParentId;
	}
	selectProductDialog = new xDialog(url,{},{title:"选择产品",iframe:true,width:"600",height:"600"});
}

function deletePackGroup(groupId){
	$.confirm("确认删除吗 ？",function(){
		var loading = top.pandora.loading("正在努力中...");
		$.ajax({
			url : "/vst_back/productPack/line/deletePackGroup.do",
			type : "post",
			dataType : 'json',
			data : "groupId=" + groupId + "&groupType=CHANGE",
			success : function(result) {
				loading.close();
				if(result.code == "success"){
					window.location.reload();
				}
			},
			error : function(result) {
				loading.close();
				$.alert(result.message);
			}
		});
	});
}

//保存时间段
var groupId = '';
function onSavePackGroup(params){
	 if(params != null){
		groupId = params.groupId;
		var groupType = params.groupType;
		if(groupType == 'HOTEL'){
			$("#categoryParentId").val();
		}
	} 
	addGroupDialog.close();
	window.location.reload();
}

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			window.location.reload();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			$.alert(result.message);
		}});
	}
}

var saveDialog;
function updatePackGroupDetail(productBranchId){
	var branchId = '${branchId!''}'; 
	var productId = '${productId!''}';
	var mainProdBranchId = '${mainProdBranchId!''}';
	saveDialog = new xDialog("/vst_back/packageTour/prod/prodbranch/showAddProductBranchTab.do",
		{"productBranchId":productBranchId, "mainProdBranchId":mainProdBranchId, "branchId":branchId, "productId":productId}, {title:"编辑产品规格",width:1000})
}

function addProductBranch(){
	var branchId = '${branchId!''}'; 
	var productId = '${productId!''}';
	var mainProdBranchId = '${mainProdBranchId!''}';
	saveDialog = new xDialog("/vst_back/packageTour/prod/prodbranch/showAddProductBranchTab.do",
		{"mainProdBranchId":mainProdBranchId, "branchId":branchId, "productId":productId}, {title:"编辑产品规格",width:1000})
}

function onUpdatePackGroupDetail(){
	saveDialog.close();
	window.location.reload();
}

function reload() {
	saveDialog.close();
	window.location.reload();
};
</script>