<div class="listHead">
	<div style="background-color:#00B2EE;width:100%;position:relative;height:30px;">
		<span style="color:white">已选岸上观光</span>
		<span style="color:white;position:absolute;right:150px">选购方式:任选一项</span>
		<input type="hidden" id="sight_select_type" value="ONE">
		<input type="hidden" id="sightProductId"  value="${productId}">
		<a class="btn btn_cc1" id="sight_button" style="position:absolute;right:5px">添加</a>
	</div>
	<div></div>
</div>
<div class="listBody">
<#if relationProductList?? && relationProductList?size &gt; 0>
<table class="p_table table_center">
    <thead>
        <tr>
    	<th>岸上观光ID</th>
        <th>岸上观光名称</th>
        <th>目的地</th>
        <th>产品经理</th>
        <th>操作</th>
        </tr>
    </thead>
    <tbody>
		<#list relationProductList as rp> 
		<tr>
		<td>${rp.product.productId} </td>
		<td>${rp.product.productName!''} </td>
		<td>${rp.product.bizDistrict.districtName!''}</td>
		<td>${rp.product.managerName!''}</td>
		<td><a href="javascript:void(0);" data="${rp.combRelation.combRelationId}" class="sight_delete">删除</a> </td>
		</tr>
		</#list>
    </tbody>
</table>
</#if>
</div>
<script>
	$("#sight_button").click(function(){
		var productId = $("#sightProductId").val();
		var sightType = $("#sight_select_type").val();
		new xDialog("/vst_back/ship/prod/resourceSelect/findAdditionItemList.do?combProductId="+productId+"&combOptionType="+sightType,{},{title:"选择附加项目",iframe:true,width:"1100",height:'600'});	
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