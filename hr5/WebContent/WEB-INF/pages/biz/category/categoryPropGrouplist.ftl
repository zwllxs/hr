<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:400px;">
<div class="iframe_search">
<form  id="dataForm">
	<input type="hidden" name="categoryId" value="${categoryId}">
	<input type="hidden" name="page" value="${page}">
	<input type="hidden" name="groupId">
	<table class="p_table form-inline">
	<tr>
		<td  class=" operate mt10"><a class="btn btn_cc1" data="" id="addCatePropGroupButton">添加新分组</a></td>
	</tr>
	</table>
</form>

<table class="p_table table_center">
    <thead>
        <tr>
    	<th>编号</th>
        <th>排序值</th>
        <th>属性分组名</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
    	<#list pageParam.items as bizCatePropGroup> 
		<tr>
		<td>${bizCatePropGroup.groupId!''} </td>
		<td>${bizCatePropGroup.seq!''}</td>
		<td>${bizCatePropGroup.groupName!''}</td>
		<td class="oper">
                <a class="editcatePropGroup" href="javascript:void(0);" data="${bizCatePropGroup.groupId!''}">编辑</a>
				<a class="deletecatePropGroup" href="javascript:void(0);" data="${bizCatePropGroup.groupId!''}">删除</a>
                <!--<a href="javascript:void(0);"  class="editPropGroupFlag" data="${bizCatePropGroup.groupId!''}" data2="${bizCatePropGroup.cancelFlag}">${(bizCatePropGroup.cancelFlag=='N')?string("设为有效", "设为无效")}</a>	-->				
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

var updateDialog;

$(document).ready(function() {

//添加
$("#addCatePropGroupButton").bind("click",function(){
	var categoryId= $("input[name='categoryId']").val();
	var url = "/vst_back/biz/categoryPropGroup/showAddCategoryPropGroup.do?categoryId="+categoryId;
	dialog(url, "添加新分组", 500, "auto",function(){
		if(!$("#dataForm").validate().form()){
			return false;
		}
		var resultCode; 
		$.confirm("确认添加吗 ？", function () {
			$.ajax({
				url : "/vst_back/biz/categoryPropGroup/addCategoryPropGroup.do",
				type : "post",
				async: false,
				data : $(".dialog #dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
				    resultCode=result.code;
					confirmAndRefresh(result);
				}
			});
		});
		if(resultCode !=='success') return false;
	},"保存");
});
	
$("a.editPropGroupFlag").bind("click",function(){
	 var groupId=$(this).attr("data");
	 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	 var url = "/vst_back/biz/categoryPropGroup/editFlag.do?groupId="+groupId+"&cancelFlag="+cancelFlag;
	 $.get(url, function(result){
        confirmAndRefresh(result);
     });
	 return false;
});

//删除
$("a.deletecatePropGroup").bind("click",function(){
	var groupId=$(this).attr("data");
    $.confirm("删除不能恢复,确认删除吗？", function () {
    	var resultCode; 
		$.ajax({
			url : "/vst_back/biz/categoryPropGroup/deleteCatePropGroup.do",
			type : "get",
			async: false,
			data : {groupId : groupId},
			dataType:'JSON',
			success : function(result) {
				 confirmAndRefresh(result);
			}
		});
   });
	   return false;
});

//修改分组
$("a.editcatePropGroup").bind("click",function(){
	var groupId=$(this).attr("data");
	var url = "/vst_back/biz/categoryPropGroup/showAddCategoryPropGroup.do?groupId="+groupId;
	dialog(url, "修改分组", 500, "auto",function(){
		if(!$("#dataForm").validate().form()){
			return false;
		}
		var resultCode; 
		$.confirm("确认修改吗 ？", function () {
			$.ajax({
				url : "/vst_back/biz/categoryPropGroup/updateCategoryPropGroup.do",
				type : "post",
				async: false,
				data : $(".dialog #dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
				    resultCode=result.code;
					confirmAndRefresh(result);
				}
			});
		});
		if(resultCode !=='success') return false;
	},"保存");
});
	
function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			//依据选择的categoryId再次刷新页面
			var categoryId = $("input[name='categoryId']").val();
		    var url = "/vst_back/biz/categoryPropGroup/findCategoryPropGroup.do?categoryId="+categoryId;
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
