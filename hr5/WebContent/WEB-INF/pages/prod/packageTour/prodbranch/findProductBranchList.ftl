<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>

<#if branchCode == 'addition'>
	<#assign branchName = '附加'/>
<#elseif branchCode == 'upgrad'>
	<#assign branchName = '升级'/>
<#elseif branchCode == 'combo_dinner'>
	<#assign branchName = '套餐'/>
<#elseif branchCode == 'changed_hotel'>
	<#assign branchName = '酒店'/>
</#if>
</head>
<body>
<form id="dataForm">
	<div class="p_box box_info" style="height:550px;width:900px" >
		<#if branchCode == 'upgrad'>
			<table class="p_table form-inline">
			<tbody>
				<tr>
					<td class=" operate mt10">
						<span style="color:red" class="cancelProd">
								注，升级方案为对线路产品已经包含的项目，做的加价升级项目，即里面填写的价格为加价部分。如涉及到多种资源升级，需要枚举组合。
								例如，酒店、交通都可以选择进行升级，则升级方案应维护为：方案一，升级酒店；方案二，升级交通；方案三，升级酒店+交通
						</span>
					</td> 
				</tr>
			</tbody>
			</table>
		</#if>
		<table class="p_table form-inline">
		<tbody>
			<tr>
				<td class=" operate mt10">
					<a id="new_button" class="btn btn_cc1" data="">添加${branchName}</a>
				</td> 
			</tr>
		</tbody>
		</table>
		<table class="p_table table_center">
            <thead>
                <tr>
            	<th>商品ID</th>
            	<th>${branchName}名称</th>
            	<th>描述</th>
                <th>商品名称</th>
                <#if branchCode == 'addition'>
                	<th>选择限制</th>
                </#if>
                <th>商品是否有效</th>
                <th>操作</th>
                </tr>
            </thead>
            <tbody>
            	<#if tourProductBranchVOList??> 
					<#list tourProductBranchVOList as tourProductBranchVO > 
						<tr>
							<td><#if tourProductBranchVO.suppGoods != null>${tourProductBranchVO.suppGoods.suppGoodsId!''}</#if></td>
							<td>${tourProductBranchVO.branchName!''}</td>
							<td>${tourProductBranchVO.propValue['branch_desc']!''}</td>
							<td><#if tourProductBranchVO.suppGoods != null>${tourProductBranchVO.suppGoods.goodsName}</#if></td>
							<#if branchCode == 'addition'>
								<td><#if tourProductBranchVO.suppGoodsRelation != null>${tourProductBranchVO.suppGoodsRelation.relationTypeCnName}</#if></td>
			                </#if>
			                <td>
			                <#if tourProductBranchVO.suppGoods != null> 
				                 <#if tourProductBranchVO.suppGoods.cancelFlag == 'Y'> 
									<span style="color:green" class="cancelProd">有效</span>
								<#else>
									<span style="color:red" class="cancelProd">无效</span>
								</#if>
							</#if>
							</td>
							<td class="oper">
								 <#if tourProductBranchVO.productBranchId != null> 
		                            <a href="javascript:void(0);" class="editProp" data=${tourProductBranchVO.productBranchId!''} data_proid=${tourProductBranchVO.branchId!''}>编辑规格</a>
								 </#if>
	                            <#if tourProductBranchVO.suppGoods != null> 
		                             <#if tourProductBranchVO.suppGoods != null && tourProductBranchVO.suppGoods.cancelFlag == 'Y'> 
		                            		<a href="javascript:void(0);" class="cancelProd" data="N" suppGoodsId=${tourProductBranchVO.suppGoods.suppGoodsId}>商品设为无效</a>
		                             <#else>
		                            		<a href="javascript:void(0);" class="cancelProd" data="Y" suppGoodsId=${tourProductBranchVO.suppGoods.suppGoodsId}>商品设为有效</a>
		                             </#if>
	                             </#if>
	                            <!-- <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${tourProductBranchVO.productBranchId!''},'objectType':'PROD_PRODUCT_BRANCH'}">操作日志</a>-->
	                        </td>
						</tr>
						<tr id ></tr>
					</#list>
				</#if>
            </tbody>
        </table>
        <table class="p_table form-inline">
		<tbody>
			<tr>
				<td class=" operate mt10">
					&nbsp;
				</td>
			</tr>
			<tr>
				<td class=" operate mt10">
					<a id="close_button" class="btn btn_cc1" data="">关闭当前窗口</a>
				</td>
			</tr>
		</tbody>
		</table>
	</div>
</form>

<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var saveDialog, addBranchDialog;
$("#new_button,a.editProp").bind("click",function(){
		var productBranchId=$(this).attr("data");
		var branchId = ${branchId!''}; 
		var productId = ${productId!''};
		var mainProdBranchId = ${mainProdBranchId!''};
		saveDialog = new xDialog("/vst_back/packageTour/prod/prodbranch/showAddProductBranchTab.do",{"productBranchId":productBranchId, "mainProdBranchId":mainProdBranchId, "branchId":branchId, "productId":productId}, {title:"编辑产品规格",width:1000})
});

//设置为有效或无效
$("a.cancelProd").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var suppGoodsId = entity.attr("suppGoodsId");
	
	 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/packageTour/prod/prodbranch/editSuppGoodsFlag.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"suppGoodsId":suppGoodsId},
			success : function(result) {
			if (result.code == "success") {
				$.alert(result.message,function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProd",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProd",entity.parents("tr")).css("color","green").text("有效");
					}
				});
			}else {
				$.alert(result.message);
			}
			}
		});
	});
});

function reload() {
	saveDialog.close();
	window.location.reload();
};

$("#close_button").bind("click",function(){
	parent.reload();
});
</script>
