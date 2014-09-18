<#if relationProductList?? && relationProductList?size &gt; 0>
	<#assign prodCombRelationBranchList = relationProductList[0].prodCombRelationBranchList />
	<#assign selectProduct = relationProductList[0].product />
</#if>

<div class="listHead">
	<div style="background-color:#00B2EE;width:100%;position:relative;height:30px;">
		<span style="color:white">已选舱房</span>
		<span style="color:white;padding-left:50px;"><#if selectProduct??>${selectProduct.productName}</#if> </span>
		<span style="color:white;position:absolute;right:280px" >选购方式</span>
		<select style="position:absolute;right:100px" id="cruise_select_type" <#if prodCombRelationBranchList?? && prodCombRelationBranchList?size &gt; 0>disabled=disabled</#if> >
			<option value="MORE_ONE" <#if prodCombOption.optionType == "MORE_ONE">selected=selected</#if> >一项起选</option>
			<option value="ONE" <#if prodCombOption.optionType == "ONE">selected=selected</#if>>任选一项</option>
		</select>
		<a class="btn btn_cc1" id="cruise_button" data="${selectProduct.productId}" style="position:absolute;right:5px">添加</a>
	</div>
	<div></div>
</div>
<div class="listBody">
<input type="hidden" id="productId" name="productId" value="${productId}">
<#if prodCombRelationBranchList?? && prodCombRelationBranchList?size &gt; 0>
<table class="p_table table_center">
    <thead>
        <tr>
    	<th>舱房ID</th>
        <th>舱房中文名称</th>
        <th>所属舱型</th>
        <th>舱房面积</th>
        <th>可住人数</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
		<#list prodCombRelationBranchList as rb> 
		<tr>
		<td>${rb.productBranch.productBranchId} </td>
		<td>${rb.productBranch.branchName!''} </td>
		<td>
				<#if rb.productBranch.propValue['cabin_type']?? && rb.productBranch.propValue['cabin_type']?size &gt; 0>
					<#list rb.productBranch.propValue['cabin_type'] as propValue > 
						${propValue.name}
					</#list>
				</#if>
			</td>
			<td>${rb.productBranch.propValue['area']!''}</td>		
			<td>${rb.productBranch.propValue['occupant_number']!''}</td>	
			<td><a href="javascript:void(0);" data="${rb.combRelation.combRelationId}" class="cruise_delete">删除</a> </td>
		</tr>
		</#list>
    </tbody>
</table>
</#if>
</div>
<script>
	$("#cruise_button").click(function(){
		var productId = $("#productId").val();
		var cruiseType = $("#cruise_select_type").val();
		var selectProductId = $(this).attr("data");
		new xDialog("/vst_back/ship/prod/resourceSelect/findProductList.do?combProductId="+productId+"&combOptionType="+cruiseType+"&selectProductId="+selectProductId,{},{title:"选择邮轮规格",iframe:true,width:"1100",height:'600'});	
	});
	
		//删除
	$("a.cruise_delete").click(function(){
		var relationId = $(this).attr("data");
		if(confirm("是否删除")){
			$.get("/vst_back/ship/prod/resourceSelect/deleteCombRelation.do?combRelationId="+relationId,function(result){
				location.reload();
			});
		}
	});
</script>