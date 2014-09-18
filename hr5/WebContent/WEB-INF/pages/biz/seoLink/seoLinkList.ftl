<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>

<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">seo管理</a> &gt;</li>
            <li class="active">seo列表</li>
        </ul>
</div>

<div class="iframe_content">   
<div class="p_box">

<form method="post" action='/vst_back/biz/seoLink/findSeoLinkList.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">${seoTypeName}：</td>
                <td class="w18"><input type="text" name="objectName" id="objectName" value="${objectName!''}"></td>
                <td class="s_label">链接地址(友链)：</td>
             	<td class="w18"><input type="text" name="linkUrl" id="linkUrl" value="${linkUrl!''}"></td>
             	
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增单条</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="import_button">导入</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="export_button">导出</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="del_select_button">删除选中项</a></td>
                <input type="hidden" name="page" value="${page}">
                <input type="hidden" name="seoType" value="${seoType}">
            </tr>
        </tbody>
    </table>	
</form>

</div>
	
<!-- 主要内容显示区域\\ -->
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th><input type="checkbox" id="allSelectHead" onClick="selectAll('allSelectHead')"/></th>
            <th>编号(ID)</th>
            <th>${seoTypeName}</th>
            <th>友链锚文</th>
            <th>链接地址(友链)</th>
            <th>备注</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizSeoFriendLink> 
			<tr>
				<td><input type="checkbox" id="checkBox${bizSeoFriendLink_index}"  value="${bizSeoFriendLink.bizSeoFriendLinkId!''}"/></td>
				<td>${bizSeoFriendLink.objectId!''} </td>
				<td>${bizSeoFriendLink.objectName!''}</td>
				<td>${bizSeoFriendLink.linkName!''} </td>
				<td>${bizSeoFriendLink.linkUrl!''} </td>
				<td>${bizSeoFriendLink.remark!''} </td>
				<td class="oper">
	                <a href="javascript:void(0);" class="editSeoLink" data=${bizSeoFriendLink.bizSeoFriendLinkId}>编辑</a>
	                <a href="javascript:void(0);" class="delSeoLink" data=${bizSeoFriendLink.bizSeoFriendLinkId}>删除</a>
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

	</div><!-- div p_box -->
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var addDialog,updateDialog;

//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});


//导入
$("#import_button").bind("click",function(){
	var url = "/vst_back/biz/seoLink/toShowUploadExecl.do?seoType=${seoType}";
	importDialog = new xDialog(url, {}, {title:"导入友链记录",width:800});
});

//新建单条
$("#new_button").bind("click",function(){
	var url = "/vst_back/biz/seoLink/toSeoLinkAdd.do?seoType=${seoType}";
	addDialog = new xDialog(url, {}, {title:"新增单条",width:500});
});

//修改
$("a.editSeoLink").bind("click",function(){
	var bizSeoFriendLinkId = $(this).attr("data");
	var url = "/vst_back/biz/seoLink/toSeoLinkUpdate.do?seoType=${seoType}";
	updateDialog = new xDialog(url,{"bizSeoFriendLinkId":bizSeoFriendLinkId}, {title:"修改",width:500});
});

//删除单条
$("a.delSeoLink").bind("click",function(){

	 var bizSeoFriendLinkId = $(this).attr("data");
	 var valid = "Y";
	 msg = valid === "Y" ? "是否确定删除？" : "取消？";
	 $.confirm(msg, function () {
		 var url = "/vst_back/biz/seoLink/doDeleteSeoLink.do?seoType=${seoType}&bizSeoFriendLinkIdList="+bizSeoFriendLinkId;
		 $.ajax({
			url : url,
			type : "post",
			dataType:'JSON',
			success : function(result) {
				confirmAndRefresh(result);
			}
		 });
     });
});

//导出
$("#export_button").bind("click",function(){
	
	var linkUrl = $("#linkUrl").val();
	var objectName = $("#objectName").val();
	var url = "/vst_back/biz/seoLink/exportExcelData.do";
	$("#searchForm").attr("action",url);
  	$("#searchForm").submit();
  	
  	var url = "/vst_back/biz/seoLink/findSeoLinkList.do";
  	$("#searchForm").attr("action",url);
});

//批量操作多条记录
$("#del_select_button").bind("click",function(){
	var batchSeoLinks = "";
	for(var i = 0; i < 20; i++)
	{
		if($("#checkBox"+i) != null && $("#checkBox"+i).attr("checked")=="checked")
		{
			batchSeoLinks += $("#checkBox"+i).val() + ",";
		}
	}
	if(batchSeoLinks == ""){
		return;
	}
	var url = "/vst_back/biz/seoLink/doDeleteSeoLink.do?seoType=${seoType}&bizSeoFriendLinkIdList="+batchSeoLinks;
	var valid = "Y";
	msg = valid === "Y" ? "是否确定批量删除？" : "取消？";
	$.confirm(msg, function () {
		$.ajax({
			url : url,
			type : "post",
			dataType:'JSON',
			success : function(result) {
				confirmAndRefresh(result);
			}
		});
	});
});

//选择所有记录
function selectAll(id){
	if($("#" + id).attr("checked")=="checked")
	{
		for(var i = 0; i < 20; i++)
		{
			if($("#checkBox"+i) != null)
			{
				$("#checkBox"+i).attr("checked",true);
			}
		}
	}
	else if($("#" + id).attr("checked")!="checked")
	{
		for(var i = 0; i < 20; i++)
		{
			if($("#checkBox"+i) != null)
			{
				$("#checkBox"+i).attr("checked",false);
			}
		}
	}
};

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		    var url = "/vst_back/biz/seoLink/findSeoLinkList.do";
		    $("#searchForm").attr("action",url);
  			$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
};

</script>