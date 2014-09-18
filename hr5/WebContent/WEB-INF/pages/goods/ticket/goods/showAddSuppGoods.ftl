<form action="/vst_back/ticket/goods/goods/addSuppGoods.do" method="post" id="dataForm">
		<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
		<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">
		<input type="hidden" name="aperiodicFlag" value="${suppGoods.aperiodicFlag}" id="aperiodicFlag">  
		<input type="hidden" name="senisitiveFlag" value="N">
		<input type="hidden" name="stockApiFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
            	<tr>
                	<td colspan=3>基本信息：</td>
                </tr>
                <tr>
                	<td class="p_label" width="100"><i class="cc1">*</i>所属规格：</td>
                	<td colspan=2>
                		<#if prodProductBranchList?size gt 0>
	                		<select name="productBranchId" id="productBranchId1" required>
									  	<option value="">请选择</option>
									  	<#list prodProductBranchList as prodProductBranch>
						                    <option value="${prodProductBranch.productBranchId}" <#if suppGoods?? && suppGoods.prodProductBranch?? && suppGoods.prodProductBranch.productBranchId==prodProductBranch.productBranchId>selected</#if> data= "${prodProductBranch.singleItemCategoryId!''}">${prodProductBranch.branchName}</option>
									  	</#list>
		                	</select>
		                <#else>	
		                	<span class="notnull">请先创建产品规格!</span>
                		</#if>
                		 <span style="color:grey">必须选择规格，当规格分类等于单门票时，规格名称不带到商品名称中。</span>
                	</td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>门票票种：</td>
                    <td colspan=2>
                    	<select name="goodsSpec" required>
                    	 			<option value="">请选择</option>
		    				<#list goodsSpecList as list>
		    						<#if combTicketFlag = "Y"><option value=${list.code!''} specName=${list.specName!''} adult=${list.adult!''} child=${list.child!''}>${list.cnName!''}</option>
		    						<#elseif list.code!="PARENTAGE" && list.code!="FAMILY" && list.code!="LOVER" && list.code!="COUPE" && list.code!="FREE">
		    							<option value=${list.code!''} specName=${list.specName!''} adult=${list.adult!''} child=${list.child!''}>${list.cnName!''}</option>
		    						</#if>
			                </#list>
			        	</select>
                    </td>
                </tr>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>成人数：</td>
                    <td colspan=2>
                    	<input type="text" name="adult" style="width:30px" value=0 min=0 max=999 required readonly>
                    </td>
                </tr>
                 <tr>
                	<td class="p_label"><i class="cc1">*</i>儿童数：</td>
                    <td colspan=2>
                    	<input type="text" name="child" style="width:30px" value=0 min=0 max=999 required readonly>
                    </td>
                </tr>
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="hidden" name="goodsNameProductBranch"><input type="hidden" name="goodsNameGoodsSpec">
                    	<input type="text" name="goodsName1" style="width:260px" value="" required maxlength=40>
                    	【<input type="text" name="goodsName2" style="width:160px" value="" maxlength=60>】
                    	<input type="hidden" name="goodsName">
                    	
                    	<span style="color:grey">名称必须填写，副标题可描述商品特点，不允许输入中括号“【】”</span>
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
												<#if noticeType.code!='EMAIL'>
													<option value="${noticeType.code}">${noticeType.cnName}</option>
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
					<td class="p_label"><i class="cc1">*</i>产品经理：</td>
					<td colspan=2>
						<input type="text" name="managerName" id="managerName" value="${suppGoods.managerName}" required=true>
                    	<input type="hidden" value="${suppGoods.managerId}" name="managerId" id="managerId" required=true>
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
					<td class="p_label"><i class="cc1">*</i>是否有效：</td>
					<td colspan=2>
						<select name="cancelFlag" required>
	                    	<option value="Y" <#if suppGoods!=null && suppGoods.cancelFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods!=null && suppGoods.cancelFlag=='N'>selected</#if>>否</option>
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
						<#if suppGoods!=null && suppGoods.aperiodicFlag=='N'>
							指定游玩日后<select name="days" style="width:70px" required>
								<option value="1">1(当)</option>
		                    	 	<#list 2..10 as i>
			                      <option value="${i}">${i}</option>
			                      </#list>
		                    </select>天内有效
		                <#else>
		                <input type="text" style="width:100px" name="startTime" errorEle="selectDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'d4322\',{d:0});}'})" required/>至
                		<input type="text" style="width:100px" name="endTime" errorEle="selectDate" class="Wdate" id="d4322" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'d4321\',{y:2});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" required/>有效<div id="selectDateError" style="display:inline"></div></br>
		                                          期票商品不适用日期：<input type="text" name="unvalid" maxlength="100">案例：2014-09-05,2014-09-05 ，不适用日期该格式填写，中间用英文逗号分开
		                </#if>
                    </td>
                </tr>
                <tr>
					<td colspan=3>供应商信息：</td>
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
					<td colspan=3>退改信息：</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>退改策略：</td>
					<td colspan=2>
								<div>
				                 		<input type="radio" name="cancelStrategy" value="MANUALCHANGE" checked="checked">可退改
				                 </div>
				                 <div id="cancelStrategyContent">
						                <div style="margin-top:2px;margin-bottom:2px;" class="cancelStrategyDiv">
								                 <#if suppGoods.aperiodicFlag=="Y">最晚有效期<#else>游玩</#if>
								                 <input type="hidden" name="goodsReFundList[0].latestCancelTime" class="latestCancelTime">
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
									                </select>分退改：扣除<select style="width:100px;margin-right:10px;" name="goodsReFundList[0].deductType" ><option value="AMOUNT">固定金额(元)</option><option value="PERCENT">票价百分比(%)</option></select>
									                <input type="hidden" style="width:30px" min=0 max=999 value=0 name="goodsReFundList[0].deductValue">
									                <input type="text" style="width:30px" min=0 max=999 value=0 name="deductValue">
									                <span class="operate"><a class="btn btn_cc1" id="add">添加</a></span>
					                   		</div>
                   					</div>
                   			<div style="margin-top:5px;">
                   					<input type="radio" name="cancelStrategy" value="UNRETREATANDCHANGE" >不可退改
                   			</div>
                    </td>
                </tr>
                <tr>
					<td colspan=3>预订限制：</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
					<td colspan=2>
						<input type="radio" name="packageFlag" value="Y">是
	                	<input type="radio" name="packageFlag" value="N" checked>否
                    </td>
                </tr> 
                <tr>
					<td class="p_label"><i class="cc1">*</i>最小起订数量：</td>
					<td colspan=2>
						<input type="text" name="minQuantity"  min=0 max=999 required=true >
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最大订购数量：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity" min=0 max=999 required=true>
                    </td>
                </tr>
                
            </tbody>
        </table>
