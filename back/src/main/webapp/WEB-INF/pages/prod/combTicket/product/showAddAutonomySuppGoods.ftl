<!DOCTYPE html>
<html>
<head>
<#include "/base/head_meta.ftl"/>
</head>
<body style="min-height:800px;">
	<div class="p_box box_info">
		<div id="templateDiv" style="display:none;">
			<table>
	             <tbody>
					<tr>
						<td>prdName</td>												 	
						<td>goodsName</td>				 	
						<td>adultChild</td>											 	
						<td>
							detailidsname
							pricetypesid
								<option value="FIXED_PRICE">固定加价</option>
								<option selected="selected" value="MAKEUP_PRICE">百分比加价</option>
							</select>
							<input type="text" style="width:100px;" pricesname/>
							showMakeupPrice
							errorMessage
						</td>												 	
						<td>
							packagecountsid
								<#assign packageCount=10> 
								<#list 1..packageCount as pCount>
									<option value="${pCount!''}">${pCount}</option>
								</#list>																			
							</select>
						</td>												 	
						<td>data</td>												 	
				 	</tr>	               
	            </tbody>
	       </table>			
		</div>
		<form method="post" action='/vst_back/combTicket/prod/product/autonomy/showAddAutonomySuppGoods.do' id="searchForm">
	        <table class="s_table">
	            <tbody>
	                <tr>
	                    <td class="s_label">门票子品类：</td>
	                    <td class="w18">
							<select name="categoryId" id="selectCategoryId">
								<option value="">全部</option>
								<option value="11" <#if suppGoodsBranchProductCategory.categoryId==11>selected="selected"</#if>>景点门票</option>
								<option value="12" <#if suppGoodsBranchProductCategory.categoryId==12>selected="selected"</#if>>其它票</option>
								<option value="13" <#if suppGoodsBranchProductCategory.categoryId==13>selected="selected"</#if>>组合套餐票</option>
							</select>	                    	
	                    </td>
	                    <td class="s_label">产品名称：</td>
	                    <td class="w18">
	                    	<input type="text" id="productName" value="${suppGoodsBranchProductCategory.productName}" name="productName"/>
	                    </td>
						<td class="s_label">商品名称：</td>
	                    <td class="w18">
	                    	<input type="text" id="goodsName" value="${suppGoodsBranchProductCategory.goodsName}" name="goodsName"/>
	                    </td>
	                    <td>
	                    	<input type="hidden" value="${suppGoodsBranchProductCategory.productId}" name="productId"/>	
	                    	&nbsp;
	                    </td>
	                    <td class="operate mt10"><a class="btn btn_cc1" id="search_button">搜索</a></td>
	                </tr>
	            </tbody>
	        </table>	
		</form>
	</div>
	<div class="main_all">
		<#--商品信息-->
		<div id="showSuppGoodsInfo">
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
									<td>
										${suppGoods.productName!''} 
									</td>
									<td>${suppGoods.goodsName!''} </td>
									<td class="oper">
				                        <a href="javascript:void(0);" adult="${suppGoods.adult!'0'}" child="${suppGoods.child!'0'}" class="addSuppGoods" goodsName="${suppGoods.goodsName!''}"  productName="${suppGoods.productName!''}" data2="${suppGoodsBranchProductCategory.categoryId!''}" data1="${suppGoodsBranchProductCategory.productId}" data="${suppGoods.suppGoodsId}">添加</a>
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
		</div>
		<form id="saveOrUpdate">
			<input type="hidden" id="productId" name="prodPackageGroup.productId"/>			
			<input type="hidden" id="categoryId" name="prodPackageGroup.categoryId"/>			
			<input type="hidden" id="objectId" name="objectId"/>			
		</form>
	</div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>
	
	// 搜索商品
	$("#search_button").click(function(){
		var initLoading1 = top.pandora.loading("正在努力加载...");
   		$("#searchForm").submit();
   		initLoading1.close();
	});
	 
	// 添加
	$('.addSuppGoods').bind('click',function(){
		var objectId = $(this).attr('data');// 商品ID
		$('#objectId').val(objectId);
		var productId = $(this).attr('data1');
		$('#productId').val(productId);
		var categoryId = $(this).attr('data2');
		$('#categoryId').val(categoryId);
		var adult = $(this).attr('adult');
		var child = $(this).attr('child');
		var goodsName = $(this).attr('goodsName');
		var productName = $(this).attr('productName');
		var adultChild = adult+'/'+child;
		
		$.ajax({
		 	 url:'/vst_back/combTicket/prod/product/autonomy/saveProdPackageDetail.do',
		 	 type: 'POST',
		 	 dataType: 'JSON',
		 	 data: $("#saveOrUpdate").serialize(),
		 	 success: function(result){
		 	 	 if(result.code=='success'){
		 	 	 	 $.alert(result.message,function(){
		 	 	 	 	 var detailId = result.attributes.detailId;
		 	 	 	 	 var groupId = result.attributes.groupId;
		 	 	 	 	 $('#groupId', window.parent.document).val(groupId);
		 	 	 	     var tr = $("#templateDiv").find('tr').attr('id',detailId);
						 var detailTemplate = $("#templateDiv").find('tr').html();
						 detailTemplate = detailTemplate.replace('prdName',productName);
						 detailTemplate = detailTemplate.replace('goodsName',goodsName);
						 detailTemplate = detailTemplate.replace('adultChild',adultChild);
						 detailTemplate = detailTemplate.replace('detailidsname',"<input type=\'hidden\' value=\'"+detailId+"\' name=\'detailIds\'/>");// 打包关系ID
						 detailTemplate = detailTemplate.replace('pricetypesid',"<select class=\'MAKEUP_PRICE\' detailId=\'"+detailId+"\' id=\'priceTypes"+detailId+"\' style=\'width:100px;\'>");// 价格模式
						 detailTemplate = detailTemplate.replace('pricesname',"id=\'prices"+detailId+"\' name=\'prices"+detailId+"\' errorEle=\'code"+detailId+"\' required");
						 detailTemplate = detailTemplate.replace('showMakeupPrice',"<div id=\'showMakeupPrice"+detailId+"\' >%</div>");
						 detailTemplate = detailTemplate.replace('errorMessage',"<div id=\'code"+detailId+"Error\' style=\'display:inline\'></div>");
						 detailTemplate = detailTemplate.replace('packagecountsid',"<select id=\'packageCounts"+detailId+"\' style=\'width:50px;\'>");// 打包数量
						 var a = "<a class='delDetail' href='javascript:void(0);' data=\'"+detailId+"\' onclick=\'delSuppGoodsDetail(this);\'>删除</a>";
						 detailTemplate = detailTemplate.replace('data',a);
						 var table = $('#suppGoodsList', window.parent.document);
						 table.append("<tr id=\'"+detailId+"\'><input type=\'hidden\' value=\'"+productName+"\' name=\'productNames\'/>"+detailTemplate+"</tr>");
		 	 	 	 });
		 	 	 }else{
					$.alert(result.message);			 	 	 
		 	 	 }
		 	 }
		 });
	});
	if($("#isView",parent.top.document).val()=='Y'){
		$(".btn,.oper>a,.delDetail").remove();
	}
</script>