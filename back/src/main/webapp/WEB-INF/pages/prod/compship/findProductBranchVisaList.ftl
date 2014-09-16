<!DOCTYPE html>
<html>
<head>
<#import "/base/spring.ftl" as spring/>
<#include "/base/head_meta.ftl"/>
<#import "/base/pagination.ftl" as pagination>
</head>
<body>
<div id="pageDiv" style="padding-bottom:50px;min-height:500px;">
<div class="iframe_search" >
<form method="post" action='/vst_back/ship/prod/resourceSelect/findProductVisaList.do' id="searchForm">
	<input type="hidden" name="categoryCode" value="category_visa">
	<input type="hidden" name="combProductId" value="${combProductId}">
	<input type="hidden" name="combOptionType" value="${combOptionType}">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">签证名称：</td>
                <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}" <#if selectProductId??>disabled="disabled"</#if> ></td>
                <td class="w18"><a class="btn btn_cc1" id="search_button">查询</a> <a class="btn btn_cc1" id="save_button">添加</a></td>
            </tr>
        </tbody>
    </table>	
	</form>
</div>
<!-- 主要内容显示区域\\ -->
<div class="p_box box_info">
<#if pageParam??>
<#if pageParam.items?? && pageParam.items?size &gt; 0>
<form id="productBranchForm">
<#list pageParam.items as product > 
<div style="background-color:grey;height:30px;width:100%;margin-top:20px;color:white;font-size:18px;"><span style="padding-left:5px">${product.productName}</span><span style="margin-left:50px">签证ID:${product.productId}</span></div>
<div class="p_box">
<table class="p_table table_center">
        <thead>
            <tr>
            <th>
            <input type="checkbox" name="checkAll_${product_index}" id="checkAll_${product_index}" data="${product.productId}"  onclick="checkAllCheckBox(this,${product_index},${product.productId})">
            </th>
        	<th>签证规格ID</th>
        	<th>签证规格名称</th>
        	<th>签证国家</th>
            <th>签证类型</th>
            </tr>
        </thead>
        <tbody>
        <#if product.prodProductBranchList?? && product.prodProductBranchList?size &gt; 0>
			<#list product.prodProductBranchList as productBranch > 
			<tr>
			<td><input type="checkbox" name="ids"  value="${productBranch.productBranchId!''}"  dataName="ids_${product_index}" data="${product.productId}" id="checkedIds" class="checkedIds"></td>
			<td>${productBranch.productBranchId!''} </td>
			<td>${productBranch.branchName!''}</td>
			<td>
				${product.districtName};
			</td>
			<td>
				<#if productBranch.propValue['visa_type']?? && productBranch.propValue['visa_type']?size &gt; 0>
					<#list productBranch.propValue['visa_type'] as propValue > 
						${propValue.name}
					</#list>
				</#if>
			</td>			
			</tr>
			</#list>
		</#if>
        </tbody>
    </table>
    </#list>
</div>
</form>
</#if>
<#else>
	<div class="no_data mt20"><i class="icon-warn32"></i>暂无查询结果，重新输入相关条件查询！</div>
</#if>
</div><!-- //主要内容显示区域 -->
	<#if pageParam.items?exists> 
					<div class="paging" > 
					${pageParam.getPagination()}
						</div> 
				</#if>
 </div>
  <#include "/base/foot.ftl"/>
</body>
<script>
	//查询
	$("#search_button").live("click",function(){
		if(!$("#searchForm").validate().form()){
				return false;
			}
		$("#searchForm").submit();
	});
	$("#save_button").live("click",function(){
		
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
		   	  		window.parent.location.reload();
		   	  	});
			}
		})
		
	});
	
	function  checkAllCheckBox(obj,index,productId){
	
		var nameStr='ids_'+index;
		
		var ischeckAll=$(obj).attr("checked"); 
		//alert(nameStr+"--"+ischeckAll);
		  if(ischeckAll=="checked")
		  {
		  	$("input[dataName='"+nameStr+"']").attr("checked",true)
		  }else{
		  	$("input[dataName='"+nameStr+"']").attr("checked",false)
		  }
	}
	$("#checkAll").bind("click",function(){
			  var ischeckAll=$("input[name='ids']").attr("checked"); 
			  if(!ischeckAll)
			  {
			  	$("input[name='ids']").attr("checked",true)
			  }else{
			  	$("input[name='ids']").attr("checked",false)
			  }
	});
</script>
</html>