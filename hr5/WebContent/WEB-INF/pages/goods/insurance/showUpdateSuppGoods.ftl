
<form action="/vst_back/goods/goods/addSuppGoods.do" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
	<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">
	<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId}">
	<input type="hidden" name="onlineFlag" value="${suppGoods.onlineFlag}">       
    <input type="hidden" name="refundId" value="${suppGoodsRefund.refundId}">
    <input type="hidden" name="timePriceId" value="${timePrice.timePriceId}">
    <input type="hidden" name="senisitiveFlag" value="N">
    <input type="hidden" name="payTarget" value="PREPAID">
    
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
	        	<td class="p_label"><i class="cc1">*</i>代理产品编号：</td>
	            <td colspan=2>
	            	<input type="text" name="insuranceAgentNo" style="width:260px" value="${insuranceAgentNo}" required>
	            	人保：多个字符串，用英文逗号隔开。格式为：套餐编码,单证编号,档次.
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
				<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
				<td colspan=2>
					<input type="radio" name="packageFlag" value="Y" <#if suppGoods?? && suppGoods.packageFlag=='Y'>checked</#if>>是
					<input type="radio" name="packageFlag" value="N" <#if suppGoods?? && suppGoods.packageFlag=='N'>checked</#if>>否
                </td>
            </tr> 
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
			<td class="p_label"><i class="cc1">*</i>退改策略：</td>
			<td colspan=2>
            	 <input type="hidden" name="latestCancelTime" id="latestCancelTime" />
            	 出游前的
             	<select class="w10 mr10" style="width:80px" name="latestCancelTime_Day" id="latestCancelTime_Day" required>
                      <#list 0..50 as i>
                       	<#if i_index == 0>
                      	  		<option value="${i}">${i}(当)</option>
                      	  <#else>
                      	  		<option value="${i}">${i}</option>
                      	  </#if>
                      </#list>
                </select>天
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour" id="latestCancelTime_Hour" required>
                      <#list 0..23 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>点
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute" id="latestCancelTime_Minute" required>
                      <#list 0..59 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分前可退改
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
var selectContractDialog2, updateSuppGoodsDialog;	
//供应商合同回调函数
function onSelectContract2(params){
	if(params!=null){
		$("input[name='suppContract.contractName']").val(params.contractName);
		$("input[name='contractId']").val(params.contractId);
	}
	selectContractDialog2.close();
}
 
/**
 * 验证是否为负数
 */
jQuery.validator.addMethod("isMinus", function(value, element) {
    var chars =  /^-/;
    return this.optional(element) || (!chars.test(value));       
 }, "不能输入负数");
	 
//打开选择供应商合同列表
$("#change_button_contract").click(function(){
	selectContractDialog2 = new xDialog("/vst_back/supp/suppContract/selectContractListBySupplier.do?callback=onSelectContract2&supplierId="+$("#supplierId").val(),{},{title:"选择供应商合同",width:"600"});
});
 
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
		 
		if($("#contractIdAdd").val()==""){
			$.alert("请选择供应商合同！");
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
			var loading = top.pandora.loading("正在努力保存中...");
			$("#settlementPriceInput").attr("disabled","disabled");
			$("#priceInput").attr("disabled","disabled");
			$("#save").attr("disabled","disabled");
			
			$.ajax({
				url : "/vst_back/insurance/goods/updateSuppGoods.do",
				type : "post",
				data : $(".dialog #dataForm").serialize(),
				success : function(result) {
					loading.close();
					$("#save").hide();
					confirmAndRefresh(result);
				}
			});
		});
		
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#priceInput").removeAttr("disabled"); 
			$("#settlementPriceInput").removeAttr("disabled");			
			$("#save").show();
			$("#save").removeAttr("disabled");
			updateSuppGoodsDialog.close();
	   		$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, mask:true,okValue:"确定",ok:function(){
			$("#save").removeAttr("disabled");
			$("#priceInput").removeAttr("disabled"); 
			$("#settlementPriceInput").removeAttr("disabled");
			$.alert(result.message);
		}});
	}
};

refreshSensitiveWord($("#dataForm").find("input[type='text'],textarea"));
</script>
