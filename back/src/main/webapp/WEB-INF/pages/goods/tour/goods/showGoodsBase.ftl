<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
        <ul class="iframe_nav">
            <li><a href="#">线路</a> &gt;</li>
            <li><a href="#">商品维护</a> &gt;</li>
            <li class="active">供应商合同关联</li>
        </ul>
</div>
<div class="iframe_content mt10">
<#--
        <div class="tiptext tip-warning cc5"><span class="tip-icon tip-icon-warning"></span>友情提示：
            <p class="pl15"></p>
        </div>
        -->
        <div class="p_box box_info">
		<form action="/vst_back/tour/goods/goods/updateSuppGoodsBase.do" method="post" id="dataForm">
		<input type="hidden" id="productId" name="productId" value="${prodProductId!''}">
		<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId!''}">
        <input type="hidden" name="goodsName" value="${suppGoods.goodsName!''}">
        <input type="hidden" id="cancelFlag" name="cancelFlag" value="${suppGoods.cancelFlag!''}">
		<input type="hidden" id="categoryId" name="categoryId" value="${categoryId!''}">
		<input type="hidden" name="stockApiFlag" value="N">
        <table class="e_table form-inline">
            <tbody>
                <tr>
	                    <td width="150" class="e_label td_top"><i class="cc1">*</i>选择供应商：</td>
	                    <td class="w18" colspan='5'>
	                    <input type="text" placeholder="请输入供应商名称" class="w35 search"  name="suppSupplier.supplierName" required=true errorEle="supplier" id="supplierName" <#if suppGoods != null && suppGoods.suppSupplier != null>value="${suppGoods.suppSupplier.supplierName}" readonly=readonly</#if> >
                	    <input type="hidden"  name="supplierId" id="supplierId" value="${suppGoods.supplierId!''}" required=true>
                	    
	                    <!--<a class="btn btn_cc1" id="selectSupplierButton">选择供应商</a><span class="cc3">(仅针对供应商进行查询)</span>-->
	                    <div style="display:inline" id="supplierError"></div>
                    	<div class="cc3"> 注：下面的内容维护人员、商品默认合同，添加新商品时均为默认值。 </div></td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>商品合同：</td>
					<td colspan=2 class=" operate mt10">
						<input type="text" readonly="readonly" id="contractName" name="suppContract.contractName" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractName}" </#if> required>
						<input type="hidden" id="contractIdUpdate" name="contractId" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractId}" </#if>>
						<a id="change_button_contract" href="#">[更改]</a>
                   	</td>
                </tr>
               	<tr>
					<td class="e_label"><i class="cc1">*</i>内容维护人员：</td>
					<td colspan=2>
						<input type="text" name="contentManagerName" id="contentManagerName" value="${contentManagerName}" required=true>	
                    	<input type="hidden" value="${suppGoods.contentManagerId}" name="contentManagerId" id="contentManagerId" required=true>
                    <div class="cc3"> 注：对信息维护负责。 </div>
                   	</td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>产品经理：</td>
					<td colspan=2>
						<input type="text" name="managerName" id="managerName" value="${suppGoods.managerName}" required=true>
                    	<input type="hidden" value="${suppGoods.managerId}" name="managerId" id="managerId" required=true>
                    	<div class="cc3"> 注：产品订单的跟进人员。 </div>
                   	</td>
                </tr>
                 <tr>
					<td class="e_label"><i class="cc1">*</i>分公司：</td>
					<td colspan=2>
						<select name="filiale" required>
                    	 			<option value="">请选择</option>
		    				<#list filialeList as list>
			                    	<option value=${list.code!''} <#if suppGoods!=null && suppGoods.filiale==list.code>selected</#if> >${list.cnName!''}</option>
			                </#list>
			        	</select>
			        	<div class="cc3"> 注：订单跟进处理时使用。 </div>
                    </td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>支付对象：</td>
					<td colspan=2>
							<select name="payTarget" required>
	                    	 			<option value="">请选择</option>
			    				<#list payTargetList as list>
				                    	<option value=${list.code!''} <#if suppGoods!=null && suppGoods.payTarget==list.code>selected</#if> <#if list.code!='PREPAID'>disabled=disabled</#if> >${list.cnName!''}</option>
				                </#list>
				        	</select>
                    </td>
                </tr>
                <tr>
					<td class="e_label"><i class="cc1">*</i>是否使用传真：</td>
					<td colspan=2>
						<input type="radio" name="faxFlag" value="Y"  <#if suppGoods?? && suppGoods.faxFlag=='Y'>checked=checked</#if>>是&nbsp;&nbsp;<span class="cc3">订单生成直接发送使用</span><br/>
						<input type="radio" name="faxFlag" value="N"  <#if suppGoods?? && suppGoods.faxFlag=='N'>checked=checked</#if>>否&nbsp;&nbsp;<span class="cc3">若EBK等失效的时候备用，请选择传真</span><br/>	
	                	<label title="传真号码：<#if suppGoods??&&suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.fax!''};</#if> 发送时间：<#if suppGoods??&&suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.sendTime!''}</#if>" name="suppFaxRule.faxRuleName"><#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleName!="">${suppGoods.suppFaxRule.faxRuleName!''}</#if></label>
						<input type="hidden" id="faxRuleId" name="faxRuleId" <#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleId!="">value="${suppGoods.suppFaxRule.faxRuleId!''}"</#if>> 
						<a id="change_button_fax" href="#">[选择供应商传真名称]</a></br>
	                    <span class="cc3">若不使用传真，且不是二维码，则商品创建后，需要去ebk里面将商品添加到对应的供应商账户下。</span>
                    </td>
                </tr>
                <#if categoryId==17>
                <tr>
					<td class="e_label"><i class="cc1">*</i>成人数：</td>
					<td colspan=2>
						<select name="adult">
								<#list 0..100 as i>
	                            <option value="${i}" <#if i==suppGoods.adult>selected="selected"</#if>>${i}</option>
                                </#list>
						 </select>
                    </td>
                </tr>
                 <tr>
					<td class="e_label"><i class="cc1">*</i>儿童数：</td>
					<td colspan=2>
						<select name="child">
									<#list 0..100 as j>
		                            <option value="${j}" <#if j==suppGoods.child>selected="selected"</#if>>${j}</option>
                                    </#list>
						</select>
                    </td>
                </tr>
                </#if>
                <tr>
					<td class="e_label"><i class="cc1">*</i>结算币种：</td>
					<td colspan=2>
						<select name="currencyType" class="w10">
						<#list currencyTypeList as list>
		                      <option value=${list.code!''} <#if suppGoods!=null && suppGoods.currencyType==list.code>selected</#if>>${list.cnName!''}</option>
                        </#list>
						</select>
                    </td>
                </tr>
                <tr>
                    <td class="e_label"></td>
                    <td><div class="fl operate"><a class="btn btn_cc1" id="save_button">保存</a> <a href="javascript:void(0);" style="margin-left:100px;" class="showLogDialog btn btn_cc1" param="{'objectId':${suppGoods.suppGoodsId},'objectType':'SUPP_GOODS_GOODS'}">操作日志</a> </div></td>
                </tr>
            </tbody>
        </table>
