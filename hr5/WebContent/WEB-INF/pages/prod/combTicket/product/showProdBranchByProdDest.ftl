<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body>
	<div class="main_all">
		<#--商品信息-->
		<#if pageParam??>
		    <#if pageParam.items?? &&  pageParam.items?size &gt; 0>
			    <div class="p_box box_info">
				    <table class="p_table table_center">
			            <thead>
			                <tr>
				            	<th width="80px">产品ID</th>
				                <th>套餐类型</th>
				                <th>产品名称</th>
				                <th>规格名称</th>
				                <th>状态</th>
				                <th width="100px">操作</th>
			                </tr>
			            </thead>
			            <tbody>
							<#list pageParam.items as prodDestReVO> 
								<tr>
									<td>${prodDestReVO.productId!''}</td>
									<td>${prodDestReVO.packageTypeDesc!''}</td>
									<td>${prodDestReVO.productName!''}</td>										
									<td>${prodDestReVO.branchName!''}</td>
									<td>
										<#if prodDestReVO.cancelFlag=='Y'>
											<span style="color:green" class="cancelProd">有效</span>
										<#else>
											<span style="color:red" class="cancelProd">无效</span>
										</#if>
									</td>
									<td class="oper">
				                        <a href="javascript:void(0);" categoryName="${prodDestReVO.categoryName}" data1="${prodDestReVO.categoryId}" data="${prodDestReVO.productId}" class="showProdProduct">查看产品</a>
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
				</div>
			<#else>
				<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div>
		    </#if>				
	    </#if>		
	</div>
	<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	 
	// 查看产品
	$('.showProdProduct').bind('click',function(){
		var productId = $(this).attr("data");
		var categoryId = $(this).attr("data1");
		var categoryName = $(this).attr("categoryName");
		window.open("/vst_back/prod/baseProduct/toUpdateProduct.do?productId="+productId+"&categoryId="+categoryId+"&categoryName="+categoryName);
		return false
	});

</script>