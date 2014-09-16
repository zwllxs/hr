<#assign mis=JspTaglibs["/WEB-INF/pages//tld/lvmama-tags.tld"]>
<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">供应商管理</a> &gt;</li>
        <li class="active">供应商合同列表</li>
    </ul>
</div>
<div class="iframe_content">   
	<div class="p_box box_info">
		<form method="post" action='/vst_back/supp/suppContract/findSupplierContractList.do' id="searchForm">
		    <table class="s_table">
		    <tbody>
		        <tr>
		            <td class="s_label">合同编号：</td>
		            <td class="w18">
		            	<input type="text" name="contractNo" value="${contract.contractNo!''}"> 
		            </td>
		            <td class="s_label">合同名称：</td>
		            <td class="w18">
		            	<input type="text" name="contractName" value="${contract.contractName!''}">
		            </td>
		            <td class="s_label">供应商名称：</td>
		            <td class="w18">
		           	<input type="text" errorEle="searchValidate"  class="searchInput" name="supplierName" id="supplierName" value="${contract.supplierName}" >
		              <input errorEle="searchValidate" type="hidden" value="${contract.supplierId}" name="supplierId" id="supplierId" >
		            </td>
		            <td class=" operate mt10">
		            <@mis.checkPerm permCode="3538" >
		            <a class="btn btn_cc1" id="new_contract_button">新增</a>
		            </@mis.checkPerm >		            
		            </td>
		        </tr>
		        <tr>
		        	<td class="s_label">审核状态：</td>
		            <td class="w18">
		            	<select name="contractStatus">
		            		<option value="">不限</option>
		                	<#list approvalList as appr>
		                		<option value="${appr.code!''}" <#if contract.contractStatus == appr.code>selected="selected"</#if>
		                		>${appr.cnName!''}</option>
		                    </#list>
		           		</select>
		            </td>
		            <td class="s_label">甲方：</td>
		            <td class="w18">
		               <select name="accSubject">
		               		<option value="">不限</option>
		                	<#list accSubjectList as accSubject>
		                	<option value="${accSubject.code!''}" <#if contract.accSubject == accSubject.code>selected="selected"</#if> 
		                		>${accSubject.accName!''}</option>
		                	</#list>               
		                </select>
		           	</td>
		            <td class="s_label">距离合同到期：</td>
		            <td class="w18">
		            	<select name="timeSort">
		                	<#list timeSortList as sort>
		                		<option value="${sort.code!''}"
		                			<#if timeSort == sort.code>selected="selected"</#if>
		                		>${sort.cnName!''}</option>
		                    </#list>
		           		</select>
		            </td>
		            <td class=" operate mt10">
		            <@mis.checkPerm permCode="3539" >
		            <a class="btn btn_cc1" id="search_button">查询</a>
		             </@mis.checkPerm >
		            </td>
		        </tr>
		    </tbody>
		    </table>	
		</form>
	</div>
    
