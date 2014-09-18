<form action="#" method="post" id="contractAddForm">
	<input type="hidden" name="supplierId" id="supplierId">
	
	<span>供应商信息：</span>
    <span class="operate mt10"><a class="btn btn_cc1" id="selectSupplierButton">选择供应商</a></span>
	<table class="p_table form-inline">
    <tbody>
       <tr>
			<td class="p_label" style="width:120px;"><i class="cc1">*</i>供应商名称：</td>
            <td style="width:270px;">
            	<input type="text" id="supplierName" name="supplierName" readonly="readonly">
            </td>
            <td class="p_label" style="width:120px;">供应商类型：</td>
            <td>
            	<input type="text" id="supplierType" readonly="readonly">
            </td>
        </tr> 
		<tr>
			<td class="p_label">所在省/市：</td>
            <td>
            	<input type="text" id="supplierDistrict" readonly="readonly">
            </td>
            <td class="p_label">地址：</td>
            <td>
            	<input type="text" id="address" readonly="readonly">
            </td>
        </tr>
        <tr>
            <td class="p_label">电话：</td>
            <td>
            	<input type="text" id="tel" readonly="readonly">
            </td>
            <td class="p_label">传真：</td>
            <td>
            	<input type="text" id="fax" readonly="readonly">
            </td>
        </tr>
        <tr>
            <td class="p_label">网址：</td>
            <td>
            	<input type="text" id="site" readonly="readonly">
            </td>
            <td class="p_label">邮编：</td>
            <td>
            	<input type="text" id="zip" readonly="readonly">
            </td>
        </tr>
        <tr>
            <td class="p_label">法定代表人：</td>
            <td>
            	<input type="text" id="legalRep" readonly="readonly">
            </td>
            <td class="p_label">旅行社许可证：</td>
            <td>
            	<input type="text" id="permit" readonly="readonly">
            </td>
        </tr>
        <tr>
            <td class="p_label">是否系统对接：</td>
            <td>
            	<input type="text" id="apiFlag" readonly="readonly">
            </td>
            <td class="p_label">父供应商：</td>
            <td>
            	<input type="text" id="fatherSupplier" readonly="readonly">
            </td>
        </tr> 
    </tbody>
    </table>
        
    <span>合同基本信息：</span>
    	<table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label" style="width:120px;">名称：</td>
                <td style="width:270px;">自动生成</td>
                <td class="p_label" style="width:120px;"><i class="cc1">*</i>合同编号：</td>
                <td>
                	<input type="hidden" name="contractNo" id="contractNo" >
                	<input type="text" id="contractNo0" name="contractNo0" errorEle="contract" required=true style="width:40px;">-
                	<input type="text" id="contractNo1" name="contractNo1" errorEle="contract" required=true style="width:40px;">-
                	<input type="text" id="contractNo2" name="contractNo2" errorEle="contract" required=true style="width:40px;">-
                	<input type="text" id="contractNo3" name="contractNo3" errorEle="contract" required=true style="width:40px;">
                	<div id="contractError"></div>
                </td>
            </tr> 
			<tr>
				<td class="p_label"><i class="cc1">*</i>合同类型：</td>
                <td>
                <select name="contractType" required=true>
                	<#list contractTypeList as contractType>
                		<option value="${contractType.code!''}">${contractType.cnName!''}</option>
                    </#list>
                </select>
                </td>
                <td class="p_label"><i class="cc1">*</i>有效期：</td>
                <td>
                	<input style="width:83px;" type="text" name="startTime" errorEle="validityDate" class="Wdate" id="d4321" onFocus="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'d4322\',{d:1});}'})" required=true>&nbsp;-&nbsp;
                	<input style="width:83px;" type="text" name="endTime"  errorEle="validityDate" class="Wdate" id="d4322" onFocus="WdatePicker({startDate:'#F{$dp.$D(\'d4321\',{y:1});}',readOnly:true,minDate:'#F{$dp.$D(\'d4321\',{d:1});}'})" required=true>
               		<div id="validityDateError" style="display:inline"></div>
				</td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>签署日期：</td>
                <td>
                	<input type="text" name="signTime" class="Wdate" id="d4320" onFocus="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'d4321\',{d:0});}'})" required=true>
                	<div id="signTimeError"></div>
                </td>
                <td class="p_label"><i class="cc1">*</i>经办人：</td>
                <td>
                	<input type="text" name="operatorName" id="operatorName" required=true>
                	<input type="hidden" value="${operator}" name="operator" id="operator" required=true>
                	<div id="operatorError"></div>
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>产品经理：</td>
                <td>
                	<input type="text" name="managerName" id="managerName" required=true>
                	<input type="hidden" value="${managerId}" name="managerId" id="managerId" required=true>
                	<div id="managerIdError"></div>
                </td>
                <td class="p_label"><i class="cc1">*</i>会计主体：</td>
                <td>
                <select name="accSubject" required=true>
                	<#list accSubjectList as accSubject>
                		<option value="${accSubject.code!''}">${accSubject.accName!''}</option>
                    </#list>               
               		<div id="accSubjectError"></div>
                </td>
            </tr> 
        </tbody>
        </table>
        
   <span> 结算：</span>
    	<table class="p_table form-inline">
        <tbody>   
             <input type="hidden" name="supplierId" id="supplierId">
            <tr>	
             <td class="p_label"><i class="cc1">*</i>结算方名称：</td>
                <td>
                	<input type="text" name="settleName" required=true>
                </td>   				
                <td class="p_label" style="width:120px;"><i class="cc1">*</i>开户名称：</td>
                <td style="width:270px;">
                	<input type="text" name="accountName" required=true>
                </td>
            </tr> 
            <tr>					
                <td class="p_label"><i class="cc1">*</i>开户账户：</td>
                <td>
                	<input type="text" name="accountNo" required=true>
                </td>   
                <td class="p_label" style="width:120px;"><i class="cc1">*</i>开户银行：</td>
                <td>
                	<input type="text" name="accountBank" required=true>
                </td>
                              
            </tr> 
			 <tr>					
                <td class="p_label">支付宝账号：</td>
                <td>
                	<input type="text" name="alipayNo">
                </td>
                <td class="p_label">支付宝用户名：</td>
                <td>
                	<input type="text" name="alipayName">
                </td>
            </tr> 
             <tr>					
                <td class="p_label"><i class="cc1">*</i>我方结算主体：</td>                    
                <td colspan="3">  
                   <select name="lvAccSubject" required=true>
                    	<#list lvAccSubjectList as lvAccSubject>
                    		<option value="${lvAccSubject.code!''}">${lvAccSubject.subName!''}</option>
                        </#list>
                    </select>     
               	</td>	 
                    
            </tr> 
            <tr>					
                <td class="p_label"><i class="cc1">*</i>结算周期：</td>    
                <td colspan="3">
                     <input type="radio" name="settlementPeriod" id="settlementPeriod" value="PERORDER"  required=true errorEle="Cycle" > 单结提前
	                   <input type="text" readOnly=true number=true style="width:15px;" id="settleCycle" name="settleCycle"  errorEle="Cycle" > 天 &nbsp;
	                   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PER_WEEK"  required=true errorEle="Cycle">周结 &nbsp;
	                   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PERMONTH"  required=true errorEle="Cycle">月结 &nbsp;
		               <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PERQUARTER"  required=true errorEle="Cycle">季结  &nbsp;
		        	   <input type="radio" id="settlementPeriod" name="settlementPeriod" value="PER_HALF_MONTH" required=true errorEle="Cycle">半月结 &nbsp;
         
                	<div  id="CycleError"></div>
                 </td>
                 
           </tr> 
           <tr>					
                <td class="p_label"><i class="cc1">*</i>结算方式：</td> 
                <td colspan="3"> 
                    <input type="radio" name="settleType" required=true errorEle="settleType"  value="SETTLEMENT_PRICE">按结算价  &nbsp&nbsp 
                    <input type="radio" name="settleType" required=true errorEle="settleType"  check="checked" value="REBATE">返佣   
                    <div  id="settleTypeError" style="display:inline"></div>
                </td> 
                
            </tr> 
            
            <tr>	
            	<td class="p_label"> 其它：</td>   
            </tr>
            <tr>
                  <td class="p_label">类型：</td>    
                  <td>
                        <input type="radio" name="ruleType" value="PERSON">个人 &nbsp&nbsp 
                    	<input type="radio" name="ruleType" value="COMPANY">公司
                   </td> 
                   <td class="p_label"></td><td> </td>
             </tr>                
             <tr>                   
                 <td class="p_label">付款方式：</td>                     
                <td>
                    <select name="payType">
                    	<#list payTypeList as payType>
                    		<option value="${payType.code!''}">${payType.typeName!''}</option>
                        </#list>
                    </select>
                </td>  
                <td class="p_label"></td><td> </td>               
            </tr>
            <tr>                   
               <td class="p_label"> 联行号：</td>                     
               <td>
                    <input type="text" name="unionBankNo" >
               </td> 
               <td class="p_label"></td><td> </td>                
            </tr>
            <tr>                   
               <td class="p_label"> 备注：</td>                     
                <td>
                    <input type="text" name="settleDesc">
                </td> 
                <td class="p_label"></td><td> </td>               
            </tr>
            
             <tr>                   
               <td class="p_label"> 财务联系人：</td>                     
                <td colspan="3">
                     <div class="suppliersContacList">
                     <#list contactlist as contact> 
                        <span><input type='hidden' name='pids' value='${contact.personId}'>姓名：${contact.name} &nbsp;性别：<#if contact.sex == "MAN">先生<#elseif contact.sex=="WOMAN">女士 <#else></#if>&nbsp;电话：${contact.tel}&nbsp;<a href= 'javascript:delContact("${contact.personId}");' id='a_${contact.personId}' class='delContact'>删除</a></span><br>
                     </#list>
                     </div>
              		 <a href="javascript:void(0);" id="suppliersContac" class="suppliersContac" <#if suppSettleRule??> data=${suppSettleRule.supplierId!''}  </#if>>添加财务联系人</a>             
                </td>
            </tr>   
        </tbody>
    </table>
