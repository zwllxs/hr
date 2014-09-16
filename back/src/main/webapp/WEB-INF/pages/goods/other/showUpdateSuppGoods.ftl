
<form action="/vst_back/other/goods/addSuppGoods.do" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
	<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">
	<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId}">
	<input type="hidden" name="onlineFlag" value="${suppGoods.onlineFlag}">       
    <input type="hidden" name="refundId" value="${suppGoodsRefund.refundId}">
    <input type="hidden" name="timePriceId" value="${timePrice.timePriceId}">
    <input type="hidden" name="senisitiveFlag" value="N">
    
<#if timePrice != null && timePrice.aheadBookTime != null>
	<#assign aheadBookTime = timePrice.aheadBookTime>
</#if>
<#if suppGoodsRefund != null && suppGoodsRefund.latestCancelTime != null>
	<#assign latestCancelTime = suppGoodsRefund.latestCancelTime>
</#if>

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
                	<input type="text" name="goodsName" style="width:260px" value="${suppGoods.goodsName}" maxlength="50" required>
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
            <#include "/goods/ticket/goods/showDistributorGoods.ftl"/>
            <tr>
				<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
				<td colspan=2>
					<input type="radio" name="packageFlag" value="Y" <#if suppGoods?? && suppGoods.packageFlag=='Y'>checked</#if>>是
					<input type="radio" name="packageFlag" value="N" <#if suppGoods?? && suppGoods.packageFlag=='N'>checked</#if>>否
                </td>
            </tr> 
            <tr>
				<td class="p_label"><i class="cc1"></i>库存量：</td>
				<td colspan=2>
					<input type="radio"  name="oversellFlag" value="Y" checked>无限
					<#if !(prodProduct.bizCategoryId==90 && prodProduct.productType == "EXPRESS")>
						<input type="radio"  name="oversellFlag" value="N" checked>不能超卖
					</#if>
	            </td>
	        </tr>
            <tr>
				<td class="p_label"><i class="cc1"></i>是否资源审核：</td>
				<td colspan=2>
					<#if !(prodProduct.bizCategoryId==90 && prodProduct.productType == "EXPRESS")>
						<input type="radio"  name="sourceChecked" value="Y" checked>是
					</#if>
					<input type="radio"  name="sourceChecked" value="N" checked>否
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
					<td rowspan="4" class="p_label" ><i class="cc1">*</i>商品类型：</td>
				 </tr>
				<#if goodsTypeList??>	
					<#list goodsTypeList as goodsType>
						<#if goodsType=="EXPRESSTYPE_DISPLAY">
						<tr>
							<td colspan=2>
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
							 <#if prodProduct.bizCategoryId==90 && prodProduct.productType == "EXPRESS">
								<tr>
									<td colspan=2>
										<label name="bizPostAera.areaName" id="areaName" <#if bizPostAera!=null && bizPostAera.areaName!=null>value="${bizPostAera.areaName}"</#if>><#if bizPostAera!=null && bizPostAera.areaName!=null>${bizPostAera.areaName}</#if></label>
										<input type="hidden" name="areaId" id="areaId" required <#if bizPostAera!=null && bizPostAera.areaId!=null> value="${bizPostAera.areaId}"</#if>>
										[收件地]
										 &nbsp;&nbsp;&nbsp;
										<label>是否免运费</label>
										<input type="radio" name="postFreeFlag" value="Y"  <#if "Y"==suppGoods.postFreeFlag>checked=checked</#if>>是
										<input type="radio" name="postFreeFlag" value="N"  <#if "N"==suppGoods.postFreeFlag>checked=checked</#if>>否
									</td>
								</tr>
							</#if>
						</#if>
						<#if goodsType=="NOTICETYPE_DISPLAY" &&  prodProduct.productType != "EXPRESS">
						<tr>
							<td colspan=2>
								<input type="radio" name="goodsType" value="${goodsType.code}" <#if goodsType.code==suppGoods.goodsType>checked=checked</#if> required>${goodsType.cnName}
								</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label>通知方式  </label>
								<select name="noticeType">
								<#list noticeTypeList as noticeType>
									<option value="${noticeType.code}" <#if noticeType.code==suppGoods.noticeType>selected="selected"</#if> >${noticeType.cnName}</option>
								</#list>
								</select>
							</td>
						</tr>
						<#else>
							<tr><td colspan=2></td></tr>
						</#if>
					</#list>	
				</#if>  
				
             <tr>
					<td class="p_label"><i class="cc1">*</i>最小起订数量：</td>
					<td colspan=2>
						<input type="text" name="minQuantity" required=true value="${suppGoods.minQuantity}" min=0 max=999 maxlength="3">
		            </td>
		        </tr>
		        <tr>
					<td class="p_label"><i class="cc1">*</i>最大订购数量：</td>
					<td colspan=2>
						<input type="text" name="maxQuantity" required=true value="${suppGoods.maxQuantity}" min=0 max=999 maxlength="3">
		            </td>
		        </tr>   
              <tr>
               <tr>
         		<td class="p_label" ><i class="cc1">*</i>商品包含：</td>
            	<td >成人数： 
                	<input type="text" name="adult" style="width:30px" value="${suppGoods.adult}" min=0 max=999 maxlength="3" >
             		 儿童数： 
                	<input type="text" name="child" style="width:30px" value="${suppGoods.child}"  min=0 max=999 maxlength="3" >
                </td>
            </tr> 
            
            <td class="e_label"><i class="cc1">*</i>提前预定时间：</td>
            <td>
            	<input type="hidden"  name="aheadBookTime" id="aheadBookTime">
				出游前的
            	<select class="w10 mr10" style="width:80px" name="aheadHour_day" id="aheadHour_day" required>
                      <#list 0..50 as i>
                       	  <#if i_index == 0>
                      	  		<option value="${i}">${i}(当)</option>
                      	  <#else>
                      	  		<option value="${i}">${i}</option>
                      	  </#if>
                      </#list>
                </select>天
                <select class="w10 mr10" style="width:60px" name="aheadHour_hour" id="aheadHour_hour" required>
                      <#list 0..23 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>点
                <select class="w10 mr10" style="width:60px" name="aheadHour_minute" id="aheadHour_minute" required>
                      <#list 0..59 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分前预订
            </td>
        </tr>
         <tr>
            <td class="e_label"><i class="cc1">*</i>销售价：</td>
            <td><input type="hidden" id="price" name="price" /><input type="text" id="priceInput" name="priceInput" number=true value="<#if timePrice != null>${timePrice.priceYuanStr}</#if>" required min=0/></td>
        </tr>
        <tr>
            <td class="e_label"><i class="cc1">*</i>结算价：</td>
            <td><input type="hidden" id="settlementPrice" name="settlementPrice" /><input type="text" id="settlementPriceInput" value="<#if timePrice != null>${timePrice.settlementPriceYuanStr}</#if>" name="settlementPriceInput" number=true  required min=0/>
            <div id="settlementPriceInputError"  ></div>
            </td>
       </tr>
       <tr class="pay">
            <td class="e_label"><i class="cc1">*</i>退改类型：</td>
             <td >
              <select class="w10" name="cancelStrategy" required id="cancelStrategy">
              		<option value="">请选择</option>
                	<option value="RETREATANDCHANGE" <#if "RETREATANDCHANGE"==suppGoodsRefund.cancelStrategy>selected="selected"</#if> >可退改</option>
                	<option value="UNRETREATANDCHANGE" <#if "UNRETREATANDCHANGE"==suppGoodsRefund.cancelStrategy>selected="selected"</#if>>不退不改</option>
                	<option value="MANUALCHANGE" <#if "MANUALCHANGE"==suppGoodsRefund.cancelStrategy>selected="selected"</#if>>人工退改</option>
                </select>
            </td>
        </tr>
         <tr>
			<td class="p_label">退改策略：</td>
			<td colspan=2>
            	 <input type="hidden" name="latestCancelTime" id="latestCancelTime" />
            	 出游前的
             	<select class="w10 mr10" style="width:80px" name="latestCancelTime_Day" id="latestCancelTime_Day" >
                      <#list 0..50 as i>
                       	<#if i_index == 0>
                      	  		<option value="${i}">${i}(当)</option>
                      	  <#else>
                      	  		<option value="${i}">${i}</option>
                      	  </#if>
                      </#list>
                </select>天
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour" id="latestCancelTime_Hour" >
                      <#list 0..23 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>点
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute" id="latestCancelTime_Minute" >
                      <#list 0..59 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分前可退改
            </td>
        </tr>
         <tr class="prePay">
                 <td class="e_label">预付扣款类型：</td>
                 <td >
                  <select class="w10" change="deductTypeChange()" id="deductType1" name="deductType">
                    	<option value="NONE" <#if "NONE"==suppGoodsRefund.deductType>selected="selected"</#if> >否</option>
                    	<option value="FULL" <#if "FULL"==suppGoodsRefund.deductType>selected="selected"</#if>>全额</option>	                    	
                    	<option value="FIRSTDAY" <#if "FIRSTDAY"==suppGoodsRefund.deductType>selected="selected"</#if>>首日</option>
                    	<option value="MONEY" <#if "MONEY"==suppGoodsRefund.deductType>selected="selected"</#if>>固定金额</option>
                    	<option value="PERCENT" <#if "PERCENT"==suppGoodsRefund.deductType>selected="selected"</#if>>百分比</option>
                    </select>   
                    <input type="hidden" id="deductValue" name="deductValue" value="${suppGoodsRefund.deductValue}"/>                
                 <input type="text" name="deductValueInput" id="deductValueInput" value="${suppGoodsRefund.deductValue}"  digits=true min=0/>
                 <div id="deductValueError" style="display:inline"></div>
                </td>
            </tr>
                
        </tbody>
    </table>
