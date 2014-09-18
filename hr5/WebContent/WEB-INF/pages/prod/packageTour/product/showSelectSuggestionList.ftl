<div class="iframe_search">
<input type="hidden" id="suggCode" name="suggCode" value="${suggCode!''}">
<#if groupList?? && groupList?size &gt; 0>
    <table class="p_table form-inline">
        <tbody>
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
							 <tr >
							 	<td>
							 		<#if group.selectType==1>
							 			<input type="radio" id="${detail.detailId}" name="dName${key}">
							 		<#elseif group.selectType==2>
							 			<input type="checkbox" id="${detail.detailId}" name="dName${key}">
							 		</#if>
							 		<span id="td${detail.detailId}">${detail.suggDesc!''}</span>
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
<#else>
 无条款，请先维护！
</#if>
    
</div>
<script>
$("#saveButton").bind("click",function(){
	$(this).attr("disabled","disabled");
	var str="";
	// 选中的行id
    $("input[name^='dName']").each(function(){
    	if($(this).attr("checked")){
    		str += $(this).attr("id")+",";
        }
    });
	// 选中的行对象
	var detailIds = str.split(",");
	var resultStr = "";
	var lineIndex = 1;
	for (var i=0; i < detailIds.length; i++) {
		var detailId = detailIds[i];
		if (detailId == '')
			continue;
		var html = $.trim($("#td" + detailId).html());
		var detailNum = $("input[name^='txt" + detailId + "']").length;
		var result = "";
		if (detailNum == 0) { // 纯文字，没有 text 框
			result += lineIndex + "、" + html + $.trim($("#td" + detailId).val())+"\n";
		} else {
			var preEndIndex = 0;
			for (var j=0; j< detailNum; j++) {
				var txtId = "txt" + detailId + "_" + j;
				var startIndex = html.indexOf("<input");
				var endIndex = html.indexOf('tail="tail">', startIndex);
				result +=  html.substr(0, startIndex) ;
				var txtVal = $("#" + txtId).val();
				if(txtVal != null && txtVal != ''){
					result += "(" + txtVal + ")";
				}
				html = html.substr(endIndex + 12);
			}
			
			result = lineIndex + "、" +  result + "\n";
		}
		lineIndex ++;
		resultStr += result;
	}
	
	if(resultStr == null || resultStr == ''){
		alert("请选择条款");
		$(this).removeAttr("disabled");
		return;
	}
	
	setSuggTextArea(resultStr);
});
</script>