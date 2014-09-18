
<form action="/vst_back/insurance/goods/addSuppGoods.do" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${suppGoods.suppSupplier.supplierId}">
	<input type="hidden" name="productId" value="${suppGoods.prodProduct.productId}">  
	<input type="hidden" name="payTarget" value="PREPAID">
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
        	<td class="p_label"><i class="cc1">*</i>代理产品编号：</td>
            <td colspan=2>
            	<input type="text" name="insuranceAgentNo" style="width:260px" value=""  maxLength=50 required>
            	人保：多个字符串，用英文逗号隔开。格式为：套餐编码,单证编号,档次.
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
			<td class="p_label"><i class="cc1">*</i>是否仅组合销售：</td>
			<td colspan=2>
				<input type="radio" required name="packageFlag" value="Y" >是
            	<input type="radio" required name="packageFlag" value="N" checked >否
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
         <tr>
			<td class="p_label"><i class="cc1">*</i>退改策略：</td>
			<td colspan=2>
            	 <input type="hidden" name="latestCancelTime" id="latestCancelTime" />
            	 出游前的
             	<select class="w10 mr10" style="width:80px" name="latestCancelTime_Day" required>
                      <#list 0..50 as i>
                          <#if i_index == 0>
                      		  <option value="${i}">${i}(当)</option>
                      	  <#else>
                      	  	  <option value="${i}">${i}</option>
                      	  </#if>
                      </#list>
                </select>天
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Hour" required>
                      <#list 0..23 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>点
                <select class="w10 mr10" style="width:60px" name="latestCancelTime_Minute" required>
                      <#list 0..59 as i>
                      <option value="${i}">${i}</option>
                      </#list>
                </select>分前可退改
            </td>
        </tr>
         <tr>
            <td class="e_label"><i class="cc1">*</i>销售价：</td>
            <td>
            	<input type="hidden" id="price" name="price" />
           		<input type="text" id="priceInput" name="priceInput" number=true  maxLength=10 required min=0/>
            </td>
        </tr>
        <tr>
            <td class="e_label"><i class="cc1">*</i>结算价：</td>
            <td>
            	<input type="hidden" id="settlementPrice" name="settlementPrice" />
            	<input type="text" id="settlementPriceInput" maxLength=10 name="settlementPriceInput" number=true  required min=0/>
            	<div id="settlementPriceInputError"  ></div>
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
	
		$.ajax({
			url : "/vst_back/insurance/goods/addSuppGoods.do",
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
			addSuppGoodsDialog.close();
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
</script>