<form action="#" method="post" id="dataForm">
<input type="hidden" name="dictDefId" value="${dictDefId!''}">
<input type="hidden" name="dataFrom" id="dataFrom">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td class="p_label">属性定义名：<span class="notnull">*</span></td>
                <td>
                	<input type="text" name="dictPropDefName" required=true>
                </td>
                <td class="p_label">是否必填：<span class="notnull">*</span></td>
                <td>
                	<select name="nullFlag" required=true>
                		<option value="N">否</option>
                		<option value="Y">是</option>
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
                <td class="p_label ele_maxlength">最大长度：</td>
                <td>
                	<input type="text" name="maxLength" maxLength=5 class="ele_maxlength">
                </td>
            </tr>
            <tr>
                <td class="p_label">状态：<span class="notnull">*</span></td>
                <td>
                	<select name="cancelFlag" required=true>
                		<option value="Y">有效</option>
                		<option value="N">无效</option>
                	</select>
                </td>
                <td class="p_label">排序值：</td>
                <td>
                	<input type="text" name="seq" maxLength=4>
                </td>
            </tr>
            <tr>
            <td class="p_label">说明文字：</td>
                <td colspan="3">
                	<textarea name="propDesc" style="width:300px"></textarea>
                </td>
            </tr>
           <!--
            <tr class="e_dataSource">
            	<td class="p_label" rowspan="3">数据源设置</td>
            	<td><input type="radio" name="hasData" checked="true">无</td>
            	<td class="p_label">默认值：</td>
                <td>
                	<input type="text" name="propDefault">
                </td>
            </tr>
            <tr class="e_dataSource">
            	<td colspan="3"><input type="radio" name="hasData">字典表 <span style="color:#7d7d7d">(需要先建立字典)</span></td>
            </tr>
            <tr class="e_dataSource">
            	<td colspan="3" class=" operate">
            		<span>已选字典：</span><br>
            		<input type="text" id="suggestText">
            		<div id="suggest"></div>
            	</td>
            </tr>
            -->
        </tbody>
    </table>
</form>
<div class="fl operate"><a class="btn btn_cc1" id="saveButton">保存</a></div>
 
<script>
$(".e_dataSource").hide();

//文本框改变事件
$("select[name='inputType']").bind("change",function(){
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
	$("#dataFrom").val($("#suggestText").attr("data"));
	
	 //验证
	if(!$("#dataForm").validate().form()){
		return false;
	}
	$.ajax({
	   url : "/vst_back/biz/dictPropDef/addBizDictPropDef.do",
	   data : $("#dataForm").serialize(),
	   type:"POST",
	   dataType:'JSON',
	   success : function(result){
			confirmAndRefresh(result);
	   		if(addDictPropDefDialog != null)
	   			addDictPropDefDialog.close();
	   		if(dictPropDefListDialog != null)
	   			dictPropDefListDialog.reload();
	   }
	});						
});

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