<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<form action="" method="post" id="goodsDataForm">
		<input type="hidden" name="productId" value="${suppGoods.productId}">
		<input type="hidden" name="suppGoodsId" value="${suppGoods.suppGoodsId}">
		<input type="hidden" name="onlineFlag" value="${suppGoods.onlineFlag}"> 
		<input type="hidden" name="currencyType" value="${suppGoods.currencyType}"> 
		<input type="hidden" name="senisitiveFlag" value="N">
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>所属规格：</td>
                	<td colspan=2>
                	    <input type="hidden" name="productBranchId"" <#if suppGoods!=null && suppGoods.prodProductBranch!=null && suppGoods.productBranchId!=null> value="${suppGoods.productBranchId}" </#if>>
                		${branchName}
                	</td>
                </tr>
				<tr>
                	<td class="p_label"><i class="cc1">*</i>商品名称：</td>
                    <td colspan=2>
                    	<input type="text" style="width:260px" value="${suppGoods.goodsName}" disabled="disabled" class="sensitive_validate">
                    	<input type="hidden" name="goodsName" value="${suppGoods.goodsName}">
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
						<input type="text" name="contentManagerName" id="contentManagerName" value="${contentManagerName}" disabled="disabled">
                    	<input type="hidden" value="${suppGoods.contentManagerId}" name="contentManagerId" id="contentManagerId">
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>产品经理：</td>
					<td colspan=2>
						<input type="text" name="managerName" id="managerName" value="${suppGoods.managerName}" disabled="disabled">
                    	<input type="hidden" value="${suppGoods.managerId}" name="managerId" id="managerId" >
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>商品合同：</td>
					<td colspan=2 class=" operate mt10">
						<input type="text" readonly="readonly" name="suppContract.contractName" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractName}" </#if> disabled="disabled">
						<input type="hidden" id="contractIdUpdate" name="contractId" <#if suppGoods?? && suppGoods.suppContract?? && suppGoods.suppContract.contractName!="">value="${suppGoods.suppContract.contractId}" </#if>>
                   	</td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>支付对象：</td>
					<td colspan=2>
						<#if suppGoods.payTarget == null>
							<select name="payTarget" disabled="disabled">
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
						<select  disabled="disabled">
                    	 			<option value="">请选择</option>
		    				<#list filialeList as list>
			                    	<option value=${list.code!''} <#if suppGoods!=null && suppGoods.filiale==list.code>selected</#if> >${list.cnName!''}</option>
			                </#list>
			        	</select>
			        	<input type="hidden" value="${suppGoods.filiale!''}" name="filiale">
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否有效：</td>
					<td colspan=2>
						<select name="cancelFlag1" disabled="disabled">
	                    	<option value="Y" <#if suppGoods?? && suppGoods.cancelFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods?? && suppGoods.cancelFlag=='N'>selected</#if>>否</option>
	                    </select>
	                    <input type="hidden" name="cancelFlag" value="${suppGoods.cancelFlag}">
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否驴妈妈可售：</td>
					<td colspan=2>
						<select name="lvmamaFlag1" disabled="disabled" >
	                    	<option value="Y" <#if suppGoods?? && suppGoods.lvmamaFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods?? && suppGoods.lvmamaFlag=='N'>selected</#if>>否</option>
	                    </select>
	                    <input type="hidden" name="lvmamaFlag" value="${suppGoods.lvmamaFlag}">
                     </td>
                </tr> 
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否可分销：</td>
					<td colspan=2>
						<select name="distributeFlag" disabled="disabled" >
	                    	<option value="Y" <#if suppGoods?? && suppGoods.distributeFlag=='Y'>selected</#if>>是</option>
	                    	<option value="N" <#if suppGoods?? && suppGoods.distributeFlag=='N'>selected</#if>>否</option>
	                    </select>
                    </td>
                </tr>           
                <tr>
					<td class="e_label"><i class="cc1">*</i>结算币种：</td>
					<td colspan=2>
						<select name="currencyType" class="w10" disabled="disabled">
						<#list currencyTypeList as list>
		                      <option value=${list.code!''} <#if suppGoods!=null && suppGoods.currencyType==list.code>selected</#if>>${list.cnName!''}</option>
                        </#list>
						</select>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>是否使用传真：</td>
					<td colspan=2>
						<input type="radio" name="faxFlag1" value="Y" <#if suppGoods?? && suppGoods.faxFlag=='Y' >checked</#if>>是&nbsp;&nbsp;<span class="cc3">订单生成直接发送使用</span><br/>
						<input type="radio" name="faxFlag1" value="N" <#if suppGoods?? && suppGoods.faxFlag=='N' >checked</#if>>否&nbsp;&nbsp;<span class="cc3">若EBK等失效的时候备用，请选择传真</span><br/>	
	                	<label title="传真号码：<#if suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.fax!''}；</#if> 发送时间：<#if suppGoods.suppFaxRule??>${suppGoods.suppFaxRule.sendTime!''}</#if>" name="suppFaxRule.faxRuleName"><#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleName!="">${suppGoods.suppFaxRule.faxRuleName!''}</#if></label>
						<input type="hidden" id="faxRuleId" name="faxRuleId" <#if suppGoods?? && suppGoods.suppFaxRule?? && suppGoods.suppFaxRule.faxRuleId!="">value="${suppGoods.suppFaxRule.faxRuleId!''}"</#if>> 
						</br>
						<input type="hidden" name="faxFlag" value="${suppGoods.faxFlag}">
	                    <span class="cc3">若不使用传真，且不是二维码，则商品创建后，需要去ebk里面将商品添加到对应的供应商账户下。</span>
                    </td>
                </tr>
                 <tr>
					<td class="p_label"><i class="cc1">*</i>最少起订份数/间数：</td>
					<td colspan=2>
						<input type="text" id="minQuantity" name="minQuantity"  required=true value="${suppGoods.minQuantity}" digits=true>
                    </td>
                </tr>
                <tr>
					<td class="p_label"><i class="cc1">*</i>最多订购份数/间数：</td>
					<td colspan=2>
						<input type="text" id="maxQuantity" name="maxQuantity"  required=true value="${suppGoods.maxQuantity}" digits=true>
                    </td>
                </tr>
                <tr>
					<td rowspan="3" class="p_label" ><i class="cc1">*</i>商品类型：</td>
				 </tr>
				<#if goodsTypeList??>	
				 <input type="hidden" id="goodsType" name="goodsType" <#if suppGoods.goodsType!=null>value="${suppGoods.goodsType}"<#else>value="NOTICETYPE_DISPLAY"</#if>>
					<#list goodsTypeList as goodsType>
						<#if goodsType=="EXPRESSTYPE_DISPLAY">
						<tr>
								<td>
									<input type="radio" name="goodsType1" value="${goodsType.code}" <#if goodsType.code==suppGoods.goodsType>checked=checked</#if> required>${goodsType.cnName}
									</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>寄件方</label>
									<select id="expressType1" name="expressType1" <#if suppGoods.prodProductBranch.bizBranch.branchCode!='addition'>disabled="disabled"</#if> >
									<#list expressTypeList as expressType>
										<option value="${expressType.code}" <#if expressType.code==suppGoods.expressType>selected="selected"</#if> >${expressType.cnName}</option>
									</#list>
									</select>
									<input type="hidden" id="expressType" name="expressType" value="${suppGoods.expressType}">
								</td>
						 </tr>
						</#if>
						<#if goodsType=="NOTICETYPE_DISPLAY">
						<tr>
								<td>
									<input type="radio" name="goodsType1" value="${goodsType.code}" <#if suppGoods.goodsType==null || goodsType.code==suppGoods.goodsType>checked=checked</#if> required>${goodsType.cnName}
									</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>通知方式  </label>
									<select id="noticeType1" name="noticeType1" <#if suppGoods.prodProductBranch.bizBranch.branchCode!='addition'>disabled="disabled"</#if> >
									<#list noticeTypeList as noticeType>
										<option value="${noticeType.code}" <#if suppGoods.noticeType==null && noticeType.code=='SMS' || noticeType.code==suppGoods.noticeType>selected="selected"</#if> >${noticeType.cnName}</option>
									</#list>
									</select>
									<input type="hidden" id="noticeType" name="noticeType" <#if suppGoods.noticeType !=null>value="${suppGoods.noticeType}"<#else>value="SMS"</#if> >
								</td>
						</tr>
						</#if>
					</#list>	
				</#if>  
				<tr>
					<td rowspan="3" class="p_label" ><i class="cc1">*</i>商品价格类型：</td>
				 </tr>
				<#if priceTypeList??>	
				<input type="hidden" id="priceType" name="priceType" value="">
					<#list priceTypeList as priceType>
						<#if priceType=="SINGLE_PRICE">
						<tr>
								<td>
									<input type="radio"  name="priceType1"  <#if suppGoods??&&suppGoods.productId!=null>disabled=disabled</#if>   value="${priceType.code}" <#if  (suppGoods.priceType ==null && (suppGoods.prodProductBranch.bizBranch.branchCode == 'changed_hotel' || suppGoods.prodProductBranch.bizBranch.branchCode == 'addition' || suppGoods.prodProductBranch.bizBranch.branchCode == 'combo_dinner')) || priceType.code==suppGoods.priceType>checked=checked</#if> required>${priceType.cnName}
									</br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>成人数</label>
									<select name="adult" value = "${suppGoods.adult}" <#if suppGoods??&&suppGoods.productId!=null&&categoryId==12>disabled=disabled</#if>>
									<#list 0..100 as i>
		                            <option value="${i}" <#if i==suppGoods.adult>selected="selected"</#if>>${i}</option>
                                    </#list>
									</select>
									<label>儿童数</label>
									<select name="child" value = "${suppGoods.child}" <#if suppGoods??&&suppGoods.productId!=null&&categoryId==12>disabled=disabled</#if>>
									<#list 0..100 as j>
		                            <option value="${j}" <#if j==suppGoods.child>selected="selected"</#if>>${j}</option>
                                    </#list>
									</select>
								</td>
						 </tr>
						</#if>
						<#if priceType=="MULTIPLE_PRICE">
						<tr>
								<td>
									<input type="radio" name="priceType1" value="${priceType.code}" <#if suppGoods??&&suppGoods.productId!=null>disabled=disabled</#if> <#if (suppGoods.priceType ==null && (suppGoods.prodProductBranch.bizBranch.branchCode == 'adult_child_diff'|| suppGoods.prodProductBranch.bizBranch.branchCode == 'upgrad')) || priceType.code==suppGoods.priceType>checked=checked</#if> required>${priceType.cnName}
								</td>
						</tr>
						</#if>
					</#list>	
				</#if>                  
            </tbody>
        </table>
