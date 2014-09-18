
<div class="iframe_search">
<form action="#"  id="updateSupplierContractForm">
	 <input type="hidden" name="settleRuleId" id="settleRuleId" value="${suppSettleRule.settleRuleId}">
	 <input type="hidden" name="supplierId" id="supplierId" value="${suppSupplier.supplierId}">
	 <input type="hidden" name="fatherId" id="fatherId" value="${suppSupplier.fatherId}">
	 <input type="hidden" name="districtId" id="districtId" value="${suppSupplier.districtId}">
	 <input type="hidden" name="contractId" id="contractId" value="${suppContract.contractId}">
	<input type="hidden" name="contractStatus" id="contractStatus" value="${contractStatus}">
	<input type="hidden" name="gotoContractStatus" id="gotoContractStatus" value="${gotoContractStatus}">
	
	<span>供应商信息：</span>
	     <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label" style="width:120px;">供应商名称1：</td>
                <td style="width:270px;">
                	<input type="text" id="supplierName" name="supplierName" value="${suppSupplier.supplierName}" readonly="readonly">
                </td>
                <td class="p_label" style="width:120px;" >供应商类型：</td>
                <td> ${suppSupplier.supplierTypeCN}<input type="hidden" id="supplierType" name="supplierType"  value="${suppSupplier.supplierType}"readonly="readonly"></td>
            </tr> 
			<tr>
				<td class="p_label">所在地区：</td>
                <td> <input type="text" id="supplierDistrict"  name="supplierDistrict"  value=" ${suppSupplier.supplierDistrict}" readonly="readonly"></td>
                <td class="p_label">地址：</td>
             	<td> <input type="text" id="address"  name="address" value="${suppSupplier.address}" readonly="readonly"></td>
            </tr>
            <tr>
                <td class="p_label">电话：</td>
                <td> <input type="text" id="tel"  name="tel" value="${suppSupplier.tel}" readonly="readonly"></td>
                <td class="p_label">传真：</td>
             	<td> <input type="text" id="fax"  name="fax" value="${suppSupplier.fax}" readonly="readonly"></td>
            </tr>
            <tr>
                <td class="p_label">网址：</td>
                <td> <input type="text" id="site"  name="site" value="${suppSupplier.site}" readonly="readonly"></td>
                <td class="p_label">邮编：</td>
             	<td> <input type="text" id="zip"  name="zip" value="${suppSupplier.zip}" readonly="readonly"></td>
            </tr>
            <tr>
                <td class="p_label">法定代表人：</td>
                <td> <input type="text" id="legalRep" name="legalRep"  value="${suppSupplier.legalRep}" readonly="readonly"></td>
                <td class="p_label">旅行社许可证：</td>
                <td> <input type="text" id="permit" name="permit"  value="${suppSupplier.permit}" readonly="readonly"></td>
            </tr>
            <tr>
                <td class="p_label">是否系统对接：</td>
                <td>
                	<input type="radio" name="apiFlag" value="Y" readonly="readonly" <#if suppSupplier.apiFlag == "Y">checked="checked"</#if>
						 >是&nbsp;&nbsp;&nbsp;<input type="radio" name="apiFlag" value="N" readonly="readonly" 
						 <#if suppSupplier.apiFlag == "N">checked="checked"</#if> >否
               </td>
               <td class="p_label">父供应商：</td>
               <td> <input type="text" id="fatherSupplier" name="fatherSupplier" value="${suppSupplier.fatherSupplier}" readonly="readonly"></td>
            </tr>
        </tbody>
        </table>
      
	  <span>合同基本信息:</span>
    	<table class="p_table form-inline">
            <tbody>
                <tr>
					<td class="p_label" style="width:120px;"><i class="cc1">*</i>名称：</td>
					<td style="width:270px;"><input type="text" id="contractName" name="contractName"  value="${suppContract.contractName}" required=true></td>
                    <td class="p_label" style="width:120px;"><i class="cc1">*</i>合同编号：</td>
                    <td>
                    	<input type="hidden" name="contractNo" id="contractNo" >
                    	<#list suppContract.splitContractNo as contractNoStr>
	                    	<input type="text" id="contractNo${contractNoStr_index}" name="contractNo${contractNoStr_index}" value="${contractNoStr}" errorEle="contract" required=true style="width:35px;">
                    	</#list>
                    	<div id="contractError"></div>
                    </td>
                </tr> 
				<tr>
					<td class="p_label"><i class="cc1">*</i>合同类型：</td>
                     <td>
                  		<select name="contractType" required=true>
	                    	<#list contractTypeList as contractType>
	                    		<option <#if contractType.code==suppContract.contractType>selected=selected</#if>
	                    		 	 value="${contractType.code!''}">${contractType.cnName!''}</option>
	                        </#list>
                    	</select>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>有效期：</td>
                    <td>
                   		<input style="width:83px" type="text" name="startTime" errorEle="validityDate" value="${suppContract.startTime?string("yyyy-MM-dd")}" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'d4322\',{d:1});}'})" required=true>&nbsp;-&nbsp;
                  		<input style="width:83px"  type="text" name="endTime" errorEle="validityDate" value="${suppContract.endTime?string("yyyy-MM-dd")}" class="Wdate" id="d4322" onFocus="WdatePicker({startDate:'#F{$dp.$D(\'d4321\',{y:1});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:1});}'})" required=true>
                    	<div id="validityDateError"></div> 	
					</td>
                </tr>
                <tr>
                    <td class="p_label"><i class="cc1">*</i>签署日期：</td>
                    <td>
                    	<input type="text" name="signTime" class="Wdate" id="d4320" value="${suppContract.signTime?string("yyyy-MM-dd")}" onFocus="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" required=true>
                    	<div id="signTimeError"></div>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>经办人：</td>
                    <td>
                   		<input type="text" name="operatorName" id="operatorName" value="${operatorUser}" required=true>
                    	<input type="hidden" value="${suppContract.operator}" name="operator" id="operator" />
                    	<div id="operatorError"></div>
                    </td>
                </tr>
                <tr>
                    <td class="p_label"><i class="cc1">*</i>产品经理：</td>
                    <td>                 
                    	<input type="text" name="managerName" id="managerName" value="${managerName}" required=true>
                	    <input type="hidden" value="${managerId}" name="managerId" id="managerId" required=true>
                    	<div id="managerIdError"></div>
                    </td>
                    <td class="p_label"><i class="cc1">*</i>会计主体：</td>
					<td>
                    	<select name="accSubject" required=true>
	                    	<#list accSubjectList as accSubject>
	                    		<option <#if accSubject.code==suppContract.accSubject>selected=selected</#if>
	                    		  	value="${accSubject.code!''}">${accSubject.accName!''}</option>
	                        </#list> 
                        </select>              
                   		<div id="accSubjectError"></div>
                    </td>
                </tr>
                <tr>
                 <td class="p_label" > 合同附件：</td>
	                 <td colspan="3">
	                    <#list suppContractAttachList as suppContractAttach> 
	                   		<a href="/vst_back/pet/ajax/file/downLoad.do?fileId=${suppContractAttach.attachment}">${suppContractAttach.fileName}附件下载 &nbsp;&nbsp;</a>
	                    </#list>
                    </td>
                </tr>
            </tbody>
        </table>
        
     <span>变更及补充单</span>
       <table class="p_table form-inline">
            <thead>
            	<th>类型</th>
            	<th>变更内容说明</th>
            	<th>录入时间</th>
            	<th>变更副本</th>
           </thead> 
            <tbody>
            <#list suppContractChangeList as suppContractChange> 
	             <tr>
	             	 <td class="p_label" style="width:120px;">${suppContractChange.changeTypeCN}</td>
		           	 <td style="width:270px;">${suppContractChange.changeDesc}</td>	
		           	 <#if suppContractChange??&&suppContractChange.createTime??><td>${suppContractChange.createTime?string("yyyy-MM-dd")}</td>
		           	 <#else><td></td>
		         	 </#if>
		           	 <td>
		           	 	<#if suppContractChange.attachment??><a href="/vst_back/pet/ajax/file/downLoad.do?fileId=${suppContractChange.attachment}">下载变更附件 </a>
		           	 	</#if>
		           	 </td>	
	             </tr>
            </#list>
            </tbody>
        </table>
      
      <span> 结算</span>
    	<table class="p_table form-inline">
        <tbody id="settleTable">   
        	<#if gotoContractStatus == "UPDATE_UNVER">
	        	<tr>	
	             	<td class="p_label" style="width:120px;"></td>
	                <td>
	                	<input type="button" id="settleUpdateButton" class="pbtn pbtn-small btn-ok" value="修改" data="disabled">
	                </td>				
	                <td class="p_label" style="width:120px;"></td>
	                <td style="width:270px;">
	                </td>
	            </tr> 
            </#if>
            
            <tr>	
             	<td class="p_label" style="width:120px;"><i class="cc1">*</i>结算方名称：</td>
                <td>
                	<input type="text" name="settleName" value="${suppSettleRule.settleName}" required=true>
                </td>				
                <td class="p_label" style="width:120px;"><i class="cc1">*</i>开户名称：</td>
                <td style="width:270px;">
                	<input type="text" name="accountName" value="${suppSettleRule.accountName}" required=true>
                </td>
            </tr> 
            <tr>	
            	 <td class="p_label" style="width:120px;"><i class="cc1">*</i>开户银行：</td>
                <td>
                	<input type="text" name="accountBank" value="${suppSettleRule.accountBank}" required=true>
                </td>				
                <td class="p_label"><i class="cc1">*</i>开户账户：</td>
                <td>
               		<input type="text" name="accountNo"  value="${suppSettleRule.accountNo}" required=true>
                </td>         
            </tr> 
			 <tr>					
                <td class="p_label">支付宝账号：</td>
                <td>
                    <input type="text" name="alipayNo" value="${suppSettleRule.alipayNo}">
                 </td>
                <td class="p_label">支付宝用户名：</td>
                <td>
                	<input type="text" name="alipayName" value="${suppSettleRule.alipayName}">
                </td>
            </tr> 
             <tr>					
                 <td class="p_label"><i class="cc1">*</i>我方结算主体：</td>                    
                 <td>  
                      <select name="lvAccSubject" required=true>
	                    	<#list lvAccSubjectList as lvAccSubject>
	                    		<option <#if lvAccSubject.code==suppSettleRule.lvAccSubject>selected=selected</#if>
	                    		   value="${lvAccSubject.code!''}">${lvAccSubject.subName!''}</option>	                    			
	                        </#list>
                   	   </select>     
               	</td>
               	<td class="p_label"></td><td> </td>	   
            </tr> 
            <tr>					
                <td class="p_label"><i class="cc1">*</i>结算周期：</td>                       
                <td>
	                   <input type="radio" name="settlementPeriod" id="settlementPeriod" value="PERORDER" <#if  suppSettleRule.settlementPeriod=="PERORDER" >checked="checked"</#if> required=true errorEle="Cycle" > 单结提前
	                   <input type="text" <#if  suppSettleRule.settlementPeriod!="PERORDER" > readOnly=true  </#if> number=true style="width:15px;" id="settleCycle" name="settleCycle" value="${suppSettleRule.settleCycle!''}" errorEle="Cycle" > 天 &nbsp;
	                   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PER_WEEK" <#if  suppSettleRule.settlementPeriod=="PER_WEEK" >checked="checked"</#if> required=true errorEle="Cycle">周结 &nbsp;
	                   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PERMONTH" <#if suppSettleRule.settlementPeriod=="PERMONTH">checked="checked"</#if> required=true errorEle="Cycle">月结 &nbsp;
		               <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PERQUARTER" <#if suppSettleRule.settlementPeriod=="PERQUARTER">checked="checked"</#if> required=true errorEle="Cycle">季结  &nbsp;
		        	   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PER_HALF_MONTH" <#if suppSettleRule.settlementPeriod=="PER_HALF_MONTH">checked="checked"</#if> required=true errorEle="Cycle">半月结 &nbsp;
                       <div  id="CycleError"></div>
                </td>   
                <td class="p_label"></td><td> </td>               
            </tr> 
            
            <tr>					
                <td class="p_label"><i class="cc1">*</i>结算方式：</td>  
                 <td> 
                 	<input type="radio" name="settleType" required=true errorEle="settleType"  value="SETTLEMENT_PRICE" 
                 		<#if suppSettleRule.settleType=="SETTLEMENT_PRICE"> checked="checked"</#if> >按结算价&nbsp;
                 	<input type="radio" name="settleType" required=true errorEle="settleType"  value="REBATE"
                 		<#if suppSettleRule.settleType =="REBATE"> checked="checked"</#if>>返佣
                 	<div  id="settleTypeError" style="display:inline"></div>
                </td>
                <td class="p_label"></td><td> </td>
            </tr>  
                          
            <tr>
            	<td class="p_label">其它：</td>   
            </tr>
            
            <tr>
               <td class="p_label">类型：</td> 
               <td>
               		<input type="radio" name="ruleType" value="PERSON" <#if suppSettleRule.ruleType=="PERSON"> checked="checked" </#if>>个人 &nbsp;&nbsp;
                 	<input type="radio" name="ruleType" value="COMPANY"<#if suppSettleRule.ruleType =="COMPANY"> checked="checked" </#if>>公司
               </td>   
               <td class="p_label"></td><td> </td>
            </tr>                
            <tr>                   
               <td class="p_label">付款方式：</td>  
               <td>                   
                     <select name="payType">
                    	<#list payTypeList as payType>
                    	   <option <#if payType.code==suppSettleRule.payType>selected=selected</#if> value="${payType.code!''}">${payType.typeName!''}</option>
                        </#list>
                    </select>
                 </td> 
                 <td class="p_label"></td><td> </td>  
            </tr>
            <tr>                   
               <td class="p_label"> 联行号：</td>                     
                <td>
                  <input type="text" name="unionBankNo" value="${suppSettleRule.unionBankNo}">
                </td> 
                <td class="p_label"></td><td> </td>                
            </tr> 
            <tr>                   
               <td class="p_label"> 备注：</td>                     
                <td>
                    <input type="text" name="settleDesc" value="${suppSettleRule.settleDesc}">
                </td> 
                <td class="p_label"></td><td> </td>                
            </tr>
             <tr>                   
               <td class="p_label"> 财务联系人：</td>                     
                <td colspan="3">
                     <div class="suppliersContacList">
                     <#list contactlist as contact> 
                        <span><input type='hidden' name='pids' value='${contact.personId}'>姓名：${contact.name} &nbsp;性别：<#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if>&nbsp;电话：${contact.tel}&nbsp;
                        			<a href='javascript:delContact("${contact.personId}");' id='a_${contact.personId}' class='delContact'>删除</a></span><br>
                     </#list>
                     </div>
              		 <a href="javascript:void(0);" class="suppliersContac" id="suppliersContac" data=${suppSettleRule.supplierId}>添加财务联系人</a>             
                </td>
            </tr>               
        </tbody>
        </table>
