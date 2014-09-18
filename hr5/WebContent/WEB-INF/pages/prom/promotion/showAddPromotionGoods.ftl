<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<#import "/base/spring.ftl" as s/>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li>促销&gt;</li>
            <li class="active">促销维护 &gt;</li>
            <li class="active">促销商品</li>
        </ul>
</div>
<div style="color:red;padding-left:30px;">
	注，仅针对某个品类的促销，则可选择的商品只能是这个品类的商品<br/>
	
	注，优惠条件、优惠方案设置后，除“分销商做删除添加”，其他均不能变更。若填写有误，则关闭该促销活动，重新创建一个
	<br/>
	注，若优惠条件，优惠方案，不能满足你的要求。。。请联系技术部，帮你添加对应的条件、方案
</div>
<form action="/vst_back/prom/promotion/savePromotionInfo.do" method="post" id="dataForm">
		<input type="hidden" name="promPromotion.promPromotionId" value="${promPromotionVo.promPromotion.promPromotionId}">
     	<div id="conditionDiv"  style="padding-left:30px;">
     		<div class="title">
				<h2 class="f16">优惠条件</h2>
			</div>
			<input type="radio" name="promPromotion.favorableTarget" controlName="categoryPayDiv" value="PROM_TARGET"
			 <#if promPromotionVo.promPromotion.favorableTarget == 'PROM_GOODS'>disabled="disabled"</#if>
			 <#if promPromotionVo.promPromotion.favorableTarget == 'PROM_TARGET'>checked="checked"</#if> >产品品类+支付方式
			<div id="categoryPayDiv"  style="padding-left:30px;display: none;">
				<table class="p_table form-inline">
		            <tbody>
		                <tr>
		                	<td width="140px;">
							选择产品品类
							</td>
		                	<td ><@s.formCheckboxes1 "promPromotionVo.categoryValues" categoryMap "" ""/></td>
		                </tr>
		                <tr>
		                	<td width="140px;">
							选择商品支付方式
							</td>
		                	<td ><@s.formCheckboxes1 "promPromotionVo.payMentValues" payMentMap "" ""/></td>
		                </tr>
		            </tbody>
        		</table>
			</div>
			<br/>
			<input type="radio" name="promPromotion.favorableTarget"  controlName="goodsDiv"  value="PROM_GOODS"
			<#if promPromotionVo.promPromotion.favorableTarget == 'PROM_TARGET'>disabled="disabled"</#if>
			<#if promPromotionVo.promPromotion.favorableTarget == 'PROM_GOODS'>checked="checked"</#if> >指定商品
			<div id="goodsDiv"  style="padding-left:30px;display: none;">
			<label>产品名称或者ID：
            	<@s.formHiddenInput "promPromotionVo.productId"/>
            	<@s.formInput "promPromotionVo.productName" 'class="search"'/>
            	<a href="javascript:void(0);" onclick="goodsSelectConfirm();">确定</a>
            </label>
				<#--<a href="javascript:void(0);" id="selectGoods">选择商品</a> -->
				<table id="goodsTb" class="p_table form-inline">
					<thead>
                    <tr>
                    <th> 操作</th>
                	<th>品类</th>
                	<th>供应商编号</th>
                	<th>供应商</th>
                    <th>产品ID</th>
                    <th>产品名称</th>
                    <th>商品ID</th>
                    <th>[规格定义名][是否有效][规格名][是否有效]商品名字</th>
                    </tr>
                </thead>
		            <tbody>
		            <#list promPromotionVo.suppGoodsList as item> 
		                <tr>
		                	<td>
							<input type="hidden" name="suppGoodsIds" value="${item.suppGoodsId}">	
		                	<a href="javascript:void(0);" onclick='removeTr(this);' style="color:red;">删除</a></td>
		                	<td>${item.prodProduct.bizCategory.categoryName!''}<#if item.prodProduct.bizCategory.cancelFlag =="N" ><span style="color:red"> [无效]</span></#if> </td>
							<td><#if item.suppSupplier??>${item.suppSupplier.supplierId!''}</#if></td>
							<td><#if item.suppSupplier??>${item.suppSupplier.supplierName!''}</#if></td>
							<td>${item.productId!''} </td>
							<td>${item.prodProduct.productName!''}</td>
							<td>${item.suppGoodsId!''}</td>
							<td>
								${item.prodProductBranch.bizBranch.branchName}
								<#if item.prodProductBranch.bizBranch.cancelFlag=="Y">有效<#else>无效</#if>
								${item.prodProductBranch.branchName}
								<#if item.prodProductBranch.cancelFlag=="Y">有效<#else>无效</#if>
								${item.goodsName!''}
							</td>
		                </tr>
		             </#list>
		            </tbody>
        		</table>
			</div>
		 </div>
        <br/>
        <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
            <div class="fl operate"><a class="btn btn_cc1" id="savePromGoods">保存</a></div>
        </div>
