<table id="selectGoodsTb" class="p_table table_center">
                <thead>
                    <tr>
                    <th><input type="checkbox" class="w6"  onclick="ckAll(this);"/></th>
                	<th>品类</th>
                	<th>供应商编号</th>
                    <th>供应商</th>
                    <th>产品ID</th>
                    <#--<th>产品名称[规格名][商品名]</th>-->
                    <th>产品名称</th>
                    <th>商品ID</th>
                    <th>[规格定义名][是否有效][规格名][是否有效]商品名字</th>
                    <th>产品状态</th>
                    <th>是否可售</th>
                    </tr>
                </thead>
                <tbody>
					<#list suppGoodsList as goods> 
					<tr>
					<td><input type="checkbox" class="w6" name="suppGoodsCk" value="${goods.suppGoodsId!''}"/></td>
					<td>${goods.prodProduct.bizCategory.categoryName!''}<#if goods.prodProduct.bizCategory.cancelFlag =="N" ><span style="color:red"> [无效]</span></#if> </td>
					<td><#if goods.suppSupplier??>${goods.suppSupplier.supplierId!''}</#if></td>
					<td><#if goods.suppSupplier??>${goods.suppSupplier.supplierName!''}</#if></td>
					<td>${goods.productId!''} </td>
					<#--<td>${goods.prodProduct.productName!''}
					[${goods.productBranch.branchName!''}]
					[${goods.suppGoods.goodsName!''}]
					 </td>-->
					<#--<td>${goods.suppGoods.suppSupplier.supplierName!''}<#if goods.suppSupplier.apiFlag=="Y"><span>[对接]</span><#else><span>[非对接]</span></#if></td>-->
					<td>${goods.prodProduct.productName!''}</td>
					<td>${goods.suppGoodsId!''}</td>
					<td>
						[${goods.prodProductBranch.bizBranch.branchName}]
						[<#if goods.prodProductBranch.bizBranch.cancelFlag=="Y">有效<#else><span style="color:red;">无效</span></#if>]
						[${goods.prodProductBranch.branchName}]
						[<#if goods.prodProductBranch.cancelFlag=="Y">有效<#else><span style="color:red;">无效</span></#if>]
						${goods.goodsName!''}
					</td>
					<td><#if goods.prodProduct.cancelFlag=="Y">有效<#else>无效</#if></td>
					<td>
					<#if goods.prodProduct.cancelFlag=="Y"&& goods.prodProductBranch.cancelFlag=="Y"&&
					goods.prodProductBranch.bizBranch.attachFlag=="Y"&&goods.cancelFlag=="Y">可售
					<#else>不可售</#if>
					</td>
					</tr>
					</#list>
                </tbody>
            </table>
<script>
	function ckAll(obj){
				if(obj.checked){
					$("input[name='suppGoodsCk']").attr("checked",true);
				  }else{
					  $("input[name='suppGoodsCk']").attr("checked",false);
				  }
			}
</script>