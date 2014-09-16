<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
	<ul class="iframe_nav">
		<li><a href="#">酒店</a> &gt;</li>
		<li><a href="#">商品维护</a> &gt;</li>
		<li class="active">主次关联</li>
	</ul>
</div>
<div class="iframe_content mt10 clearfix">
	<div class="p_box box_info">
	        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">注，可以查询的供应商为在 “ 供应商合同关联 ” 里面维护的供应商</p>
             <p class="pl15">注，任选 [0 、 1 、 2 、 3 、 … 最大购买数 ] ；可选 [0 、最大购买数 ] ；等量 [ 最大购买数 ] </p>                  
         </div>  
		<form method="post" action='/vst_back/goods/goodsRelation/showGoodsRelationList.do' id="searchForm">
			<input type="hidden" id="productId" name="productId" value="${productId}" />
			 <input  type="hidden" id="categoryId" name="categoryId" value="${categoryId}"/>
		<div class="p_box box_info mt20">
			<table class="e_table form-inline">
				<tbody>					
					<tr>
						<td width="75" class="e_label td_top">选择供应商：</td>
						<td class="w25"><select id="supplierId" name="supplierId">
								<option value=""></option> 
								<#list suppSupplierList as suppSupplier>
									<option value="${suppSupplier.supplierId!''}">${suppSupplier.supplierName!''}</option> 
								</#list>
							</select>
						</td>
						<td>
							<div class="fl operate"><a class="btn btn_cc1" id="search_button">查询</a></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</form>
	
	<!-- 主要内容显示区域\\ -->	
		  <div class="p_box box_info mt20">
			<form method="post" id="relationFrom" action="/vst_back/goods/goodsRelation/saveRelation.do">
				<table class="p_table table_center">
				<#assign index = 0/>
					<#list suppGoodList as main> 
					<tr>
						<th colspan="4" style="text-align:left; font-size:14px; font-weight:bold;">[主规格] 
						<#if main.bizBranch!=null&&main.prodProductBranch.cancelFlag=="Y">[有效]</#if>
						<#if main.bizBranch!=null&&main.prodProductBranch.cancelFlag=="N">[无效]</#if>
						[${main.bizBranch.branchName}]
						[${main.prodProductBranch.branchName}]
						${main.goodsName}
						</th>						
					</tr>
											
							
								<tr>
									<th style="background:#EFF7FE; color:#797F98; border-bottom-color:#DBE7EF; border-left-color:#DBE7EF; border-right-color:#EFF7FE">是否关联</th>
									<th style="background:#EFF7FE; color:#797F98; border-bottom-color:#DBE7EF; border-right-color:#EFF7FE">次规格商品</th>
									<th style="background:#EFF7FE; color:#797F98; border-bottom-color:#DBE7EF; border-right-color:#EFF7FE">当主规格买一份，次规格最多可购买份</th>
									<th style="background:#EFF7FE; color:#797F98; border-bottom-color:#DBE7EF; border-right-color:#DBE7EF">下单数量可选</th> 
								</tr>
								<#list suppGoodList2 as secRelation>
								<#assign relation=relationMap[main.suppGoodsId+''+secRelation.suppGoodsId]>
								<tr>
									<td><input type="checkbox"<#if relation!=null> checked="checked"</#if> /></td>
									<td style="text-align:left;">
										<input type="hidden" name=suppGoodsRelationList[${index}].mainGoodsId id="mainGoodsId${index}" value="${main.suppGoodsId}" />
										<input type="hidden" name=suppGoodsRelationList[${index}].relationId id="relationId${index}"<#if relation!=null> value="${relation.relationId}" </#if> />
										<input type="hidden" name=suppGoodsRelationList[${index}].secGoodsId id="secGoodsId${index}" value="${secRelation.suppGoodsId}" /> 
										<#if secRelation.bizBranch!=null&&secRelation.prodProductBranch.cancelFlag=="Y">[有效]</#if>
										<#if secRelation.bizBranch!=null&&secRelation.prodProductBranch.cancelFlag=="N">[无效]</#if>
										[${secRelation.bizBranch.branchName!''}]
										[${secRelation.prodProductBranch.branchName}]
										${secRelation.goodsName}
									</td>
									<td><select name=suppGoodsRelationList[${index}].maxQuantity disabled="disabled" data=${index}> 
											<#list 1..50 as i>
												<option <#if relation!=null&& i==relation.maxQuantity>selected=selected   </#if>value="${i}" >${i}</option> 
											</#list>
										</select>
									</td>
									<td><select name=suppGoodsRelationList[${index}].relationType disabled="disabled" data=${index} >
										<#list relationTypeList as relationType>
											<option <#if relation!=null&&relationType.code==relation.relationType>selected=selected</#if> value="${relationType.code!''}">${relationType.cnName!''}</option>
										</#list>
										</select>
									</td>
								</tr>
								<#assign index = index+1/> 
								</#list> 	
					
					</#list>
				</table>
			</form>
		</div>
		<div class="fl operate">
			<a class="btn btn_cc1" id="save_button">保存</a>
		</div>
	
</div>	
	<!-- //主要内容显示区域 -->

	<#include "/base/foot.ftl"/>
</body>
</html>
	<script>
		$(function(){
			$("#searchForm #supplierId").val("${supplierId!''}");
			$("input[type=checkbox]").each(function() {
				if ($(this).attr("checked") == "checked") {
					$(this).parent("td").parent("tr").find("select").removeAttr("disabled");
				}
			});
		});
		//查询
		$("#search_button").bind("click", function() {
					if ($("#supplierId").val() != null && $("#supplierId").val() != "") {
						$("#searchForm").submit();
					} else {
						alert("请先选择供应商！");
					}
				});
		//选中后去除disabled
		$("input[type=checkbox]").click(function() {
			if ($(this).attr("checked") == "checked") {
				$(this).parent("td").parent("tr").find("select").removeAttr("disabled");
			} else {
				$(this).parent("td").parent("tr").find("select").attr("disabled","disabled");
			}
		});
		//保存
		$("#save_button").bind("click", function() {
			
			$("input[type=checkbox]").each(function() {
					if ($(this).attr("checked") == "checked") {
						if ($(this).parents("tr").find("select").eq(1).val() == "DEFAULT") {
						alert("请选择下单类型");
						breek;
						}
					}else{
						$(this).parents("tr").find("input").eq(0).val(null);
						$(this).parents("tr").find("input").eq(1).val(null);
					}
			});
			$.ajax({
				url : "/vst_back/goods/goodsRelation/saveRelation.do",
				type : "post",
				data : $("#relationFrom").serialize(),
				success : function(result) {
					if (result.code == "success") {
						alert(result.message);
						$("#searchForm").submit();
					} else {
						alert(result.message);
					}

				}
			});
		});
	</script>