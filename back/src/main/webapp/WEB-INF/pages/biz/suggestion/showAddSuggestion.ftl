<div class="iframe_search">
<form id="dataForm">
<input type="hidden" id="suggId" name="suggId" value="${suggestion.suggId!''}">
    <table class="p_table form-inline">
        <tbody>
             <tr>
				<td class="p_label"><span class="notnull">*</span>名称：</td>
                <td>
                	<input id="suggName" name="suggName" required=true maxlength="100" value="${suggestion.suggName!''}" <#if suggestion.suggName??>readonly=readonly</#if> >
                </td>
            </tr>
            <tr>
            	<td class="p_label"><span class="notnull">*</span>编号：</td>
                <td><input id="suggCode" name="suggCode" required=true maxlengh="50" value="${suggestion.suggCode!''}" <#if suggestion.suggCode??>readonly=readonly</#if>>（必须保证唯一）</td>
            </tr>
        </tbody>
    </table>
    <button class="pbtn pbtn-small btn-ok" style="float:middle;margin-top:20px;" id="addButton">确认并保存</button>
    <button class="pbtn pbtn-small btn-ok" style="float:middle;margin-top:20px;" id="cancelButton">取消</button>
</form>
</div>
<script>
$("#cancelButton").bind("click",function(){
	if ($("#suggId").val()=="")
		addSuggestionDialog.close();
	else
		updateSuggestionDialog.close();
});

$("#addButton").bind("click",function(){
	$(this).attr("disabled","disabled");
	
	//验证
	if (!$("#dataForm").validate({
			rules : {
				suggName : {
					isChar : true
				}
				/*,
				suggCode : {
					isChar : true
				}*/
			},
			messages : {
				suggName : '不可输入特殊字符'
				/*,
				suggCode : '不可输入特殊字符'*/

			}
		}).form()) {
			$(this).removeAttr("disabled");
			return false;
		}
		//遮罩层
		var loading = pandora.loading("正在努力保存中...");
		$.ajax({
			url : "/vst_back/biz/suggestion/addOrModifySuggestion.do",
			type : "post",
			dataType : 'json',
			async: false,
			data : $("#dataForm").serialize(),
			success : function(result) {
				$("#addButton").removeAttr("disabled");
				loading.close();
				if (result.code == "success") {
					if ($("#suggId").val()=="")
						addSuggestionDialog.close();
					else
						updateSuggestionDialog.close();
					window.location = "/vst_back/biz/suggestion/findSuggestionList.do";
				} else {
					$.alert(result.message);
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown,exc) {
				$("#addButton").removeAttr("disabled");
				loading.close();
				addSuggestionDialog.close();
			}
		})

	});
</script>
