<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px;">
<div class="iframe_search">

<form  id="catePropForm">
<input type="hidden" name="categoryId" value="${categoryId}">
<input type="hidden" name="page" id="page" value="${page}">

<table class="p_table form-inline">
	<tr>
		 <td style="width:270px">请选择属性组：<select name="groupId">
			  <option value="">请选择</option>
			  <#list bizCatePropGroups as bizCatePropGroup> 					    
		            <option value="${bizCatePropGroup.groupId}"
					<#if (bizCatePropGroup.groupId == groupId)>selected</#if>	
					>${bizCatePropGroup.groupName}</option>
			  </#list>
	        </select>
		</td>
		<td class=" operate mt10"><a class="btn btn_cc1" data="" id="addCatePropButton">添加属性</a></td>
	</tr>
	</table>
</form>

<table class="p_table table_center">
    <thead>
        <tr>
    	<th>编号</th>
        <th>排序值</th>
        <th>属性组</th>
		<th>属性名</th>
		<th>属性Code</th>
		<th>状态</th>
		<th>录入方式</th>
		<th>数据源</th>
		<th>默认值</th>
		<th>是否必填</th>
		<th width="90px">说明文字</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
    	<#list pageParam.items as bizCateProp> 
		<tr>
		<td>${bizCateProp.propId!''} </td>
		<td>${bizCateProp.seq!''} </td>
		<td>${bizCateProp.getBizCatePropGroup().groupName!''}</td>
		<td>${bizCateProp.propName!''}</td>
		<td>${bizCateProp.propCode!''}</td>
		<td>
			<#if bizCateProp.cancelFlag == 'Y'>
				<span style="color:green" class="cancelProp">有效</span>
			<#else>
				<span style="color:red" class="cancelProp">无效</span>
			</#if> 
		</td>
		<td>${bizCateProp.inputTypeName!''}</td>
		<td>${bizCateProp.dataFromName!'无'}</td>
		<td>${bizCateProp.propDefault!''}</td>
		<td>${(bizCateProp.nullFlag=='N')?string("否", "是")}</td>
		<td>${bizCateProp.propDesc!''}</td>
		<td class="oper">
                <a class="editcateProp" href="#" data="${bizCateProp.propId!''}" data2="1">编辑</a>
                <a href="#"  class="editCatePropFlag" data="${bizCateProp.propId!''}" data2="${bizCateProp.cancelFlag}">${(bizCateProp.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
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
var  addDialog,updateDialog,selectBizPropPoolDialog,updatePropDialog;
$().ready(function() {

$("select[name='groupId']").change(function(){
   var categoryId=$("input[name='categoryId']").val();
   var groupId=$(this).val();
   $("#page").val("1");
   var url = "/vst_back/biz/categoryProp/findCategoryPropList.do?categoryId="+categoryId+"&groupId="+groupId;
   $("#catePropForm").attr("url",url);
   $("#catePropForm").submit();
});

//添加属性
$("#addCatePropButton").bind("click",function(){
	if(${groupSize} == 0){
		pandora.dialog({wrapClass: "dialog-mini", content:"请先创建属性组!", okValue:"确定",ok:function(){
		}});
		return false;
	}
	var groupId=$("select[name='groupId']").val();
	if(groupId == ''){
		pandora.dialog({wrapClass: "dialog-mini", content:"请先选择属性组!", okValue:"确定",ok:function(){
		}});
		return false;
	}
    var categoryId=$("input[name='categoryId']").val();
    var param = "?callback=onSelectBizPropPool&categoryId="+categoryId+"&groupId="+groupId+"&propType=category";
    var url = "/vst_back/biz/category/selectBizPropPoolList.do"+ param;
	//打开选择属性池列表
	selectBizPropPoolDialog = new xDialog(url,{},{title:"选择属性",iframe:true,width:"1000",height:"auto"});
	
});
	
//编辑
$("a.editcateProp").bind("click",function(){
    var propId=$(this).attr("data");
    updatePropDialog = new xDialog("/vst_back/biz/categoryProp/showCategoryProp.do",
	{"propId":propId}, {title:"修改分组",width:800});
});
  
$("a.editCatePropFlag").bind("click",function(){
      var propId=$(this).attr("data");
	  var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	  var url = "/vst_back/biz/categoryProp/editFlag.do?propId="+propId+"&cancelFlag="+cancelFlag+"&newDate="+new Date();
	  msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	  $.confirm(msg, function () {
		 $.get(url, function(data){
	         confirmAndRefresh(data);
	     });
     });
	 return false;
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			//依据选择的groupId再次刷新页面
			var categoryId = $("input[name='categoryId']").val();
		    var groupId=$("select[name='groupId']").val();
		    var url = "/vst_back/biz/categoryProp/findCategoryPropList.do?categoryId="+categoryId+"&groupId="+groupId;
		    $("#catePropForm").attr("url",url);
  			$("#catePropForm").submit();
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
function onSelectBizPropPool(){
	//关闭属性池列表
	selectBizPropPoolDialog.close();
	
	//依据选择的groupId再次刷新页面
	var categoryId = $("input[name='categoryId']").val();
    var groupId=$("select[name='groupId']").val();
    var url = "/vst_back/biz/categoryProp/findCategoryPropList.do?categoryId="+categoryId+"&groupId="+groupId;
    $("#catePropForm").attr("url",url);
	$("#catePropForm").submit();
}  
</script> 
