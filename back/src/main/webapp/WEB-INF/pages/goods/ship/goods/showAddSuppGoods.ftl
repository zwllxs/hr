<form action="/vst_back/ship/goods/goods/addSuppGoods.do" method="post" id="dataForm">
		<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
		<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">   
		<input type="hidden" name="senisitiveFlag" value="N">
		<input type="hidden" name="stockApiFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
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
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="text" name="goodsName" style="width:260px" value=""  maxlength="50" required>
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
					<td class="p_label"><i class="cc1">*</i>是否驴妈妈可售：</td>
					<td colspan=2>
						<select id="lvmamaFlag" name="lvmamaFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.lvmamaFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.lvmamaFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr> 
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否可分销：</td>
					<td colspan=2>
						<select id="distributeFlag" name="distributeFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.distributeFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.distributeFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr>                
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
					<td colspan=2>
					<select name="packageFlag" required>
						<option  value="Y" >是</option>
	                	<option  value="N" >否</option>
	                </select>	
                    </td>
                </tr>        
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否兴旅同业中心可售：</td>
					<td colspan=2>
                	<select id="b2bFlag" name="xingBrigadeFlag" required>
						<option  value="Y" >是</option>
	                	<option  value="N" selected="selected">否</option>
	                </select>	
	                <span class="cc3">兴旅可售是，驴妈妈不可售，不可分销。</span>
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
					<td class="p_label"><i class="cc1">*</i>最少起订份数/间数：</td>
					<td colspan=2>
						<input type="text" name="minQuantity"  min=0 max=999>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最多订购份数/间数：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity"  min=0 max=999>
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
<div class="p_box box_info clearfix mb20">
            <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
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
		
		$("#lvmamaFlag,#distributeFlag").change(function(){
			//如果驴妈妈可售或可分销，则B2B 不可售
			if($(this).val()=='Y'){
				$("#b2bFlag").find("option[value='N']").attr("selected","selected");
			}
		});
		
		$("#b2bFlag").change(function(){
			if($(this).val()=='Y'){
				$("#lvmamaFlag,#distributeFlag").find("option[value='N']").attr("selected","selected");
			}
		});
		
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
		
		$("#save").bind("click",function(){
		//验证
			if(!$("#dataForm").validate({
				rules: {
				   minQuantity: {
				    required: true,
				    number: true,
				    min : 0
				   },
				   maxQuantity: {
				    required: true,
				    number: true,
				    min : 0
				   }
				  },
				messages: {
				   minQuantity: "请输入最少起订份数",
				   maxQuantity:"请输入最多起订份数"
				  }
			}).form()){
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
			
			var msg = '确认保存吗 ？';	
			if(refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"))){
				$("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?';
			}else {
				 $("input[name=senisitiveFlag]").val("N");
			}
			
			$.confirm(msg,function(){
				$.ajax({
					url : "/vst_back/ship/goods/goods/addSuppGoods.do",
					type : "post",
					data : $(".dialog #dataForm").serialize(),
					success : function(result) {
						confirmAndRefresh(result);
					}
				});
			});
		});
</script>