</form>
<div class="fl operate"><a class="btn btn_cc1" id="update_goods_button">保存</a></div>
<#include "/base/foot.ftl"/>
</body>
</html>
<script>

var branchCode = '${suppGoods.prodProductBranch.bizBranch.branchCode}';		
if('${suppGoods.minQuantity}'==''){
   if(branchCode != 'addition'){
       $("#minQuantity").val(1);
   }else{
       $("#minQuantity").val(0);
   }
}
if('${suppGoods.maxQuantity}'==''){
   $("#maxQuantity").val(10);
}	
	
$("input[type='radio'][name='faxFlag1']").each(function(){
            $(this).attr("disabled",true);
});		
$("input[type='radio'][name='goodsType1']").each(function(){
         if(branchCode != 'addition'){
            $(this).attr("disabled",true);
         }
});	


$("input[type='radio'][name='goodsType1']").click(function(){
           $("#goodsType").val($(this).val());
});	

$("input[type='radio'][name='priceType1']").each(function(){
         if($(this).attr("checked")=="checked"){
            $("#priceType").val($(this).val());
         }
         if(branchCode == 'combo_dinner'){
            $(this).attr("disabled",true);
         }
});	

$("input[type='radio'][name='priceType1']").click(function(){
           $("#priceType").val($(this).val());
});	

$("#expressType1").change(function(){
           $("#expressType").val($(this).val()); 
});
$("#noticeType1").change(function(){
           $("#noticeType").val($(this).val()); 
});
	

$("#update_goods_button").click(function(){
    var min = parseInt($("#minQuantity").val());
    var max = parseInt($("#maxQuantity").val());
    if(min>max){
      alert("最少起订 不能大于 最多起订");
      return false;
    };
    //验证
	if(!$("#goodsDataForm").validate().form()){
		return false;
	}
	 var msg = '确认保存吗 ？';	
	  if(refreshSensitiveWord($("input[type='text'],textarea"))){
	 	 $("input[name=senisitiveFlag]").val("Y");
	 	 msg = '内容含有敏感词,是否继续?';
	  }else {
	  	 $("input[name=senisitiveFlag]").val("N");
	  }

	$.confirm(msg,function(){
		$.ajax({
			url : '/vst_back/tour/goods/goods/updateSuppGoods.do',
			type : 'POST',
			data : $("#goodsDataForm").serialize(),
			success : function(message){
				if(message.code == 'success'){
					$.alert("更新成功");
					parent.reload();
				}
			}
		});
	});
	
});
refreshSensitiveWord($("input[type='text'],textarea"));

</script>
