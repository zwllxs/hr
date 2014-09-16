<form action="#" method="post" id="dataForm">
	<input type="hidden" name="supplierId" value="${supplier.supplierId}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label"><span class="notnull">*</span>供应商名称：</td>
                <td>
                	<!--<input type="text" name="supplierName" value="${supplier.supplierName}" required>-->
                	<input type="text"  name="supplierName" id="supplierName" value="${supplier.supplierName}" required=true>
                </td>
                <td class="p_label"><span class="notnull">*</span>供应商类型：</td>
                <td>
                	<select name="supplierType">
                		<#list supplierTypeList as supplierType>
                			<#if supplier.supplierType == supplierType.code>
                				<option value="${supplierType.code!''}" selected="selected">${supplierType.cnName!''}</option>
                			<#else>
                				<option value="${supplierType.code!''}">${supplierType.cnName!''}</option>
                			</#if>
                		</#list>
                	</select>
                </td>
            </tr> 
			<tr>
				<td class="p_label"><span class="notnull">*</span>所在地区：</td>
                <td>
                	<input type="text" id="district"  required=true  readonly="readonly" value="<#if supplier.supplierDistrict??>${supplier.supplierDistrict!''}</#if>">
                	<input type="hidden" name="districtId" id="districtId" value="${supplier.districtId}">
                </td>
                <td class="p_label"><span class="notnull">*</span>地址：</td>
                <td>
                	<input type="text" name="address" value="${supplier.address}" required>
                </td>
            </tr>
            <tr>
                <td class="p_label"><span class="notnull">*</span>电话：</td>
                <td>
                	<input type="text" name="tel" value="${supplier.tel}" required>
                </td>
                <td class="p_label">传真：</td>
                <td>
                	<input type="text" name="fax" value=${supplier.fax} required=true>
                </td>
            </tr>
            <tr>
                <td class="p_label">网址：</td>
                <td>
                	<input type="text" name="site" value=${supplier.site}>
                </td>
                <td class="p_label">邮编：</td>
                <td>
                	<input type="text" name="zip" value=${supplier.zip}  required=true maxlength=6>
                </td>
            </tr>
            <tr>
                <td class="p_label">法定代表人：</td>
                <td>
                	<input type="text" name="legalRep" value=${supplier.legalRep}>
                </td>
                <td class="p_label">旅行社许可证：</td>
                <td>
                	<input type="text" name="permit" value=${supplier.permit}>
                </td>
            </tr>
            <tr>
                <td class="p_label">父供应商：</td>
                <td>
                	<!--<input type="text" id="fatherName" readonly="readonly" value="<#if supplier.fatherSupplier??>${supplier.fatherSupplier!''}</#if>">
                	<input type="hidden" name="fatherId" id="fatherId" value=${supplier.fatherId}>-->
                	<input type="text" class="searchInput" name="fatherName" id="fatherName" value="<#if supplier.fatherSupplier??>${supplier.fatherSupplier!''}</#if>">
                    <input type="hidden" value="${supplier.fatherId}" name="fatherId" id="fatherId" >
                </td>
            </tr>
        </tbody>
    </table>
</form>
<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>
<script>
var contactAddDialog,districtSelectDialog,selectSupplierDialog;

//vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');
vst_pet_util.commListSuggest("#fatherName", "input[name=fatherId]",'/vst_back/supp/supplier/searchSupplierList.do');

$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
		return;
	}
	$.confirm("确认修改吗 ？", function () {
	$.ajax({
	   url : "/vst_back/supp/supplier/updateSupplier.do",
	   data : $("#dataForm").serialize(),
	   type:"POST",
	   dataType:"JSON",
	   success : function(result){
   		if(result.code=="success"){
   			updateSupplierDialog.close();
	   		$.alert(result.message,function(){
	   			$("#searchForm").submit();
	   		});
   		}else {
   		  	$.alert(result.message);
   		}
	   }
	});	
	});					
});
	
//供应商选择后的回调函数
function onSelectSupplier(params){
	if(params!=null){
		$("#fatherName").val(params.supplierName);
		$("#fatherId").val(params.supplierId);
	}
	//关闭供应商列表
	selectSupplierDialog.close();
}

//打开选择供应商列表
//$("#fatherName").click(function(){
	//var url = "/vst_back/supp/supplier/selectSupplierList.do?callback=onSelectSupplier";
	//selectSupplierDialog = new xDialog(url,{},{title:"选择供应商",iframe:true,width:"1000"});
//});

//选择行政区
function onSelectDistrict(params){
	if(params!=null){
		$("#district").val(params.districtName);
		$("#districtId").val(params.districtId);
	}
	districtSelectDialog.close();
}

//打开选择行政区窗口
$("#district").click(function(){
	var url = "/vst_back/biz/district/selectDistrictList.do";
	districtSelectDialog = new xDialog(url,{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
});
</script>