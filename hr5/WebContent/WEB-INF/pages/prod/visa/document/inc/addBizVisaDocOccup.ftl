<form action="/vst_back/visa/visaDoc/saveBizVisaDocOccup.do" method="post" id="bizVisaDocOccupForm">
	<input type="hidden" name="docId" value="${docId}">
	<input type="hidden" name="occupId" value="${occupId}">
	<input type="hidden" name="copyFlag" value="${copyFlag}">
	<table class="p_table form-inline">
		<tbody>
			<tr>
				<td class="p_label" style="width:120px;">所属人群：</td>
				<td >
					<select name="occupType">
						<#list occupTypeList as occupType>
								<option value="${occupType.code}" <#if occupType_index=0>selected</#if>>${occupType.cnName}</option>
						</#list>
                    </select>
				</td>
			</tr>
		  </tbody>
	  </table>
	  <br/>
	   <div class="p_box box_info clearfix mb20" style="padding-left:30px;">
	            <div class="fl operate"><a class="btn btn_cc1" id="save_visa_document">保存</a></div>
	   </div>
</form>
<script>
	 $("#save_visa_document").click(function(){
			var loading = pandora.loading("正在努力保存中...");
			$.ajax({
				url : "/vst_back/visa/visaDoc/saveBizVisaDocOccup.do",
				type : "post",
				dataType : 'json',
				data : $("#bizVisaDocOccupForm").serialize(),
				success : function(result) {
					loading.close();
					if(!result.success){
				 		$.alert(result.message);
				 	}else{
					 	location.href="/vst_back/visa/visaDoc/showBizVisaDocOccup.do?docId=${docId}";
				 	}
					
				}
			});
		});
</script>