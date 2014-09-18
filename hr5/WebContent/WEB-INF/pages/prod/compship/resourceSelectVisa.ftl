<div class="listHead">
	<div style="background-color:#00B2EE;width:100%;position:relative;height:30px;">
		<span style="color:white">已选签证</span>
		<span style="color:white;position:absolute;right:150px">选购方式:必选</span>
		<select style="position:absolute;right:100px" id="visa_select_type" <#if relationProductList?? && relationProductList?size &gt; 0>disabled=disabled</#if> >
			<option value="REQUIR" <#if prodCombOption.optionType == "REQUIR">selected=selected</#if> >必选</option>
			<option value="NONE" <#if prodCombOption.optionType == "NONE">selected=selected</#if>>可选</option>
		</select>
		<input type="hidden" id="visaProductId"  value="${productId}">
		<a class="btn btn_cc1" id="visa_button" style="position:absolute;right:5px">添加</a>
	</div>
	<div></div>
</div>
<#if relationProductList?? && relationProductList?size &gt; 0>
<#list relationProductList as rp>
<#assign prodCombRelationBranchList = rp.prodCombRelationBranchList />
<#assign product = rp.product />
<div style="background-color:grey;height:30px;width:100%;color:white;font-size:18px;"><span style="padding-left:5px">${product.productName}</span><span style="margin-left:50px">签证ID:${product.productId}</span></div>
<#if prodCombRelationBranchList?? && prodCombRelationBranchList?size &gt; 0>
<div class="listBody">
<table class="p_table table_center">
    <thead>
        <tr>
    	<th>签证规格ID</th>
    	<th>签证规格名称</th>
    	<th>签证国家</th>
        <th>签证类型</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
		<#list prodCombRelationBranchList as rb> 
		<tr>
		<td>${rb.productBranch.productBranchId} </td>
		<td>${rb.productBranch.branchName!''} </td>
		<td>
			${product.districtName}
		</td>
		<td>
			<#if rb.productBranch.propValue['visa_type']?? && rb.productBranch.propValue['visa_type']?size &gt; 0>
				<#list rb.productBranch.propValue['visa_type'] as propValue > 
					${propValue.name}
				</#list>
			</#if>
		</td>			
		<td><a href="javascript:void(0);" data="${rb.combRelation.combRelationId}" class="visa_delete">删除</a> </td>
		</tr>
		</#list>
    </tbody>
</table>
</#if>
</div>
</#list>
</#if>
<script>
	$("#visa_button").click(function(){
		var productId = $("#visaProductId").val();
		var visaType = $("#visa_select_type").val();
		new xDialog("/vst_back/ship/prod/resourceSelect/findProductVisaList.do?combProductId="+productId+"&combOptionType="+visaType,{},{title:"选择签证",iframe:true,width:"1100",height:'600'});	
	});
	
		//删除
	$("a.visa_delete").click(function(){
		var relationId = $(this).attr("data");
		if(confirm("确定删除?")){
			$.get("/vst_back/ship/prod/resourceSelect/deleteCombRelation.do?combRelationId="+relationId,function(result){
				location.reload();
			});
		}
	});
</script>