</form>
</div><!-- //主要内容显示区域 -->

<script> 
vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
vst_pet_util.superUserSuggest("#operatorName", "input[name=operator]");
var updateContractDialog;
var selectSupplierDialog;
var selectContactDialog;
var contactids = [];

var gotoContractStatus = $("#gotoContractStatus").val();
if(gotoContractStatus == "UPDATE_UNVER"){
	$("#settleTable").find("input[type=text],select").attr("disabled","disabled");
	$("#settleTable").find("input[type=radio]").attr("disabled","disabled");
	$("#settleUpdateButton").attr("data","disabled");
}

 $("#settleUpdateButton").click(function() {
 	 var alertStr = "结算对象修改规则：<br>1、一个月中只有一种结算周期。（如果中途修改周期会出现如下情况：月结改成单结算，财务会在修改后的第一天将本月的所有的订单结算掉。单结算改成月结算，从下个月1号开始结算修改日之后的所有订单）";
		 alertStr = alertStr + "<br>2、修改结算本身的账号名单信息，月结产品仅仅可以在11-30号修改，每单结算可以在每天的5点后修改，但是修改后第二天的打款即刻为新账号";
		 alertStr = alertStr + "<br>3、提前打款规则为，按照游玩日期提前一个工作日打款。遇到节假日和周末以最近的工作日为依据。";
		 alertStr = alertStr + "<br>4、尽量系统以月结和单结算（提前打款）两种结算方式为主。 <br>---确定修改?";
 	 $.confirm(alertStr, function(){
	 	 $("#settleTable").find("input[type=text],select").removeAttr("disabled");
		 $("#settleTable").find("input[type=radio]").removeAttr("disabled");
		 $("#settleUpdateButton").attr("data","enabled");
 	 });
 }); 
 
