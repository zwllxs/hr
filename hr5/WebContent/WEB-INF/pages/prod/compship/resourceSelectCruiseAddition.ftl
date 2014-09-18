<div class="listHead">
	<div style="background-color:#00B2EE;width:100%;position:relative;height:30px;">
		<span style="color:white">已选邮轮附加项</span>
		<span style="color:white;position:absolute;right:150px">选购方式:任选一项</span>
		<select style="position:absolute;right:100px" id="sightType" <#if relationBranchList?? && relationBranchList?size &gt; 0>disabled=disabled</#if> >
			<option value="MORE_ONE" <#if prodCombOption.optionType == "MORE_ONE">selected=selected</#if> >一项起选</option>
			<option value="ONE" <#if prodCombOption.optionType == "ONE">selected=selected</#if>>任选一项</option>
			<option value="REQUIR" <#if prodCombOption.optionType == "REQUIR">selected=selected</#if> >必选</option>
			<option value="NONE" <#if prodCombOption.optionType == "NONE">selected=selected</#if>>可选</option>			
		</select>		
		<input type="hidden" id="sightProductId"  value="${productId}">
		<a class="btn btn_cc1" id="add_button" style="position:absolute;right:5px">添加</a>
	</div>
	<div></div>
</div>
<div class="listBody">
<#if relationProductList?? && relationProductList?size &gt; 0>
<table class="p_table table_center">
    <thead>
        <tr>
    	<th>邮轮附加项ID</th>
        <th>邮轮附加项名称</th>
        <th>产品经理</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
		<#list relationProductList as rp> 
		<tr>
		<td>${rp.product.productId} </td>
		<td>${rp.product.productName!''} </td>
		<td>${rp.product.managerName!''}</td>
		<td><a href="javascript:void(0);" data="${rp.combRelation.combRelationId}" class="sight_delete">删除</a> </td>
		</tr>
		</#list>
    </tbody>
</table>
</#if>
</div>
<script>
	$("#add_button").click(function(){
		var productId = $("#sightProductId").val();
		var sightType = $("#sightType").val();
		new xDialog("/vst_back/ship/prod/resourceSelect/findCruiseAdditionItemList.do?combProductId="+productId+"&combOptionType="+sightType,{},{title:"选择邮轮附加项",iframe:true,width:"1100",height:'600'});	
	});
	
		//删除
	$("a.sight_delete").click(function(){
		var relationId = $(this).attr("data");
		if(confirm("确定删除?")){
			$.get("/vst_back/ship/prod/resourceSelect/deleteCombRelation.do?combRelationId="+relationId,function(result){
				location.reload();
			});
		}
	});
</script>