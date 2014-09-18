<form action="/vst_back/ticket/goods/goods/addSuppGoods.do" method="post" id="dataForm">
		<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
		<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">
		<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId}">
		<input type="hidden" name="onlineFlag" value="${suppGoods.onlineFlag}">
		<input type="hidden" id="aperiodicFlag" name="aperiodicFlag" value="${suppGoods.aperiodicFlag}">
		<input type="hidden" name="seq" value="${suppGoods.seq}">  
		<input type="hidden" name="senisitiveFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
            	<tr>
                	<td colspan=3>基本信息：</td>
                </tr>            
                <tr>
                	<td class="p_label" width="100"><i class="cc1">*</i>所属规格：</td>
                	<td colspan=2>
                	    <input type="hidden" name="productBranchId" <#if suppGoods!=null && suppGoods.prodProductBranch!=null && suppGoods.prodProductBranch.productBranchId!=null> value="${suppGoods.prodProductBranch.productBranchId}" </#if>>
                		<select id="productBranchId1" disabled="disabled" >
								  	<option value="">请选择</option>
								  	<#list prodProductBranchList as prodProductBranch>
					                    <option value="${prodProductBranch.productBranchId}"<#if suppGoods!=null && suppGoods.prodProductBranch!=null && suppGoods.prodProductBranch.productBranchId==prodProductBranch.productBranchId>selected</#if> data= "${prodProductBranch.singleItemCategoryId!''}">${prodProductBranch.branchName}</option>
								  	</#list>
	                	</select>
	                	<span style="color:grey">必须选择规格，当规格分类等于单门票时，规格名称不带到商品名称中。</span>
                	</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>门票票种：</td>
                    <td colspan=2>
                    	<select name="goodsSpec" id="goodsSpec" required>
                    	 			<option value="">请选择</option>
		    						<#list goodsSpecList as list>
		    						<#if combTicketFlag = "Y">
		    							<option value=${list.code!''}  specName=${list.specName!''} adult=${list.adult!''} child=${list.child!''} <#if suppGoods!=null && suppGoods.goodsSpec==list.code>selected</#if>>${list.cnName!''}</option>
		    						<#elseif list.code!="PARENTAGE" && list.code!="FAMILY" && list.code!="LOVER" && list.code!="COUPE" && list.code!="FREE">
		    							<option value=${list.code!''}  specName=${list.specName!''} adult=${list.adult!''} child=${list.child!''} <#if suppGoods!=null && suppGoods.goodsSpec==list.code>selected</#if>>${list.cnName!''}</option>
		    						</#if>
			                </#list>
			        	</select>
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
                	<td class="p_label"><i class="cc1">*</i>成人数：</td>
                    <td colspan=2>
                    	<input type="text" name="adult" style="width:30px" value="${suppGoods.adult}" readonly>
                    </td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>儿童数：</td>
                    <td colspan=2>
                    	<input type="text" name="child" style="width:30px" value="${suppGoods.child}" readonly>
                    </td>
                </tr>                
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="hidden" name="goodsNameProductBranch"><input type="hidden" name="goodsNameGoodsSpec">
                    	<input type="text" name="goodsName1" style="width:260px" value="" required maxlength=40>
                    	【<input type="text" class="textWidth" name="goodsName2" style="width:260px" value="" maxlength=60>】
                    	<input type="hidden" name="goodsName" value="${suppGoods.goodsName}">
                    	<span style="color:grey">名称必须填写，副标题可描述商品特点，不允许输入中括号“【】”</span>
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
 				<tr>
					<td rowspan="3" class="p_label" ><i class="cc1">*</i>商品类型：</td>
				 </tr>
				<#if goodsTypeList??>	
					<#list goodsTypeList as goodsType>
						<#if goodsType=="EXPRESSTYPE_DISPLAY">
						<tr>
								<td>
									<input type="radio" name="goodsType" value="${goodsType.code}" <#if goodsType.code==suppGoods.goodsType>checked=checked</#if> required>${goodsType.cnName}
									</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>寄件方</label>
									<select name="expressType">
									<#list expressTypeList as expressType>
										<option value="${expressType.code}" <#if expressType.code==suppGoods.expressType>selected="selected"</#if> >${expressType.cnName}</option>
									</#list>
									</select>
								</td>
						 </tr>
						</#if>
						<#if goodsType=="NOTICETYPE_DISPLAY">
						<tr>
								<td>
									<input type="radio" name="goodsType" value="${goodsType.code}" <#if goodsType.code==suppGoods.goodsType>checked=checked</#if> required>${goodsType.cnName}
									</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>通知方式  </label>
									<select name="noticeType">
									<#list noticeTypeList as noticeType>
										<#if noticeType.code!='EMAIL'>
											<option value="${noticeType.code}" <#if noticeType.code==suppGoods.noticeType>selected="selected"</#if> >${noticeType.cnName}</option>
										</#if>
									</#list>
									</select>
								</td>
						</tr>
						</#if>
					</#list>	
				</#if> 
                <tr>
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
					<td class="p_label"><i class="cc1">*</i>产品经理：</td>
					<td colspan=2>
						<input type="text" name="managerName" id="managerName" value="${suppGoods.managerName}" required=true>
                    	<input type="hidden" value="${suppGoods.managerId}" name="managerId" id="managerId" required=true>
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
					<td class="p_label"><i class="cc1">*</i>是否有效：</td>
					<td colspan=2>
						<select name="cancelFlag" required>
	                    	<option value="Y" <#if suppGoods?? && suppGoods.cancelFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods?? && suppGoods.cancelFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr>  
                <#include "/goods/ticket/goods/showDistributorGoods.ftl"/>
               	<tr>
					<td colspan=3>有效期：</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>有效期：</td>
					<td colspan=2>
						<input type="hidden" name="expId" value=${suppGoodsExp.expId}>
						<#if suppGoods!=null && suppGoods.aperiodicFlag=='N'>
							指定游玩日后<select name="days" style="width:70px" required>
								<option value="1"<#if suppGoodsExp?? && suppGoodsExp.days==i>selected</#if>>1(当)</option>
		                    	 	<#list 2..10 as i>
			                      <option value="${i}"<#if suppGoodsExp?? && suppGoodsExp.days==i>selected</#if>>${i}</option>
			                      </#list>
		                    </select>天内有效
		                <#else>
		                <input type="text" style="width:100px" name="startTime" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" value="${suppGoodsExp.startTimeStr}" required/>至
                		<input type="text" style="width:100px" name="endTime" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" value="${suppGoodsExp.endTimeStr}" required/>有效<div id="selectDateError" style="display:inline"></div></br>
		                                          期票商品不适用日期：<input type="text" name="unvalid" value="${suppGoodsExp.unvalid}" maxlength="100">"案例：2014-09-05,2014-09-05 ，不适用日期该格式填写，中间用英文逗号分开"
		                </#if>
                    </td>
                </tr>
                <tr>
					<td colspan=3>供应商信息：</td>
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
					<td colspan=3>退改信息：</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>退改策略：</td>
					<td colspan=2>
								<div>
				                 	<input type="radio" name="cancelStrategy" value="MANUALCHANGE" <#if suppGoods.goodsReFundList?? && suppGoods.goodsReFundList?size &gt; 0 >checked="checked"</#if> >可退改
				                 </div>
				                 <div id="cancelStrategyContent">
				                 		<#assign index = 0>
				                 		<#if suppGoods.goodsReFundList?? && suppGoods.goodsReFundList?size&gt;0>
				                 		<#list suppGoods.goodsReFundList as sgr>
						                <div style="margin-top:2px;margin-bottom:2px;" class="cancelStrategyDiv" data="${sgr.refundId}">
						                		<input type="hidden" name="goodsReFundList[${index}].refundId"  value="${sgr.refundId}">
								                 <#if suppGoods.aperiodicFlag=="Y">最晚有效期<#else>游玩</#if>
								                 	<input type="hidden" name="goodsReFundList[${index}].latestCancelTime" class="latestCancelTime" value="${sgr.latestCancelTime}">
							                     	<select class="w10 mr10" style="width:60px" name="latestCancelTime_Day">
									                      <#list 1..7 as i>
									                      <option value="${8-i}">前${8-i}</option>
									                      </#list>
									                      <option value="0">当0</option>
									                      <#list 1..7 as i>
									                      <option value="${-i}">后${i}</option>
									                      </#list>
									                </select>天   
									                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour">
									                      <#list 0..23 as i>
									                      <option value="${i}">${i}</option>
									                      </#list>
									                </select>点
									                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute">
									                      <#list 0..59 as i>
									                      <option value="${i}">${i}</option>
									                      </#list>
									                </select>分退改：扣除<select style="width:120px;margin-right:10px;" name="goodsReFundList[${index}].deductType" ><option value="AMOUNT" <#if sgr.deductType=="AMOUNT">selected=selected</#if> >固定金额(元)</option><option value="PERCENT" <#if sgr.deductType=="PERCENT">selected=selected</#if>>票价百分比(%)</option></select>
									                <input type="hidden" style="width:30px" min=0 max=999 name="goodsReFundList[${index}].deductValue">
									                <input type="text" style="width:30px" min=0 max=999 value="${sgr.deductValue/100}" name="deductValue">
									                <#if index==0><span class="operate"><a class="btn btn_cc1" id="add">添加</a></span>
									                <#else>
									                <span class="operate"><a class="btn btn_cc1 delete" >删除</a></span>
									                </#if>
					                   		</div>
					                   		<#assign index = index+1>
					                   		</#list>
					                   		<#else>
					                   		<div style="margin-top:2px;margin-bottom:2px;" class="cancelStrategyDiv">
								                 <#if suppGoods.aperiodicFlag=="Y">最晚有效期<#else>游玩</#if>
								                 <input type="hidden" name="goodsReFundList[0].latestCancelTime" class="latestCancelTime">
							                     	<select class="w10 mr10" style="width:60px" name="latestCancelTime_Day">
									                      <#list 1..7 as i>
									                      <option value="${8-i}"  <#if i==7>selected=selected</#if> >前${8-i}</option>
									                      </#list>
									                      <option value="0">当0</option>
									                      <#list 1..7 as i>
									                      <option value="${-i}">后${i}</option>
									                      </#list>
									                </select>天   
									                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour">
									                      <#list 0..23 as i>
									                      <option value="${i}">${i}</option>
									                      </#list>
									                </select>点
									                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute">
									                      <#list 0..59 as i>
									                      <option value="${i}">${i}</option>
									                      </#list>
									                </select>分退改：扣除<select style="width:100px;margin-right:10px;" name="goodsReFundList[0].deductType" ><option value="AMOUNT">固定金额(元)</option><option value="PERCENT">票价百分比(%)</option></select>
									                <input type="hidden" style="width:30px" min=0 max=999 value=0 name="goodsReFundList[0].deductValue">
									                <input type="text" style="width:30px" min=0 max=999 value=0 name="deductValue">
									                <span class="operate"><a class="btn btn_cc1" id="add">添加</a></span>
					                   		</div>
					                   		</#if>
                   					</div>
                   			<div style="margin-top:5px;">
                   					<input type="radio" name="cancelStrategy" value="UNRETREATANDCHANGE" <#if suppGoods.goodsReFundList?size==0>checked=checked</#if> >不可退改
                   			</div>
                    </td>
                </tr>
                <tr>
					<td colspan=3>预订限制：</td>
                </tr>                                             
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
					<td colspan=2>
						<input type="radio" name="packageFlag" value="Y" <#if suppGoods?? && suppGoods.packageFlag=='Y'>checked</#if>>是
						<input type="radio" name="packageFlag" value="N" <#if suppGoods?? && suppGoods.packageFlag=='N'>checked</#if>>否
                    </td>
                </tr>                  

                 <tr>
					<td class="p_label"><i class="cc1">*</i>最小起订数量：</td>
					<td colspan=2>
						<input type="text" name="minQuantity" required=true value="${suppGoods.minQuantity}" min=0 max=999>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最大订购数量：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity" required=true value="${suppGoods.maxQuantity}" min=0 max=999>
                    </td>
                </tr>   
            </tbody>
        </table>
