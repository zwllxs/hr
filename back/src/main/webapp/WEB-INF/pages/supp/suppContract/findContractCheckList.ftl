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
        <li class="active">供应商合同审核</li>
    </ul>
</div>
<div class="iframe_content">   
<div class="p_box box_info">
<form method="post"  action="/vst_back/supp/suppContractCheck/findSupplierContractCheckList.do"  id="searchForm">
    <table class="s_table">
    <tbody>
        <tr>
            <td class="s_label">供应商名称：</td>
            <td class="w18">
            <!-- <input type="text" name="supplierName" value="${contract.supplierName}"> -->
            <input type="text" class="searchInput" name="supplierName" id="supplierName" value="${contract.supplierName}">
            </td>
            <td class="s_label">合同编号：</td>
            <td class="w18"><input type="text" name="contractNo" value="${contract.contractNo}"> </td>
            <td class="s_label">录入人：</td>
            <td class="w18">
                <input type="text" name="createUserName" id="createUserName" value="${createUserName}" >
                <input type="hidden" value="${contract.createUserId}" name="createUserId" id="createUserId">
            </td>
            <td class=" operate mt10">
           <@mis.checkPerm permCode="3541" >            
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
	        <th>合同编号</th>
	        <th>供应商名称</th>
	        <th>录入人</th>
	        <th>录入时间</th>
	        <th>是否上传扫描件</th>
	        <th>审核</th>
		</tr>
        </thead>
                
        <tbody>
        <#if pageParam?exists> 
			<#list pageParam.items as contract> 
				<tr>
					<td>${contract.contractId} </td>
					<td>${contract.contractNo!''}</td>
					<td>${contract.supplierName} </td>
					<td>${contract.createUserName}</td>
					<td><#if contract.createTime??>${contract.createTime?string("yyyy-MM-dd")}</#if></td>
					<#if contract.attachmentNum gt 0 ><td>已上传</td><#else> <td>未上传</td></#if>
					<td>
					      <@mis.checkPerm permCode="3542" > 
						 <a href="javascript:void(0);" class="uploadContract" contractNo="${contract.contractNo}" data="${contract.contractId}">上传合同</a>
						  </@mis.checkPerm >  
						  <@mis.checkPerm permCode="3543" >
						 <a href="javascript:void(0);" class="showCheckContract" attachmentNum="${contract.attachmentNum}" 
						 	contractNo="${contract.contractNo}" supplierId="${contract.supplierId}" data="${contract.contractId}">审核</a>
						  </@mis.checkPerm >	
					</td>
				</tr>
			</#list>
		</#if>
        </tbody>
    </table>
	 
	 <#if pageParam?exists> 
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
vst_pet_util.superUserSuggest("#createUserName", "input[name=createUserId]");

vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');
var uploadContractDialog,checkContractDialog;

$("#search_button").click(function(){
	$("#searchForm").submit();
});

//上传合同
$("a.uploadContract").click(function(){	
	var contractId = $(this).attr("data");
	var contractNo= $(this).attr("contractNo");
	var url = "/vst_back/supp/suppContractCheck/showAddContracAttachment.do";
	uploadContractDialog = new xDialog(url,{"contractId":contractId,"contractNo":contractNo},{title:"上传合同",width:700});
});
	
//查看合同
$("a.showContract").click(function(){
	var contractId = $(this).attr("data");
	var supplierId = $(this).attr("supplierId");
	var contractNo = $(this).attr("contractNo");
	var url = "/vst_back/supp/suppContract/showSupplierContract.do";
	showContractDialog = new xDialog(url,{"check":"N","contractId":contractId,"supplierId":supplierId,"contractNo":contractNo},{title:"查看合同",width:900});
});	

//审核合同
$("a.showCheckContract").click(function(){
	var contractId = $(this).attr("data");
	var supplierId = $(this).attr("supplierId");
	var contractNo = $(this).attr("contractNo");
	var url = "/vst_back/supp/suppContract/showSupplierContract.do?check=Y&contractId="+contractId+"&supplierId="+supplierId+"&contractNo="+contractNo;
	if($(this).attr("attachmentNum") > 0){
		checkContractDialog = new xDialog(url,{},{title:"审核合同",width:900});
		return false;	
	}else{
	    alert("请先上传附件");
	}		
});		

//查询
$("#search_button").bind("click", function() {
	// 验证FORM
	if (!$("#searchForm").validate({}).form()) {
		return;
	}
	$.ajax({
		url : "/vst_back/supp/suppContractCheck/findSupplierContractCheckList.do",
		data : $("#searchForm").serialize(),
		type : "POST",
		dataType : "JSON",
		success : function(result) {
			if (result.code == "success") {
				$.alert(result.message, function() {});
			} else {
				$.alert(result.message);
			}
		}
	});
});	
</script>
