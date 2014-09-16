<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px;">
<div class="iframe_search">

<form  id="dataForm">
	<table class="p_table form-inline">
		<tr>
			<td class=" operate mt10"><a class="btn btn_cc1" data="" id="addButton">添加属性</a></td>
		</tr>
		<tr>
			<input type="hidden" name="categoryId" value="${categoryId}">
			<input type="hidden" name="branchId" value="${branchId}">
			<input type="hidden" name="page" value="${page}">
		</tr>
	</table>
</form>

<table class="p_table table_center">
    <thead>
        <tr>
    	<th>编号</th>
        <th>排序值</th>
		<th>属性名</th>
		<th>属性Code</th>
		<th>状态</th>
		<th>录入方式</th>
		<th>数据源</th>
		<th>默认值</th>
		<th>是否必填</th>
		<th>说明文字</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
    	<#list pageParam.items as bizBranchProp> 
			<tr>
				<td>${bizBranchProp.propId!''} </td>
				<td>${bizBranchProp.seq!''} </td>
				<td>${bizBranchProp.propName!''}</td>
				<td>${bizBranchProp.propCode!''}</td>
				<td>
					<#if bizBranchProp.cancelFlag == 'Y'>
						<span style="color:green" class="cancelProp">有效</span>
					<#else>
						<span style="color:red" class="cancelProp">无效</span>
					</#if> 
				</td>
				<td>${bizBranchProp.inputTypeName!''}</td>
				<td>${bizBranchProp.dataFromName!'无'}</td>
				<td>${bizBranchProp.propDefault!''}</td>
				<td>${(bizBranchProp.nullFlag=='N')?string("否", "是")}</td>
				<td>${bizBranchProp.propDesc!''}</td>
				<td class="oper">
	                <a class="editProp" href="javascript:void(0);" data="${bizBranchProp.propId!''}">编辑</a>
	                <a href="javascript:void(0);"  class="editBranchPropFlag" data="${bizBranchProp.propId!''}" data2="${bizBranchProp.cancelFlag}">${(bizBranchProp.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
	            </td>					
		</tr>
		</#list>
    </tbody>
</table>
<#if pageParam.items?exists> 
	<div class="paging" > 
		${pageParam.getPagination()}
	</div> 
</#if>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var selectBranchBizPropPoolDialog,updateBranchPropDialog;
$().ready(function() {

//添加属性
$("#addButton").bind("click",function(){
    var categoryId=$("input[name='categoryId']").val();
	var branchId=$("input[name='branchId']").val();
    var param = "?callback=onBranchSelectBizPropPool&categoryId="+categoryId+"&branchId="+branchId+"&propType=branch";
    
	//打开选择属性池列表
	selectBranchBizPropPoolDialog = new xDialog("/vst_back/biz/category/selectBizPropPoolList.do"+ param,{},{title:"选择属性",iframe:true,width:"1000",height:"auto"});
	
});
	
//修改属性
$("a.editProp").bind("click",function(){
    var categoryId=$("input[name='categoryId']").val();
    var propId=$(this).attr("data");
    var url = "/vst_back/biz/branchProp/showBranchProp.do";
    updateBranchPropDialog = new xDialog(url,{"propId":propId,"categoryId":categoryId}, {title:"修改属性",width:800});
  });
    
 
//设为无效/设为有效
$("a.editBranchPropFlag").bind("click",function(){
   var propId=$(this).attr("data");
   var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
   var url = "/vst_back/biz/branchProp/editFlag.do?propId="+propId+"&cancelFlag="+cancelFlag+"&newDate="+new Date();
   msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
   $.confirm(msg, function () {
	   $.get(url, function(result){
	      confirmAndRefresh(result);
	   });
   });
   return false;
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			//依据选择的groupId再次刷新页面
			var categoryId = $("input[name='categoryId']").val();
		    var branchId=$("select[name='branchId']").val();
		    var url = "/vst_back/biz/branchProp/findBranchPropsList.do?categoryId="+categoryId+"&branchId="+branchId;
		    $("#dataForm").attr("url",url);
  			$("#dataForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
};
});

</script>

<script type="text/javascript"> 
 //属性池选择后的回调函数
function onBranchSelectBizPropPool(){
	//关闭属性池列表
	selectBranchBizPropPoolDialog.close();
	
	//依据选择的groupId再次刷新页面
	var categoryId = $("input[name='categoryId']").val();
    var branchId=$("select[name='branchId']").val();
    var url = "/vst_back/biz/branchProp/findBranchPropsList.do?categoryId="+categoryId+"&branchId="+branchId;
    $("#dataForm").attr("url",url);
	$("#dataForm").submit();
}  
</script> 