</form>
</div>
</div>
<#include "/base/foot.ftl"/>
</body>
</html>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
vst_pet_util.commListSuggest("#supplierName", "#supplierId",'/vst_back/supp/supplier/searchSupplierList.do','${suppJsonList}');
</script>

<script>
	$(function(){
		if('Y'==$("input[name='faxFlag'][checked]").val()){
				$("#change_button_fax").show();
		}else{
				$("#change_button_fax").hide();
		}	
	});
		var selectContractDialog2;	
		var selectSuppFaxRule;
		//供应商合同回调函数
		function onSelectContract2(params){
			if(params!=null){
				$("input[name='suppContract.contractName']").val(params.contractName);
				$("input[name='contractId']").val(params.contractId);
			}
			selectContractDialog2.close();
		}
		
		//供应商传真号回调函数
		function onSelectSuppFaxRule(params){
			if(params!=null){
				$("input[name='faxRuleId']").val(params.faxRuleId);
				$("label[name='suppFaxRule.faxRuleName']").text(params.faxRuleName);
				$("label[name='suppFaxRule.faxRuleName']").attr('title','传真号码：'+params.fax+'； 发送时间：'+params.sendTime);
			}
			selectSuppFaxRule.close();
		}
		
		//打开选择供应商合同列表
		$("#change_button_contract").click(function(){
			if($("#supplierId").val()==""){
				$.alert("请选择供应商!");
				return;
			}
			selectContractDialog2 = new xDialog("/vst_back/supp/suppContract/selectContractListBySupplier.do?callback=onSelectContract2&supplierId="+$("#supplierId").val(),{},{title:"选择供应商合同",width:"600"});
		});
		
		//打开选择供应商传真号列表
		$("#change_button_fax").click(function(){
			selectSuppFaxRule = new xDialog("/vst_back/supp/fax/selectSuppFaxRuleList.do?callback=onSelectSuppFaxRule&supplierId="+$("#supplierId").val()+"&categoryId="+$("input[name='categoryId']").val(),{},{title:"选择供应商传真号",iframe:true,width:"800",height:"400"});
		});
		
		$("input[name='faxFlag']").change(function(){
			if('Y'==$(this).val()){
				$("#change_button_fax").show();
			}else{
				$("#change_button_fax").hide();
				$("input[name='faxRuleId']").val("");
				$("label[name='suppFaxRule.faxRuleName']").text("");
			}
			
		});
		
		$("#save_button").click(function(){
			
			//验证
			if(!$("#dataForm").validate().form()){
				return false;
			}
			
			if($("input[name=faxFlag]:checked").size()==0){
				$.alert("请选择传真策略");
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
		
			//遮罩层
    		var loading = top.pandora.loading("正在努力保存中...");	
    		$.ajax({
				url : "/vst_back/tour/goods/goods/updateSuppGoodsBase.do",
				type : "post",
				dataType : 'json',
				data : $("#dataForm").serialize(),
				success : function(result) {
					loading.close();
					if(result.code == "success"){
						$.alert(result.message,function(){
							window.location = "/vst_back/tour/goods/goods/showBaseSuppGoods.do?prodProductId="+$("#productId").val()+"&categoryId="+$("#categoryId").val();
						});
					}else {
						$.alert(result.message);
					}
				},
				error : function(){
					loading.close();
				}
			});
		});
		
	if($("#isView",parent.document).val()=='Y'){
		$("#add_button,#save_traffic_detail,#save_button").remove();
	}
	
	$("#supplierName").change(function(){
		//取消合同
		$("#contractIdUpdate").val("");
		$("#contractName").val("");
		//取消传真
        var $browsers = $("input[name=faxFlag]");
        $browsers.attr("checked",false);
        $("#change_button_fax").hide();
        $("label[name='suppFaxRule.faxRuleName']").text("");
        $("#faxRuleId").val("");
	});
</script>
