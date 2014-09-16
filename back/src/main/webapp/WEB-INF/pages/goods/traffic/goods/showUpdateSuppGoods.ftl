<form action="/vst_back/goods/traffic/addSuppGoods.do" method="post" id="dataForm" class="goodsForm">
		<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
		<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">
		<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId}">
		<input type="hidden" name="onlineFlag" value="${suppGoods.onlineFlag}">       
		<input type="hidden" name="senisitiveFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>所属规格：</td>
                	<td colspan=2>
                	    <input type="hidden" name="productBranchId"" <#if suppGoods!=null && suppGoods.prodProductBranch!=null && suppGoods.prodProductBranch.productBranchId!=null> value="${suppGoods.prodProductBranch.productBranchId}" </#if>>
                		<select disabled="disabled" >
								  	<option value="">请选择</option>
								  	<#list prodProductBranchList as prodProductBranch>
					                    <option value="${prodProductBranch.productBranchId}"<#if suppGoods!=null && suppGoods.prodProductBranch!=null && suppGoods.prodProductBranch.productBranchId==prodProductBranch.productBranchId>selected</#if>>${prodProductBranch.branchName}</option>
								  	</#list>
	                	</select>
                	</td>
                </tr>
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="text" name="goodsName" style="width:260px" value="${suppGoods.goodsName}" required>
                    </td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>是否对接：</td>
                    <td colspan=2>
                    	<#if suppGoods.stockApiFlag??>
                    			<#if suppGoods.stockApiFlag=="Y">对接<#else>非对接</#if>
                    	<#else>
                    	未设置		
                    	</#if>
                    </td>
            </tr>
               	<tr>
					<td class="p_label"><i class="cc1">*</i>内容维护人员：</td>
					<td colspan=2>
						<input type="text" name="contentManagerName" id="contentManagerName" value="${contentManagerName}" required=true>
                    	<input type="hidden" value="${suppGoods.contentManagerId}" name="contentManagerId" id="contentManagerId" required=true>
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>产品经理：</td>
					<td colspan=2>
						<input type="text" name="managerName" id="managerName" value="${suppGoods.managerName}" required=true>
                    	<input type="hidden" value="${suppGoods.managerId}" name="managerId" id="managerId" required=true>
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>商品合同：</td>
					<td colspan=2 class=" operate mt10">
						<input type="text" readonly="readonly" name="suppContract.contractName" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractName}" </#if> required>
						<input type="hidden" id="contractIdUpdate" name="contractId" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractId}" </#if>>
						<a id="change_button_contract" href="#">[更改]</a>
                   	</td>
                </tr>
                <tr   style="display:none">
					<td class="p_label"><i class="cc1">*</i>支付对象：</td>
					<td colspan=2>
						<#if suppGoods.payTarget == null>
							<select name="payTarget" required>
	                    	 			<option value="">请选择</option>
			    				<#list payTargetList as list>
				                    	<option value=${list.code!''} <#if suppGoods!=null && suppGoods.payTarget==list.code>selected</#if> >${list.cnName!''}</option>
				                </#list>
				        	</select>
						<#else>
							<input name="payTarget" id="payTarget" type="hidden" value="${suppGoods.payTarget}"/>${suppGoods.payTargetCn}
						</#if>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>分公司：</td>
					<td colspan=2>
						<select name="filiale" required>
                    	 			<option value="">请选择</option>
		    				<#list filialeList as list>
			                    	<option value=${list.code!''} <#if suppGoods!=null && suppGoods.filiale==list.code>selected</#if> >${list.cnName!''}</option>
			                </#list>
			        	</select>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否有效：</td>
					<td colspan=2>
						<select name="cancelFlag" required>
	                    	<option value="Y" <#if suppGoods?? && suppGoods.cancelFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods?? && suppGoods.cancelFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
					<td colspan=2>
						<input type="radio" name="packageFlag" value="Y" <#if suppGoods?? && suppGoods.packageFlag=='Y'>checked</#if>>是
						<input type="radio" name="packageFlag" value="N" <#if suppGoods?? && suppGoods.packageFlag=='N'>checked</#if>>否
                    </td>
                </tr>                  
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否使用传真：</td>
					<td colspan=2>
						<input type="radio" name="faxFlag" value="Y" <#if suppGoods?? && suppGoods.faxFlag=='Y'>checked</#if>>是&nbsp;&nbsp;<span class="cc3">订单生成直接发送使用</span><br/>
						<input type="radio" name="faxFlag" value="N" <#if suppGoods?? && suppGoods.faxFlag=='N'>checked</#if>>否&nbsp;&nbsp;<span class="cc3">若EBK等失效的时候备用，请选择传真</span><br/>	
	                	<label title="传真号码：<#if suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.fax!''}；</#if> 发送时间：<#if suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.sendTime!''}</#if>" name="suppFaxRule.faxRuleName"><#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleName!="">${suppGoods.suppFaxRule.faxRuleName!''}</#if></label>
						<input type="hidden" id="faxRuleId" name="faxRuleId" <#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleId!="">value="${suppGoods.suppFaxRule.faxRuleId!''}"</#if>> 
						<a id="change_button_fax" href="#">[选择供应商传真名称]</a></br>
	                    <span class="cc3">若不使用传真，且不是二维码，则商品创建后，需要去ebk里面将商品添加到对应的供应商账户下。</span>
                    </td>
                </tr>
                 <tr>
					<td class="p_label"><i class="cc1">*</i>最少起订份数：</td>
					<td colspan=2>
						<input type="text" name="minQuantity" required=true value="${suppGoods.minQuantity}" min=0 max=999>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最多订购份数：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity" required=true value="${suppGoods.maxQuantity}" min=0 max=999>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>退改策略：</td>
					<td colspan=2>
						<input type="radio" name="cancelStrategy" value="UNRETREATANDCHANGE" <#if suppGoodsRefund?? && suppGoodsRefund.cancelStrategy=='UNRETREATANDCHANGE'>checked</#if>  required=true />不退不改</br>
						<input type="radio" name="cancelStrategy" value="MANUALCHANGE" <#if suppGoodsRefund?? && suppGoodsRefund.cancelStrategy=='MANUALCHANGE'>checked</#if> required=true />人工退改
                    </td>
                </tr>
            </tbody>
        </table>
