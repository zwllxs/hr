<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
<form method="post" action='/vst_back/biz/dest/selectDestList.do' id="searchForm">
 <input type="hidden" name="type" value="${type}"/>
 
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">目的地ID：</td>
                <td class="w18"><input type="text" name="pdestId" value="${destId!''}" number=true></td>
                <td class="s_label">目的地名称：</td>
                <td class="w18"><input type="text" name="destName" value="${destName!''}"></td>
                <td class="s_label">目的地类型：</td>
                <td class="w18">
                	<select name="destType">
                	<option value="">不限</option>
                    	<#list destTypeList as destTypeItem>
                    		<#if destType == destTypeItem.code>
                    		<option value="${destTypeItem.code!''}" selected="selected">${destTypeItem.cnName!''}</option>
                    		<#else>
                    		<option value="${destTypeItem.code!''}">${destTypeItem.cnName!''}</option>
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
        	<th>目的地编号</th>
            <th>目的地名称</th>
            <th>上级目的地</th>
            <th>类型</th>
            <th>上级行政区域</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizDest> 
			<tr>
			<td>
				<input type="radio" name="dest" value="${bizDest.destId!''}">
				<input type="hidden" name="destNameHide" value="${bizDest.destName!''}">
				<input type="hidden" name="destIdHide" value="${bizDest.destId!''}">
				<input type="hidden" name="destTypeHide" value="${bizDest.destTypeCnName!''}">
				<input type="hidden" name="foreighFlag" value="${bizDest.foreighFlag!''}">
			 </td>
			<td>${bizDest.destId!''} </td>
			<td>${bizDest.destName!''} </td>
			<td><#if bizDest.parentDest ??>${bizDest.parentDest.destName!''}</#if></td>
			<td>${bizDest.destTypeCnName!''} </td>
			<td>${bizDest.districtName!''} </td>
			</tr>
			</#list>
        </tbody>
    </table>
     <table class="co_table">
        <tbody>
            <tr>
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

var newDests = window.parent.dests;

var selectItem  = '${oldOtherParentDestIds}'.split(',');
var filterItem  = '${filterDestIds}'.split(',');

//继续加载已选次父目的
if (!newDests && typeof(newDests)!="undefined"){
	for(var i = 0 ; i < newDests.length; i++){
	   selectItem.push(newDests[i].destId);
	}
}

//排除所有已有的自己
$("input[type='radio']").each(function(){

     if($(this).val()=='${parentDestId}'){
         $(this).attr("checked",true);
     }
     
     //排除所有已有的父目地及自己,直系(次父)子孙
     if($(this).val()=='${oneselfDestId}'){
         $(this).attr("disabled",true);
     }

     if($.inArray($(this).val(), filterItem) > -1){
         $(this).attr("disabled",true);
     }
     
     if($.inArray($(this).val(), selectItem) > -1){
         $(this).attr("disabled",true);
     }
});

//查询
$("#search_button").bind("click",function(){
    if(!$("#searchForm").validate().form()){
		return;
	}
	$("#searchForm").submit();
});

$("input[type='radio']").bind("click",function(){
	var obj = $(this).parent("td");
	var dest = {};
	dest.destId = $("input[name='destIdHide']",obj).val();
    dest.destName = $("input[name='destNameHide']",obj).val();
    dest.destType = $("input[name='destTypeHide']",obj).val();
    dest.foreighFlag = $("input[name='foreighFlag']",obj).val();
	parent.onSelectDest(dest);
});

</script>


