<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">首页</a> &gt;</li>
            <li><a href="#">运营&渠道</a> &gt;</li>
            <li><a href="#">分销商管理</a> &gt;</li>
            <li class="active">分销商商品</li>
        </ul>
</div>


<div class="iframe_search">
<form method="post" action='/vst_back/dist/distributorGoods/findDistributorGoodsList.do' id="searchForm">
        <table class="s_table">
            <tbody>
                <tr>
                    <td class="s_label">分销商名称：</td>
                    <td class="w18"><input type="text" name="distributor.distributorName" required=true value="<#if distDistributorGoods.distributor??>${distDistributorGoods.distributor.distributorName!''}</#if>"></td>
                    <td class="s_label">产品名称：</td>
                    <td class="w18"><input type="text" name="product.productName" value="<#if distDistributorGoods.product??>${distDistributorGoods.product.productName!''}</#if>"></td>
                    <td class="s_label">产品ID：</td>
                    <td class="w18"><input type="text" name="productId" number=true value="<#if distDistributorGoods.productId??>${distDistributorGoods.productId!''}</#if>"></td>
                 </tr>
                 <tr>
                    <td class="s_label">营销活动：</td>
                    <td class="w18">
                    <select name="" >	
                    		<option value="N">不限</option>
                    </select>
                    </td>
                    <td class="s_label">库存限制：</td>
                    <td class="w18"><select name="" >	
                    		<option value="N">不限</option>
                    </select>
                    </td>
                    <td class="s_label">不退改：</td>
                    <td class="w18"><select name="" >	
                    		<option value="N">不限</option>
                    </select>
                    </td>
                    <td class=" operate mt10">&nbsp;&nbsp;&nbsp;</td>          
                    <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                 </tr>                
            </tbody>
        </table>	
		</form>
    </div>
<!-- 主要内容显示区域\\ -->

<div class="iframe-content"> 
<#if pageParam.items?? &&  pageParam.items?size &gt; 0>  
    <div class="p_box">
	<table class="p_table table_center">
                <thead>
                    <tr>
                	<th>品类</th>
                    <th>产品ID</th>
                    <th>产品名称[规格名][商品名]</th>
                    <th>供应商</th>
                    <th>产品状态</th>
                    <th>是否可售</th>
                    <th>操作</th>
                    </tr>
                </thead>
                <tbody>
					<#list pageParam.items as distDistributorGoods> 
					<tr>
					<td>${distDistributorGoods.product.bizCategory.categoryName!''}<#if distDistributorGoods.product.bizCategory.cancelFlag =="N" ><span style="color:red"> [无效]</span></#if> </td>
					<td>${distDistributorGoods.productId!''} </td>
					<td>${distDistributorGoods.product.productName!''}
					[${distDistributorGoods.productBranch.branchName!''}]
					[${distDistributorGoods.suppGoods.goodsName!''}]
					 </td>
					<td>${distDistributorGoods.suppGoods.suppSupplier.supplierName!''}<#if distDistributorGoods.suppGoods.suppSupplier.apiFlag=="Y"><span>[对接]</span><#else><span>[非对接]</span></#if></td>
					<td><#if distDistributorGoods.product.cancelFlag=="Y">有效<#else>无效</#if></td>
					<td>
					<#if distDistributorGoods.product.cancelFlag=="Y"&& distDistributorGoods.productBranch.cancelFlag=="Y"&&
					distDistributorGoods.productBranch.bizBranch.attachFlag=="Y"&&distDistributorGoods.suppGoods.cancelFlag=="Y">可售
					<#else>不可售</#if>
					</td>
					<td class="oper">
                            <a href="javascript:void(0);" class="showProp" data=${distDistributorGoods.productId!''} >预览</a>
                            <a href="javascript:void(0);" class="editPro" data=${distDistributorGoods.distGoodsId!''} >查看运营设置</a>					
                            <a href="javascript:void(0);" class="cancelProp" data=${distDistributorGoods.distGoodsId!''}>删除</a>
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
		<div class="no_data mt20"><i class="icon-warn32"></i>暂无相关分销商商品，重新输入相关条件查询！</div>
    </#if>
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>
<script>


	//查询
	$("#search_button").bind("click",function(){
	if(!$("#searchForm").validate().form()){
				return false;
			}
		$(".iframe-content").empty();
		$(".iframe-content").append("<div class='loading mt20'><img src='../../img/loading.gif' width='32' height='32' alt='加载中'> 加载中...</div>");
		$("#searchForm").submit();
	});
	
	//预览
	$("a.showProp").bind("click",function(){
		var productId = $(this).attr("data");
		window.open("http://hotels.lvmama.com/hotel/"+productId);
	});
	
	//删除
	$("a.cancelProp").bind("click",function(){
	
	 	 var distGoodsId=$(this).attr("data");
        $.confirm("删除不能恢复,确认删除吗？", function () {
		$.ajax({
			url : "/vst_back/dist/distributorGoods/editFlag.do",
			type : "get",
			async: false,
			data : {distGoodsId : distGoodsId},
			dataType:'JSON',
			success : function(result) {
				 confirmAndRefresh(result);
			}
		});
   });
	   return false;
});

	
	//确定并刷新
	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				location.reload();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	}
	
</script>