</form>
<div class="p_box box_info clearfix mb20">
     <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="update">保存</a></div>
</div>
<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
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
			selectContractDialog2 = new xDialog("/vst_back/supp/suppContract/selectContractListBySupplier.do?callback=onSelectContract2&supplierId="+$("#supplierId").val(),{},{title:"选择供应商合同",width:"600"});
		});
		
		//打开选择供应商传真号列表
		$("#change_button_fax").click(function(){
			selectSuppFaxRule = new xDialog("/vst_back/supp/fax/selectSuppFaxRuleList.do?callback=onSelectSuppFaxRule&supplierId="+$("#supplierId").val()+"&categoryId="+$("input[name='prodProduct.bizCategory.categoryId']").val(),{},{title:"选择供应商传真号",iframe:true,width:"800",height:"400"});
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
		
		$("#update").bind("click",function(){
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
			
			var msg = '确认修改吗 ？';	
				if(refreshSensitiveWord($(".goodsForm").find("input[type='text'],textarea"))){
					$("input[name=senisitiveFlag]").val("Y");
			 		msg = '内容含有敏感词,是否继续?';
			 }else  {
			 	$("input[name=senisitiveFlag]").val("N");
			 }
			
			$.confirm(msg,function(){
				$.ajax({
					url : "/vst_back/goods/traffic/updateSuppGoods.do",
					type : "post",
					data : $(".dialog #dataForm").serialize(),
					success : function(result) {
						confirmAndRefresh(result);
					}
				});
			});
			
		});
		
		refreshSensitiveWord($(".goodsForm").find("input[type='text'],textarea"))
</script>
