<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<title>建议分类列表</title>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">后台</a> &gt;</li>
        <li><a href="#">建议分类列表</a></li>
    </ul>
</div>
<!-- 主要内容显示区域\\ -->
<#if pageParam??>
	<#if pageParam.items?? &&  pageParam.items?size &gt; 0>
	<div class="p_box box_info">
	<table class="p_table table_center">
	<thead>
    <tr>
    	<th>分类名称</th>
		<th>排序值</th>
        <th>单复选</th>
        <!-- <th>是否允许维护时新增描述内容</th> -->
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
	<#list pageParam.items as group> 
		<tr>
			<td>${group.groupName!''}</td>
			<td>${group.seq!''}</td>
			<td>
				<#if group.selectType==1>
					单选
				<#elseif group.selectType==2>
					复选
				</#if>
			</td>
			<!--
			<td>
				<#if group.addFlag==1>
					是
				<#else>
					否
				</#if>
			</td>
			-->
			<td class="oper"><a href="javascript:void(0);" class="editGroup" data="${group.groupId}">修改</a></td>
		</tr>
	</#list>
	</tbody>
    </table>
	<#if pageParam.items?exists> 
		<div class="paging">${pageParam.getPagination()}</div> 
	</#if>
		</div><!-- div p_box -->
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关数据，重新输入相关条件查询！</div>
    </#if>
</#if>
<!-- //主要内容显示区域 -->
</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
var updateGroupDialog;
$(function(){
	//查询
	$("#search_button").bind("click",function(){
		if (!$("#searchForm").validate().form()) {
			return false;
		}
		$(".iframe-content").empty().append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#searchForm").submit();
	});

	//修改
	$("a.editGroup").bind("click",function(){
		var groupId = $(this).attr("data");
	    var url = "/vst_back/biz/suggestionGroup/showAddGroup.do";
		updateGroupDialog = new xDialog(url,{"groupId":groupId}, {title:"修改",width:800,height:700});
		return false;
	});

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
	
	if($("#isView",parent.top.document).val()=='Y'){
		$(".editGroup").remove();
	}
});
</script>