//添加财务联系人
//$("a.suppliersContac").bind("click",function(){
	//var supplierId  = $(this).attr("data");
	//contactListDialog = new xDialog("/vst_back/supp/contact/findContactList.do",{"supplierId":supplierId},{title:"联系人列表",width:900});
//});

var shtml;
// 财务联系人选择后的回调函数
function onSelectContact(params) {

if (params != null) {
        $('.suppliersContacList').empty();
	    shtml = '';
	    for(var i =0; i<params.length; i++){
	    shtml +="<span><input type='hidden' name='pids' value='"+params[i].personId+"'>姓名："+params[i].pname+"&nbsp;性别："+params[i].sex+"&nbsp;电话："+params[i].tel+"&nbsp;"+"<a href= 'javascript:delContact(\""+params[i].personId+"\");' id='a_"+params[i].personId+"' class='delContact'>"+"删除</a></span><br>";
        }
        $('.suppliersContacList').html(shtml);
}
	// 关闭财务联系人列表
	selectContactDialog.close();
}

function delContact(v)
{  
	var settleUpdateButtonVal = $("#settleUpdateButton").attr("data");
	if(settleUpdateButtonVal == "enabled"){
	    var obj = $('#a_'+v).parent("span");
	    obj.remove();     
	}
 } 
 
