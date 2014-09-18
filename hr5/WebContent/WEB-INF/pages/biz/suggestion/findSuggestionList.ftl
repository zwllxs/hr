<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<title>建议插件列表</title>
<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">后台</a> &gt;</li>
        <li><a href="#">建议插件列表</a></li>
    </ul>
</div>
<div class="p_box box_info">
	<form method="post" id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                    <td class=" operate mt10">&nbsp;</td>
                    <td class=" operate mt10">
                    <a class="btn btn_cc1" id="new_button">新增建议内容</a></td>
                </tr>
            </tbody>
        </table>	
	</form>
</div>
<!-- 主要内容显示区域\\ -->
    <#if pageParam??>
    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                    <tr>
                    <th>建议内容名称</th>
                    <th>编号</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as suggestion> 
					<tr>
						<td>${suggestion.suggName!''}</td>
						<td>${suggestion.suggCode!''}</td>
						<td class="oper">
                            <a href="javascript:void(0);" class="editSuggestion" data="${suggestion.suggId}">修改基础信息</a>&nbsp;
                            <a href="javascript:void(0);" class="groupList" data="${suggestion.suggId}">修改分类</a>
                            <a href="javascript:void(0);" class="addGroup" data="${suggestion.suggId}">新增分类</a>
                            <a href="javascript:void(0);" class="editDetail" data="${suggestion.suggId}" data2="${suggestion.suggName!''}">修改/增加描述内容</a>
                            <a href="javascript:void(0);" class="previewDetail" data="${suggestion.suggCode}">预览(临时加上)</a>
                        </td>
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
var addSuggestionDialog, updateSuggestionDialog, addGroupDialog, groupListDialog, detailListDialog;
$(function(){
	//查询
	$("#search_button").bind("click",function(){
		if (!$("#searchForm").validate().form()) {
			return false;
		}
		$(".iframe-content").empty().append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#searchForm").submit();
	});

	// add suggestion
	$("#new_button").bind("click",function(){
		addSuggestionDialog = new xDialog("/vst_back/biz/suggestion/showAddSuggestion.do",{},{title:"基础信息",width:800,height:700});
		return;
	});

	//edit suggestion
	$("a.editSuggestion").bind("click",function(){
		var suggId = $(this).attr("data");
	    var url = "/vst_back/biz/suggestion/showAddSuggestion.do";
		updateSuggestionDialog = new xDialog(url,{"suggId":suggId}, {title:"修改",width:800,height:700});
		return false;
	});

	// add group
	$("a.addGroup").bind("click",function(){
		var suggId = $(this).attr("data");
		var url = "/vst_back/biz/suggestionGroup/showAddGroup.do";
		addGroupDialog = new xDialog(url,{"suggId":suggId},{title:"分类",width:800,height:700});
		return;
	});

	// show group list
	$("a.groupList").bind("click",function(){
		var suggId = $(this).attr("data");
	    var url = "/vst_back/biz/suggestionGroup/findGroupList.do";
		groupListDialog = new xDialog(url,{"suggId":suggId}, {title:"修改",width:800,height:700});
		return ;
	});

	//edit detail
	$("a.editDetail").bind("click",function(){
		var suggId = $(this).attr("data");
		var suggName = $(this).attr("data2");
	    var url = "/vst_back/biz/suggestionDetail/findDetailList.do";
		detailListDialog = new xDialog(url,{"suggId":suggId, "suggName":suggName}, {title:"修改"+suggName,width:800,height:700});
		return false;
	});

	// preview detail(验证预览效果，临时使用)
	$("a.previewDetail").bind("click",function(){
		var suggCode = $(this).attr("data");
	    var url = "/vst_back/biz/suggestionDetail/previewSuggDetail.do";
		new xDialog(url,{"suggCode":suggCode,"reqDataFrom":""}, {title:"预览",width:1200,height:1000});
		return false;
	});

	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		} else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	};
	
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper > a").remove();
	}
});
</script>