</form>
<div class="p_box box_info clearfix mb20">
            <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="update">修改</a></div>
</div>
<div id="template" style="display:none">
		<div style="margin-top:2px;margin-bottom:2px;" class="cancelStrategyDiv">
             {{name}}
             <input type="hidden" name="goodsReFundList[{{index}}].latestCancelTime" class="latestCancelTime">
             	<select class="w10 mr10" style="width:60px" name="latestCancelTime_Day">
                      <#list 1..7 as i>
                      <option value="${8-i}" <#if i==7>selected=selected</#if> >前${8-i}</option>
                      </#list>
                      <option value="0">当0</option>
                      <#list 1..7 as i>
                      <option value="${-i}">后${i}</option>
                      </#list>
                </select>天   
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour">
                      <#list 0..23 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>点
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute">
                      <#list 0..59 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分退改：扣除<select style="width:120px;margin-right:10px;" name="goodsReFundList[{{index}}].deductType" ><option value="AMOUNT">固定金额(元)</option><option value="PERCENT">票价百分比(%)</option></select>
                <input type="hidden" style="width:30px" min=0 max=999 value=0 name="goodsReFundList[{{index}}].deductValue">
                <input type="text" style="width:30px" min=0 max=999 value=0 name="deductValue">
                <span class="operate"><a class="btn btn_cc1 delete" >删除</a></span>
   		<div>
