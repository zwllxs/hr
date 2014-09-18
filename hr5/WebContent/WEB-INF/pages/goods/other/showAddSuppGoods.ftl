
<form action="/vst_back/other/goods/addSuppGoods.do" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
	<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">  
	<input type="hidden" name="stockApiFlag" value="N">
	<input type="hidden" name="senisitiveFlag" value="N">
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
            	<input type="text" name="goodsName" style="width:260px" value="" maxlength="50" required>
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
				<input type="hidden" id="contractIdAdd" name="contractId" required <#if suppGoods!=null && suppGoods.suppContract!=null> value="${suppGoods.suppContract.contractId}"</#if>>
				<a id="change_button_contract" href="#">[更改]</a>
				<div id="contractIdError"></div>
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
        <#include "/goods/ticket/goods/showDistributorGoods.ftl"/>
        <tr>
			<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
			<td colspan=2>
				<input type="radio" required name="packageFlag" value="Y" >是
            	<input type="radio" required name="packageFlag" value="N" checked >否
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
				<input type="text" name="minQuantity" required=true value="${suppGoods.minQuantity}" min=0 max=999 maxlength="3">
            </td>
        </tr>
          <tr>
			<td class="p_label"><i class="cc1">*</i>最多订购份数/间数：</td>
			<td colspan=2>
				<input type="text" name="maxQuantity" required=true value="${suppGoods.maxQuantity}" min=0 max=999 maxlength="3">
            </td>
        </tr>   
         <tr>
         		<td   class="p_label" ><i class="cc1">*</i>商品包含：</td>
            	<td colspan=2>成人数： 
                	<input type="text" name="adult" style="width:30px" value="${suppGoods.adult}"  >
               		儿童数： 
                	<input type="text" name="child" style="width:30px" value="${suppGoods.child}"  >
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
							 <#if prodProduct.bizCategoryId==90 && prodProduct.productType == "EXPRESS">
								 <tr>
										<td colspan=2>
											<label name="bizPostAera.areaName" id="areaName"></label>
											<input type="hidden" name="areaId" id="areaId" required>
											 <a id="change_button_area" href="#">[收件地]</a>
											 &nbsp;&nbsp;&nbsp;
											<label>是否免运费</label>
											<input type="radio" name="postFreeFlag" value="Y" >是
											<input type="radio" name="postFreeFlag" value="N" checked=checked>否
										</td>
								</tr>
							</#if>
						</#if>
						<#if goodsType=="NOTICETYPE_DISPLAY" &&  prodProduct.productType != "EXPRESS">
							<tr>
									<td colspan=2>
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
						<#else>
							<tr><td colspan=2></td></tr>
						</#if>
					</#list>	
				</#if>
         <tr>
            <td class="e_label"><i class="cc1">*</i>销售价：</td>
            <td colspan=2><input type="hidden" id="price" name="price" /><input type="text" id="priceInput" name="priceInput" number=true  maxLength=10 required min=0/></td>
        </tr>
        <tr>
            <td class="e_label"><i class="cc1">*</i>结算价：</td>
            <td colspan=2><input type="hidden" id="settlementPrice" name="settlementPrice" /><input type="text" id="settlementPriceInput" maxLength=10 name="settlementPriceInput" number=true  required min=0/>
            <div id="settlementPriceInputError"  ></div>
            </td>
       </tr>
   
	  <tr>
        <td class="e_label"><i class="cc1">*</i>提前预定时间：</td>
        <td colspan=2>
        	<input type="hidden"  name="aheadBookTime" id="aheadBookTime">
			出游前的
        	<select class="w10 mr10" style="width:80px" name="aheadHour_day" required>
                  <#list 0..50 as i>
                  	  <#if i_index == 0>
                  	  		<option value="${i}">${i}(当)</option>
                  	  <#else>
                  	  		<option value="${i}">${i}</option>
                  	  </#if>
                  </#list>
            </select>天
            <select class="w10 mr10" style="width:60px" name="aheadHour_hour" required>
                  <#list 0..23 as i>
                  <option value="${i}">${i}</option>
                  </#list>
            </select>点
            <select class="w10 mr10" style="width:60px" name="aheadHour_minute" required>
                  <#list 0..59 as i>
                  <option value="${i}">${i}</option>
                  </#list>
            </select>分前预订
        </td>
    </tr>
    <tr >
        <td class="e_label"><i class="cc1">*</i>退改类型：</td>
         <td colspan=2>
          <select class="w10" name="cancelStrategy" id="cancelStrategy" required>
          		<option value="">请选择</option>
            	<option value="RETREATANDCHANGE">可退改</option>
            	<option value="UNRETREATANDCHANGE">不退不改</option>
            	<option value="MANUALCHANGE">人工退改</option>	  
          </select>
        </td>
    </tr>
    <tr class="rePay">
		<td class="p_label">退改策略：</td>
		<td colspan=2>
        	 <input type="hidden" name="latestCancelTime" id="latestCancelTime" />
        	 出游前的
         	<select class="w10 mr10" style="width:80px" name="latestCancelTime_Day">
                  <#list 0..50 as i>
                      <#if i_index == 0>
                  		  <option value="${i}">${i}(当)</option>
                  	  <#else>
                  	  	  <option value="${i}">${i}</option>
                  	  </#if>
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
            </select>分前可退改
        </td>
    </tr>
    <tr class="rePay">
         <td class="e_label">预付扣款类型：</td>
         <td colspan=2>
          <select class="w10" change="deductTypeChange()" id="deductType1" name="deductType">
            	<option value="NONE">否</option>
            	<option value="FULL">全额</option>	                    	
            	<option value="FIRSTDAY">首日</option>
            	<option value="MONEY">固定金额</option>
            	<option value="PERCENT">百分比</option>
            </select>   
            <input type="hidden" id="deductValue" name="deductValue" />                
         <input type="text" name="deductValueInput" id="deductValueInput" value="${deductValue}"  digits=true min=0/>
         <div id="deductValueError" style="display:inline"></div>
        </td>
    </tr>
    </tbody>
    </table>
</form>
 
 <div class="p_box box_info clearfix mb20">
	<div class="fl operate"><a class="btn btn_cc1" id="save">保存</a></div>
</div>

<script> 
vst_pet_util.superUserSuggest("#contentManagerName","input[name=contentManagerId]");
vst_pet_util.superUserSuggest("#managerName","input[name=managerId]");
</script>

<script>
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
	
	if('Y'==$("input:radio[name='faxFlag']:checked").val() && $("input[name='faxRuleId']").val()==""){
		$.alert("请选择供应商传真号！");
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
		$("#settlementPriceInput").attr("disabled","disabled");
		$("#priceInput").attr("disabled","disabled");
		
		$.ajax({
			url : "/vst_back/other/goods/addSuppGoods.do",
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

//打开选择供应商传真号列表
$("#change_button_fax").click(function(){
	selectSuppFaxRule = new xDialog("/vst_back/supp/fax/selectSuppFaxRuleList.do?callback=onSelectSuppFaxRule&supplierId="+$("#supplierId").val()+"&categoryId="+$("input[name='prodProduct.bizCategory.categoryId']").val(),{},{title:"选择供应商传真号",iframe:true,width:"700",height:"400"});
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

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#save").show();
			$("#save").removeAttr("disabled");
			addSuppGoodsDialog.close();
	   		$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#save").removeAttr("disabled");
			$.alert(result.message);
		}});
	}
};
</script>