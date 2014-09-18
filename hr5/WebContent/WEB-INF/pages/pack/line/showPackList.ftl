<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">${categoryName !''}</a> &gt;</li>
            <li><a href="#">自主打包</a> &gt;</li>
            <li><a href="#">组合打包</a> </li>
        </ul>
</div>
<div class="iframe_content mt10">
<div class="tiptext tip-warning"><span class="tip-icon tip-icon-warning"></span>
<#if groupType == 'HOTEL'>
注：选择有预付商品的产品，前台仅调取预付商品<br/>
 注：前台购买，每个区间段，必须且仅可购买一个规格的商品……若是用户可选是否要，请在“运营>关联销售”里面维护。<br/>
 注：新增酒店的时间段，需要注意其是否已经添加了与之入住晚有交集的线路产品
<#elseif groupType == 'LINE'>
注：选择有预付商品的产品，前台仅调取预付商品。<br/>
  注：前台购买，每个区间段，必须且仅可购买一个规格的商品……若是用户可选是否要，请在“运营>关联销售”里面维护。<br/>
  注：新增线路的时间段，需要注意其是否已经添加了与之入住晚有交集的酒店产品<br/>
  注：选择线路产品，同一个时间段里面的线路产品，行程天数、入住晚数，需要完全一致<br/>
  注：自由行、跟团游，一个时间段里面只能有一个产品。主要为了用户前台的交互体验
<#elseif  groupType == 'LINE_TICKET'>
 注：选择有预付商品的产品，前台仅调取预付商品。<br/>
  注：前台购买，每个区间段，必须且仅可购买一个规格的商品……若是用户可选是否要，请在“运营>关联销售”里面维护。<br/>
<#elseif  groupType == 'TRANSPROT'>
 注：选择有预付商品的产品，前台仅调取预付商品。<br/>
 注：前台购买，每个区间段，必须且仅可购买一个规格的商品……若是用户可选是否要，请在“运营>关联销售”里面维护。<br/>
</#if>
  </div><br/>
<#assign routeNum = '' />
<#assign stayNum = '' />
<#if prodProduct.prodLineRoute ?? >
	<#assign routeNum=prodProduct.prodLineRoute.routeNum />
	<#assign stayNum=prodProduct.prodLineRoute.stayNum />
</#if>
<input type="hidden" id = "groupType" name="groupType" value="${groupType }"/>
<input type="hidden" id = "productId" name="productId" value="${productId }"/>
<input type="hidden" id = "groupId" name="groupId" />
<input type="hidden" id = "routeNum" name="routeNum" value="${routeNum }" />
<input type="hidden" id = "stayNum" name="stayNum" value="${stayNum }" />
<input type="hidden" id = "categoryParentId" name="categoryParentId" value="${categoryParentId }"/>
<input type="hidden" id = "selectParentCategoryFlag" name="selectParentCategoryFlag" value="${selectParentCategoryFlag }"/>

