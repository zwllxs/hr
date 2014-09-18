
<form id="dataForm">
    <table class="p_table form-inline">
        <input type="hidden" name="propId" id="propId" value="${bizBranchProp.propId!''}">
		<input type="hidden" name="branchId" id="branchId" value="${bizBranchProp.branchId!''}">
    <tbody>
        <tr>
        	<td class="p_label">属性名：<span class="notnull">*</span></td>
            <td><input type="text" name="propName"  id="propName" required=true value="${bizBranchProp.propName!''}"></td>
        	<td class="p_label">属性Code：<span class="notnull">*</span></td>
            <td><input type="text" name="propCode" id="propCode" required=true  disabled="disabled" value="${bizBranchProp.propCode!''}"></td>
		 </tr>	 
		 <tr>
				<td class="p_label">排序值：</td>
                <td><input type="text" number="true" name="seq" value="${bizBranchProp.seq!''}"></td>	
                <td class="p_label">最大长度：</td>
            	<td><input type="text" number="true" name="maxLength" value="${bizBranchProp.maxLength!''}" number=true max=4000></td>
		</tr>
		<tr>
				 <td class="p_label">是否必填：<span class="notnull">*</span></td>
	            <td>
			        <select name="nullFlag" id="nullFlag"  required=true>
					  <option  value="N" ${(bizBranchProp.nullFlag== "N")?string("selected", "")}>否</option>
					  <option value="Y" ${(bizBranchProp.nullFlag== "Y")?string("selected", "")}>是</option>
			        </select>
			     </td>	
				<td class="p_label">状态：<span class="notnull">*</span></td>
                <td>
					<select name="cancelFlag" id="cancelFlag" required=true>
				      <option value="N" ${(bizBranchProp.cancelFlag=="N")?string("selected", "")} >无效</option>
					  <option value="Y" ${(bizBranchProp.cancelFlag=="Y")?string("selected", "")} >有效</option>
				   </select>
       			</td>
            </tr>
		    <tr>
				<td class="p_label">录入方式：<span class="notnull">*</span></td>
				<td>
				 <select name="inputType" id="inputType"  disabled="disabled" required=true>
				    <#list inputtypes as inputtype> 					    
		                <option value="${inputtype.code}"
						${(bizBranchProp.inputType==inputtype.code)?string("selected", "")} 
						>${inputtype.cnName}</option>
				    </#list>  
                </select>
				</td>
			</tr>
		     <tr  class="e_dataSource">
			  <td rowspan="5" class="p_label">数据源设置：<span class="notnull">*</span></td>
			</tr>
			<tr  class="e_dataSource">
				<td><input type="radio" name="datasource" id="defaultRadio"  disabled="disabled" checkDataFrom value="0" ${(bizBranchProp.dataFrom??)?string("", "checked")} /> 无</td>
				<td class="p_label">默认值：</td>
				<td><input type="text" name="propDefault" id="defaultInput"  disabled="disabled" value="${bizBranchProp.propDefault!''}"></td>			
	        </tr>
			<tr  class="e_dataSource">
				<td colspan="3"><input type="radio" name="datasource" id="sourceRadio"   disabled="disabled" checkDataFrom value="1" ${(bizBranchProp.dataFrom??)?string("checked", "")} /> 字典表(需要先建立字典表)</td>
			</tr>
			<tr class="e_dataSource"><td colspan="3">已选字典:${bizBranchProp.dataFromName!''}</td>  </tr>
			<tr class="e_dataSource">	
				<td class=" operate mt10" colspan="3">
				     <input type="hidden" id="suggestValue" name="dataFrom" value="${bizBranchProp.dataFrom!''}">
					 <input type="text" id="suggestText"  value="${bizBranchProp.dataFromName!''}"  disabled="disabled"><span id="errorDataFromMess"></span>
					 <div id="suggest"></div>
				</td>			
	        </tr>	
	        
			<tr><td colspan="2">说明文字(属性名后面显示):</td> <td colspan="2"> 用途概述(告知自己做什么用):</td>  </tr>
			<tr>
				<td colspan="2"><textarea rows="3" cols="40" style="width:256px" name="propDesc" maxlength=100>${bizBranchProp.propDesc!''}</textarea></td> 
				<td colspan="2"><textarea rows="3" cols="40" style="width:256px" name="propUse" maxlength=100>${bizBranchProp.propUse!''}</textarea></td> 
			</tr>
        </tbody>
    </table>
