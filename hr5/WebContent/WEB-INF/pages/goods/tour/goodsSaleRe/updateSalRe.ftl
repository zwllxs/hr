<div class="iframe_content">
	<div>注，任选[0、1、2、3、…最大购买数]；可选[0、最大购买数]；等量[最大购买数]</div>
 </div>
 <div class="iframe_content">
	设置规则
 </div>
 <#if saleRelationList?? &&  saleRelationList?size==1>
 	<#assign saleRelation = saleRelationList[0].suppGoodsSaleRe>
 </#if>
 <form id="form">
 <div class="iframe_content">
 	<!--如果仅有一个关联关系，则设置默认选中-->
	<span style="margin-right:20px;">常规限制：</span><input type="radio"  name="reType" value="OPTIONAL" checked="checked">任选<input type="radio"  name="reType" value="OPTION" <#if saleRelation??&&saleRelation.reType=='OPTION'>checked=checked</#if> >可选<input type="radio"  name="reType" value="AMOUNT" <#if saleRelation??&&saleRelation.reType=='AMOUNT'>checked=checked</#if>>等量
 </div>
    
<!-- 主要内容显示区域\\ -->
    <#if saleRelationList?? &&  saleRelationList?size &gt; 0>
    <div class="p_box box_info">
    <table class="p_table table_center">
                <thead>
                    <tr>
                	<th width="80px">产品类型</th>
                    <th>产品ID</th>
                    <th>产品名称</th>
                    <th>规格ID</th>
                    <th>规格</th>
                    </tr>
                </thead>
                <tbody>
					<#list saleRelationList as pgr> 
					<input type="hidden" name="reIds" value="${pgr.suppGoodsSaleRe.reId}">
					<tr>
					<td>${pgr.category.categoryName!''}</td>
					<td>${pgr.product.productId!''} </td>
					<td>${pgr.product.productName!''} </td>
					<td>${pgr.productBranch.productBranchId!''}</td>
					<td>${pgr.productBranch.branchName!''}</td>
					</tr>
					</#list>
                </tbody>
            </table>
        
	</div><!-- div p_box -->
	</form>
	<#else>
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关关联产品！</div>
    </#if>
<!-- //主要内容显示区域 -->
</div>
  <div class="operate">
  	<a class="btn btn_cc1" id="update_button">保存并添加</a> 
  </div>
<script>
	$("#update_button").click(function(){
		$.ajax({
			url : '/vst_back/tour/goods/goods/updateGoodsSaleRe.do',
			type : 'POST',
			async : false,
			data : $("#form").serialize(),
			success : function(message){
				if(message=="success"){
					$.alert("更新成功",function(){
						if(goodsSaleUpdateDialog!=null)
							goodsSaleUpdateDialog.close();
						window.location.reload();
					});
				}else 
					$.alert(message);
			}
		});
		});
</script>