</form>
<#include "/base/foot.ftl"/>
</body>
</html>
<script> 
	$(function(){
		 
		$("#productName").jsonSuggest({
			url:"${rc.contextPath}/prod/product/queryProdProductList.do",
			maxResults: 20,
			minCharacters:1,
			onSelect:function(item){
				$("#productId").val(item.id);
			}
		});
		var condition=$("input[type=radio][name=promPromotion.favorableTarget]:checked").attr("controlName");
		$("#"+condition).show();
		$("input[type=radio][name=promPromotion.favorableTarget]").change(function(){
			$("input[type=radio][name=promPromotion.favorableTarget]").each(function(){
				var id=$(this).attr("controlName");
				if($(this).attr("checked")=="checked"){
	    			 $("#"+id).show();
		    	}else{
	    			 $("#"+id).hide();
		    	}
			});
		});
		
	});
	
	$("#savePromGoods").click(function(){
		var favorableTarget=$("input[type=radio][name=promPromotion.favorableTarget]:checked").val();
		if(favorableTarget==""||favorableTarget==undefined){
			$.alert("请选择一种优惠条件");
			return;
		}
		var categoryValues=$("input[type=checkbox][name=categoryValues]:checked").length;
		var payMentValues=$("input[type=checkbox][name=payMentValues]:checked").length;
		var goodsIds=$("input[type=hidden][name=suppGoodsIds]").length;
		 
		if(categoryValues<=0&&goodsIds<=0){
			$.alert("请选择优惠条件");
			return;
		}
		if(favorableTarget=="PROM_TARGET"&&categoryValues<=0){
			$.alert("请至少选择一种产品品类 ");
			return;
		}
		if(favorableTarget=="PROM_TARGET"&&payMentValues<=0){
			$.alert("请至少选择一个支付方式 ");
			return;
		}
		if(favorableTarget=="PROM_GOODS"&&goodsIds<=0){
			$.alert("请选择指定商品 ");
			return;
		}
		$.ajax({
				url : "/vst_back/prom/promotion/savePromotionGoods.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					if(!result.success){
				 		$.alert(result.message);
				 	}else{
						parent.refreshIframeMain("/vst_back/prom/promotion/showAddPromotionGoods.do?promPromotionId="+result.attributes.promPromotionId);
					}
					//promotionGoodsDialog.close();
				}
			});
	});
	
	
	function goodsSelectConfirm(){
		var id=$("#productId").val();
		var productName=$("#productName").val();
		if($.trim(id)==""||$.trim(productName)==""){
			$.alert("请重新输入产品名称或者产品ID查询！")
			return;
		}
		if($.trim(id)==""&&$.trim(productName)!=""){
			$.alert("暂无相关产品，请重新输入产品名称或者产品ID查询！")
			return;
		}
		 $.ajax({
				type: "POST",
				url: "/vst_back/prom/promotion/showSelectGoods.do?productId="+id,
				success: function (data) {
					$.dialog({
		                width: 1000,
		                title: "选择商品",
		                content: data,
		                ok: function(){
		                	$("input[type=checkbox][name=suppGoodsCk]:checked").each(function(){
								var id=$(this).val();
								var flagContent= true;
								$("#goodsTb input[type=hidden][name=suppGoodsIds]").each(function(){
								 	 if($(this).val()==id){
								 	 	flagContent=false
								 	 	return false;
								 	 }
								 });
								 if(flagContent){
								 	var line=$(this).parent().parent();
								 	var column1=$(line).find("td:eq(1)").html();
								 	var column2=$(line).find("td:eq(2)").html();
								 	var column3=$(line).find("td:eq(3)").html();
								 	var column4=$(line).find("td:eq(4)").html();
								 	var column5=$(line).find("td:eq(5)").html();
								 	var column6=$(line).find("td:eq(6)").html();
								 	var column7=$(line).find("td:eq(7)").html();
								 	$("#goodsTb tbody").append("<tr><td width='40'><input type='hidden' name='suppGoodsIds' value='"+id+"' /><a href='javascript:void(0);'  onclick='removeTr(this);'  style='color:red;' >删除</a></td><td>"+column1+"</td><td>"+column2+"</td><td>"+column3+"</td><td>"+column4+"</td><td>"+column5+"</td><td>"+column6+"</td><td>"+column7+"</td></tr>");
								 }
							});
		                },
		                cancel: true,
		                okValue: "确认",
		                cancelValue: "返回"
		            });
				}
			});
	}
	
	/**
	 * 移除一行
	 **/
	function removeTr(obj){
		if(confirm('确定要删除当前记录吗'))
		$(obj).parent().parent().remove();
	}
</script>