<form action="" method="post" id="dataForm">
	 <#if selectCategoryList??>
	 	<#list selectCategoryList as bizCategory> 
	 		<#if bizCategory.categoryCode!='category_traffic' && bizCategory.categoryCode !='category_comb_ticket'>
			<div class="p_box box_info p_line" style="border:solid 1px #aaa">
	            <div class="box_content">
	                <table class="e_table form-inline" style="width: 1054px" >
	                    <tbody>
		                <tr style="background-color:#E4E4E4">
		                	<td class="e_label" width="20px" style="font-weight:bold;text-align: left">
		                		${bizCategory.categoryName}
		                		<#if bizCategory.categoryId == 1>
		                			-[指定区间日期，不可选]
		                		<#elseif bizCategory.categoryId ==16 || bizCategory.categoryId ==11 || bizCategory.categoryId ==12 || bizCategory.categoryId ==13>
		                			-[区间日期，可选]
		                		<#elseif bizCategory.categoryId ==16>
		                			-[区间日期，可选]
		                		<#else>
		                			-[指定日，不可选]
		                		</#if>
		                	</td>
		                	<td class="e_label" width="10px" style="font-weight:bold;text-align: center">
		                		行程天数：${routeNum}天${ stayNum}晚
		                	</td>
		                	<td class="e_label" width="20px" style="text-align: right;"><a class="btn btn_cc1"  onclick="addGroup('${bizCategory.categoryId}')" selectCategoryId="${bizCategory.categoryId}">插入时间段</a></td>
		                </tr>
	                	</tbody>
	                </table>
	            </div>
	            <div >
	            </#if>
	                <table  style="width: 1054px">
	                    <tbody>
	                     <#if packGroupList?? && groupType??>
	                     	<#if groupType == 'HOTEL'>
	    						<#list packGroupList as packGroup> 
	    							<#if packGroup?? && packGroup.prodPackageGroupHotel??>
	    								<tr >
						                	<td  style="font-weight:bold;text-align: left;width:700px">
						                		第${packGroup.prodPackageGroupHotel.stayDays?substring(0,1)}晚——第 ${packGroup.prodPackageGroupHotel.stayDays?substring(packGroup.prodPackageGroupHotel.stayDays?length - 1,packGroup.prodPackageGroupHotel.stayDays?length) } 晚 【备注：${packGroup.prodPackageGroupHotel.remark}】
						                	</td>
						                	<td  style="text-align: right">
						                		<a class="btn btn_cc1" onclick="selectPackGroupProductBranch('${packGroup.groupId }','${bizCategory.categoryId}')" >选择产品</a>
												<a class="btn btn_cc1" onclick="deletePackGroup('${packGroup.groupId }')">删除该段</a>
						                	</td>
						                </tr>
						                <tr>
						                	<td colspan="2">
											  <div class="p_box box_info">
											    <table class="p_table table_center" style="width: 1055px">
									                <thead>
									                    <th>产品类型</th>
									                    <th>产品ID</th>
									                    <th>产品名称</th>
									                    <th>行政区划</th>
									                    <th>规格ID</th>
									                    <th>规格</th>
									                    <th>销售价规则</th>
									                    <th>操作</th>
									                    </tr>
									                </thead>
									                 <tbody>
															<#list packGroup.prodPackageDetails as detail> 
																<#if detail?? && detail.prodProductBranch??>
																	<tr>
																		<td >${detail.prodProductBranch.categoryName!''}</td>
																		<td>${detail.prodProductBranch.productId!''}</td>
																		<td>
																			<a style="cursor:pointer" 
																				onclick="openProduct(${detail.prodProductBranch.productId!''},${detail.prodProductBranch.categoryId!''},'${detail.prodProductBranch.categoryName!''}')">
																				${detail.prodProductBranch.productName!''}
																			</a>
																		</td>
																		<td>${detail.prodProductBranch.districtName!''}</td>
																		<td>${detail.prodProductBranch.productBranchId!''}</td>
																		<td>${detail.prodProductBranch.branchName!''}</td>
																		<td>
																			<#if detail.priceType?? && detail.priceType == 'FIXED_PRICE'>
																				加价：${detail.price/100}
																			</#if>
																			<#if detail.priceType?? && detail.priceType == 'MAKEUP_PRICE'>
																				利润：${detail.price/100}%
																			</#if>
																			</td>
																		<td>
																			<a id="setPriceRule" style="cursor:pointer" onclick="updatePackGroupDetail('${detail.detailId !''}')">设置价格规则</a>
																			<a id="deletePackGroupDetail" style="cursor:pointer" onclick="deletePackGroupDetail('${detail.detailId !''}')">取消打包</a>
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
					          <!-- 线路 -->
					          <#if groupType == 'LINE' >
	    						<#list packGroupList as packGroup>
	    							<#if packGroup ?? && packGroup.prodPackageGroupLine??>
	    								<#if packGroup.categoryId ?? && packGroup.categoryId == bizCategory.categoryId>
	    								<tr>
						                	<td style="font-weight:bold;text-align: left;width:700px">
						                		第&nbsp;${packGroup.prodPackageGroupLine.startDay}&nbsp;天
						                		 ${packGroup.prodPackageGroupLine.travelDays}天 ${packGroup.prodPackageGroupLine.stayDays}晚 
						                	【备注：${packGroup.prodPackageGroupLine.remark}】
						                	</td>
						                	<td style="text-align: right">
						                		<a class="btn btn_cc1" onclick="selectPackGroupProductBranch('${packGroup.groupId }','${bizCategory.categoryId}')" >选择产品</a>
												<a class="btn btn_cc1" onclick="deletePackGroup('${packGroup.groupId }')">删除该段</a>
						                	</td>
						                </tr>
						                <tr>
						                	<td colspan="2">
											  <div class="p_box box_info">
											    <table class="p_table table_center" style="width: 1054px">
									                <thead>
									                    <th>产品类型</th>
									                    <th>产品ID</th>
									                    <th>产品名称</th>
									                    <th>规格ID</th>
									                    <th>规格</th>
									                    <th>销售价规则</th>
									                    <th>操作</th>
									                    </tr>
									                </thead>
									                 	<#if packGroup.prodPackageDetails ??>
															<#list packGroup.prodPackageDetails as detail> 
																<#if detail?? && detail.prodProductBranch??>
																	<tr >
																		<td >${detail.prodProductBranch.categoryName!''}</td>
																		<td>${detail.prodProductBranch.productId!''}</td>
																		<td>
																			<a style="cursor:pointer" 
																				onclick="openProduct(${detail.prodProductBranch.productId!''},${detail.prodProductBranch.categoryId!''},'${detail.prodProductBranch.categoryName!''}')">
																				${detail.prodProductBranch.productName!''}
																			</a>
																		</td>
																		<td>${detail.prodProductBranch.productBranchId!''}</td>
																		<td>${detail.prodProductBranch.branchName!''}</td>
																		<td>
																			<#if detail.priceType?? && detail.priceType == 'FIXED_PRICE'>
																				加价：${detail.price/100}
																			</#if>
																			<#if detail.priceType?? && detail.priceType == 'MAKEUP_PRICE'>
																				利润：${detail.price/100}%
																			</#if>
																			</td>
																		<td>
																			<a id="setPriceRule" style="cursor:pointer" onclick="updatePackGroupDetail('${detail.detailId !''}')">设置价格规则</a>
																			<a id="deletePackGroupDetail" style="cursor:pointer" onclick="deletePackGroupDetail('${detail.detailId !''}')">取消打包</a>
																		</td>
																	</tr>
																</#if>
																
															</#list>
														  </#if>
										                </tbody>
									               </table>
									            </div>
						                	</td>
						                </tr>
						                </#if>
	    							</#if>
	    						 </#list>
					          </#if>
					          <!-- 线路结束 -->
					          <!-- 门票开始 -->
					          <#if groupType == 'LINE_TICKET' >
	    						<#list packGroupList as packGroup>
	    							<#if packGroup ?? && packGroup.prodPackageGroupTicket??>
	    								<#if packGroup.categoryId ?? && packGroup.categoryId == bizCategory.categoryId>
	    								<tr>
						                	<td  style="font-weight:bold;text-align: left;width:700px">
						                		第&nbsp;${packGroup.prodPackageGroupTicket.startDay}&nbsp;天 
						                	【备注：${packGroup.prodPackageGroupTicket.remark}】
						                	</td>
						                	<td style="text-align: right">
						                		<a class="btn btn_cc1" onclick="selectPackGroupProductBranch('${packGroup.groupId }','${bizCategory.categoryId}')" >选择产品</a>
												<a class="btn btn_cc1" onclick="deletePackGroup('${packGroup.groupId }')">删除该段</a>
						                	</td>
						                </tr>
						                <tr>
						                	<td colspan="2">
											  <div class="p_box box_info">
											    <table class="p_table table_center" style="width: 1054px">
									                <thead>
									                    <th>产品类型</th>
									                    <th>产品ID</th>
									                    <th>产品名称</th>
									                    <th>规格ID</th>
									                    <th>规格</th>
									                    <th>销售价规则</th>
									                    <th>操作</th>
									                    </tr>
									                </thead>
									                 	<#if packGroup.prodPackageDetails ??>
															<#list packGroup.prodPackageDetails as detail> 
																<#if detail?? && detail.prodProductBranch??>
																	<tr >
																		<td >${detail.prodProductBranch.categoryName!''}</td>
																		<td>${detail.prodProductBranch.productId!''}</td>
																		<td>																		
																			<a style="cursor:pointer" 
																				onclick="openProduct(${detail.prodProductBranch.productId!''},${detail.prodProductBranch.categoryId!''},'${detail.prodProductBranch.categoryName!''}')">
																				${detail.prodProductBranch.productName!''}
																			</a>
																		</td>
																		<td>${detail.prodProductBranch.productBranchId!''}</td>
																		<td>${detail.prodProductBranch.branchName!''}</td>
																		<td>
																			<#if detail.priceType?? && detail.priceType == 'FIXED_PRICE'>
																				加价：${detail.price/100}
																			</#if>
																			<#if detail.priceType?? && detail.priceType == 'MAKEUP_PRICE'>
																				利润：${detail.price/100}%
																			</#if>
																			</td>
																		<td>
																			<a id="setPriceRule" style="cursor:pointer" onclick="updatePackGroupDetail('${detail.detailId !''}')">设置价格规则</a>
																			<a id="deletePackGroupDetail" style="cursor:pointer" onclick="deletePackGroupDetail('${detail.detailId !''}')">取消打包</a>
																		</td>
																	</tr>
																</#if>
																
															</#list>
														  </#if>
										                </tbody>
									               </table>
									            </div>
						                	</td>
						                </tr>
						                </#if>
	    							</#if>
	    						 </#list>
					          </#if>	
					          <!-- 门票结束 -->
					          <!-- 大交通开始 -->
					          <#if groupType == 'TRANSPORT' >
	    						<#list packGroupList as packGroup>
	    							<#if packGroup ?? && packGroup.prodPackageGroupTicket??>
	    								<#if packGroup.categoryId ?? && packGroup.categoryId == bizCategory.categoryId>
	    								<tr>
						                	<td  style="font-weight:bold;text-align: left;width:700px">
						                		第&nbsp;${packGroup.prodPackageGroupTicket.startDay}&nbsp;天 
						                	【备注：${packGroup.prodPackageGroupTicket.remark}】
						                	</td>
						                	<td style="text-align: right">
						                		<a class="btn btn_cc1" onclick="selectPackGroupProductBranch('${packGroup.groupId }','${bizCategory.categoryId}')" >选择产品</a>
												<a class="btn btn_cc1" onclick="deletePackGroup('${packGroup.groupId }')">删除该段</a>
						                	</td>
						                </tr>
						                <tr>
						                	<td colspan="2">
											  <div class="p_box box_info">
											    <table class="p_table table_center" style="width: 1054px">
									                <thead>
									                    <th>产品类型</th>
									                    <th>产品ID</th>
									                    <th>产品名称</th>
									                    <th>规格ID</th>
									                    <th>规格</th>
									                    <th>销售价规则</th>
									                    <th>操作</th>
									                    </tr>
									                </thead>
									                 	<#if packGroup.prodPackageDetails ??>
															<#list packGroup.prodPackageDetails as detail> 
																<#if detail?? && detail.prodProductBranch??>
																	<tr >
																		<td >${detail.prodProductBranch.categoryName!''}</td>
																		<td>${detail.prodProductBranch.productId!''}</td>
																		<td>																		
																			<a style="cursor:pointer" 
																				onclick="openProduct(${detail.prodProductBranch.productId!''},${detail.prodProductBranch.categoryId!''},'${detail.prodProductBranch.categoryName!''}')">
																				${detail.prodProductBranch.productName!''}
																			</a>
																		</td>
																		<td>${detail.prodProductBranch.productBranchId!''}</td>
																		<td>${detail.prodProductBranch.branchName!''}</td>
																		<td>
																			<#if detail.priceType?? && detail.priceType == 'FIXED_PRICE'>
																				加价：${detail.price/100}
																			</#if>
																			<#if detail.priceType?? && detail.priceType == 'MAKEUP_PRICE'>
																				利润：${detail.price/100}%
																			</#if>
																			</td>
																		<td>
																			<a id="setPriceRule" style="cursor:pointer" onclick="updatePackGroupDetail('${detail.detailId !''}')">设置价格规则</a>
																			<a id="deletePackGroupDetail" style="cursor:pointer" onclick="deletePackGroupDetail('${detail.detailId !''}')">取消打包</a>
																		</td>
																	</tr>
																</#if>
																
															</#list>
														  </#if>
										                </tbody>
									               </table>
									            </div>
						                	</td>
						                </tr>
						                </#if>
						                <!-- 大交通结束 -->
	    							</#if>
	    						 </#list>
					          </#if>	
				         </#if>
	                	</tbody>
	                </table>
	            </div>
	        </div>
        </#list>
	</#if>