</form>
<button class="pbtn pbtn-small btn-ok"  style="float:right;margin-top:20px;" id="saveContractButton">保存</button>

<script> 
vst_pet_util.superUserSuggest("#managerName", "input[name=managerId]");
vst_pet_util.superUserSuggest("#operatorName", "input[name=operator]");
var selectSupplierDialog;
var selectContactDialog;
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
       var obj = $('#a_'+v).parent("span");
       obj.remove();     

 } 
 
$("a.suppliersContac").click(function() {
	if ($("#supplierId").val() == "") {
			$.alert("请先选择供应商");
			return false;
		}
   var supplierId  = $("#supplierId").val();
   var pids = $("*[name='pids']").map(function(){return $(this).val()}).get().join(",");
   //vst_back/supp/contact/suppliersContac.do?callback=onSelectContact&supplierId="+supplierId
	selectContactDialog = new xDialog("/vst_back/supp/contact/suppliersContac.do", {"supplierId":supplierId,"pids":pids}, {
		title : "选择财务联系人",
		//iframe : true,
		scrolling:"yes",
		width : "1000"
	});
});  

$("input[name='settleCycle']").eq(0).click(function(){
    if($(this).attr("checked")=="checked"){
        $("input[name='Cycle']").attr("required", true);
		$("input[name='Cycle']").removeAttr("readonly");
		$("input[name='Cycle']").removeAttr("disabled");
    }
})
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
		$("input[name='settleCycle']").removeAttr("disabled");
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