<!-- 主要内容显示区域\\ -->
	<input type="hidden" name ="supplierId" id="supplierId" value=${supplierId}>
    <div class="p_box box_info">
	<table class="p_table table_center">
        <thead>
        <tr>
	    	<th>序号</th>
	        <th>合同名称</th>
	        <th>合同编号</th>
	        <th>审核状态</th>
	        <th>对应供应商</th>
	        <th>合同有效期</th>
	        <th>距离合同到期</th>
	        <th>经办人</th>
	        <th>甲方</th>
	        <th>操作</th>
		</tr>
        </thead>
        
        <tbody>
			<#list pageParam.items as contract> 
				<tr>
					<td>${contract.contractId} </td>
					<td>${contract.contractName!''} </td>
					<td><a href="javascript:void(0);" class="showUpdateContract" contractStatus="${contract.contractStatus}" 
						contractNo="${contract.contractNo}" supplierId="${contract.supplierId}" data="${contract.contractId}">${contract.contractNo!''}</a>
					</td>
					<td>${contract.contractStatusCn}</td>
					<td><#if contract.supplierName??>${contract.supplierName!''}</#if></td>
					<td><#if contract.startTime??> ${contract.startTime?string("yyyy-MM-dd")}</#if>到<#if contract.endTime??>${contract.endTime?string("yyyy-MM-dd")} </#if></td>
					<td>
						<#if contract.leftDays==0>
							今天到期
						<#elseif contract.leftDays<0>
							<span style="color:red">超期${-contract.leftDays}天</span>
						<#elseif contract.leftDays &lt; 30 && contract.leftDays &gt; 0>
							<span style="color:blue">即将到期${contract.leftDays}天</span>
						<#else>
							<span style="color:green">${contract.leftDays}天</span>
						</#if>
					</td>
					<td>${contract.operatorName}</td>
					<td>${contract.accSubjectCn}</td>
					<td class="oper">
						 <@mis.checkPerm permCode="3540" >
							 <a href="javascript:void(0);" class="editContract" contractNo="${contract.contractNo}" 
							 		supplierId="${contract.supplierId}" data="${contract.contractId}">合同变更</a>
						 </@mis.checkPerm >
	                     <#if contract.contractStatus=="REJECTED">
	                    	<a href="javascript:void(0);" class="reCheckContract" data="${contract.contractId}">再次提交审核</a>
						 </#if>
						 <#if contract.contractStatus=="PASS" || contract.contractStatus=="UPDATE_REJ">
							 <a href="javascript:void(0);" class="showUpdateContract" contractStatus="${contract.contractStatus}" gotoContractStatus="UPDATE_UNVER" 
									contractNo="${contract.contractNo}" supplierId="${contract.supplierId}" data="${contract.contractId}">合同修改</a>
						 </#if>
						 <a href="javascript:void(0);" class="showLogDialog" param="{'objectId':${contract.contractId},'objectType':'SUPP_SUPPLIER_CONTRACT'}">操作日志</a> 
					</td>
					
					</td>
				</tr>
			</#list>
        </tbody>
    </table>
	 <#if pageParam.items?exists> 
		<div class="paging" > 
			${pageParam.getPagination()}
		</div> 
	</#if>
	
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var contractAddDialog,contractUpdateDialog,showContractDialog,checkContractDialog,updateContractDialog;
vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');

//新增合同
$("#new_contract_button").click(function(){	
	var url = "/vst_back/supp/suppContract/showAddSupplierContract.do";
	contractAddDialog = new xDialog(url,{},{title:"新增供应商合同",width:900});
});
//变更合同
$("a.editContract").click(function(){
	var contractId = $(this).attr("data");
	var supplierId = $(this).attr("supplierId");
	var contractNo = $(this).attr("contractNo");
	var url = "/vst_back/supp/suppContract/showUpdateContractChange.do";
	contractUpdateDialog = new xDialog(url,{"contractId":contractId,"supplierId":supplierId,"contractNo":contractNo},{title:"修改供应商合同",width:500});
});	

//查看合同
$("a.showContract").click(function(){
	var contractId = $(this).attr("data");
	var supplierId = $(this).attr("supplierId");
	var contractNo = $(this).attr("contractNo");
	var url = "/vst_back/supp/suppContract/showSupplierContract.do";
	showContractDialog = new xDialog(url,{"check":"N","contractId":contractId,"supplierId":supplierId,"contractNo":contractNo},{title:"查看合同",width:900});
});	

