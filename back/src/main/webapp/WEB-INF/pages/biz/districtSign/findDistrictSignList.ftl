<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">地理位置管理</a> &gt;</li>
        <li class="active">地理位置列表</li>
    </ul>
</div>
<div class="iframe_content">  
<div class="p_box">
<form method="post" action='/vst_back/biz/districtSign/findDistrictSignList.do' id="searchForm">
	<table class="s_table">
    <tbody>
        <tr>
            <td class="s_label">名称：</td>
            <td class="w18"><input type="text" name="signName" value="${signName!''}"></td>
            <td class="s_label">类型：</td>
            <td class="w18">
            	<select name="signType">
            	<option value="">不限</option>
                	<#list bizDictList as bizDict>
                		<#if signType == bizDict.dictId>
                			<option value="${bizDict.dictId!''}" selected="selected">${bizDict.dictName!''}</option>
                		<#else>
                			<option value="${bizDict.dictId!''}">${bizDict.dictName!''}</option>
                		</#if>
                	</#list>
            	</select>
            </td>
           <td class="s_label">
                                                      是否有效：
            </td>
            <td class="w18">
            	<select name="cancelFlag" value="Y">
            	        <option value="UN" <#if cancelFlag == 'UN'>selected</#if>>不限</option>
                		<option value="Y" <#if cancelFlag == 'Y'>selected</#if>>是</option>
                		<option value="N" <#if cancelFlag == 'N'>selected</#if>>否</option>
            	</select>
            </td>
            <td class="s_label">
                                                    经纬度为空:
            </td>
            <td class="w18">
                <input type="checkbox" <#if longitudeNullFlag == 'N'>checked</#if> name="longitudeNullFlag" value="N" >
            </td>
            </tr>
            <tr>
            <td class="s_label">行政区名称：</td>
            <td class="w18"><input type="text" name="districtName" value="${districtName!''}"></td>
            <input type="hidden" name="page" value="${page}">
            <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
            <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
        </tr>
    </tbody>
	</table>	
</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<#if pageParam.items?? &&  pageParam.items?size &gt; 0>  
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            	<th>编号</th>
                <th>名称</th>
            	<th>行政区名称</th>
            	<th>拼音</th>
            	<th>简拼</th>
                <th>描述</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDistrictSign> 
			<tr>
				<td>${bizDistrictSign.signId!''} </td>
				<td>${bizDistrictSign.signName!''} </td>
				<td>${bizDistrictSign.districtName!''}<#if bizDistrictSign.parentDistrictName != "">--${bizDistrictSign.parentDistrictName!''}</#if>
				</td>
				<td>${bizDistrictSign.pinyin!''} </td>
				<td>${bizDistrictSign.shortPinyin!''} </td>
				<td>${bizDistrictSign.signDesc!''} </td>
				<td>
					<#if bizDistrictSign.cancelFlag == "Y"> 
						<span style="color:green" class="cancelProp">有效</span>
					<#else>
						<span style="color:red" class="cancelProp">无效</span>
					</#if>
				</td>
				<td class="oper">
                    <a href="javascript:void(0);" class="editProp" data=${bizDistrictSign.signId}>编辑基本属性</a>
                    <a href="/vst_back/pub/comCoordinate/modifyCoordinate.do?objectId=${bizDistrictSign.signId!''}&objectType=BIZ_DISTRICT_SIGN&coordType=BAIDU&searchKey=${bizDistrictSign.signName!''} ${bizDistrictSign.districtName!''}&signTypeName=${bizDistrictSign.signTypeBizDict.dictName}">设置百度经纬度</a>
                    <a href="/vst_back/pub/comCoordinate/modifyCoordinate.do?objectId=${bizDistrictSign.signId!''}&objectType=BIZ_DISTRICT_SIGN&coordType=GOOGLE&searchKey=${bizDistrictSign.signName!''} ${bizDistrictSign.districtName!''}&signTypeName=${bizDistrictSign.signTypeBizDict.dictName}">设置谷歌经纬度</a>
                    <#if bizDistrictSign.cancelFlag == "Y"> 
                    	<a href="javascript:void(0);" class="cancelProp" data="N" signId=${bizDistrictSign.signId}>设为无效</a>
                    <#else>
                    	<a href="javascript:void(0);" class="cancelProp" data="Y" signId=${bizDistrictSign.signId}>设为有效</a>
                    </#if>
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
	
<#else>
	<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关地理位置，重新输入相关条件查询！</div>
</#if>
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var addDialog,updateDialog;

$("select[name='cancelFlag']").val("${bizDistrictSign.cancelFlag}");

$(function(){

//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});

//新建
$("#new_button").bind("click",function(){
	var url = "/vst_back/biz/districtSign/showAddDistrictSign.do";
	addDialog = new xDialog(url, {}, {title:"新增地理位置",width:500});
});

//修改
$("a.editProp").bind("click",function(){
	var signId = $(this).attr("data");
	var url = "/vst_back/biz/districtSign/showUpdateDistrictSign.do";
	updateDialog = new xDialog(url,{"signId":signId}, {title:"修改地理位置",width:500});
});
		
//设置为有效或无效
$("a.cancelProp").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var signId = entity.attr("signId");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
 	$.confirm(msg, function () {	
	$.ajax({
		url : "/vst_back/biz/districtSign/cancelDistrictSign.do",
		type : "post",
		data : {"cancelFlag":cancelFlag,"signId":signId},
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
});

//确定并刷新
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
}
</script>
