  <div class="iframe_search">
<form id="dataForm">
<input type="hidden" id="suggCode" name="suggCode" value="${suggCode!''}">
    <table class="p_table form-inline">
        <tbody>
            <tr>
				<td>选中对应条目就行哦！</td>
            </tr>
            <#list groupList as group> 
				<table id="tab${group.groupId!''}">
				<tr>
					<td>
						<h1>${group.groupName!''}:</h1>
					</td>
				</tr>
				<#list detailMap?keys as key>
					<#if key==group.groupId>
						<#assign details = detailMap[key]>
						<#list details as detail>
							 <tr id="tr${detail.detailId}">
							 	<td>
							 		<#if group.selectType==1>
							 			<input type="radio" id="${detail.detailId}" name="dName${key}">
							 		<#elseif group.selectType==2>
							 			<input type="checkbox" id="${detail.detailId}" name="dName${key}">
							 		</#if>
							 		${detail.suggDesc!''}
							 	</td>
							 </tr>
						</#list>
					</#if>
				</#list>
				</table>
			</#list>
        </tbody>
    </table>
    <button class="pbtn pbtn-small btn-ok" style="float:middle;margin-top:20px;" id="saveButton">确认</button>
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
$("#saveButton").bind("click",function(){
	$(this).attr("disabled","disabled");
	var str="";
	// 选中的行id
    $("input[name^='dName']").each(function(){
    	if($(this).attr("checked")){
    		str += $(this).attr("id")+",";
        }
    });
//	console.log(str);
	// 选中的行对象
	var detailIds = str.split(",");
	var resultStr = "";
	for (var i=0; i<detailIds.length; i++) {
		var detailId = detailIds[i];
		if (detailId=='')
			continue;
		var html = $.trim($("#tr"+detailId).html());
//		console.log("html="+html);
		var detailNum = $("input[name^='txt"+detailId+"']").length;
		var result = "<tr>";
		if (detailNum==0) { // 纯文字，没有 text 框
			result += "<td>"+$.trim($("#tr"+detailId).text())+"</td>";
		} else {
			var preEndIndex = 0;
			for (var j=0; j< detailNum; j++) {
				var txtId = "txt"+detailId+"_"+j;
				var startIndex = html.indexOf(txtId)+txtId.length+9;
				var endIndex = html.indexOf('"', startIndex);
				var res = html.substr(preEndIndex, startIndex-preEndIndex)+$("#"+txtId).val();
				if (j==detailNum-1)
					res += html.substr(endIndex, html.length-endIndex);
				result += res;
//				console.log("res="+res);
				preEndIndex = endIndex;
			}
		}
		result += "</tr>";
//		console.log ("result=" + result );
		resultStr += result;
	}
	console.log ("resultStr=" + resultStr );
	return;
});
</script>
