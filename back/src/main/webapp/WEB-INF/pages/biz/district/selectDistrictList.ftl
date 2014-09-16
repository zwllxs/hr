<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
<form method="post" action='/vst_back/biz/district/selectDistrictList.do' id="searchForm">
	<input type="hidden" name="callBack" value="${callBack}"/>
	<input type="hidden" name="elementId" value="${elementId}"/>
	<input type="hidden" name="nameId" value="${nameId}"/>
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
                 <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
	</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            <th>选择</th>
        	<th>编号</th>
            <th>名称</th>
            <th>直接上级目的地</th>
            <th>类型</th>
            <th>拼音</th>
            <th>URL拼音</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDistrict> 
			<tr>
				<td>
					<input type="radio" name="district">
					<input type="hidden" name="districtNameHide" value="${bizDistrict.districtName!''}">
					<input type="hidden" name="districtIdHide" value="${bizDistrict.districtId!''}">
				 </td>
				<td>${bizDistrict.districtId!''} </td>
				<td>${bizDistrict.districtName!''} </td>
				<td>${(bizDistrict.parentDistrict.districtName)!''} </td>
				<td>${bizDistrict.districtTypeCnName!''} </td>
				<td>${bizDistrict.pinyin!''} </td>
				<td>${bizDistrict.urlPinyin!''} </td>
			</tr>
			</#list>
        </tbody>
    </table>
     <table class="co_table">
        <tbody>
            <tr>
                <td class=" operate mt10"><a class="btn btn_cc1" id="clear_Button">清除</a></td>
                 <td class="s_label">
                 	<#if pageParam.items?exists> 
						<div class="paging" > 
						${pageParam.getPagination()}
						</div> 
					</#if>
                 </td>
            </tr>
        </tbody>
    </table>	
	</div><!--p_box-->
	
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});

//清除
$("#clear_Button").bind("click",function(){
	if (typeof(parent.onClearDistrict) === "function") {
		var district = {};
		parent.onClearDistrict(district);
	}
});

$("input[type='radio']").bind("click",function(){
	var obj = $(this).parent("td");
	var district = {};
	district.districtId = $("input[name='districtIdHide']",obj).val();
    district.districtName = $("input[name='districtNameHide']",obj).val();
    district.elementId='${elementId}';
    district.nameId='${nameId}';
    <#if callBack?? && callBack!=''>
    	parent.${callBack}(district);
    <#else>
    	parent.onSelectDistrict(district);
    </#if>
	
});
	
</script>


