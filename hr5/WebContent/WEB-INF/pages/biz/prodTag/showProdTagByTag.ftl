<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:800px;">
<!-- 订单详情页面传真查询 -->
 	<div class="price_tab">
        <ul class="J_tab ui_tab">   
            <li <#if prodTagVO.objectType=="PROD_PRODUCT" >class="active"</#if>>
            	<a href="javascript:;" name="tabChange" data=0>关联的产品</a>
            </li>
            <li <#if prodTagVO.objectType=="SUPP_GOODS" >class="active"</#if>>
            	<a href="javascript:;" name="tabChange" data=1>关联的商品</a>
            </li>
        </ul>
    </div>
	<div style="margin-top: 10px;" class="delProdTag">
		<#if prodTagVO.objectType=="PROD_PRODUCT">
			<a class="btn btn_cc1" href="javascript:void(0);" >删除标签关联的产品</a>
		<#else>
			<a class="btn btn_cc1" href="javascript:void(0);" >删除标签关联的商品</a>
		</#if>
	</div>
	
	<!-- 主要内容显示区域\\ -->
 	<form method="post" id="deleteForm">
		<div class="iframe-content">   
		    <div class="p_box">
			    <table class="p_table table_center" style="margin-top: 10px;">
                    <tr>
						<#if prodTagVO.objectType=="PROD_PRODUCT" > 
							<th>&nbsp;<input type="checkbox" class="selectAll"/></th>
							<th>产品ID</th>
		                    <th>产品名称</th>
		                    <th>起始时间</th>
		                    <th>结束时间</th>
		                    <th>品类</th>
						<#else>
		                	<th>
		                		<input type="checkbox" class="selectAll"/>
		                	</th>
							<th>商品ID</th>
		                    <th>商品名称</th>
		                    <th>起始时间</th>
		                    <th>结束时间</th>
		                    <th>品类</th>
						</#if>
                    </tr>
				    <#if pageParam??>
				    	<#if pageParam.items?? &&  pageParam.items?size &gt; 0>
							<#list pageParam.items as item> 
								<tr>
									<#if prodTagVO.objectType=="PROD_PRODUCT" > 
										<td><input type="checkbox" value="${item.reId}" name="reIds"/></td>
										<td>${item.productId}</td>
										<td>${item.productName}</td>
										<td>${item.startTime?string('yyyy-MM-dd')}</td>
										<td>${item.endTime?string('yyyy-MM-dd')}</td>
										<td>
											<#if item.categoryId?? && item.categoryId=='6'>
												邮轮组合产品
											<#else>
												${item.categoryName}
											</#if>
										</td>
									<#else>
										<td><input type="checkbox" value="${item.reId}" name="reIds"/></td>
										<td>${item.suppGoodsId}</td>
										<td>${item.goodsName}</td>
										<td>${item.startTime?string('yyyy-MM-dd')}</td>
										<td>${item.endTime?string('yyyy-MM-dd')}</td>
										<td>
											<#if item.categoryId?? && item.categoryId=='6'>
												邮轮组合产品
											<#else>
												${item.categoryName}
											</#if>
										</td>								
									</#if>
								</tr>
							</#list>
           				 </table>
						<#if pageParam.items?exists> 
							<div class="paging" > 
								${pageParam.getPagination()}
							</div> 
						</#if>
				    </#if>
			    </#if>
		    </div><!-- div p_box -->
		</div>
		<!-- //主要内容显示区域 -->
	</form>
	
	<form method="post" action='/vst_back/biz/bizTag/findProdTagByTagId.do' id="searchForm">
        <input type="hidden" name="objectType" id="objectType" value="${prodTagVO.objectType}"/>
        <input type="hidden" name="tagId" id="tagId" value="${prodTagVO.tagId}"/>
	</form>
	
	<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	$(function(){
		//tab切换
		$("a[name=tabChange]").click(function(){
			if($(this).attr("data")==0){
				$(this).parent().next().removeClass();
				$(this).parent().addClass('active');
				$('#objectType').val('PROD_PRODUCT');
			}else {
				$(this).parent().prev().removeClass();
				$(this).parent().addClass('active');
				$('#objectType').val('SUPP_GOODS');
			}
			$('#searchForm').submit();
		})
		
		// 删除标签关联的产品与商品信息
		$('.delProdTag').find('a').bind('click',function(){
			var size = $("input[type=checkbox][name=reIds]:checked").size();
			if(size<=0){
				$.alert('请选择需要删除的信息');
				return;
			}
			$.confirm('确定删除',function(){
				$.ajax({
					url : "/vst_back/biz/bizTag/deleteProdTag.do",
					type : "post",
					data : $("#deleteForm").serialize(),
					success : function(result) {
						if(result.code=='success'){
				 	 	 	 $.alert(result.message,function(){
				   				$('#searchForm').submit();
				 	 	 	 });
				 	 	 }else{
							$.alert(result.message);			 	 	 
				 	 	 }
					}
				});				
			});
		});
		
		// 全选与取消
		$('.selectAll').bind('click',function(){
			 if($(this).attr('checked')=='checked'){
				 $("input[type=checkbox][name=reIds]").attr('checked',true);			 	
			 }else{
			 	 $("input[type=checkbox][name=reIds]").attr('checked',false);
			 }
		});
	});
	
</script>


