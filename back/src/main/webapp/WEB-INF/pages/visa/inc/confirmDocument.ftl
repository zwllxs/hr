<form action="/visa/approval/saveConfirmDocument.do" method="post" id="confirmDocumentForm">
	<input type="hidden" name="docId" value="${docId}">
	<input type="hidden" name="visaApprovalId" value="${visaApprovalId}">
	<table class="p_table table_left" style="border:0px;">
		<tbody>
			<tr>
				<td class="f14" style="width:120px;">游客&nbsp;<span class="cc6 f14">${visaApproval.name}</span>&nbsp;属于哪种人群：</td>
			</tr>
			<tr>
				<td >
					<#list occupTypeList as occupType>
						<#list bizVisaDocOccupList as bizVisaDocOccup>
							<#if bizVisaDocOccup.occupType==occupType.code><input type="radio" name="occupId" value="${bizVisaDocOccup.occupId}" <#if visaApproval?? && visaApproval.occupId?? && visaApproval.occupId==bizVisaDocOccup.occupId>checked</#if>>${occupType.cnName}</#if>
						</#list>
					</#list>
				</td>
			</tr>
		  </tbody>
	  </table>
	  <br/>
	   <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
	            <div class="fl operate"><a class="btn btn_cc1" id="saveConfirmDocument">保存</a></div>
	   </div>
</form>
<script>
	$("#saveConfirmDocument").click(function(){
			var occupId=$("input[type=radio][name=occupId]:checked").val();
			if($.trim(occupId)==""){
				$.alert("请选择所属人群");
				return;
			}
			var loading = pandora.loading("正在努力保存中...");
			$.ajax({
					url : "/vst_back/visa/approval/saveConfirmDocument.do",
					type : "post",
					dataType : 'json',
					data : $("#confirmDocumentForm").serialize(),
					success : function(result) {
						loading.close();
						if(result.code=='success'){
							loadVisaApprovalList();
						 	confirmDocumentDialog.close();
					 	}else{
					 		$.alert(result.message);
					 	}
						
					}
				});
		});
</script>