<div class="iframe_search">
<form id="dataForm">
    <input type="hidden" name="propId" id="propId" value="${bizPropPool.propId!''}"> 
    <table class="p_table form-inline">
    <tbody>
		 <tr>
		 	<td class="p_label">属性类型：<span class="notnull">*</span></td>
            <td>
	            <select name="propType" required=true>
				  <option  value="category" ${(bizPropPool.propType== "category")?string("selected", "")}>品类属性</option>
				  <option  value="branch" ${(bizPropPool.propType== "branch")?string("selected", "")}>规格属性</option>
	            </select>
	         </td>
	         
        	<td class="p_label">属性Code：<span class="notnull">*</span></td>
            <td><input type="text" name="propCode" required=true value="${bizPropPool.propCode!''}"></td>
		 </tr>	
		 
        <tr>
        	<td class="p_label">属性名：<span class="notnull">*</span></td>
            <td><input type="text" name="propName" required=true value="${bizPropPool.propName!''}"></td>
			<td class="p_label">是否必填：<span class="notnull">*</span></td>
            <td>
	            <select name="nullFlag" required=true>
				  <option  value="N" ${(bizPropPool.nullFlag== "N")?string("selected", "")}>否</option>
				  <option value="Y" ${(bizPropPool.nullFlag== "Y")?string("selected", "")}>是</option>
	            </select>
	         </td>
		 </tr>
		 <tr>
			<td class="p_label">排序值：</td>
            <td><input type="text" name="seq" value="${bizPropPool.seq!''}"></td>
			<td class="p_label">最大长度：</td>
            <td><input type="text" name="maxLength" value="${bizPropPool.maxLength!''}"  number=true max=4000></td>
		</tr>	 
		 <tr>
			<td class="p_label">录入方式：<span class="notnull">*</span></td>
			<td>
				<select name="inputType" id="inputType" required=true>
				    <#list inputtypes as inputtype> 					    
		                <option value="${inputtype.code}"				
						${(bizPropPool.inputType==inputtype.code)?string("selected", "")}
						>${inputtype.cnName}</option>
					  </#list>
	            </select>
			</td>			
        </tr>
	    <tr  class="e_dataSource">
		  <td rowspan="5" class="p_label">数据源设置：<span class="notnull">*</span></td>
		</tr>
		<tr  class="e_dataSource">
			<td><input type="radio" name="datasource" id="defaultRadio" checkDataFrom value="0" ${(bizPropPool.dataFrom??)?string("", "checked")} /> 无</td>
			<td class="p_label">默认值：</td>
			<td><div id="defaultDiv"><input type="text" name="propDefault" id="defaultInput" value="${bizPropPool.propDefault!''}"></div></td>			
        </tr>
		<tr  class="e_dataSource">
			<td colspan="3"><input type="radio" name="datasource" id="sourceRadio"  checkDataFrom value="1" ${(bizPropPool.dataFrom??)?string("checked", "")} /> 字典表(需要先建立字典表)</td>
		</tr>
		<tr class="e_dataSource"><td colspan="3">已选字典:${bizPropPool.dataFromName!''}</td>  </tr>
		<tr class="e_dataSource">	
			<td class=" operate mt10" colspan="3">
			     <input type="hidden" id="suggestValue" name="dataFrom" value="${bizPropPool.dataFrom!''}">
				 <input type="text" id="suggestText" value="${bizPropPool.dataFromName!''}"><span id="errorDataFromMess"></span>
				 <div id="suggest"></div>
			</td>			
        </tr>	
        
		<tr><td colspan="2">说明文字(属性名后面显示):</td> <td colspan="2"> 用途概述(告知自己做什么用):</td>  </tr>
		<tr>
			<td colspan="2"><textarea rows="3" cols="40" style="width:256px" name="propDesc" maxlength=100>${bizPropPool.propDesc!''}</textarea></td> 
			<td colspan="2"><textarea rows="3" cols="40" style="width:256px" name="propUse" maxlength=100>${bizPropPool.propUse!''}</textarea></td> 
		</tr>
    </tbody>
    </table>
</form>
<script>

var select = $("select[name='inputType']");
if(select.val() == "INPUT_TYPE_CHECKBOX" || select.val() == "INPUT_TYPE_RADIO" || select.val() == "INPUT_TYPE_SELECT"){
	$("#defaultRadio").removeAttr("checked");
	$("#defaultRadio").attr("disabled",true);
	$("#defaultInput").attr("disabled",true);
	
	$("#sourceRadio").attr("disabled",false);
	$("#suggestText").attr("disabled",false);
	$("#sourceRadio").attr("checked","checked");
}else {
	$("#defaultRadio").attr("disabled",false);
	$("#defaultInput").attr("disabled",false);
	
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
		
		if($(this).val() == "INPUT_TYPE_YESNO"){
			$("#defaultDiv").html('<select name="propDefault" id="defaultInput" ><option  value="N" ${(bizPropPool.propDefault== "N")?string("selected", "")}>否</option><option value="Y" ${(bizPropPool.propDefault== "Y")?string("selected", "")}>是</option></select>');
		}else if($(this).val() == "INPUT_TYPE_NUMBER"){
			$("#defaultDiv").html('<input type="text" name="propDefault" id="defaultInput" number=true value="${bizPropPool.propDefault!''}">');
		}else if($(this).val() == "INPUT_TYPE_TEXT"||$(this).val() == "INPUT_TYPE_COORDINATE"||$(this).val() == "INPUT_TYPE_IMG_L" ||$(this).val() == "INPUT_TYPE_IMG_M"||$(this).val() == "INPUT_TYPE_IMG_S"){
			$("#defaultDiv").html('<input type="text" name="propDefault" id="defaultInput" value="${bizPropPool.propDefault!''}">');
		}else if($(this).val() == "INPUT_TYPE_RICH" || $(this).val() == "INPUT_TYPE_TEXTAREA"){
			$("#defaultDiv").html('<textarea name="propDefault" id="defaultInput" >${bizPropPool.propDefault!''}</textarea>');
		}else if($(this).val() == "INPUT_TYPE_YYYYMMDD"){
			$("#defaultDiv").html('<input type="text" name="propDefault" id="defaultInput" class="Wdate" id="defaultInput" onFocus="WdatePicker({readOnly:true})">');
		}else if($(this).val() == "INPUT_TYPE_YYYYMM"){
			$("#defaultDiv").html('<input type="text" name="propDefault" id="defaultInput" class="Wdate" id="defaultInput" onfocus="WdatePicker({readOnly:true, dateFmt:\'yyyy-MM\'})">');
		}
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
 
</script>