</form>
&nbsp;&nbsp;&nbsp;&nbsp;
 <div class="p_box box_info clearfix mb20">
	<div class="fl operate"><a class="btn btn_cc1" id="save">保存</a></div>
</div>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
</script>

<script>
var updateSuppGoodsDialog;	
var selectContractDialog2;
var addSuppGoodsDialog;
var selectSuppFaxRule;
var selectBizPostAera;

/**
 * 验证是否为负数
 */
jQuery.validator.addMethod("isMinus", function(value, element) {
    var chars =  /^-/;
    return this.optional(element) || (!chars.test(value));       
 }, "不能输入负数");	
		 
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
 
//打开选择收件地列表
$("#change_button_area").click(function(){
	selectBizPostAera = new xDialog("/vst_back/other/goods/selectBizPostAeraList.do?callback=onSelectBizPostAera",{},{title:"收件地",iframe:true,width:"700",height:"400"});
});

//收件地回调函数
function onSelectBizPostAera(params){
	if(params!=null){
		$("#areaName").text(params.areaName);
		$("#areaId").val(params.areaId);
	}
	selectBizPostAera.close();
}

function jsSelectItemByValue(objSelect, value){
	for (var i = 0; i < objSelect.options.length; i++) {
		if (objSelect.options[i].value() == value){
			 objSelect.options[i].selected = true; 
			 $("#id option[value='1']").attr("selected","selected");
			 break; 
		}
	}
};