//  新增合同	
$("#saveContractButton").bind("click",function(){
		if ($("#supplierId").val() == "") {
			$.alert("请先选择供应商");
			return false;
		}
		if ($("#contractNo0").val() != "" && $("#contractNo1").val() != "" && $("#contractNo2").val() != "" && $("#contractNo3").val() != "") {
			var contractNo = $("#contractNo0").val() + "-" + $("#contractNo1").val() + "-" + $("#contractNo2").val() + "-" + $("#contractNo3").val()
			$("#contractNo").val(contractNo);
		}
		// 验证FORM
		if (!$("#contractAddForm").validate({}).form()) {
			return false;
		}
		if ($("#operator").val() == "" || $("#managerId").val() == "") {
			$.alert("产品经理和经办人必须从下拉数据中选择.");
			return false;
		}
	$("#saveContractButton").attr("disabled","disabled");	
	$.confirm("确认提交 ？", function () {	
	$.ajax({
	  url : "/vst_back/supp/suppContract/addSupplierContract.do",
		data : $(".dialog #contractAddForm").serialize(),
		type : "POST",
	   dataType:"JSON",
	   success : function(result){	 
	   		if(result.code=="success"){	
			   		$.alert("提交成功",function(){
			   			$("#searchForm").submit();
			   		});
			   	}
	   	}
	});	
	},function(){
		$("#saveContractButton").removeAttr("disabled");	
	});					
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

// 打开选择供应商列表
$("#selectSupplierButton").click(function() {
	selectSupplierDialog = new xDialog("/vst_back/supp/supplier/selectSupplierList.do", {}, {
	//vst_back/supp/supplier/selectSupplierList.do?callback=onSelectSupplier
		title : "选择供应商",
		iframe : true,
		width : "1000"
	});
});
 
</script>