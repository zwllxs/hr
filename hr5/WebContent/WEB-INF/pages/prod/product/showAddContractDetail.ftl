<form id="dataForm">
		<input type="hidden" value="${prodContractDetail.detailId!''}" name="detailId"  id="detailId"/>
		<input type="hidden" value="${prodContractDetail.productId!''}" name="productId"  id="productId"/>
		<input type="hidden" value="${prodContractDetail.detailType!''}" name="detailType"  id="detailType"/>
        <table class="p_table form-inline">
            <tbody>
                <tr>
                	<td class="p_label"><i class="cc1">*</i>行程天数：</td>
                    <td>
                    	<select name="nDays" id="nDays" required=true>
                    		<#list 1..prodLineNday as lineNday>
		                     	<option value="${lineNday!''}" <#if prodContractDetail.nDays == lineNday>selected</#if>>${lineNday!''}</option>
	                		</#list>
                    	</select>
                    </td>
                </tr>
				<tr>
					<td class="p_label"><i class="cc1">*</i>地      点：</td>
                    <td>
                    	<input type="text" name="address" value="${prodContractDetail.address!''}" maxlength="50" required=true>
                    </td>
                </tr>
                <tr>
		            <td class="p_label"><i class="cc1">*</i><#if prodContractDetail.detailType == 'RECOMMEND'>项目名称和内容：<#else>购物场所名称：</#if></td>
		            <td colspan="3">
		            	<textarea  name="detailName"  rows="3"  maxlength="50"  style="width:300px" required=true>${prodContractDetail.detailName!''}</textarea>
		            </td>
		        </tr>
		        <tr>
                    <td class="p_label"><i class="cc1">*</i><#if prodContractDetail.detailType == 'RECOMMEND'>费    用：<#else>主要商品信息: </#if></td>
                    <td colspan="3">
                    	<input type="text"  name="detailValue" value="${prodContractDetail.detailValue!''}"  maxlength="500"  required=true>
                    </td>
                </tr>
                <tr>
                    <td class="p_label"><i class="cc1">*</i><#if prodContractDetail.detailType == 'RECOMMEND'>项目时长(分钟)：<#else>最长停留时间(分钟): </#if></td>
                    <td colspan="3">
                    	<input type="text"  name="stay" value="${prodContractDetail.stay!''}" maxlength="10" number="true" required=true>
                    </td>
                </tr>
                  <tr>
		            <td class="p_label">其他说明：</td>
		            <td colspan="3">
		            	<textarea  name="other"  rows="3"  maxlength="250" style="width:300px">${prodContractDetail.other!''}</textarea>
		            </td>
		        </tr>
            </tbody>
        </table>
</form>
		<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="saveButton">保存</button>
<script>
//保存
$("#saveButton").bind("click",function(){
	if(!$("#dataForm").validate().form()){
		return;
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
			url : "/vst_back/prod/product/prodContractDetail/saveProdContractDetail.do",
			type : "post",
			dataType:"json",
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
			   if(result.code=="success"){
					$.alert(result.message,function(){
		   				showAddContractDetailDialog.close();
		   				window.location.reload();
		   			});
				}else {
					$.alert(result.message);
		   		}
			   }
			});			
	});
				
});
refreshSensitiveWord($("input[type='text'],textarea"));
</script>
