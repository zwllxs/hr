<form action="/vst_back/biz/district/updateDistrict.do" method="post" id="dataForm">
	<input type="hidden" name="dictPropDefId" value="${dictPropDef.dictPropDefId!''}">
	<input type="hidden" name="dataFrom" id="dataFrom" value=${dictPropDef.dataFrom!''}>
	<input type="hidden" name="dictId" id="dictId" value="${dictId}">
	<input type="hidden" name="dictDefId" id="dictDefId" value="${dictDefId}">

    <table class="p_table form-inline">
         <tbody>
            <tr>
				<td class="p_label">属性定义名：<span class="notnull">*</span></td>
                <td>
                	<input type="text" name="dictPropDefName"  required=true value=${dictPropDef.dictPropDefName!''}>
                </td>
                <td class="p_label">是否必填：<span class="notnull">*</span></td>
                <td>
                	<select name="nullFlag"  required=true >
                	  <option value="Y" <#if dictPropDef.nullFlag == 'Y'>selected</#if> >是</option>
                      <option value="N" <#if dictPropDef.nullFlag == 'N'>selected</#if> >否</option>
                	</select>
                </td>
            </tr> 
			<tr>
				<td class="p_label">录入方式：</td>
                <td>文本
                	<!--
                	<select name="inputType">
                		<#list inputTypeList as inputType>
                		<option value="${inputType.code!''}">${inputType.cnName!''}</option>
                		</#list>
                	</select>
                	-->
                </td>
                <td class="p_label">最大长度：</td>
                <td>
                	<input type="text" name="maxLength" maxlength=5 value=${dictPropDef.maxLength!''}>
                </td>
            </tr>
            <tr>
                <td class="p_label">状态：<span class="notnull">*</span></td>
                <td>
                	<select name="cancelFlag"  required=true >
            	  	  <option value="Y" <#if dictPropDef.cancelFlag == 'Y'>selected</#if> >有效</option>
                      <option value="N" <#if dictPropDef.cancelFlag == 'N'>selected</#if> >无效</option>
                	</select>
                </td>
                <td class="p_label">排序值：</td>
                <td>
                	<input type="text" name="seq" maxlength=4 value=${dictPropDef.seq!''}>
                </td>
            </tr>
            <tr>
            <td class="p_label">说明文字：</td>
                <td colspan="3">
                	<textarea name="propDesc" style="width:300px">${dictPropDef.propDesc!''}</textarea>
                </td>
            </tr>
            <!--
                <tr class="e_dataSource">
                	<td class="p_label" rowspan="3">数据源设置</td>
                	<td>
                	<input type="radio" name="hasData" onClick="clearSuggest()" <#if dictPropDef.propDefault != null> checked="true" </#if>>无
                	</td>
                	<td class="p_label">默认值：</td>
                    <td>
                    	<input type="text" name="propDefault" id="propDefault" value=${dictPropDef.propDefault}>
                    </td>
                </tr>
                <tr class="e_dataSource">
                	<td colspan="3"><input type="radio" onClick="clearDefault()"  <#if dictPropDef.dataFrom != null> checked="true" </#if> name="hasData">字典表 <span style="color:#7d7d7d">(需要先建立字典)</span></td>
                </tr>
                <tr class="e_dataSource">
                	<td colspan="3" class=" operate">
                		<span>已选字典：</span><br>
                		<input type="text" id="suggestText" value=${dictPropDef.dataFrom}>
                		<div id="suggest"></div>
                	</td>
                </tr>
            -->
        </tbody>
    </table>
</form>
 <table class="p_table form-inline">
     <tbody>
        <tr>
          <td style="text-align:right"><div class="operate"><a class="btn btn_cc1" id="saveButton">保存</a></div></td>
        </tr>
     </tbody>
</table>
        
<script>
var select = $("select[name='inputType']");
if(select.val() == "INPUT_TYPE_CHECKBOX" || select.val() == "INPUT_TYPE_RADIO" || select.val() == "INPUT_TYPE_SELECT"){
		$(".e_dataSource").show();
	}else {
		$(".e_dataSource").hide();
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
		$(".e_dataSource").show();
	}else {
		//清空已有数据
		$("#suggestText").val("");
		$("#dataFrom").val("");
		$("#propDefault").val("");
		$("#suggestText").attr("data","");
		$(".e_dataSource").hide();
	}
});
	
//搜索下拉框
new xSuggester({
	url : "/vst_back/biz/dict/findDictDefInSuggest.do",
	renderTo:"suggest",
	ele : "suggestText"
});
	
$("#saveButton").bind("click",function(){
	//$("#dataFrom").val($("#suggestText").attr("data"));
	
	 //验证
	if(!$("#dataForm").validate().form()){
		return false;
	}
	$.confirm("确认修改吗 ？", function () {
		$.ajax({
		   url : "/vst_back/biz/dictPropDef/updateBizDictPropDef.do",
		   data : $("#dataForm").serialize(),
		   type: "POST",
		   dataType:'JSON',
		   success : function(result){
		   		confirmAndRefresh(result);
		   		if(updateDictPropDefDialog != null)
		   			updateDictPropDefDialog.close();
		   		if(dictPropDefListDialog != null)
		   			dictPropDefListDialog.reload();
		   }
		});	
	});	
});
	
function clearSuggest() { 
	 $("#suggestText").val("");
}
function clearDefault() { 
	 $("#propDefault").val("");
}
function confirmAndRefresh(result){
	if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
		}});
	}
} 
</script>