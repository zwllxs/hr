<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">邮轮</a> &gt;</li>
            <li><a href="#">商品维护</a> &gt;</li>
            <li class="active">供应商合同关联</li>
        </ul>
</div>
<div class="iframe_content mt10">
<!--
        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15">1.酒店自签，暂不支持“现付”请勿勾选</p>
            <p class="pl15">2.当“商品名”=“规格名”时，前台只显示规格的名称</p>      
        </div>
        -->
        <div class="p_box box_info">
        <form method="post" action='/vst_back/goods/shipAddition/findSuppGoodsList.do' id="searchForm">
            <input type="hidden" name="prodProduct.bizCategory.categoryName" value="${suppGoods.prodProduct.bizCategory.categoryName!''}">
            <input type="hidden" name="prodProduct.productId" value="${suppGoods.prodProduct.productId!''}">
           <input type="hidden" name="prodProduct.bizCategory.categoryId" value="${suppGoods.prodProduct.bizCategory.categoryId!''}">
        <input type="hidden" id="cancelFlag1" name="cancelFlag" value="${cancelFlag}">
            <table class="e_table form-inline">
            <tbody>             
                </tr>
                    <tr>
	                    <td width="150" class="e_label td_top"><i class="cc1">*</i>选择供应商：</td>
	                    <td class="w18" colspan='5'>
	                    <input type="hidden" name="productId" value="${suppGoods.prodProduct.productId!''}">
	                    <input type="text" placeholder="请输入供应商名称" class="w35 search" name="suppSupplier.supplierName" id="supplierName" <#if suppGoods != null && suppGoods.suppSupplier != null>value="${suppGoods.suppSupplier.supplierName}"</#if> >
                	    <input type="hidden"  name="supplierId" id="supplierId" value="${suppGoods.supplierId!''}" required=true>
                	    
	                    <!--<a class="btn btn_cc1" id="selectSupplierButton">选择供应商</a><span class="cc3">(仅针对供应商进行查询)</span>-->
	                    <a class="btn btn_cc1" id="search_button">查询供应商商品</a>
                    	<div class="cc3"> 注：下面的内容维护人员、商品默认合同，添加新商品时均为默认值。 </div></td>
                    </tr>
                     
                    <tr>
                        <td class="e_label"></td>
                        <td><div class="fl operate"><a class="btn btn_cc1" id="new_button">添加新商品</a></div></td>
                    </tr>
                </tbody>
            </table>
        </div>
 <!-- 主要内容显示区域\\ -->        
                <#if suppGoodsMap?? && suppGoodsMap?size &gt; 0> 
	                <#list suppGoodsMap?keys as testKey>
	                	<#assign suppGoodsList=suppGoodsMap[testKey] >          
        
        <div class="p_box box_info">
            <div class="f16 mb10" style="display:inline">${testKey?substring(1,testKey?last_index_of("_"))}
            <#if suppGoodsList?? && suppGoodsList?size &gt; 0>
            <a target="iframeMain" class="f12 fb" href="/vst_back/goods/shipAddition/showGoodsTimePrice.do?prodProduct.productId=${suppGoods.prodProduct.productId!''}&prodProductBranch.bizBranch.branchId=${testKey?substring(testKey?last_index_of("_")+1,testKey?length)}&suppSupplier.supplierId=${suppGoods.supplierId!''}&suppSupplier.supplierName=${suppGoods.suppSupplier.supplierName!''}&cancelFlag=${cancelFlag}">[查看/维护时间价格表]</a>
            </#if>
            </div>
           <#if testKey_index ==0>
			商品状态:<select  id="cancelFlag">
                				<option value="">不限</option>
		                    	<option value='Y'<#if cancelFlag == 'Y'>selected</#if>>有效</option>
		                    	<option value='N'<#if cancelFlag == 'N'>selected</#if>>无效</option>
                	</select>
			</#if>
            <table class="p_table table_center">
                <thead>
                    <tr>
                        
                        <th>商品编号</th>
                        <th>商品名称</th>
                         <th>产品经理</th>
                        <th>产品状态</th>   
                        <th>驴妈妈自有销售</th>
                        <th>可分销</th>
                        <th>兴旅同业中心可售</th>
                        <th>内容维护人员</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <#if suppGoodsList?? && suppGoodsList?size &gt; 0>
                	<#list suppGoodsList as suppGoods> 
						<tr>
							<td>${suppGoods.suppGoodsId!''} </td>
							<td>${suppGoods.goodsName!''} </td>
							<td>${suppGoods.managerName!''} </td>
							<td>
							<#if suppGoods.cancelFlag == "Y"> 
							<span style="color:green" class="cancelProp">有效</span>
							<#else>
							<span style="color:red" class="cancelProp">无效</span>
							</#if>
							</td>		
							<td><#if suppGoods.lvmamaFlag =="Y">是<#else>否</#if></td>
							<td><#if suppGoods.distributeFlag =="Y">是<#else>否</#if></td>
							<td><#if suppGoods.xingBrigadeFlag =="Y">是<#else>否</#if></td>
							<td>${suppGoods.contentManagerName!''} </td>
							<td class="oper">
		                            <a href="javascript:void(0);" class="editProp" data=${suppGoods.suppGoodsId}>编辑</a>
		                            <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${suppGoods.suppGoodsId},'objectType':'SUPP_GOODS_GOODS'}">操作日志</a> 
		                            <#if suppGoods.cancelFlag == "Y"> 
		                            <a href="javascript:void(0);" class="cancelProp" data="N" suppGoodsId=${suppGoods.suppGoodsId} productId=${suppGoods.productId}>设为无效</a>
		                            <#else>
		                            <a href="javascript:void(0);" class="cancelProp" data="Y" suppGoodsId=${suppGoods.suppGoodsId} productId=${suppGoods.productId}>设为有效</a>
		                            </#if>		                            
		                 	</td>
						</tr>
						</#list>
				<#else>
					<tr><td colspan=10><div class="no_data mt20"><i class="icon-warn32"></i>暂无相关产品，重新输入相关条件查询！</div></td></tr>
    			</#if>
                </tbody>
            </table>
        </div>
					</#list>
					<#else>
					<div class="p_box box_info">商品状态:<select  id="cancelFlag" style="font-size:10px;">
                				<option value="">不限</option>
		                    	<option value='Y'<#if cancelFlag == 'Y'>selected</#if>>有效</option>
		                    	<option value='N'<#if cancelFlag == 'N'>selected</#if>>无效</option>
                	</select></div>
				</#if>
 </div>