</form>
<div class="p_box box_info clearfix mb20">
            <div class="fl operate" style="margin-top:20px;"><a class="btn btn_cc1" id="save">保存</a></div>
</div>
<div id="template" style="display:none">
		<div style="margin-top:2px;margin-bottom:2px;" class="cancelStrategyDiv">
             {{name}}
             <input type="hidden" name="goodsReFundList[{{index}}].latestCancelTime" class="latestCancelTime">
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
                </select>分退改：扣除<select style="width:100px;margin-right:10px;" name="goodsReFundList[{{index}}].deductType" ><option value="AMOUNT">固定金额(元)</option><option value="PERCENT">票价百分比(%)</option></select>
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


if($("#productBranchId option:selected").val()!=''){
	if($("#productBranchId1 option:selected").attr("data")!="310"){
		$("input[name=goodsNameProductBranch]").val($("#productBranchId option:selected").text());
		$("input[name=goodsName1]").val($("#productBranchId option:selected").text());
	}
}

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
		
		//选择票种
		$("select[name=goodsSpec]").change(function(){
			var temp= $("select[name=goodsSpec] option:selected").text();
			if(temp=="自定义"){
				$("input[name=goodsName1]").val("");
				$("input[name=child]").attr("readonly",false);
				$("input[name=child]").val("");
				$("input[name=adult]").attr("readonly",false);
				$("input[name=adult]").val("");
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
		
		//选择规格
		$("#productBranchId1").change(function(){
			if($("#productBranchId1 option:selected").attr("data")!="310"){
				$("input[name=goodsNameProductBranch]").val($("#productBranchId1 option:selected").text());
			}else{
				$("input[name=goodsNameProductBranch]").val("");
			}
			$("input[name=goodsName1]").val($("input[name=goodsNameProductBranch]").val() + ' '+ $("input[name=goodsNameGoodsSpec]").val());
			if($("input[name=goodsName2]").val()==""){
				$("input[name=goodsName]").val($("input[name=goodsName1]").val());
			}else{
				$("input[name=goodsName]").val($("input[name=goodsName1]").val() + '【'+ $("input[name=goodsName2]").val() +'】');
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
		
		$("#save").bind("click",function(){
			/**
			 * 验证正整数
			 */
			jQuery.validator.addMethod("isInteger1", function(value, element) {
			    var num = /^[1-9]{0}\d*(\.\d{1,2})?$/;
			    return this.optional(element) || (num.test(value));       
			 }, "只能填写整数");
		 
		
			//验证
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
			if($("#contractIdAdd").val()==""){
				$.alert("请选择供应商合同！");
				return false;
			}
			if(parseInt($("input[name=maxQuantity]").val())<parseInt($("input[name=minQuantity]").val())){
				$.alert("最小订购数量不能大于最大订购数量！");
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
			if('Y'==$("input:radio[name='faxFlag']:checked").val() && $("input[name='faxRuleId']").val()==""){
				$.alert("请选择供应商传真号！");
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
			var msg = '确认保存吗 ？';	
			if(refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"))){
				$("input[name=senisitiveFlag]").val("Y");
			 	msg = '内容含有敏感词,是否继续?';
			}else {
			$("input[name=senisitiveFlag]").val("N");
			}
			$.confirm(msg,function(){
				$.ajax({
				url : "/vst_back/ticket/goods/goods/addSuppGoods.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					confirmAndRefresh(result);
				}
			});
			});
		});
var index = 1;
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
	//增加删除
	templateObj.find(".delete").click(function(){
		$.confirm("是否删除",function(){
					templateObj.remove();
		});
	});
});

//设置最晚取消时间
function setLatestCancelTime(day,hour,minute,target){
	target.val(day*24*60-hour*60-minute);
}
</script>