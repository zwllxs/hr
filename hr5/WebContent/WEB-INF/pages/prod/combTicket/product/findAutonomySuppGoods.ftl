<!DOCTYPE html>
<html>
<head></head>
<body>
	<#if pageParam??>
	    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
	    <div class="p_box box_info">
		    <table class="p_table table_center">
	            <thead>
	                <tr>
		            	<th width="80px">门票子品类</th>
		                <th>产品名称</th>
		                <th>商品名称</th>
		                <th width="350px">操作</th>
	                </tr>
	            </thead>
	            <tbody>
					<#list pageParam.items as suppGoods> 
						<tr>
							<td>${suppGoods.categoryName!''}</td>
							<td>${suppGoods.productName!''} </td>
							<td>${suppGoods.goodsName!''} </td>
							<td class="oper">
		                        <a href="javascript:void(0);" class="addSuppGoods" data="${suppGoods.suppGoodsId}">添加</a>
		                    </td>
						</tr>
					</#list>
	            </tbody>
	        </table>
			<#if pageParam.items?exists> 
				<div class="paging" > 
					${pageParam.getPagination()}
				</div> 
			</#if>
		</div><!-- div p_box -->
		<#else>
			<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
	    </#if>
    </#if>	
</body>
</html>
<script>
	 
	$("#saveAndNext").click(function(){
    	//遮罩层
		$.ajax({
			url : "/vst_back/combTicket/prod/product/addProduct.do",
			type : "post",
			dataType : 'json',
			data :{},
			success : function(result) {
				if(result.code == "success"){
					//为子窗口设置productId
					$("input[name='productId']").val(result.attributes.productId);
					//为父窗口设置productId
					$("#productId",window.parent.document).val(result.attributes.productId);
					$("#productName",window.parent.document).val(result.attributes.productName);
					$("#categoryName",window.parent.document).val(result.attributes.categoryName);			
				}else {
					$.alert(result.message);
				}
			}
		});
	});
		if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a").remove();
	}
</script>