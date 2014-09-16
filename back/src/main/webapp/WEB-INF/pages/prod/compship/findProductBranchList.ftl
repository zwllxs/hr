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
<form method="post" action='/vst_back/ship/prod/resourceSelect/findProductList.do' id="searchForm">
	<input type="hidden" name="categoryCode" value="category_cruise">
	<input type="hidden" name="combProductId" value="${combProductId}">
	<input type="hidden" name="combOptionType" value="${combOptionType}">
	<input type="hidden" name="selectProductId" value="${selectProductId}">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">邮轮名称：</td>
                <td class="w18"><input type="text" name="productName" value="${prodProduct.productName!''}" <#if selectProductId??>readonly="readonly"</#if> ></td>
                <td class="s_label">邮轮ID：</td>
                <td class="w18"><input type="text" name="productId" value="<#if selectProductId??>${selectProductId!''}<#else>${prodProduct.productId!''}</#if>" <#if selectProductId??>readonly="readonly"</#if> number=true></td>
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
<div style="background-color:grey;height:30px;width:100%;margin-top:20px;color:white;font-size:18px;"><span style="padding-left:5px">${product.productName}</span><span style="margin-left:50px">邮轮ID:${product.productId}</span></div>
<div class="p_box">
<table class="p_table table_center">
        <thead>
            <tr>
            <th>
            <input type="checkbox" name="checkAll_${product_index}" id="checkAll_${product_index}" data="${product.productId}"  onclick="checkAllCheckBox(this,${product_index},${product.productId})">
            </th>
        	<th>舱房ID</th>
        	<th>舱房名称</th>
        	<th>所属舱型</th>
            <th>舱房面积</th>
            <th>可住人数</th>
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
				<#if productBranch.propValue['cabin_type']?? && productBranch.propValue['cabin_type']?size &gt; 0>
					<#list productBranch.propValue['cabin_type'] as propValue > 
						${propValue.name}
					</#list>
				</#if>
			</td>
			<td>${productBranch.propValue['area']!''}</td>		
			<td>${productBranch.propValue['occupant_number']!''}</td>			
			</tr>
			<tr id ></tr>
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
	$(".checkedIds").bind("click",function(){
		var productId = $(this).attr("data");
		$("input[data!="+productId+"]").removeAttr("checked");
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
	
		$("input[data!="+productId+"]").removeAttr("checked");
	
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