$("a.suppliersContac").click(function() {
	var settleUpdateButtonVal = $("#settleUpdateButton").attr("data");
	if(settleUpdateButtonVal == "enabled"){
	   var supplierId  = $(this).attr("data");
	   var pids = $("*[name='pids']").map(function(){return $(this).val()}).get().join(",");
	   //vst_back/supp/contact/suppliersContac.do?callback=onSelectContact&supplierId="+supplierId
		selectContactDialog = new xDialog("/vst_back/supp/contact/suppliersContac.do", {"supplierId":supplierId,"pids":pids}, {
			title : "选择财务联系人",
			//iframe : true,
			scrolling:"yes",
			width : "1000"
		});
	}
});  
  
  
// 供应商选择后的回调函数
function onSelectSupplier(params) {
	if (params != null) {
		$("#supplierName").val(params.supplierName);
		$("#supplierId").val(params.supplierId);
		$("#supplierDistrict").val(params.supplierDistrict);
		$("#address").val(params.address);
		$("#tel").val(params.tel);
		$("#fax").val(params.fax);
		$("#site").val(params.site);
		$("#zip").val(params.zip);
		$("#legalRep").val(params.legalRep);
		$("#permit").val(params.permit);
		$("#fatherSupplier").val(params.fatherSupplier);
		$("#supplierid").val(params.supplierid);
		$("#supplierType").val(params.supplierType);
		if (params.apiFlag == "Y") {
			$("#apiFlag").val("是");
		} else {
			$("#apiFlag").val("否");
		}
	}
	// 关闭供应商列表
	selectSupplierDialog.close();
}

