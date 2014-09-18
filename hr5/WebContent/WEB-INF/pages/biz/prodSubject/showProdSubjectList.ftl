<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="iframe_content">
	<!-- 主要内容显示区域\\ -->
	    <div class="p_box box_info">
	    	<table class="p_table table_center" style="margin-top: 10px;">
	            <thead>
	                <tr>
	                	<th width="50px">产品ID</th>
	                    <th width="100px">产品名称</th>
	                    <th width="100px">品类</th>
	                </tr>
	            </thead>
    	    	<#if pageParam??>
    				<#if pageParam.items?? &&  pageParam.items?size &gt; 0>
			            <tbody>
							<#list pageParam.items as prodSubject> 
							<tr>
								<td>${prodSubject.productId!''}</td>
								<td>
									<#if prodSubject.prodProduct??>
										${prodSubject.prodProduct.productName!''}
									</#if>
								</td>
								<td>
									<#if prodSubject.prodProduct?? && prodSubject.prodProduct.bizCategory??>
										${prodSubject.prodProduct.bizCategory.categoryName!''}
									</#if>								
								</td>
							</tr>
							</#list>
			            </tbody>
			        </#if>
			    </#if>
	        </table>
			<#if pageParam?? && pageParam.items?size &gt; 0> 
				<div class="paging" > 
					${pageParam.getPagination()}
				</div> 
			</#if>
		</div><!-- div p_box -->
		<div class="p_box box_info" style="width:700;" align="center">
			<a class="btn btn_cc1" id="cancel">取消</a>
		</div>
	<!-- //主要内容显示区域 -->
	</div>
</body>
</html>
<script>
	
	$(function(){
		// 取消
		$('#cancel').bind('click',function(){
			showProdProduct.close();	
		});
	});
	
	
</script>


