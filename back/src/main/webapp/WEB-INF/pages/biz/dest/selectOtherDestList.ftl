<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_search">
<form method="post" action='/vst_back/biz/dest/selectDestList.do' id="searchForm">
<input type="hidden" name="type" value="${type}"/>
<input type="hidden" name="destId" value="${bizDest.destId}"/>
<input type="hidden" name="parentDestId" value="${parentDestId!''}"/>

    <table class="s_table">
        <tbody>
            <tr>
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
				<input type="checkbox"  class="ck-box" name="ck-destId" value="${bizDest.destId}">
				<input type="hidden" name="destNameHide" value="${bizDest.destName!''}">
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
            <td class=" operate mt10"><a class="btn btn_cc1" id="select_Button">确定</a></td>
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
for(var i = 0 ; i < newDests.length; i++){
   selectItem.push(newDests[i].destId);
}
$('input[name="ck-destId"]').each(function(){
	 //选中已有次父
     if($.inArray($(this).val(), selectItem) > -1){
         $(this).attr("checked",true);
     }
     
     //排除所有已有的父目地及自己,直系(次父)子孙
     if($(this).val()=='${parentDestId}'){
         $(this).attr("disabled",true);
     }
     if($(this).val()=='${oneselfDestId}'){
         $(this).attr("disabled",true);
     }
     if($.inArray($(this).val(), filterItem) > -1){
         $(this).attr("disabled",true);
     }
});
 
//确定提交
$("#select_Button").bind("click",function(){
	 parent.onSelectOtherDest(newDests);
	 window.parent.dests = newDests;//更新父变量
});

//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});

</script>
<script>
$("*[class='ck-box']").click(function(){ 
	if($(this).attr("checked")=="checked"){
		 var objParent = $(this).parent("td");
		 //添加选中对象
		 var dest = {};
         dest.destId = $(this).val();
         dest.destName = objParent.find("input[name='destNameHide']").val();
         newDests.push(dest);
	}else{ 
		newDests = window.parent.remove(newDests,"destId", $(this).val());
	} 
	
});

</script>