$("#closeButton").bind("click", function() {
 	//updateContractDialog.close();
 	dialog.close();
 	//$(".dialog").close();
});

function disabledCycle() {
	$("input[name='settleCycle']").removeAttr("required");
	$("input[name='settleCycle']").attr("readonly", "readonly");
	$("#CycleError").html("");
	$("input[name='settleCycle']").val(null);
}

//结算周期选择 settleCycle = 0
$("input[name='settlementPeriod']").eq(0).click(function(){
    if($(this).attr("checked")=="checked"){
        $("input[name='settleCycle']").attr("required", true);
		$("input[name='settleCycle']").removeAttr("readonly");
     }
})
 
//结算周期选择 settleCycle = 1
$("input[name='settlementPeriod']").eq(1).click(function(){
    if($(this).attr("checked")=="checked"){   
        disabledCycle();
	}
})

//结算周期选择 settleCycle = 2
$("input[name='settlementPeriod']").eq(2).click(function(){
   if($(this).attr("checked")=="checked"){
        disabledCycle();
    }
})
 
//结算周期选择 settleCycle = 3
$("input[name='settlementPeriod']").eq(3).click(function(){
    if($(this).attr("checked")=="checked"){
       disabledCycle();
    }
})

//结算周期选择 settleCycle = 4
$("input[name='settlementPeriod']").eq(4).click(function(){
    if($(this).attr("checked")=="checked"){
        disabledCycle();
	 }
})

</script>