<form action="#" method="post" id="dataForm">
    <table class="p_table form-inline">
	    <tbody>
	        <tr>
				<td class="e_label" width="150"><i class="cc1">*</i>供应商名称：</td>
	            <td>
	            	<!--<input type="text" name="supplierName" id="supplierName" required>-->
                <input type="text" class="searchInput" name="supplierName" id="supplierName" <#if supplier??>value="${supplier.supplierName!''}"</#if>  required=true>
	            	<div id="supplierNameError"></div>
	            </td>
	            <td class="e_label" width="150"><i class="cc1">*</i>供应商类型：</td>
	            <td>
	            	<select name="supplierType">
	            		<#list supplierTypeList as supplierType>
	            		<option value="${supplierType.code!''}">${supplierType.cnName!''}</option>
	            		</#list>
	            	</select>
	            </td>
	        </tr> 
			<tr>
				<td class="e_label"><i class="cc1">*</i>所在地：</td>
	            <td>
	            	<input type="text" id="district" readonly = "readonly" required>
	            	<input type="hidden" name="districtId" id="districtId" >
	            	<div  id="districtError"></div>
	            </td>
	            <td class="e_label"><i class="cc1">*</i>地址：</td>
	            <td>
	            	<input type="text" name="address" required=true maxlength=100>
	            	<div  id="addressError"></div>
	            </td>
	        </tr>
	        <tr>
	            <td class="e_label"><i class="cc1">*</i>电话：</td>
	            <td>
	            	<input type="text" name="tel" id="tel" required=true>
	            	<div  id="telError"></div>
	            </td>
	            <td class="e_label"><i class="cc1">*</i>传真：</td>
	            <td>
	            	<input type="text" name="fax" >
	            	<div  id="faxError"></div>
	            </td>
	        </tr>
	        <tr>
	            <td class="e_label">网址：</td>
	            <td>
	            	<input type="text" name="site">
	            </td>
	            <td class="e_label"><span class="notnull">*</span>邮编：</td>
	            <td>
	            	<input type="text" name="zip" required=true maxlength=6>
	            	<div id="zipError"></div>
	            </td>
	        </tr>
	        <tr>
	            <td class="e_label">法定代表人：</td>
	            <td>
	            	<input type="text" name="legalRep">
	            </td>
	            <td class="e_label">旅行社许可证：</td>
	            <td>
	            	<input type="text" name="permit">
	            </td>
	        </tr>
	        <tr>
	            <td class="e_label">父供应商：</td>
	            <td>
	            	<!--<input type="text" id="fatherName" readonly="readonly">
	            	<input type="hidden" name="fatherId" id="fatherId">-->
	            	<input type="text" class="searchInput" name="fatherName" id="fatherName">
                    <input type="hidden" name="fatherId" id="fatherId">
	            </td>
	        </tr>
	    </tbody>
	</table>
</form>
<button class="pbtn pbtn-small btn-ok"  style="float:right;margin-top:20px;" id="saveButton">保存</button>

<script>
var contactAddDialog,districtSelectDialog,selectSupplierDialog;
vst_pet_util.commListSuggest("#supplierName", null,'/vst_back/supp/supplier/searchSupplierList.do');
vst_pet_util.commListSuggest("#fatherName", "input[name=fatherId]",'/vst_back/supp/supplier/searchSupplierList.do');
//  	
$("#saveButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate({
		rules: {
			fax:{
				required : true,
				isFax : true
			}
		},
		messages: {
			fax:{
				required:'请输入传真号',
				isFax:'传真号不正确'
			}
		}
	}).form()){
		return;
	}	
	$.ajax({
	   url : "/vst_back/supp/supplier/addSupplier.do",
	   data : $("#dataForm").serialize(),
	   type:"POST",
	   dataType:"JSON",
	   success : function(result){	   
	   		if(result.code=="success"){
	   			addSupplierDialog.close();	 
	   			$.alert(result.message,function(){
	   				if(result.attributes && result.attributes.supplierName) {
		   				$("#searchForm #supplierName").val(result.attributes.supplierName);
	   				}
	   				$("#searchForm").submit();
	   			});
	   		}else {
	   			$.alert(result.message);
	   		}
	   }
	});						
});



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