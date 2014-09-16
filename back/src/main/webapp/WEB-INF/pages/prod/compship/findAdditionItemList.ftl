<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px">
<div class="iframe_search">
<form method="post" action='/vst_back/ship/prod/resourceSelect/findAdditionItemList.do' id="searchForm">
	<input type="hidden" name="categoryCode" value="category_sightseeing">
	<input type="hidden" name="combProductId" value="${combProductId}">
	<input type="hidden" name="combOptionType" value="${combOptionType}">
    <table class="s_table">
        <tbody>
            <tr>
            	<td class="s_label">附加项目子品类：</td>
                <td class="w18">
                <select name="bizCategoryId">
                	<#if bizCategoryList?? && bizCategoryList?size &gt; 0>
                		<#list bizCategoryList as category>
                			<option value="${category.categoryId}" <#if category.categoryId==9>selected=selected<#else>disabled=disabled </#if> >${category.categoryName}</option>
                		</#list>
                	</#if>
                </select>
                </td>
                <td class="s_label">产品名称：</td>
                <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}"></td>
                <td class="s_label">产品ID：</td>
                 <td class="w18"><input type="text" name="productId" value="${prodProduct.productId!''}" number=true></td>
            </tr>
            <tr>
            	<td class="s_label">产品经理：</td>
                <td class="w18">
                <input type="text" name="managerName" id="managerName" value="${prodProduct.managerName}" >
                <input type="hidden" value="${prodProduct.managerId}" name="managerId" id="managerId" > </td>
                <td class="s_label">目的地：</td>
                <td class="w18"><input type="text" name="bizDistrict.districtName" value="<#if prodProduct.bizDistrict??>${prodProduct.bizDistrict.districtName!''}</#if>"></td>
                <td class="w18"><a class="btn btn_cc1" id="search_button">查询</a> <a class="btn btn_cc1" id="save_button">添加</a></td>
            </tr>
        </tbody>
    </table>	
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="p_box box_info" >
<form id="productBranchForm">
<div class="p_box">
<table class="p_table table_center">
        <thead>
            <tr>
            <th></th>
        	<th>岸上观光ID</th>
        	<th>岸上观光名称</th>
        	<th>目的地</th>
            <th>产品经理</th>
            </tr>
        </thead>
        <tbody>
        <#if pageParam??>
        <#if pageParam.items?? && pageParam.items?size &gt; 0>
			<#list pageParam.items as product > 
			<#if product??>
			<tr>
			<td><input type="checkbox" name="ids" value="${product.productId}" data="${product.productId}"></td>
			<td>${product.productId!''} </td>
			<td>${product.productName!''} </td>
			<td><#if product.bizDistrict??>${product.bizDistrict.districtName!''}</#if> </td>
			<td>${product.managerName!''}</td>
			</tr>
			</#if>
			</#list>
		</#if>
		</#if>
        </tbody>
    </table>
    <#if pageParam??&&pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
						</div> 
	</#if>
</form>
</div>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
<script>
	vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
	//查询
	$("#search_button").bind("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$("#searchForm").submit();
	});
	$("#save_button").bind("click",function(){
		var size = $("input[type='checkbox']:checked").size();
		if(size==0){
			$.alert("未选中任何条目");
			return;
		}
		$.ajax({
			url : '/vst_back/ship/prod/resourceSelect/saveCombRelation.do',
			type : "post",
			dataType : 'json',
			data : $("#productBranchForm,#searchForm").serialize(),
			success : function(data) {
		   	  	$.alert(data.message,function(){
		   	  		parent.location.reload();
		   	  	});
			}
		})
		
	});
</script>
</html>