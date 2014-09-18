<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:600px">
<div class="iframe_search">
<form method="post" action='/vst_back/ship/prod/resourceSelect/findCruiseAdditionItemList.do' id="searchForm">
	<input type="hidden" name="categoryCode" value="category_cruise_addition">
	<input type="hidden" name="combProductId" value="${combProductId}">
	<input type="hidden" name="combOptionType" value="${combOptionType}">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">产品名称： </td>
                <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}"></td>
                <td class="s_label">产品ID：</td>
                 <td class="w18"><input type="text" name="productId" value="${prodProduct.productId!''}" number=true></td>
            </tr>
            <tr>
            	<td class="s_label">产品经理：</td>
                <td class="w18">
                <input type="text" name="managerName" id="managerName" value="${prodProduct.managerName}" >
                <input type="hidden" value="${prodProduct.managerId}" name="managerId" id="managerId" > </td>
                <td class="s_label"></td>
                <td class="w18"></td>
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
		<#if pageParam?? && pageParam.items?? && pageParam.items?size &gt; 0>
	        <thead>
	            <tr>
	            <th>
	            </th>
	        	<th>邮轮附加项ID</th>
	        	<th>邮轮附加项名称</th>
	            <th>产品经理</th>
	            </tr>
	        </thead>
	        <tbody>
				<#list pageParam.items as product > 
					<#if product??>
						<tr>
						<td><input type="checkbox" name="ids" value="${product.productId}" data="${product.productId}"></td>
						<td>${product.productId!''} </td>
						<td>${product.productName!''} </td>
						<td>${product.managerName!''}</td>
						</tr>
					</#if>
				</#list>
	       </tbody>
		<#else>
			<div class="no_data mt20"><i class="icon-warn32"></i>暂无查询结果，重新输入相关条件查询！</div>
		</#if>
    </table>
	</div>
</form>
</div><!-- //主要内容显示区域 -->
	<#if pageParam?? && pageParam.items?? && pageParam.items?size &gt; 0>
		<div class="paging" > 
			${pageParam.getPagination()}
		</div> 
	</#if>
 </div>
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