</form>
<div class="fl operate"><a href="javascript:void(0);"  class="showLogDialog btn btn_cc1" param="{'objectId':${productId},'objectType':'PROD_PRODUCT_PRODUCT_GROUP'}">操作日志</a></div>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var addGroupDialog, selectProductDialog,updateGroupDetailDialog;
function addGroup(selectCategoryId){
	var url = "/vst_back/productPack/line/showAddGroup.do?groupType=" +  $("#groupType").val() + "&productId=" + $("#productId").val();
	url += "&selectCategoryId=" + selectCategoryId + "&routeNum=" + $("#routeNum").val() + "&stayNum=" + $("#stayNum").val();
	addGroupDialog = new xDialog(url,{},{title:"新增组",iframe:true,width:"600",height:"600"});
} 

//取消打包
function deletePackGroupDetail(detailId){
	$.confirm("确认取消吗 ？",function(){
		var loading = top.pandora.loading("正在努力中...");
		$.ajax({
			url : "/vst_back/productPack/line/deletePackGroupDetail.do",
			type : "post",
			dataType : 'json',
			data : "detailId=" + detailId+ "&productId=" + $("#productId").val(),
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

/**
 * 加入产品规格
 */
function selectPackGroupProductBranch(groupId,selectCategoryId){
	var groupType = $(window.parent.document).find("#groupType").val();
	var categoryParentId = $("#categoryParentId").val();
	
	var url = "/vst_back/productPack/line/showSelectProductList.do?groupType=" + groupType + "&groupId=" + groupId  
		+ "&selectParentCategoryFlag=" + $("#selectParentCategoryFlag").val()
		+ "&selectCategoryId=" + selectCategoryId;
	if(groupType != 'HOTEL'){
		url += "&categoryParentId=" + categoryParentId;
	}
	selectProductDialog = new xDialog(url,{},{title:"选择产品",iframe:true,width : "1000px", height : "1100px"});
}

function deletePackGroup(groupId){
	$.confirm("确认删除吗 ？",function(){
		var loading = top.pandora.loading("正在努力中...");
		$.ajax({
			url : "/vst_back/productPack/line/deletePackGroup.do",
			type : "post",
			dataType : 'json',
			data : "groupId=" + groupId + "&groupType=" + $(window.parent.document).find("#groupType").val()+ "&productId=" + $("#productId").val(),
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
		/*var selectCategoryId = params.selectCategoryId;
		var url = "/vst_back/productPack/line/showSelectProductList.do?groupType=" + groupType + "&groupId=" + groupId  
					+ "&selectParentCategoryFlag=" + $("#selectParentCategoryFlag").val()
					+ "&selectCategoryId=" + selectCategoryId;
		selectProductDialog = new xDialog(url,{},{title:"选择产品",iframe:true,width:"1000",height:"600"}); */
	} 
	addGroupDialog.close();
	window.location.reload();
}

//关联规格与产品或者商品
function onSavePackGroupDetail(params){
	if(params != null){
		var groupId = params.groupId;
		var groupType = params.groupType;
		var selectCategoryId = params.selectCategoryId;
		var detailIds = params.detailIds;
		var url = "/vst_back/productPack/line/showUpdateGroupDetail.do?groupType=" + groupType + "&groupId=" + groupId 
					+ "&selectCategoryId=" + selectCategoryId+ "&detailIds=" + detailIds;
		updateGroupDetailDialog = new xDialog(url,{},{title:"设置价格规则",iframe:true,width:"600",height:"600"});
	}
	
	selectProductDialog.close();
}

//设置单条记录价格规则
function updatePackGroupDetail(detailId){
	var groupType = $(window.parent.document).find("#groupType").val();
	var url = "/vst_back/productPack/line/showSingleUpdateGroupDetail.do?groupType=" + groupType + "&detailIds=" + detailId;
	updateGroupDetailDialog = new xDialog(url,{},{title:"设置价格规则",iframe:true,width:"600",height:"600"});	
}

//设置价格规则
function onUpdatePackGroupDetail(){
	updateGroupDetailDialog.close();
	window.location.reload();
}

function openProduct(productId, categoryId, categoryName){
	window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
}
if($("#isView",parent.top.document).val()=='Y'){
	$(".btn,#setPriceRule,#deletePackGroupDetail").remove();
}
</script>