<!DOCTYPE html>
<html>
<head>

</head>
<body>

<div class="iframe_search">
<form method="post" action='/vst_back/supp/suppContract/selectSupplierContractList.do' id="searchForm">
	<input type="hidden" name="supplierId" value="${supplierId}">
</form>
</div>

<!-- 主要内容显示区域\\ -->
<div class="iframe-content">   
    <div class="p_box">
	<table class="p_table table_center">
    <thead>
        <tr>
       		<th>选择</th>
	    	<th>合同编号</th>
	        <th>合同名称</th>
	        <th>经办人</th>
	        <th>产品经理</th>
		</tr>
        </thead>
        <tbody>
			<#list suppContractList as contract> 
			<tr>
				<td>
					<input type="radio" name="contract">
					<input type="hidden" name="contractNameHide" value="${contract.contractName!''}">
					<input type="hidden" name="contractIdHide" value="${contract.contractId!''}">
				</td>
				<td><a href="javascript:void(0);" class="showContract" supplierId="${contract.supplierId}" 
					    	contractId="${contract.contractId}" >${contract.contractNo}</a>
				</td>
				<td>${contract.contractName!''} </td>
				<td>${contract.operatorName} </td>
				<td>${contract.managerName!''} </td>
			</tr>
			</#list>
    </tbody>
    </table>
		
	</div><!-- div p_box -->
</div><!-- //主要内容显示区域 -->


</body>
</html>
<script>
var  showContractDialog;
$("a.showContract").bind("click",function(){
	var contractId = $(this).attr("contractId");
	var supplierId = $(this).attr("supplierId");
	var url = "/vst_back/supp/suppContract/showSupplierContract.do";		
	showContractDialog = new xDialog(url,{"check":"N","contractId":contractId,"supplierId":supplierId},{title:"查看合同",width:800});
});

//查询
$("#search_button").bind("click",function(){
	$("#searchForm").submit();
});

$("input[type='radio'][name=contract]").bind("click",function(){
	var obj = $(this).parent("td");
	var contract = {};
	contract.contractId = $("input[name='contractIdHide']",obj).val();
    contract.contractName = $("input[name='contractNameHide']",obj).val();
	<#if callback??>
		${callback}(contract);
	<#else>
		onSelectContract(contract);
	</#if>
});
</script>
