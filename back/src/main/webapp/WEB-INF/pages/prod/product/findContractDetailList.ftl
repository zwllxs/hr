<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>

<body style="min-height:700px;">
<input type="hidden" value="${productId!''}" name="productId"  id="productId"/>

<table class="p_table table_center">
        <thead>
            <tr>
            	<td> 
					<div class="fl operate" style="margin:20px;">
					推荐项目&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn btn_cc1" id="newRecommendButton" onclick="addProdContractDetail('RECOMMEND')" href="javascript:void(0);">新增</a>
					</div>
				</td>
             </tr>
        </thead>
    </table>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
	    <thead>
	        <tr>
	    	<th>行程天数</th>
	        <th>地点</th>
	        <th>项目名称和内容</th>
	        <th>费用</th>
	        <th>项目时长(分钟)</th>
	        <th>其他说明</th>
	        <th>操作</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<#if recommendList?? && recommendList?size &gt; 0>
			<#list recommendList as recommendItem> 
				<tr>
					<td>${recommendItem.nDays!''} </td>
					<td>${recommendItem.address!''} </td>
					<td>${recommendItem.detailName!''} </td>
					<td>${recommendItem.detailValue!''} </td>
					<td>${recommendItem.stay!''} </td>
					<td>${recommendItem.other!''}</td>
					<td>
						<a href="javascript:void(0);" onclick="updateProdContractDetail('${recommendItem.detailId!''}')" class="cancel">修改</a>
						<a href="javascript:void(0);" onclick="deleteProdContractDetail('${recommendItem.detailId!''}')" class="cancel">删除</a>
					</td>
		        </tr>
			</#list>
			</#if>
	    </tbody>
	</table>
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->

<div class="operate" style="margin-bottom:10px;">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购物说明&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a class="btn btn_cc1" id="newShopingButton" onclick="addProdContractDetail('SHOPING')" href="javascript:void(0);">新增</a>
</div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
	    <thead>
	        <tr>
	    	<th>行程天数</th>
	        <th>地点</th>
	        <th>购物场所名称</th>
	        <th>主要商品信息</th>
	        <th>项目时长(分钟)</th>
	        <th>其他说明</th>
	        <th>操作</th>
	        </tr>
	    </thead>
	    <tbody>
	    	<#if shopingList?? && shopingList?size &gt; 0>
			<#list shopingList as shopingItem> 
				<tr>
					<td>${shopingItem.nDays!''} </td>
					<td>${shopingItem.address!''} </td>
					<td>${shopingItem.detailName!''} </td>
					<td>${shopingItem.detailValue!''} </td>
					<td>${shopingItem.stay!''} </td>
					<td>${shopingItem.other!''}</td>
					<td>
						<a href="javascript:void(0);" onclick="updateProdContractDetail('${shopingItem.detailId!''}')" class="cancel">修改</a>
						<a href="javascript:void(0);" onclick="deleteProdContractDetail('${shopingItem.detailId!''}')" class="cancel">删除</a>
					</td>
		        </tr>
			</#list>
			</#if>
	    </tbody>
	</table>
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>

</body>
</html>
<script>
var showAddContractDetailDialog;
//删除
function deleteProdContractDetail(detailId) {
	if(!detailId) {
		return false;
	}
	$.ajax({
		url : "/vst_back/prod/product/prodContractDetail/deleteProdContractDetail.do?detailId="+detailId,
		type : "get",
		dataType:"json",
		async: false,
		success : function(result) {
		   if(result.code=="success"){
				alert(result.message);
   				window.location.reload();
			}else {
				alert(result.message);
	   		}
		}
   });
}
//新增
function addProdContractDetail(detailType) {
   var title = detailType == "RECOMMEND" ? "推荐项目" : "购物说明";
	if(detailType != "") {
		var url = "/vst_back/prod/product/prodContractDetail/addOrUpdateContractDetail.do?detailType="+ detailType +"&productId="+$("#productId").val();
		showAddContractDetailDialog = new xDialog(url,{},{title:"新增"+ title, width:600, height:450});
	}
}
//修改
function updateProdContractDetail(detailId) {
	var url = "/vst_back/prod/product/prodContractDetail/addOrUpdateContractDetail.do?detailId="+detailId;
	showAddContractDetailDialog = new xDialog(url,{},{title:"修改信息", width:600, height:450});
}

if($("#isView",parent.top.document).val()=='Y'){
	$("#newShopingButton,#newRecommendButton,.cancel").remove();
}
</script>
