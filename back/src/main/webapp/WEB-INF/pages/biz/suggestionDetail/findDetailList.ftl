<div class="iframe_search">
<form id="dataForm">
<input type="hidden" id="suggId" name="suggId" value="${suggId!''}">
<input type="hidden" id="detailValue" name="detailValue" value="">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td>${suggName}</td>
            </tr>
            <tr>
				<td>
					描述内容举例：包含成人【文本-20字符-默认值“成人数”】以及儿童【文本-20字符】<br>
					注意：<br>
					1. 编辑时，建议先复制粘贴过去，格式完全按照例子来。<br>
					2. 多选和单项按钮仅作显示，无实际作用，勿纠结。
				</td>
            </tr>
            <#assign rowCount = 1>
            <#list groupList as group> 
				<table id="tab${group.groupId!''}">
				<tr>
					<td>
						【 ${group.groupName!''} 】
						【 排序值 ${group.seq!''} 】
						<#if group.selectType==1>
							【 单选 】
						<#elseif group.selectType==2>
							【 复选 】
						</#if>
						<input type="button" class="pbtn pbtn-small btn-ok" style="float:middle;" name="addButton" onclick="addRow('${group.groupId}', '${group.selectType}')" value="添加描述">
					</td>
				</tr>
				<#list detailMap?keys as key>
					<#if key==group.groupId>
						<#assign details = detailMap[key]>
						<#list details as detail>
							 <tr class="tr_${rowCount}">
							 	<td>
							 		<#if group.selectType==1>
							 			<input type="radio">
							 		<#elseif group.selectType==2>
							 			<input type="checkbox">
							 		</#if>
							 		&nbsp;<input id="group${group.groupId!''}" value="${detail.suggDesc}" maxlength=500>
							 		<a href="#" onclick=delRow(${group.groupId!''},${rowCount})>&nbsp;删除</a>
							 		 <#assign rowCount = rowCount + 1>
							 	</td>
							 </tr>
						</#list>
					</#if>
				</#list>
				</table>
			</#list>
        </tbody>
    </table>
    <button class="pbtn pbtn-small btn-ok" style="float:middle;margin-top:20px;" id="saveButton">确认并保存</button>
    <button class="pbtn pbtn-small btn-ok" style="float:middle;margin-top:20px;" id="cancelButton">取消</button>
</form>
</div>
<script>
$("#cancelButton").bind("click",function(){
	if ($("#groupId").val()=="")
		addGroupDialog.close();
	else
		updateGroupDialog.close();
});
var rowCount = ${rowCount};
function addRow(groupId, selectType) {
	rowCount++;
	var type = "";
	if (selectType==1)
		type = "radio";
	else if (selectType==2)
		type = "checkbox";
	var rowTemplate = '<tr class="tr_'+rowCount+'">'+
					  '<td>&nbsp;<input type="'+type+'">&nbsp;'+
					  '<input type="text" maxlength=500 id="group'+groupId+'"><a href="#" onclick=delRow('+groupId+','+rowCount+')>&nbsp;删除</a></td></tr>';
	$("#tab"+groupId).append(rowTemplate);
}
function delRow(groupId, _id){
	$("#tab"+groupId+" .tr_"+_id).remove();
	rowCount--;
}
$("#saveButton").bind("click",function(){
	$(this).attr("disabled","disabled");
	var str = "";
	var details = $("input[id^='group']");
	for (var i=0; i<details.length; i++) {
		var groupStr = $(details[i]).attr("id");
		str += groupStr.substr(5, groupStr.length) + "," + $(details[i]).val() + ";";
//		console.log(i+"="+$(details[i]).val()+" && id="+$(details[i]).attr("id"));
	}
//	console.log($("#suggId").val());
	$("#detailValue").val(str);
	//遮罩层
	var loading = pandora.loading("正在努力保存中...");
	$.ajax({
		url : "/vst_back/biz/suggestionDetail/addOrModifyDetail.do",
		type : "post",
		dataType : 'json',
		async: false,
		data : $("#dataForm").serialize(),
		success : function(result) {
			$("#addButton").removeAttr("disabled");
			loading.close();
			if (result.code == "success") {
				detailListDialog.close();
			} else {
				$.alert(result.message);
			}
		},
		error : function() {
			$("#addButton").removeAttr("disabled");
			loading.close();
			detailListDialog.close();
		}
	});
});
</script>