</form>

<button class="pbtn pbtn-small btn-ok" style="float:right;margin-top:20px;" id="editButton">保存</button>

<script>

var select = $("select[name='inputType']");
if(select.val() == "INPUT_TYPE_CHECKBOX" || select.val() == "INPUT_TYPE_RADIO" || select.val() == "INPUT_TYPE_SELECT"){
	$("#defaultRadio").removeAttr("checked");
	$("#defaultRadio").attr("disabled",true);
	$("#defaultInput").attr("disabled",true);
	
	$("#sourceRadio").attr("checked","checked");
}else {
	$("#sourceRadio").removeAttr("checked");
	$("#sourceRadio").attr("disabled",true);
	$("#suggestText").attr("disabled",true);
	$("#defaultRadio").attr("checked","checked");
}

var propId = $("#propId").val();
if(propId != ""){
	$("#inputType").attr("disabled",true);
}

//文本框改变事件
select.bind("change",function(){

	//如果是文本框
	if($(this).val() == "INPUT_TYPE_TEXT"){
		$(".ele_maxlength").show();
	}else{
		$(".ele_maxlength").hide();
	}
	
	//判断是否显示数据源
	if($(this).val() == "INPUT_TYPE_CHECKBOX" || $(this).val() == "INPUT_TYPE_RADIO" || $(this).val() == "INPUT_TYPE_SELECT"){
		$("#defaultRadio").removeAttr("checked");
		$("#defaultRadio").attr("disabled",true);
		$("#defaultInput").attr("disabled",true);
		$("#sourceRadio").attr("disabled",false);
		$("#suggestText").attr("disabled",false);
		$("#sourceRadio").attr("checked","checked");
	
	}else {
		//清空已有数据
		$("#defaultRadio").attr("disabled",false);
		$("#defaultInput").attr("disabled",false);
		$("#suggestText").val("");
		$("#suggestValue").val("");
		$("#propDefault").val("");
		$("#suggestText").attr("data","");
		$("#sourceRadio").removeAttr("checked");
		$("#sourceRadio").attr("disabled",true);
		$("#suggestText").attr("disabled",true);
		$("#defaultRadio").attr("checked","checked");
		
	}
});
	
//搜索下拉框
new xSuggester({
	url : "/vst_back/biz/dict/findDictDefInSuggest.do",
	renderTo:"suggest",
	ele : "suggestText",
	suggestValue: "suggestValue"
});

checkDataFrom = function(datasourceValue){
  if(datasourceValue=='1' && $("input[name='dataFrom']").val() == '' ){
     return false;
  }else{
	  return true;
  }
};

jQuery.validator.addMethod("checkDataFrom", function(value, element){ 
     return this.optional(element)||checkDataFrom(value);}, "选字典表时,必须选择一个字典!!");
     
//修改属性
$("#editButton").bind("click",function(){
	//验证
	if(!$("#dataForm").validate().form()){
	return false;
}
$("#propType,#propCode,#inputType,#defaultRadio,#sourceRadio,#suggestText,#groupId").attr("disabled",false);
	$.confirm("确认修改吗 ？", function () {
	$.ajax({
	url : "/vst_back/biz/branchProp/updateBranchProp.do",
	type : "post",
	dataType:"json",
	async: false,
	data : $("#dataForm").serialize(),
	success : function(result) {
	   if(result.code=="success"){
				$.alert(result.message,function(){
		   				updateBranchPropDialog.close();
		   				window.location.reload();
   			});
			}else {
				$.alert(result.message);
	   		}
	   }
	});
	});						
}); 
	     
</script>