</div>
<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
</script>

<script>
	$(function(){
		$("input[name='goodsName2']").each(function(){
			
			$(this).keyup(function() {
				if($(this).val().substring($(this).val().length-2,$(this).val().length)=="【】" || $(this).val().substring($(this).val().length-2,$(this).val().length)=="】【")
		        $(this).val($(this).val().substring(0,$(this).val().length-2));
				if($(this).val().substring($(this).val().length-1,$(this).val().length)=="【" || $(this).val().substring($(this).val().length-1,$(this).val().length)=="】")
		        $(this).val($(this).val().substring(0,$(this).val().length-1));
				vst_util.countLenth($(this));
			});
		});
	});


	//将分钟数转换为天/时/分
        function minutesToDate(time,dayTarget,hourTarget,minuteTarget){
        	var time = parseInt(time);
			var day=0;
			var hour=0;
			var minute=0;
			if(time >  0){
				day = Math.ceil(time/1440);
				if(time%1440==0){
					hour = 0;
					minute = 0;
				}else {
					hour = parseInt((1440 - time%1440)/60);
					minute = parseInt((1440 - time%1440)%60);
				}
				
			}else if(time < 0  && time >= -1439){
				time = -time;
				hour = parseInt(time/60);
				minute = parseInt(time%60);
			}else if(time < -1439){
				time = -time;
				day = parseInt(time/1440);
				if(time%1440==0){
					hour = 0;
					minute = 0;
				}else {
					hour = parseInt((time%1440)/60);
					minute = parseInt((time%1440)%60);
				}
				day = -day;
			}
			dayTarget.find("option[value="+day+"]").attr("selected", true);
			hourTarget.find("option[value="+hour+"]").attr("selected", true);
			minuteTarget.find("option[value="+minute+"]").attr("selected", true);
        }      

	$(function(){
		if('Y'==$("input[name='faxFlag'][checked]").val()){
				$("#change_button_fax").show();
		}else{
				$("#change_button_fax").hide();
		}
		var temp= $("select[name=goodsSpec] option:selected").text();
		var index1 = temp.indexOf('[');
		var index2 = $("input[name=goodsName]").val().indexOf('【');
		var index3 = $("input[name=goodsName]").val().indexOf('】');
		$("input[name=goodsNameGoodsSpec]").val(temp.substring(0,index1));
		
		if($("#productBranchId1 option:selected").attr("data")!="310"){
		$("input[name=goodsNameProductBranch]").val($("#productBranchId1 option:selected").text());
		}
		if(index2==-1){
			$("input[name=goodsName1]").val($("input[name=goodsName]").val());
		}else{
			$("input[name=goodsName2]").val($("input[name=goodsName]").val().substring(index2+1,index3));
			$("input[name=goodsName1]").val($("input[name=goodsNameProductBranch]").val() + ' '+ $("input[name=goodsNameGoodsSpec]").val());
			$("input[name=goodsName1]").val($("input[name=goodsName]").val().substring(0,index2));
		}
		if(temp=="自定义"){
			$("input[name=child]").attr("readonly",false);
			$("input[name=adult]").attr("readonly",false);
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
		
		//设置已有退改的时间
		$("#cancelStrategyContent").find("div.cancelStrategyDiv").each(function(){
				var time = $(this).find(".latestCancelTime").val();
				var day = $(this).find("select[name=latestCancelTime_Day]");
				var hour = $(this).find("select[name=latestCancelTime_Hour]");
				var minute = $(this).find("select[name=latestCancelTime_Minute]");
				minutesToDate(time,day,hour,minute);
		});
		
		//选择票种
		$("select[name=goodsSpec]").change(function(){
			var temp= $("select[name=goodsSpec] option:selected").text();
			if(temp=="自定义"){
				$("input[name=child]").attr("readonly",false);
				$("input[name=adult]").attr("readonly",false);
			}else{
				$("input[name=child]").attr("readonly",true);
				$("input[name=adult]").attr("readonly",true);
				$("input[name=adult]").val($("select[name=goodsSpec] option:selected").attr('adult'));
				$("input[name=child]").val($("select[name=goodsSpec] option:selected").attr('child'));
				$("input[name=goodsNameGoodsSpec]").val($("select[name=goodsSpec] option:selected").attr('specName'));
				$("input[name=goodsName1]").val($("input[name=goodsNameProductBranch]").val() + ' '+ $("input[name=goodsNameGoodsSpec]").val());
				if($("input[name=goodsName2]").val()==""){
					$("input[name=goodsName]").val($("input[name=goodsName1]").val());
				}else{
					$("input[name=goodsName]").val($("input[name=goodsName1]").val() + '【'+ $("input[name=goodsName2]").val() +'】');
				}
			}
		});
		
		//【】中商品名
		$("input[name=goodsName2]").keyup(function() {
			if($("input[name=goodsName2]").val()==""){
				$("input[name=goodsName]").val($("input[name=goodsName1]").val());
			}else{
				$("input[name=goodsName]").val($("input[name=goodsName1]").val() + '【'+ $("input[name=goodsName2]").val() +'】');
			}
		});
		
		$("input[name=goodsName1]").keyup(function() {
			if($("input[name=goodsName2]").val()==""){
				$("input[name=goodsName]").val($("input[name=goodsName1]").val());
			}else{
				$("input[name=goodsName]").val($("input[name=goodsName1]").val() + '【'+ $("input[name=goodsName2]").val() +'】');
			}
		});
		$("input[name=deductValue]").keyup(function() {
			if($("input[name=deductValue]").val()==""){
				$("input[name=deductValue]").val(0);
			}
		});
		$("#update").bind("click",function(){
			/**
			 * 验证正整数
			 */
			jQuery.validator.addMethod("isInteger1", function(value, element) {
			     var num = /^[1-9]{0}\d*(\.\d{1,2})?$/;
		   		 return this.optional(element) || (num.test(value));
			 }, "只能填写2位小数");
			if(!$("#dataForm").validate({
				rules : {
					adult:{
						required : true,
						min:0,
						max:999
					},
					child:{
						required : true,
						min:0,
						max:999
					},
					minQuantity: {
						required : true,
						min:0,
						max:999
					},
					maxQuantity: {
						required : true,
						min:0,
						max:999
					},
					deductValue: {
						isInteger1:true,
						min:0,
						max:999
					}
				}
			}).form()){
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
			if($("input[name=startTime]").val()>$("input[name=endTime]").val()){
				$.alert("开始时间不能大于结束时间！");
				return false;
			}	
			if(parseInt($("input[name=child]").val())==0 && parseInt($("input[name=adult]").val())==0){
				$.alert("儿童成人数量不能同时为0！");
				return false;
			}
			if(parseInt($("input[name=maxQuantity]").val())<parseInt($("input[name=minQuantity]").val())){
				$.alert("最小订购数量不能大于最大订购数量！");
				return false;
			}	
			
			//判断不适用日期
			var unvalidDate  = $("input[name=unvalid]").val();
			var isValidDate = true; 
			if(unvalidDate!="" && typeof(unvalidDate) != "undefined"){
				var unvalidDateArray =  unvalidDate.split(",");
				for(var i=0;i<unvalidDateArray.length;i++){
					var date = unvalidDateArray[i];
					var objRegExp = /^(\d{4})\-(\d{2})\-(\d{2})$/;
					if(!objRegExp.test(date)){
						isValidDate = false;
					}
				}
			}
			if(!isValidDate){
				$.alert("期票商品不适用日期格式不正确!");
				return;
			}
			//把最晚无损退票时间转化为分钟数
			$("#cancelStrategyContent").find("div.cancelStrategyDiv").each(function(){
					var target = $(this).find(".latestCancelTime");
					var day = $(this).find("select[name=latestCancelTime_Day]").val();
					var hour = $(this).find("select[name=latestCancelTime_Hour]").val();
					var minute = $(this).find("select[name=latestCancelTime_Minute]").val();
					setLatestCancelTime(parseInt(day),parseInt(hour),parseInt(minute),target);
			});
			//转换退改价格
			$("input[name=deductValue]").each(function(){
					$(this).prev("input").val(parseInt($(this).val()*100));
			});
			$("input[name=goodsName]").val($.trim($("input[name=goodsName]").val()));
			
			var msg = '确认修改吗 ？';	
			if(refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"))){
				$("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?';
			}else {
			$("input[name=senisitiveFlag]").val("N");
		}
			$.confirm(msg,function(){
				$.ajax({
					url : "/vst_back/ticket/goods/goods/updateSuppGoods.do",
					type : "post",
					data : $(".dialog #dataForm").serialize(),
					success : function(result) {
						confirmAndRefresh(result);
					}
				});
			});
		
		});
		refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"));
		
var index = $("#cancelStrategyContent").find("div.cancelStrategyDiv").size();
$("#add").bind("click",function(){
	//获得模板
	var template = $("#template").html();
	//判断是不是期票
	var aperiodicFlag = $("#aperiodicFlag").val();
	if(aperiodicFlag=="Y"){
		template = template.replace(/{{name}}/g,"最晚有效期");
	}else {
		template = template.replace(/{{name}}/g,"游玩");
	}
	//设置index
	template = template.replace(/{{index}}/g,index);
	index++;
	var templateObj = $(template);
	//添加模板
	$("#cancelStrategyContent").append(templateObj);
});		

function deleteRefund(goodsRefundId){
		var flag = false;
		$.ajax({
			url : "/vst_back/ticket/goods/goods/deleteSuppGoodsRefund.do",
			type : "post",
			data : {"goodsRefundId":goodsRefundId},
			async:false,
			success : function(result) {
				if(result=='success'){
					flag = true;
				}
			}
		});
		return flag;
}		


//设置最晚取消时间
function setLatestCancelTime(day,hour,minute,target){
	target.val(day*24*60-hour*60-minute);
}

$(".delete").live("click",function(){
	var cancelStrategyDiv = $(this).parents(".cancelStrategyDiv");
	var refundId = cancelStrategyDiv.attr("data");
	if(refundId!=null){
				deleteRefund(refundId);
				cancelStrategyDiv.remove();
	}else {
			cancelStrategyDiv.remove();
	}
});
</script>
