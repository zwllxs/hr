<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">行政区管理</a> &gt;</li>
            <li class="active">行政区列表</li>
        </ul>
</div>
<div class="iframe_content">   
<div class="p_box">
<form method="post" action='/vst_back/biz/district/findDistrictList.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">名称：</td>
                <td class="w18"><input type="text" name="districtName" value="${districtName!''}"></td>
                <td class="s_label">区域类型：</td>
                <td class="w18">
                	<select name="districtType">
                	<option value="">不限</option>
                    	<#list districtTypeList as distType>
                    		<#if districtType == distType.code>
                    		<option value="${distType.code!''}" selected="selected">${distType.cnName!''}</option>
                    		<#else>
                    		<option value="${distType.code!''}">${distType.cnName!''}</option>
                    		</#if>
                    	</#list>
                	</select>
                </td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                 <input type="hidden" name="page" value="${page}">
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
        	<th>编号</th>
            <th>名称</th>
            <th>类型</th>
            <th>拼音</th>
            <th>简拼</th>
            <th>URL拼音</th>
            <th>上级区域</th>
            <th>状态</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDistrict> 
			<tr>
				<td>${bizDistrict.districtId!''} </td>
				<td>${bizDistrict.districtName!''} </td>
				<td>${bizDistrict.districtTypeCnName!''} </td>
				<td>${bizDistrict.pinyin!''} </td>
				<td>${bizDistrict.shortPinyin!''} </td>
				<td>${bizDistrict.urlPinyin!''} </td>
				<#if bizDistrict.parentDistrict??>
					<td>${bizDistrict.parentDistrict.districtName} </td>
				<#else>
					<td></td>
				</#if>
				<td>
					<#if bizDistrict.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProp">有效</span>
					<#else>
						<span style="color:red" class="cancelProp">无效</span>
					</#if>
				</td>
				<td class="oper">
	                <a href="javascript:void(0);" class="editProp" data=${bizDistrict.districtId}>编辑</a>
	                <a href="javascript:void(0);" class="addChild" data=${bizDistrict.districtId}>添加下级</a>
	                <#if bizDistrict.cancelFlag == "Y"> 
	                	 <a href="javascript:void(0);" class="cancelProp" data="N" districtid=${bizDistrict.districtId}>设为无效</a>
	                <#else>
	               		 <a href="javascript:void(0);" class="cancelProp" data="Y" districtid=${bizDistrict.districtId}>设为有效</a>
	                </#if>
	                <a href="/vst_back/pub/comCoordinate/modifyCoordinate.do?objectId=${bizDistrict.districtId!''}&objectType=BIZ_DISTRICT&coordType=BAIDU&searchKey=${bizDistrict.districtName!''} <#if bizDistrict.parentDistrict ??>${bizDistrict.parentDistrict.districtName!''}</#if>">设置百度经纬度</a>
                    <a href="/vst_back/pub/comCoordinate/modifyCoordinate.do?objectId=${bizDistrict.districtId!''}&objectType=BIZ_DISTRICT&coordType=GOOGLE&searchKey=${bizDistrict.districtName!''} <#if bizDistrict.parentDistrict ??>${bizDistrict.parentDistrict.districtName!''}</#if>">设置谷歌经纬度</a>
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
	if(!$("#searchForm").validate().form()){
		return;
	}
	$("#searchForm").submit();
});

//新建
$("#new_button").bind("click",function(){
	var url = "/vst_back/biz/district/showAddDistrict.do";
	addDialog = new xDialog(url, {}, {title:"新增行政区",width:800});
});

//修改
$("a.editProp").bind("click",function(){
	var districtId = $(this).attr("data");
	var url = "/vst_back/biz/district/showUpdateDistrict.do";
	updateDialog = new xDialog(url,{"districtId":districtId}, {title:"修改行政区",width:800});
});

//设置为有效或无效
$("a.cancelProp").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var districtId = entity.attr("districtid");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
 	$.confirm(msg, function () {	
	$.ajax({
		url : "/vst_back/biz/district/cancelDistrict.do",
		type : "post",
		data : {"cancelFlag":cancelFlag,"districtId":districtId},
		success : function(result) {
			if (result.code == "success") {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
					}
				}});
			}else {
				pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				}});
			}		
		}
	});
	});
});

//新建下级
$("a.addChild").bind("click",function(){
	var districtId = $(this).attr("data");
	var url = "/vst_back/biz/district/showAddChildDistrict.do?districtId="+districtId;
	dialog(url, "新增下级行政区", 800, "auto",function(){
		if(!$("#dataForm").validate().form()){
			return false;
		}
		$.ajax({
			url : "/vst_back/biz/district/addDistrict.do",
			type : "post",
			data : $(".dialog #dataForm").serialize(),
			dataType:'JSON',
			success : function(result) {
				confirmAndRefresh(result);
			}
		});
	},"保存");
});

</script>