<!-- //主要内容显示区域 -->

<#include "/base/foot.ftl"/>
</body>
</html>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
//vst_pet_util.commListSuggest("#supplierName", "#supplierId","/vst_back/supp/supplier/searchSupplierList.do? '${suppJsonList}');
vst_pet_util.commListSuggest("#supplierName", "#supplierId",'/vst_back/supp/supplier/searchSupplierList.do','${suppJsonList}');
</script>


<script>
		$("#cancelFlag").change(function(){
			$("#cancelFlag1").val($(this).val());
			$("#search_button").click();
		});
		
		//查询
		$("#search_button").bind("click",function(){
		if($("#supplierId").val()!=null && $("#supplierId").val()!=""){
			$("#searchForm").submit();
		}else{
			$.alert("请先选择供应商！");
		}	
		});
		
		//新建
		$("#new_button").bind("click",function(){
		if($("#supplierId").val()!=null && $("#supplierId").val()!=""){	
			new xDialog("/vst_back/goods/shipAddition/showAddSuppGoods.do",{productId:$("input[name='prodProduct.productId']").val(),supplierId:$("#supplierId").val(),contractName:$("#contractName").val(),contractId:$("#contractId").val(),contentManagerId:$("#contentManagerId").val(),contentManagerName:$("#contentManagerName").val(),categoryId:$("input[name='prodProduct.bizCategory.categoryId']").val(),productBranchId:$("#productBranchId").val()},{title:"新增商品",width:800,ok:function(){
			//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			if($("#contractIdAdd").val()==""){
				$.alert("请选择供应商合同！");
				return false;
			}
			if('Y'==$("input:radio[name='faxFlag']:checked").val() && $("input[name='faxRuleId']").val()==""){
				$.alert("请选择供应商传真号！");
				return false;
			}
			
			var xingBrigadeFlag=$("#xingBrigadeFlag").val();
			var lvmamaFlag=$("#lvmamaFlag").val();
			var distributeFlag=$("#distributeFlag").val();
			//alert(xingBrigadeFlag+""+lvmamaFlag+""+distributeFlag);
			if( xingBrigadeFlag=="Y" && ( lvmamaFlag=="Y" || distributeFlag=="Y" ) ){
				$.alert("是否兴旅同业中心可售为是的时候，是否驴妈妈可售  和 是否可分销 必须为否！");
				return false;
			}	
			
			var minQuantity=$("#minQuantity").val();
			var maxQuantity=$("#maxQuantity").val();
			if(parseInt(minQuantity)>parseInt(maxQuantity))
			{
				$.alert("最多订购数应大于等于最少订购数！");
				return false;
			
			}
			
			$.ajax({
				url : "/vst_back/goods/shipAddition/addSuppGoods.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
			},okValue:"保存"});
		}else{
			$.alert("请先选择供应商！");
		}	
		});
		
		//修改
		$("a.editProp").bind("click",function(){
		var suppGoodsId = $(this).attr("data");
		new xDialog("/vst_back/goods/shipAddition/showUpdateSuppGoods.do",{suppGoodsId:suppGoodsId,productId:$("input[name='prodProduct.productId']").val(),supplierId:$("#supplierId").val(),contractId:$("#contractId").val(),contentManagerId:$("#contentManagerId").val(),categoryId:$("input[name='prodProduct.bizCategory.categoryId']").val(),productBranchId:$("#productBranchId").val()},{title:"编辑商品",width:800,ok:function(){
			//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			if($("#contractIdUpdate").val()==""){
				$.alert("请选择供应商合同！");
				return false;
			}			
			if('Y'==$("input:radio[name='faxFlag']:checked").val() && $("input[name='faxRuleId']").val()==""){
				$.alert("请选择供应商传真号！");
				return false;
			}
			
			
			var xingBrigadeFlag=$("#xingBrigadeFlag").val();
			var lvmamaFlag=$("#lvmamaFlag").val();
			var distributeFlag=$("#distributeFlag").val();
			//alert(xingBrigadeFlag+""+lvmamaFlag+""+distributeFlag);
			if( xingBrigadeFlag=="Y" && ( lvmamaFlag=="Y" || distributeFlag=="Y" ) ){
				$.alert("是否兴旅同业中心可售为是的时候，是否驴妈妈可售  和 是否可分销 必须为否！");
				return false;
			}	
			
			var minQuantity=$("#minQuantity").val();
			var maxQuantity=$("#maxQuantity").val();
			
			if(parseInt(minQuantity)>parseInt(maxQuantity))
			{
				$.alert("最多订购数应大于等于最少订购数！");
				return false;
			
			}
			
			$.ajax({
				url : "/vst_back/goods/shipAddition/updateSuppGoods.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
		},okValue:"保存"});
		});
		
		//设置为有效或无效
		$("a.cancelProp").bind("click",function(){
			var entity = $(this);
			var cancelFlag = entity.attr("data");
			var suppGoodsId = entity.attr("suppGoodsId");
			var productId= entity.attr("productId");
			$.ajax({
				url : "/vst_back/goods/shipAddition/cancelSuppGoods.do",
				type : "post",
				dataType:"JSON",
				data : {"cancelFlag":cancelFlag,"suppGoodsId":suppGoodsId},
				success : function(result) {
				if (result.code == "success") {
					$.alert(result.message,function(){
						if(cancelFlag == 'N'){
							entity.attr("data","Y");
							entity.text("设为有效");
							$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
						}else if(cancelFlag == 'Y'){
							entity.attr("data","N");
							entity.text("设为无效");
							$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
						}
					});
				}else {
					$.alert(result.message);
				}
				}
			});
		});
		
		//供应商搜索
		function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$.alert(result.message);
			}});
		}
	};
</script>