//将提前预定时间选中
function fillPageSelectValue(time, selectCode){
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
		
	}else if(time < 0 ){
		time = -time;
		hour = parseInt(time/60);
		minute = parseInt(time%60);
	}
	if(hour<10)
		hour = hour;
	if(minute<10)
		minute = minute;
	
	if(selectCode == 'aheadBookTime'){
		$("#aheadHour_day option[value="+day+"]").attr("selected","selected");
		$("#aheadHour_hour option[value="+hour+"]").attr("selected","selected");
		$("#aheadHour_minute option[value="+minute+"]").attr("selected","selected");
		
	}else if(selectCode == 'latestCancelTime'){
		$("#latestCancelTime_Day option[value="+day+"]").attr("selected","selected");
		$("#latestCancelTime_Hour option[value="+hour+"]").attr("selected","selected");
		$("#latestCancelTime_Minute option[value="+minute+"]").attr("selected","selected");
	}
	
};

var aheadBookTime = ${aheadBookTime};
fillPageSelectValue(parseInt(aheadBookTime), 'aheadBookTime');    

var latestCancelTime = ${latestCancelTime};
fillPageSelectValue(parseInt(latestCancelTime), 'latestCancelTime');    

//保存
$("#save").bind("click",function(){
	//把提前预定时间转换为分钟数	
	var day = $("select[name=aheadHour_day]").val() == "" ? 0 : parseInt($("select[name=aheadHour_day]").val());
	var hour = $("select[name=aheadHour_hour]").val() == "" ? 0 : parseInt($("select[name=aheadHour_hour]").val());
	var minute = $("select[name=aheadHour_minute]").val() == "" ? 0 : parseInt($("select[name=aheadHour_minute]").val());
	$("#aheadBookTime").val(day*24*60-hour*60-minute);
	var aheadBookTime = $("#aheadBookTime").val();
   
	//把最晚无损退票时间转化为分钟数
	var day1 = $("select[name=latestCancelTime_Day]").val() == "" ? 0 : parseInt($("select[name=latestCancelTime_Day]").val());
	var hour1 = $("select[name=latestCancelTime_Hour]").val() == "" ? 0 : parseInt($("select[name=latestCancelTime_Hour]").val());
	var minute1 = $("select[name=latestCancelTime_Minute]").val() == "" ? 0 : parseInt($("select[name=latestCancelTime_Minute]").val());
	$("#latestCancelTime").val(day1*24*60-hour1*60-minute1);
	var latestCancelTime = $("#latestCancelTime").val();
    
	if(!$("#dataForm").validate({
			rules: {
			   priceInput: {
			    isMinus : true,
			    required: true,
			    number: true,
			    min : 0
			   },
			   settlementPriceInput: {
			    isMinus : true,
			    required: true,
			    number: true,
			    min : 0
			   },minQuantity: {
					required : true,
					min:0,
					max:999
				},
				maxQuantity: {
					required : true,
					min:0,
					max:999
				}
			  },
			messages: {
			   priceInput: "请输入正确的销售价",
			   settlementPriceInput:"请输入正确的结算价"
			  }
		}).form()){
			return false;
		}
	
	var priceInput = parseFloat($("#priceInput").val());	
	var settlementPriceInput = parseFloat($("#settlementPriceInput").val());
	
	 if(aheadBookTime == 0)
	 {
		$.alert("选择提前时间！");
		return false;
	 }
	 if(latestCancelTime == 0)
	 {
		$.alert("选择退票时间！");
		return false;
	 }
	if(!priceInput > 0)
	 {
		$.alert("销售价必须大于0！");
		return false;
	 }
	 if(!settlementPriceInput > 0)
	 {
		$.alert("结算价必须大于0！");
		return false;
	 }
	 if(priceInput < settlementPriceInput)
	 {
		$.alert("销售价必须大于结算价！");
		return false;
	 }
	if(parseInt($("input[name=maxQuantity]").val())<parseInt($("input[name=minQuantity]").val())){
		$.alert("最小订购数量不能大于最大订购数量！");
		return false;
	}
		
	//将元转换为分
	if($("#settlementPriceInput").val()!="")
	$("#settlementPrice").val(Math.round(parseFloat($("#settlementPriceInput").val())*100));
	if($("#priceInput").val()!="")
	$("#price").val(Math.round(parseFloat($("#priceInput").val())*100));
	 if($("#deductValueInput").val()!="")
	$("#deductValue").val(Math.round(parseFloat($("#deductValueInput").val())*100));
	
	if($("#contractIdAdd").val()==""){
		$.alert("请选择供应商合同！");
		return false;
	}
	var cancelStrategy = $("#cancelStrategy").val();
	if(cancelStrategy.indexOf("RETREATANDCHANGE")==0 || cancelStrategy.indexOf("RETREATANDCHANGE")> 0 ){
		if($("#latestCancelTime").val() == 0){
			alert("填写最晚无损退票时间");
			return false;
		}
		if(typeof($("#deductValueInput").val()) == "undefined"){
			alert("填写完整预付扣款类型");
			return false;
		}
		if($("#deductType1").val() == "NONE"){
			alert("填写预付扣款类型");
			return false;
		}
	}
	
	var msg = '确认保存吗 ？';	
	if(refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"))){
	$("input[name=senisitiveFlag]").val("Y");
	 	msg = '内容含有敏感词,是否继续?';
	}else {
		$("input[name=senisitiveFlag]").val("N");
	}
	$.confirm(msg,function(){
		var loading = top.pandora.loading("正在努力保存中...");
		$("#save").attr("disabled","disabled");
		$("#settlementPriceInput").attr("disabled","disabled");
		$("#priceInput").attr("disabled","disabled");
	
		$.ajax({
			url : "/vst_back/other/goods/updateSuppGoods.do",
			type : "post",
			data : $(".dialog #dataForm").serialize(),
			success : function(result) {
				loading.close();
				$("#save").hide();
				$("#priceInput").removeAttr("disabled"); 
				$("#settlementPriceInput").removeAttr("disabled");
				confirmAndRefresh(result);
			}
		});
	});
		
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#save").show();
			$("#save").removeAttr("disabled");
			updateSuppGoodsDialog.close();
	   		$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#save").removeAttr("disabled");
			$.alert(result.message);
		}});
	}
};

refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"));
</script>