//修改合同
$("a.showUpdateContract").click(function(){

	var gotoContractStatus = $(this).attr("gotoContractStatus");
	//合同为审核通过状态,不执行修改只可查看
	if($(this).attr("contractStatus")=="PASS" && gotoContractStatus != "UPDATE_UNVER"){	
	    var contractId = $(this).attr("data");
		var supplierId = $(this).attr("supplierId");
		var contractNo = $(this).attr("contractNo");
		var url = "/vst_back/supp/suppContract/showSupplierContract.do";
		showContractDialog = new xDialog(url,{"check":"N","contractId":contractId,"supplierId":supplierId,"contractNo":contractNo},{title:"查看合同",width:900});

    }else{	
  		 //合同为待审核和驳回状态可以编辑合同, 同时合同为审核通过状态,执行修改也能编辑
		var contractId = $(this).attr("data");
		var supplierId = $(this).attr("supplierId");
		var contractNo = $(this).attr("contractNo");	
		var contractStatus = $(this).attr("contractStatus");
		var param = "contractId="+contractId+"&supplierId="+supplierId+"&contractNo="+contractNo+"&contractStatus="+contractStatus+"&gotoContractStatus="+gotoContractStatus;
		var url = "/vst_back/supp/suppContract/showUpdateSupplierContract.do?" + param;
		
		dialog(url, "修改合同", 900, "auto",function(){
			if($("input[name='settlementPeriod']").eq(0).attr("checked")=="checked"){
		        $("input[name='settleCycle']").attr("required", true);
			 }
			if ($("#contractNo0").val() != "" && $("#contractNo1").val() != "" && $("#contractNo2").val() != "" && $("#contractNo3").val() != "") {
				var contractNo = $("#contractNo0").val() + "-" + $("#contractNo1").val() + "-" + $("#contractNo2").val() + "-" + $("#contractNo3").val()
				$("#contractNo").val(contractNo);
			}
			if(!$("#updateSupplierContractForm").validate().form()){
				return false;
			}
			if ($("#operator").val() == "" || $("#managerId").val() == "") {
				$.alert("产品经理和经办人必须从下拉数据中选择.");
				return false;
			}	
			//结算周期
			if($("#Cycle").val()!=null){
				$("#settleCycle").val($("#Cycle").val());
				$("#Cycle").attr("disabled","disabled");
			}
			
			var resultCode;
			$.ajax({
				url : "/vst_back/supp/suppContract/updateSupplierContract.do",
				type : "post",
				data : $(".dialog #updateSupplierContractForm").serialize(),
				dataType:'JSON',
				success : function(result) {
				   resultCode=result.code;
				   confirmAndRefresh(result);
				}
			});
			if(resultCode !=='success') return false;
		},"保存");
	}
});
 

//再次提交审核合同
$("a.reCheckContract").click(function(){
    var contractId = $(this).attr("data");
	$.confirm("确认再次审核 ？", function () {
		$.ajax({
			url : "/vst_back/supp/suppContract/checkContract.do",
			type : "post",
			dataType:"JSON",
			data : {"contractId":contractId,"check":"UNVERIFIED"},
			success : function(result) {
				if(result.code=="success"){	
			   		$.alert("提交成功",function(){
			   			$("#searchForm").submit();
			   		});
			   	}
			}
		});	
	});	
});	

$("#search_button").click(function(){
	$("#searchForm").submit();
});

//设置为有效或无效
$("a.cancelFlagContract").bind("click",function(){
	var entity = $(this);
	var cancelFlag = entity.attr("data");
	var contractId = entity.attr("contractId");
	msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	$.confirm(msg, function () {
		$.ajax({
			url : "/vst_back/supp/suppContract/cancelSupplierContract.do",
			type : "post",
			dataType:"JSON",
			data : {"cancelFlag":cancelFlag,"contractId":contractId},
			success : function(result) {
			if (result.code == "success") {
				$.alert(result.message,function(){
					if(cancelFlag == 'N'){
						entity.attr("data","Y");
						entity.text("设为有效");
						$("span.cancelProp",entity.parents("tr")).css("color","red").text("无效");
					}else if(cancelFlag == 'Y'){
						entity.attr("data","N");
						entity.text("设为无效");
						$("span.cancelProp",entity.parents("tr")).css("color","green").text("有效");
					}
				});
			}else {
				$.alert(result.message);
			}
			}
		});
	});
});	

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
  			$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
}
</script>
