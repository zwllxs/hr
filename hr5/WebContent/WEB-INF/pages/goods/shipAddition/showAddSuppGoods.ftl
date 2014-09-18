<form action="/vst_back/goods/goods/addSuppGoods.do" method="post" id="dataForm">
		<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
		<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">   
		<input type="hidden" name="stockApiFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
            <#-- 
                 <tr>
                	<td class="p_label"><i class="cc1">*</i>所属规格：</td>
                	<td colspan=2>
                		<#if prodProductBranchList?size gt 0>
	                		<select name="productBranchId" required>
									  	<option value="">请选择</option>
									  	<#list prodProductBranchList as prodProductBranch>
						                    <option value="${prodProductBranch.productBranchId}" <#if suppGoods?? && suppGoods.prodProductBranch?? && suppGoods.prodProductBranch.productBranchId==prodProductBranch.productBranchId>selected</#if> >${prodProductBranch.branchName}</option>
									  	</#list>
		                	</select>
		                <#else>	
		                	<span class="notnull">请先创建产品规格!</span>
                		</#if>
                	</td>
                </tr>
                -->
                
                 <!--	所属规格 -->
                <input type="hidden" value="${prodProductBranch.productBranchId}" name="productBranchId" id="productBranchId" required=true>
                
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="text" name="goodsName" style="width:260px" value="" required>
                    </td>
                </tr>
               	<tr>
					<td class="p_label"><i class="cc1">*</i>内容维护人员：</td>
					<td colspan=2>
						<input type="text" name="contentManagerName" id="contentManagerName" value="${suppGoods.contentManagerName}" required=true>
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
						<label id="contractNameAdd" name="contractName"> <#if suppGoods!=null && suppGoods.suppContract!=null>${suppGoods.suppContract.contractName}</#if></label>
						<input type="hidden" id="contractIdAdd" name="contractId" <#if suppGoods!=null && suppGoods.suppContract!=null> value="${suppGoods.suppContract.contractId}"</#if>>
						<a id="change_button_contract" href="#">[更改]</a>
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>支付对象：</td>
					<td colspan=2>
						<select name="payTarget" required>
                    	 			<option value="">请选择</option>
		    				<#list payTargetList as list>
			                    	<option value=${list.code!''}>${list.cnName!''}</option>
			                </#list>
			        	</select>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>分公司：</td>
					<td colspan=2>
						<select name="filiale" required>
                    	 			<option value="">请选择</option>
		    				<#list filialeList as list>
			                    	<option value=${list.code!''}>${list.cnName!''}</option>
			                </#list>
			        	</select>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否有效：</td>
					<td colspan=2>
						<select name="cancelFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.cancelFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.cancelFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr> 
                 <tr>
					<td class="p_label"><i class="cc1">*</i>是否兴旅同业中心可售：</td>
					<td colspan=2>
						<select name="xingBrigadeFlag"  id="xingBrigadeFlag"  required>
	                    	<option value="Y" <#if XingBrigadeFlag!=null && XingBrigadeFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if XingBrigadeFlag!=null && XingBrigadeFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr> 
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否驴妈妈可售：</td>
					<td colspan=2>
						<select name="lvmamaFlag"  id="lvmamaFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.lvmamaFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.lvmamaFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr> 
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否可分销：</td>
					<td colspan=2>
						<select name="distributeFlag"  id="distributeFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.distributeFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.distributeFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr>                
                 
                
                
                
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
					<td colspan=2>
						<input type="radio" name="packageFlag" value="Y" checked>是
	                	<input type="radio" name="packageFlag" value="N" >否
                    </td>
                </tr>                  
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否使用传真：</td>
					<td colspan=2>
						<input type="radio" name="faxFlag" value="N" >否&nbsp;&nbsp;<span class="cc3">若EBK等失效的时候备用，请选择传真</span><br/>
						<input type="radio" name="faxFlag" value="Y" checked>是&nbsp;&nbsp;<span class="cc3">订单生成直接发送使用</span><br/>
	                	<label name="suppFaxRule.faxRuleName" id="faxRuleName" <#if suppFaxRule!=null && suppFaxRule.faxRuleName!=null> value="${suppFaxRule.faxRuleName}"</#if>></label>
						<input type="hidden" name="faxRuleId" id="faxRuleId" <#if suppFaxRule!=null && suppFaxRule.faxRuleId!=null> value="${suppFaxRule.faxRuleId}"</#if>>
	                    <a id="change_button_fax" href="#">[选择供应商传真名称]</a></br>
	                    <span class="cc3">若不使用传真，且不是二维码，则商品创建后，需要去ebk里面将商品添加到对应的供应商账户下。</span>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最少起订数：</td>
					<td colspan=2>
						<input type="text" name="minQuantity" id="minQuantity"  min="0" max="999" required=true >
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最多订购数：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity" id="maxQuantity"  min="0" max="999" required=true>
                    </td>
                </tr>
                
                <tr>
					<td rowspan="3" class="p_label" ><i class="cc1">*</i>商品类型：</td>
				 </tr>
						<#if goodsTypeList??>	
							<#list goodsTypeList as goodsType>
								<#if goodsType=="EXPRESSTYPE_DISPLAY">
								<tr>
										<td>
											<input type="radio" name="goodsType" value="${goodsType.code}" required checked="checked">${goodsType.cnName}
											</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<label>寄件方</label>
											<select name="expressType">
											<#list expressTypeList as expressType>
												<option value="${expressType.code}">${expressType.cnName}</option>
											</#list>
											</select>
										</td>
								 </tr>
								</#if>
								<#if goodsType=="NOTICETYPE_DISPLAY">
								<tr>
										<td>
											<input type="radio" name="goodsType" value="${goodsType.code}" required >${goodsType.cnName}
											</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<label>通知方式  </label>
											<select name="noticeType">
											<#list noticeTypeList as noticeType>
												<option value="${noticeType.code}">${noticeType.cnName}</option>
											</#list>
											</select>
										</td>
								</tr>
								</#if>
							</#list>	
						</#if>
            </tbody>
        </table>
</form>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
</script>

<script>
		var selectContractDialog2;
		var selectSuppFaxRule;
		//供应商合同回调函数
		function onSelectContract2(params){
			if(params!=null){
				$("#contractNameAdd").text(params.contractName);
				$("#contractIdAdd").val(params.contractId);
			}
			selectContractDialog2.close();
		}
		//供应商传真号回调函数
		function onSelectSuppFaxRule(params){
			if(params!=null){
				$("#faxRuleName").text(params.faxRuleName);
				$("#faxRuleId").val(params.faxRuleId);
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
			}
			
		});
</script>